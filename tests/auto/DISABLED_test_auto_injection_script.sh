. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

data=$(auto/fail_no_auto.sh)
assert_equals 0 $?
assert_not_equals "null" $(echo "$data" | jq '.name')
auto/fail.sh 42
assert_equals 42 $?
