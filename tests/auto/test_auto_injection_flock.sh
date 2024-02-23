. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

touch .lock
chmod +x lock
flock .lock echo hello world
assert_equals 0 $?
span="$(resolve_span '.name == "flock .lock echo hello world"')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
span="$(resolve_span '.name == "echo hello world"')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
