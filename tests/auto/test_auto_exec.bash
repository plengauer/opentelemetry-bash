. ./assert.sh

bash auto/exec.shell
assert_equals 0 $?
span="$(resolve_span '.name == "/bin/bash auto/exec.shell"')"
assert_equals "SpanKind.SERVER" $(\echo "$span" | jq -r '.kind')
