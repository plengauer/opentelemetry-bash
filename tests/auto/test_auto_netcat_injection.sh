if ! [ -x "$(which ncat)" ]; then exit 0; fi
set -e
. ./assert.sh

port=12345

otel4netcat ncat -l -p "$port" -c cat &
assert_equals "hello world" "$(echo -n hello world | netcat -w 30 127.0.0.1 "$port")"
span="$(resolve_span '.kind == "SpanKind.SERVER"')"
assert_equals "send/receive" $(\echo "$span" | jq -r '.name')
span_id=$(\echo "$span" | jq -r '.context.span_id')
span="$(resolve_span '.name == "cat"')"
assert_equals "SpanKind.INTERNAL" $(\echo "$span" | jq -r '.name')
assert_equals "$span_id" $(\echo "$span" | jq -r '.parent_id')
