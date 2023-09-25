. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

traceparent=$OTEL_TRACEPARENT
assert_not_equals "" "$OTEL_TRACEPARENT"

span_id=$(otel_span_start INTERNAL inner)
otel_span_activate $span_id
assert_not_equals "" "$OTEL_TRACEPARENT"
assert_not_equals "$traceparent" "$OTEL_TRACEPARENT"

otel_span_deactivate $span_id
otel_span_end $span_id
assert_equals "$traceparent" "$OTEL_TRACEPARENT"
