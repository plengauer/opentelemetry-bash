. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

sh -c 'echo hello world'
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command_line" == "sh -c echo hello world"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"

assert_equals "$(\sh -c 'echo $0' 'foo' 'bar baz')" "$(sh -c 'echo $0' 'foo' 'bar baz')"
assert_equals "$(\sh -c 'echo $1' 'foo' 'bar baz')" "$(sh -c 'echo $1' 'foo' 'bar baz')"
assert_equals "$(\sh -c 'echo $2' 'foo' 'bar baz')" "$(sh -c 'echo $2' 'foo' 'bar baz')"
