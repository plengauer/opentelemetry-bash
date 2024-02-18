. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

timeout 60s echo hello world
assert_equals 0 $?
span="$(resolve_span '.name == "timeout 60s hello world"')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
span="$(resolve_span '.name == "echo hello world"')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
