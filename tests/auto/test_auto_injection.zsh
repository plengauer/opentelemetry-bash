. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

data=$(zsh auto/fail_no_auto.shell 2>&1)
assert_equals 0 $?
assert_not_equals "null" $(echo "$data" | jq '.name')
zsh auto/fail.shell 42
assert_equals 42 $?
