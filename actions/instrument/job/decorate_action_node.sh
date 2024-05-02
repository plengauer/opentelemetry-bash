#!/bin/bash
# need to use bash over sh, because it propagates invalid env vars correctly (env vars with dashes in keys)
export GITHUB_STEP="$(curl --no-progress-meter --fail --retry 12 --retry-all-errors -H 'Cache-Control: no-cache' "$GITHUB_API_URL"/repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/jobs 2> /dev/null | jq -r ".jobs[] | select(.name == \"$GITHUB_JOB\") | select(.run_attempt == $GITHUB_RUN_ATTEMPT) | .steps[] | select(.status == \"in_progress\") | .name")"
. otelapi.sh
otel_init
span_handle="$(otel_span_start INTERNAL "$GITHUB_WORKFLOW / $GITHUB_JOB / $GITHUB_ACTION")"
otel_span_activate "$span_handle"
otel_observe "$@"
exit_code="$?"
if [ "$exit_code" -ne 0 ]; then otel_span_error "$span_handle"; fi
otel_span_deactivate "$span_handle"
otel_span_end "$span_handle"
otel_shutdown
exit "$exit_code"
