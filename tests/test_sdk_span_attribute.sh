#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_sdk.sh

function test {
  otel_init
  otel_span_start SERVER myspan
  assert_equals 0 $?
  otel_span_attribute key=value
  assert_equals 0 $?
  otel_span_end
  assert_equals 0 $?
  otel_shutdown
}
data=$(test 2>&1)

echo "$data"
assert_equals "myspan" $(echo "$data" | jq -r '.name')
assert_equals "SpanKind.SERVER" $(echo "$data" | jq -r '.kind')
assert_equals "null" $(echo "$data" | jq -r '.parent_id')
assert_equals "UNSET" $(echo "$data" | jq -r '.status.status_code')
assert_equals "value" $(echo "$data" | jq -r '.attributes.key')
