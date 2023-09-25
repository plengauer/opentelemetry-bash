. ./assert.sh
. /usr/bin/opentelemetry_shell_api.sh

otel_init
function print {
  echo "$@" 1>&2
}
result=$(otel_observe print hello world 2>&1)
assert_equals "hello world" "$result"
otel_shutdown
