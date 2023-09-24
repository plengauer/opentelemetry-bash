. ./assert.sh
if [ "$SHELL" != "bash" ]; then
  exit 0
fi
. /usr/bin/opentelemetry_shell.sh

assert_equals 0 $($SHELL auto/count_fail_no_auto.sh)
assert_equals 1 $($SHELL auto/count_fail_no_auto.sh foo)
assert_equals 2 $($SHELL auto/count_fail_no_auto.sh foo bar)
assert_equals 1 $($SHELL auto/count_fail_no_auto.sh "foo bar")
