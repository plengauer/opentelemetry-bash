. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

data=$(/bin/bash auto/fail_no_auto.shell)
assert_equals 0 $?
assert_not_equals "null" $(echo "$data" | jq '.name')
/bin/bash auto/fail.shell 42
assert_equals 42 $?
