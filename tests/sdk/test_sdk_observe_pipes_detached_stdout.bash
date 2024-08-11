# disabled for non bash be ause dash has very weird (buggy) behavior for commands that follow closing stdout
. ./assert.sh
export OTEL_SHELL_EXPERIMENTAL_OBSERVE_PIPES=TRUE
. /usr/bin/opentelemetry_shell_api.sh

exec 1>&-
otel_init
echo "hello world" | otel_observe cat
otel_shutdown

span="$(resolve_span '.name == "cat"')"
assert_equals "12" $(echo "$span" | jq -r '.attributes."pipe.stdin.bytes"')
assert_equals "1" $(echo "$span" | jq -r '.attributes."pipe.stdin.lines"')
assert_equals "12" $(echo "$span" | jq -r '.attributes."pipe.stdout.bytes"')
assert_equals "1" $(echo "$span" | jq -r '.attributes."pipe.stdout.lines"')
assert_equals "0" $(echo "$span" | jq -r '.attributes."pipe.stderr.bytes"')
assert_equals "0" $(echo "$span" | jq -r '.attributes."pipe.stderr.lines"')
