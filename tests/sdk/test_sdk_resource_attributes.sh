. ./assert.sh
. /usr/bin/opentelemetry_shell_api.sh

export OTEL_SERVICE_NAME=TEST

function test {
  otel_init
  span_id=$(otel_span_start INTERNAL myspan)
  otel_span_end $span_id
  otel_shutdown
}
data=$(test 2>&1)

echo "$data"
assert_equals "bash" $(echo "$data" | jq -r '.resource.attributes."telemetry.sdk.language"')
assert_equals "opentelemetry" $(echo "$data" | jq -r '.resource.attributes."telemetry.sdk.name"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."telemetry.sdk.version"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.pid"')
assert_equals "bash" $(echo "$data" | jq -r '.resource.attributes."process.executable.name"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.executable.path"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.command"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.command_args"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.owner"')
assert_equals "bash" $(echo "$data" | jq -r '.resource.attributes."process.runtime.name"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.runtime.description"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."process.runtime.version"')
assert_not_equals "null" $(echo "$data" | jq -r '.resource.attributes."host.name"')
assert_equals "$OTEL_SERVICE_NAME" $(echo "$data" | jq -r '.resource.attributes."service.name"')

