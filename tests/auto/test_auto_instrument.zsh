. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

otel_instrument echo
zsh -x auto/echo.shell

span="$(resolve_span '.name == "echo hello world"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')
assert_not_equals "null" $(\echo "$span" | jq -r '.parent_id')
assert_equals "UNSET" $(\echo "$span" | jq -r '.status.status_code')
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.attributes."subprocess.command"')"
assert_equals "hello world" "$(\echo "$span" | jq -r '.attributes."subprocess.command_args"')"
assert_equals "echo" "$(\echo "$span" | jq -r '.attributes."subprocess.executable.name"')"
# assert_equals "/usr/bin/echo" "$(\echo "$span" | jq -r '.attributes."subprocess.executable.path"')" # identified as alias
assert_equals "0" $(\echo "$span" | jq -r '.attributes."subprocess.exit_code"')
