. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

time sh auto/echo_arg.shell hello world 0
time sh auto/echo_arg.shell hello world 1
time sh auto/echo_arg.shell hello world 2
time sh auto/echo_arg.shell hello world 3

span="$(resolve_span '.name == "echo hello world 0"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

span="$(resolve_span '.name == "echo hello world 1"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

span="$(resolve_span '.name == "echo hello world 2"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

span="$(resolve_span '.name == "echo hello world 3"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')
