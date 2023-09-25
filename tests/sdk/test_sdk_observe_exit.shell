. ./assert.sh
. /usr/bin/opentelemetry_shell_api.sh

otel_init
function fail {
  return $1
}
otel_observe fail
fail 0
assert_equals 0 $?
fail 1
assert_equals 1 $?
fail 42
assert_equals 42 $?
otel_shutdown
