#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_api.sh

function test {
  otel_init
  otel_observe cat FILE_THAT_DOES_NOT_EXIST &> /dev/null
  assert_not_equals 0 $?
  otel_shutdown
}
data=$(test 2>&1)

assert_equals "cat FILE_THAT_DOES_NOT_EXIST" "$(echo "$data" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(echo "$data" | jq -r '.kind')
assert_equals "null" $(echo "$data" | jq -r '.parent_id')
assert_equals "ERROR" $(echo "$data" | jq -r '.status.status_code')
assert_equals "cat FILE_THAT_DOES_NOT_EXIST" "$(echo "$data" | jq -r '.attributes."subprocess.command"')"
assert_not_equals "0" $(echo "$data" | jq -r '.attribtues."subprocess.exit_code"')
