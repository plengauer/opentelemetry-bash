. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

data=$(bash auto/fail_no_auto.shell 2>&1 | tee /dev/stderr)
assert_equals 0 $?
assert_not_equals "null" $(echo "$data" | jq '.name')
bash auto/fail.shell 42
assert_equals 42 $?
