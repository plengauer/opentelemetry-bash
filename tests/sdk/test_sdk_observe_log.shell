. ./assert.sh
. /usr/bin/opentelemetry_shell_api.sh

otel_init
otel_observe wget http://www.google.at
otel_shutdown

log="$(resolve_log '.body == "HTTP request sent, awaiting response... 200 OK"')"
assert_equals "HTTP request sent, awaiting response... 200 OK" "$(echo "$log" | jq -r '.body')"
