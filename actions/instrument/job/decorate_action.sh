#!/bin/sh
if [ -z "$GITHUB_RUN_ID" ] || [ "$(cat /proc/$PPID/cmdline | tr '\000-\037' ' ' | cut -d ' ' -f 1 | rev | cut -d / -f 1 | rev)" != "Runner.Worker" ]; then exec "$@"; fi
variable_name_to_attribute_key() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}
variable_2_attribute_value() {
  case "$1" in
    *-*) node -e "console.log(require('process').env['$1']);";;
    *) printf '%s' "${!1}";;
  esac
}
. otelapi.sh
_otel_resource_attributes_process() {
  :
}
eval "$(cat "$_OTEL_GITHUB_STEP_AGENT_INSTRUMENTATION_FILE" | grep -v '_otel_alias_prepend ')"
otel_init
span_handle="$(otel_span_start INTERNAL "${GITHUB_STEP:-$GITHUB_ACTION}")"
otel_span_attribute_typed $span_handle string github.actions.type=step
otel_span_attribute_typed $span_handle string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
printenv | grep '^INPUT_' | cut -d '=' -f 1 | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.input."$(variable_name_to_attribute_key "${key#INPUT_}")"="$(variable_2_attribute_value "$key")"; done
printenv | grep '^STATE_' | cut -d '=' -f 1 | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.state.before."$(variable_name_to_attribute_key "${key#STATE_}")"="$(variable_2_attribute_value "$key")"; done
[ -z "${GITHUB_ACTION_PATH:-}" ] || ! [ -d "$GITHUB_ACTION_PATH" ] || _OTEL_GITHUB_STEP_ACTION_TYPE=composite/"$_OTEL_GITHUB_STEP_ACTION_TYPE"
otel_span_attribute_typed $span_handle string github.actions.action.type="$_OTEL_GITHUB_STEP_ACTION_TYPE"
otel_span_attribute_typed $span_handle string github.actions.action.name="$GITHUB_ACTION_REPOSITORY"
otel_span_attribute_typed $span_handle string github.actions.action.ref="$GITHUB_ACTION_REF"
[ -z "${_OTEL_GITHUB_STEP_ACTION_PHASE:-}" ] || otel_span_attribute_typed $span_handle string github.actions.action.phase="$_OTEL_GITHUB_STEP_ACTION_PHASE"
otel_span_activate "$span_handle"
otel_observe "$_OTEL_GITHUB_STEP_AGENT_INJECTION_FUNCTION" "$@"
exit_code="$?"
cat "$GITHUB_STATE" | while read -r kvp; do otel_span_attribute_typed $span_handle string github.actions.step.state.after."$(variable_name_to_attribute_key "${kvp%%=*}")"="${kvp#*=}"; done
cat "$GITHUB_OUTPUT" | while read -r kvp; do otel_span_attribute_typed $span_handle string github.actions.step.output."$(variable_name_to_attribute_key "${kvp%%=*}")"="${kvp#*=}"; done
if [ "$exit_code" != 0 ]; then
  otel_span_attribute_typed $span_handle string github.actions.step.conclusion=failure
  otel_span_error "$span_handle"
  touch /tmp/opentelemetry_shell.github.error
else
  otel_span_attribute_typed $span_handle string github.actions.step.conclusion=success
fi
otel_span_deactivate "$span_handle"
otel_span_end "$span_handle"
otel_shutdown
exit "$exit_code"
