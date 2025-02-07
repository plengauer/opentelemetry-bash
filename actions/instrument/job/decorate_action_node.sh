#!/bin/bash
# need to use bash over sh, because it propagates invalid env vars correctly (env vars with dashes in keys)
if [ "$(cat /tmp/opentelemetry_shell_action_name 2> /dev/null)" = "$GITHUB_ACTION" ] || [ -z "$GITHUB_RUN_ID" ] || [ "$(cat /proc/$PPID/cmdline | tr '\000-\037' ' ' | cut -d ' ' -f 1 | rev | cut -d / -f 1 | rev)" != "Runner.Worker" ]; then exec "$@"; fi
# export GITHUB_STEP="$(curl --no-progress-meter --fail --retry 12 --retry-all-errors "$GITHUB_API_URL"/repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/jobs 2> /dev/null | jq -r ".jobs[] | select(.name == \"$GITHUB_JOB\") | select(.run_attempt == $GITHUB_RUN_ATTEMPT) | .steps[] | select(.status == \"in_progress\") | .name")"
. otelapi.sh
eval "$(cat /usr/share/opentelemetry_shell/agent.instrumentation.node.sh | grep -v '_otel_alias_prepend ')"
otel_init
span_handle="$(otel_span_start INTERNAL "${GITHUB_STEP:-$GITHUB_ACTION}")"
otel_span_attribute_typed $span_handle string github.step.name="${GITHUB_STEP:-$GITHUB_ACTION}"
otel_span_attribute_typed $span_handle string github.job.name="${OTEL_SHELL_GITHUB_JOB:-${GITHUB_JOB:-}}"
otel_span_attribute_typed $span_handle string github.workflow.name="${GITHUB_WORKFLOW:-}"
otel_span_attribute_typed $span_handle int github.workflow_run.id="${GITHUB_RUN_ID:-}"
otel_span_attribute_typed $span_handle int github.workflow_run.attempt="${GITHUB_RUN_ATTEMPT:-}"
otel_span_attribute_typed $span_handle int github.workflow_run.number="${GITHUB_RUN_NUMBER:-}"
otel_span_attribute_typed $span_handle int github.actor.id="${GITHUB_ACTOR_ID:-}"
otel_span_attribute_typed $span_handle string github.actor.name="${GITHUB_ACTOR:-}"
otel_span_attribute_typed $span_handle string github.event.name="${GITHUB_EVENT_NAME:-}"
otel_span_attribute_typed $span_handle string github.event.ref="/refs/heads/${GITHUB_REF:-}"
otel_span_attribute_typed $span_handle string github.event.ref.sha="${GITHUB_SHA:-}"
otel_span_attribute_typed $span_handle string github.event.ref.name="${GITHUB_REF_NAME:-}"
otel_span_activate "$span_handle"
otel_observe _otel_inject_node "$@"
exit_code="$?"
if [ "$exit_code" != 0 ]; then otel_span_error "$span_handle"; touch /tmp/opentelemetry_shell.github.error; fi
otel_span_deactivate "$span_handle"
otel_span_end "$span_handle"
otel_shutdown
exit "$exit_code"
