. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

bash auto/fail_no_auto.shell
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command" == "bash auto/fail_no_auto.shell"')"
assert_equals "myspan" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

bash auto/fail.shell 42
assert_equals 42 $?

bash auto/echo.shell
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command" == "bash auto/echo.shell"')"
assert_equals "echo hello world" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')
