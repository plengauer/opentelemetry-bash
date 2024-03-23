. ./assert.sh

bash auto/exec.shell
assert_equals 0 $?
span="$(resolve_span '.name == "bash auto/exec.shell"')"
assert_equals "SpanKind.SERVER" $(\echo "$span" | jq -r '.kind')
resolve_span '.name == "exec echo hello world"'

bash auto/exec.shell source
assert_equals 0 $?
span="$(resolve_span '.name == "exec echo hello world sourced"')"
