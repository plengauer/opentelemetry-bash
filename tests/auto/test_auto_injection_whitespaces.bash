. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

assert_equals 0 $(bash auto/count_fail_no_auto.shell)
assert_equals 1 $(bash auto/count_fail_no_auto.shell foo)
assert_equals 2 $(bash auto/count_fail_no_auto.shell foo bar)
assert_equals 1 $(bash auto/count_fail_no_auto.shell "foo bar")
