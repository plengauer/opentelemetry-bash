. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

sh auto/fail_no_auto.shell
assert_equals 0 $?
sleep 3
assert_equals "sh auto/fail_no_auto.shell" "$(cat $OTEL_TRACES_LOCATION | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(cat $OTEL_TRACES_LOCATION | jq -r '.kind')
sh auto/fail.shell 42
assert_equals 42 $?
