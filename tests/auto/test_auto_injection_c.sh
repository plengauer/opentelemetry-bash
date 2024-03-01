. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

sh -c 'echo hello world'
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command" == "sh -c echo hello world"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"

assert_equals "sh" "$(sh -c 'echo $0' 'foo' 'bar')"
assert_equals "foo" "$(sh -c 'echo $1' 'foo' 'bar')"
assert_equals "bar" "$(sh -c 'echo $2' 'foo' 'bar')"
