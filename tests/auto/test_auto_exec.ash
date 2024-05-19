. ./assert.sh

ash auto/exec.shell hello world 0
assert_equals 0 $?
span="$(resolve_span '.name == "echo hello world 0"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

SOURCE=TRUE ash auto/exec.shell hello world 1
assert_equals 0 $?
span="$(resolve_span '.name == "echo hello world 1"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

# OPEN_FD=TRUE ash auto/exec.shell hello world 2
# assert_equals 0 $?
# span="$(resolve_span '.name == "echo hello world 2"')"
# assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')

# SOURCE=TRUE OPEN_FD=TRUE ash auto/exec.shell hello world 3
# assert_equals 0 $?
# span="$(resolve_span '.name == "echo hello world 3"')"
# assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.kind')
