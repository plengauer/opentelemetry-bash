. ./assert.sh

zsh auto/exec.shell
assert_equals 0 $?
span="$(resolve_span '.name == "/bin/zsh auto/exec.shell"')"
assert_equals "SpanKind.SERVER" $(\echo "$span" | jq -r '.kind')
