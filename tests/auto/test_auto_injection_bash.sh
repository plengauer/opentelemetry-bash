. ./assert.sh
echo $SHELL
if [ "$SHELL" != "bash" ]; then
  exit 0
fi
. /usr/bin/opentelemetry_shell.sh

data=$(bash auto/fail_no_auto.sh)
assert_equals 0 $?
assert_not_equals "null" $(echo "$data" | jq '.name')
bash auto/fail.sh 42
assert_equals 42 $?
