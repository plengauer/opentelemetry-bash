#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash.sh

otel_instrument echo
data=$(bash auto/inner_echo.sh 2>&1 1> /dev/null | jq '. | select(.name == "echo hello world")')

\echo "$data"
assert_equals "echo hello world" "$(\echo "$data" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(\echo "$data" | jq -r '.kind')
assert_not_equals "null" $(\echo "$data" | jq -r '.parent_id')
assert_equals "UNSET" $(\echo "$data" | jq -r '.status.status_code')
assert_equals "echo hello world" "$(\echo "$data" | jq -r '.attributes."subprocess.command"')"
assert_equals "0" $(\echo "$data" | jq -r '.attributes."subprocess.exit_code"')
