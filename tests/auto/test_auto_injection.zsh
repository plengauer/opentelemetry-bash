. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

zsh auto/fail_no_auto.shell
assert_equals 0 $?
span="$(resolve_span '.resource.attributes."process.command" == "zsh auto/fail_no_auto.shell"')"
assert_equals "zsh auto/fail_no_auto.shell" "$(\echo "$span" | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" "$(\echo "$span" | jq -r '.kind')"
zsh auto/fail.shell 42
assert_equals 42 $?
