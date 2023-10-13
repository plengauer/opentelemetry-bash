. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

otel_instrument echo
bash auto/echo.shell

span="$(resolve_span '.name == "echo hello world"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')
assert_not_equals "null" $(\echo "$span" | jq -r '.parent_id')
assert_equals "UNSET" $(\echo "$span" | jq -r '.status.status_code')
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.attributes."subprocess.command"')"
assert_equals "hello world" "$(\echo "$span" | jq -r '.attributes."subprocess.command_args"')"
assert_equals "echo" "$(\echo "$span" | jq -r '.attributes."subprocess.executable.name"')"
assert_ends_with "/echo" "$(\echo "$span" | jq -r '.attributes."subprocess.executable.path"')"
assert_equals "0" $(\echo "$span" | jq -r '.attributes."subprocess.exit_code"')
