. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

ash -c 'echo hello world' -x
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command" == "ash -c echo hello world -x"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
