#!/bin/sh
if [ -z "$GITHUB_RUN_ID" ] || [ "$(cat /proc/$PPID/cmdline | tr '\000-\037' ' ' | cut -d ' ' -f 1 | rev | cut -d / -f 1 | rev)" != "Runner.Worker" ]; then exec "$@"; fi
variable_name_2_attribute_key() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}
variable_name_2_attribute_value() {
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
time_start="$(date +%s.%N)"
span_handle="$(otel_span_start INTERNAL "${GITHUB_STEP:-$GITHUB_ACTION}")"
otel_span_attribute_typed $span_handle string github.actions.type=step
otel_span_attribute_typed $span_handle string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
printenv -0 | tr '\n' ' ' | tr '\0' '\n' | cut -d '=' -f 1 | grep '^INPUT_' | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.input."$(variable_name_2_attribute_key "${key#INPUT_}")"="$(variable_name_2_attribute_value "$key")"; done
printenv -0 | tr '\n' ' ' | tr '\0' '\n' | cut -d '=' -f 1 | grep '^STATE_' | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.state.before."$(variable_name_2_attribute_key "${key#STATE_}")"="$(variable_name_2_attribute_value "$key")"; done
[ -z "${GITHUB_ACTION_PATH:-}" ] || ! [ -d "$GITHUB_ACTION_PATH" ] || _OTEL_GITHUB_STEP_ACTION_TYPE=composite/"$_OTEL_GITHUB_STEP_ACTION_TYPE"
otel_span_attribute_typed $span_handle string github.actions.action.type="$_OTEL_GITHUB_STEP_ACTION_TYPE"
otel_span_attribute_typed $span_handle string github.actions.action.name="$GITHUB_ACTION_REPOSITORY"
otel_span_attribute_typed $span_handle string github.actions.action.ref="$GITHUB_ACTION_REF"
[ -z "${_OTEL_GITHUB_STEP_ACTION_PHASE:-}" ] || otel_span_attribute_typed $span_handle string github.actions.action.phase="$_OTEL_GITHUB_STEP_ACTION_PHASE"
otel_span_activate "$span_handle"
commands_mute_token="$(mktemp -u)"
exit_code_file="$(mktemp)"
{ otel_observe "$_OTEL_GITHUB_STEP_AGENT_INJECTION_FUNCTION" "$@"; echo "$?" > "$exit_code_file"; } | while read -r line; do
  printf '%s\n' "$line"
  if [ -r "$commands_mute_token_file" ]; then
    if [ "$line" = ::"$(cat "$commands_mute_token_file")":: ]; then
      rm "$commands_mute_token_file"
    fi
    continue
  fi
  case "$line" in
    ::stop-commands::*)
      echo "${line#::stop-commands::}" > "$commands_mute_token_file"
      line=""
      severity=unspecified
      ;;
    ::endgroup::)
      line=""
      severity=unspecified
      ;;
    '::'group)
      line="${line#::}"
      line="${line#*::}"
      severity=unspecified
      ;;
    ::save-state' 'name=*::)
      line="${line#::save-state name=}"
      otel_span_attribute_typed $span_handle string github.actions.step.state.after."$(variable_name_2_attribute_key "${line%%::*}")"="${line#*::}"
      line=""
      severity=unspecified
      ;;
    ::set-output' 'name=*::)
      line="${line#::set-output name=}"
      otel_span_attribute_typed $span_handle string github.actions.step.output."$(variable_name_2_attribute_key "${line%%::*}")"="${line#*::}"
      line=""
      severity=unspecified
      ;;
    ::add-mask::)
      # in theory we should adjust the collector config and restart
      # in reality, the first commands using the unsmasked value (including the echo writing it) are already out ...
      line=""
      severity=unspecified
      ;;
    '::'*'::'*)
      line="${line#::}"
      severity="${line%%::*}"
      severity="${severity%% *}"
      line="${line#*::}"
      ;;
    '[command]'*)
      severity=trace
      line="${line#[command]}"
      ;;
    *) severity=unspecified;;
  esac
  case "$severity" in
    trace) severity=1;;
    debug) severity=5;;
    notice) severity=9;;
    warning) severity=13;;
    error) severity=17;;
    *) severity=0;;
  esac
  [ "$severity" = 0 ] || _otel_log_record "$TRACEPARENT" auto "$severity" "$line"
done
exit_code="$(cat "$exit_code_file")"
otel_span_deactivate "$span_handle"
printenv -0 | tr '\n' ' ' | tr '\0' '\n' | cut -d '=' -f 1 | grep '^STATE_' | while read -r key; do otel_span_attribute_typed $span_handle string github.actions.step.state.after."$(variable_name_2_attribute_key "${key#STATE_}")"="$(variable_name_2_attribute_value "$key")"; done
! [ -r "$GITHUB_STATE" ] || cat "$GITHUB_STATE" | while read -r kvp; do otel_span_attribute_typed $span_handle string github.actions.step.state.after."$(variable_name_2_attribute_key "${kvp%%=*}")"="${kvp#*=}"; done
! [ -r "$GITHUB_OUTPUT" ] || cat "$GITHUB_OUTPUT" | while read -r kvp; do otel_span_attribute_typed $span_handle string github.actions.step.output."$(variable_name_2_attribute_key "${kvp%%=*}")"="${kvp#*=}"; done
if [ "$exit_code" != 0 ]; then
  _otel_log_record "$TRACEPARENT" auto 17 "Process completed with exit code $exit_code."
  conclusion=failure
else
  conclusion=success
fi
otel_span_attribute_typed $span_handle string github.actions.step.conclusion="$conclusion"
if [ "$conclusion" = failure ]; then otel_span_error "$span_handle"; touch /tmp/opentelemetry_shell.github.error; fi
otel_span_end "$span_handle"
time_end="$(date +%s.%N)"

counter_handle="$(otel_counter_create counter github.actions.steps 1 'Number of step runs')"
observation_handle="$(otel_observation_create 1)"
otel_observation_attribute_typed "$observation_handle" string github.actions.workflow.name="$GITHUB_WORKFLOW"
otel_observation_attribute_typed "$observation_handle" int github.actions.workflow_run.attempt="$GITHUB_RUN_ATTEMPT"
otel_observation_attribute_typed "$observation_handle" int github.actions.actor.id="$GITHUB_ACTOR_ID"
otel_observation_attribute_typed "$observation_handle" string github.actions.actor.name="$GITHUB_ACTOR"
otel_observation_attribute_typed "$observation_handle" string github.actions.event.name="$GITHUB_EVENT_NAME"
otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref="/refs/heads/$GITHUB_REF_NAME"
otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref.name="$GITHUB_REF_NAME"
otel_observation_attribute_typed "$observation_handle" string github.actions.job.name="${OTEL_SHELL_GITHUB_JOB:-$GITHUB_JOB}"
otel_observation_attribute_typed "$observation_handle" string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
otel_observation_attribute_typed "$observation_handle" string github.actions.step.conclusion="$conclusion"
otel_counter_observe "$counter_handle" "$observation_handle"

counter_handle="$(otel_counter_create counter github.actions.steps.duration s 'Duration of step runs')"
observation_handle="$(otel_observation_create "$(python3 -c "print(str($time_end - $time_start))")")"
otel_observation_attribute_typed "$observation_handle" string github.actions.workflow.name="$GITHUB_WORKFLOW"
otel_observation_attribute_typed "$observation_handle" int github.actions.workflow_run.attempt="$GITHUB_RUN_ATTEMPT"
otel_observation_attribute_typed "$observation_handle" int github.actions.actor.id="$GITHUB_ACTOR_ID"
otel_observation_attribute_typed "$observation_handle" string github.actions.actor.name="$GITHUB_ACTOR"
otel_observation_attribute_typed "$observation_handle" string github.actions.event.name="$GITHUB_EVENT_NAME"
otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref="/refs/heads/$GITHUB_REF_NAME"
otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref.name="$GITHUB_REF_NAME"
otel_observation_attribute_typed "$observation_handle" string github.actions.job.name="${OTEL_SHELL_GITHUB_JOB:-$GITHUB_JOB}"
otel_observation_attribute_typed "$observation_handle" string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
otel_observation_attribute_typed "$observation_handle" string github.actions.step.conclusion="$conclusion"
otel_counter_observe "$counter_handle" "$observation_handle"

if [ -n "${GITHUB_ACTION_REPOSITORY:-}" ]; then
  counter_handle="$(otel_counter_create counter github.actions.actions 1 'Number of action runs')"
  observation_handle="$(otel_observation_create 1)"
  otel_observation_attribute_typed "$observation_handle" string github.actions.workflow.name="$GITHUB_WORKFLOW"
  otel_observation_attribute_typed "$observation_handle" int github.actions.workflow_run.attempt="$GITHUB_RUN_ATTEMPT"
  otel_observation_attribute_typed "$observation_handle" int github.actions.actor.id="$GITHUB_ACTOR_ID"
  otel_observation_attribute_typed "$observation_handle" string github.actions.actor.name="$GITHUB_ACTOR"
  otel_observation_attribute_typed "$observation_handle" string github.actions.event.name="$GITHUB_EVENT_NAME"
  otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref="/refs/heads/$GITHUB_REF_NAME"
  otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref.name="$GITHUB_REF_NAME"
  otel_observation_attribute_typed "$observation_handle" string github.actions.job.name="${OTEL_SHELL_GITHUB_JOB:-$GITHUB_JOB}"
  otel_observation_attribute_typed "$observation_handle" string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
  otel_observation_attribute_typed "$observation_handle" string github.actions.action.name="$GITHUB_ACTION_REPOSITORY"
  otel_observation_attribute_typed "$observation_handle" string github.actions.action.ref="$GITHUB_ACTION_REF"
  otel_observation_attribute_typed "$observation_handle" string github.actions.action.conclusion="$conclusion"
  otel_counter_observe "$counter_handle" "$observation_handle"
  
  counter_handle="$(otel_counter_create counter github.actions.actions.duration s 'Duration of action runs')"
  observation_handle="$(otel_observation_create "$(python3 -c "print(str($time_end - $time_start))")")"
  otel_observation_attribute_typed "$observation_handle" string github.actions.workflow.name="$GITHUB_WORKFLOW"
  otel_observation_attribute_typed "$observation_handle" int github.actions.workflow_run.attempt="$GITHUB_RUN_ATTEMPT"
  otel_observation_attribute_typed "$observation_handle" int github.actions.actor.id="$GITHUB_ACTOR_ID"
  otel_observation_attribute_typed "$observation_handle" string github.actions.actor.name="$GITHUB_ACTOR"
  otel_observation_attribute_typed "$observation_handle" string github.actions.event.name="$GITHUB_EVENT_NAME"
  otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref="/refs/heads/$GITHUB_REF_NAME"
  otel_observation_attribute_typed "$observation_handle" string github.actions.event.ref.name="$GITHUB_REF_NAME"
  otel_observation_attribute_typed "$observation_handle" string github.actions.job.name="${OTEL_SHELL_GITHUB_JOB:-$GITHUB_JOB}"
  otel_observation_attribute_typed "$observation_handle" string github.actions.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
  otel_observation_attribute_typed "$observation_handle" string github.actions.action.name="$GITHUB_ACTION_REPOSITORY"
  otel_observation_attribute_typed "$observation_handle" string github.actions.action.ref="$GITHUB_ACTION_REF"
  otel_observation_attribute_typed "$observation_handle" string github.actions.action.conclusion="$conclusion"
  otel_counter_observe "$counter_handle" "$observation_handle"
fi

otel_shutdown
exit "$exit_code"
