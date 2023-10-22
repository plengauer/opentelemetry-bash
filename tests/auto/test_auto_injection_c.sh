. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

sh -c 'echo hello world'
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command" == "sh -c echo hello world"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
