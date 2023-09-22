#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_sdk.sh

otel_init
assert_equals "" "$OTEL_TRACEPARENT"
otel_span_start INTERNAL myspan
traceparent=$OTEL_TRACEPARENT
assert_not_equals "" "$OTEL_TRACEPARENT"
otel_span_start INTERNAL inner
assert_not_equals "" "$OTEL_TRACEPARENT"
assert_not_equals "$traceparent" "$OTEL_TRACEPARENT"
otel_span_end
assert_equals "$traceparent" "$OTEL_TRACEPARENT"
otel_span_end
assert_equals "" "$OTEL_TRACEPARENT"
otel_shutdown
