. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

assert_equals 0 $(zsh auto/count_fail_no_auto.shell)
assert_equals 1 $(zsh auto/count_fail_no_auto.shell foo)
assert_equals 2 $(zsh auto/count_fail_no_auto.shell foo bar)
assert_equals 1 $(zsh auto/count_fail_no_auto.shell "foo bar")
