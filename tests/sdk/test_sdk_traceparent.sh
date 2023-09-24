#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_api.sh

otel_init
assert_equals "" "$OTEL_TRACEPARENT"

span_id=$(otel_span_start INTERNAL myspan)
assert_equals "" "$OTEL_TRACEPARENT"

otel_span_activate $span_id
traceparent=$OTEL_TRACEPARENT
assert_not_equals "" "$OTEL_TRACEPARENT"

span_id_2=$(otel_span_start INTERNAL inner)
otel_span_activate $span_id_2
assert_not_equals "" "$OTEL_TRACEPARENT"
assert_not_equals "$traceparent" "$OTEL_TRACEPARENT"

otel_span_deactivate $span_id_2
otel_span_end $span_id_2
assert_equals "$traceparent" "$OTEL_TRACEPARENT"

otel_span_deactivate $span_id
otel_span_end $span_id
assert_equals "" "$OTEL_TRACEPARENT"

otel_shutdown
