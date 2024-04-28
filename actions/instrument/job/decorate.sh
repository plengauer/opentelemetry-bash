#!/bin/sh
. otelapi.sh
otel_init
span_handle="$(otel_span_start INTERNAL "$GITHUB_WORKFLOW / $GITHUB_JOB / $GITHUB_ACTION")"
otel_span_activate "$span_handle"
exit_code=0
otel_observe "$@" || exit_code="$?"
if [ "$exit_code" -ne 0 ]; then otel_span_error "$span_handle"; fi
# TODO it can exit with 0 and still fail
otel_span_deactivate "$span_handle"
otel_span_end "$span_handle"
otel_shutdown
exit "$exit_code"
