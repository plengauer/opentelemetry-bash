#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_api.sh

function test {
  otel_init
  otel_observe echo "hello world"
  assert_equals 0 $?
  otel_shutdown
}
data=$(test 2>&1 1> /dev/null)

echo "$data"
assert_equals "echo hello world" "$(echo "$data" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(echo "$data" | jq -r '.kind')
assert_equals "null" $(echo "$data" | jq -r '.parent_id')
assert_equals "UNSET" $(echo "$data" | jq -r '.status.status_code')
assert_equals "echo hello world" "$(echo "$data" | jq -r '.attributes."subprocess.command"')"
assert_equals "0" $(echo "$data" | jq -r '.attributes."subprocess.exit_code"')
