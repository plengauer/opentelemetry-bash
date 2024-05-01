#!/bin/sh
printenv >&2
export INPUT_MERGE-MULTIPLE=false
echo "+ $*" >&2
"$@"
exit_code="$?"
echo "- $* => $exit_code" >&2
exit "$exit_code"

#if [ -n "$GITHUB_ACTION" ] && [ "$(\cat /proc/$PPID/cmdline | \tr '\000-\037' ' ' | \cut -d ' ' -f 1 | \rev | \cut -d / -f 1 | \rev)" = "Runner.Worker" ]; then
  export OTEL_SHELL_SDK_OUTPUT_REDIRECT=/dev/null # not necessary probably
  export GITHUB_STEP="$(curl --no-progress-meter --fail --retry 12 --retry-all-errors "$GITHUB_API_URL"/repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/jobs 2> /dev/null | jq -r ".jobs[] | select(.name == \"$GITHUB_JOB\") | select(.run_attempt == $GITHUB_RUN_ATTEMPT) | .steps[] | select(.status == \"in_progress\") | .name")"
  . otelapi.sh
  otel_init
  span_handle="$(otel_span_start SERVER "$GITHUB_WORKFLOW / $GITHUB_JOB / $GITHUB_STEP")"
  otel_span_activate "$span_handle"
  otel_observe "$@"
  exit_code="$?"
  if [ "$exit_code" -ne 0 ]; then otel_span_error "$span_handle"; fi
  otel_span_deactivate "$span_handle"
  otel_span_end "$span_handle"
  otel_shutdown
  exit "$exit_code"
#else
#  exec "$@"
#fi
