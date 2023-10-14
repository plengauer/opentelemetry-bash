. ./assert.sh

ash auto/exec.shell
assert_equals 0 $?
span="$(resolve_span '.name == "ash auto/exec.shell"')"
assert_equals "SpanKind.SERVER" $(\echo "$span" | jq -r '.kind')
