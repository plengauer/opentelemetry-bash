#!/bin/sh
if [ -z "$GITHUB_RUN_ID" ] || [ "$(cat /proc/$PPID/cmdline | tr '\000-\037' ' ' | cut -d ' ' -f 1 | rev | cut -d / -f 1 | rev)" != "Runner.Worker" ]; then exec "$@"; fi
. otelapi.sh
_otel_resource_attributes_process() {
  _otel_resource_attribute string github.repository.id="$GITHUB_REPOSITORY_ID"
  _otel_resource_attribute string github.repository.name="$GITHUB_REPOSITORY"
  _otel_resource_attribute string github.repository.owner.id="$GITHUB_REPOSITORY_OWNER_ID"
  _otel_resource_attribute string github.repository.owner.name="$GITHUB_REPOSITORY_OWNER"
  _otel_resource_attribute string github.actions.workflow.name="$GITHUB_WORKFLOW"
  _otel_resource_attribute string github.actions.workflow.ref="$GITHUB_WORKFLOW_REF"
  _otel_resource_attribute string github.actions.workflow.sha="$GITHUB_WORKFLOW_SHA"
}
eval "$(cat "$_OTEL_GITHUB_STEP_AGENT_INSTRUMENTATION_FILE" | grep -v '_otel_alias_prepend ')"
otel_init
span_handle="$(otel_span_start INTERNAL "${GITHUB_STEP:-$GITHUB_ACTION}")"
otel_span_attribute_typed $span_handle string github.actions.type=step
otel_span_attribute_typed $span_handle string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
printenv | grep '^INPUT_' | cut -d '=' -f 1 | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.input."${key#INPUT_}"="${!key}"; done
printenv | grep '^STATE_' | cut -d '=' -f 1 | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.state."${key#STATE_}"="${!key}"; done
[ -z "${GITHUB_ACTION_PATH:-}" ] || ! [ -d "$GITHUB_ACTION_PATH" ] || _OTEL_GITHUB_STEP_ACTION_TYPE=composite/"$_OTEL_GITHUB_STEP_ACTION_TYPE"
otel_span_attribute_typed $span_handle string github.actions.action.type="$_OTEL_GITHUB_STEP_ACTION_TYPE"
otel_span_attribute_typed $span_handle string github.actions.action.name="$GITHUB_ACTION_REPOSITORY"
otel_span_attribute_typed $span_handle string github.actions.action.ref="$GITHUB_ACTION_REF"
[ -z "${_OTEL_GITHUB_STEP_ACTION_PHASE:-}" ] || otel_span_attribute_typed $span_handle string github.actions.action.phase="$_OTEL_GITHUB_STEP_ACTION_PHASE"
otel_span_activate "$span_handle"
otel_observe "$_OTEL_GITHUB_STEP_AGENT_INJECTION_FUNCTION" "$@"
exit_code="$?"
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
