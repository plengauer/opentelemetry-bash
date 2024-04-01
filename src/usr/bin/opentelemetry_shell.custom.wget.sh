#!/bin/false

# wget -O - https://www.google.at => wget -O - https://www.google.at '--header=traceparent: 00-XXXXXX-01'

_otel_propagate_wget() {
  local url=$(_otel_dollar_star "$@" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local span_id="$(otel_span_current)"
  otel_span_attribute "$span_id" network.protocol.name=http
  otel_span_attribute "$span_id" network.transport=tcp
  otel_span_attribute "$span_id" "http.request.method=GET"
  otel_span_attribute "$span_id" "url.full=$url"
  otel_span_attribute "$span_id" "url.path=/$(\printf '%s' "$url" | \cut -d / -f 4- | \cut -d ? -f 1)"
  otel_span_attribute "$span_id" "url.query=$(\printf '%s' "$url" | \cut -sd ? -f 2-)"
  otel_span_attribute "$span_id" "url.scheme=$(\printf '%s' "$url" | \cut -sd : -f 1)"
  otel_span_attribute "$span_id" user_agent.original=wget
  local stderr_pipe="$(\mktemp -u)_opentelemetry_shell_$$.stderr.wget.pipe"
  \mkfifo "$stderr_pipe"
  ( (while read -r line; do _otel_parse_wget_output "$span_id" "$line"; \echo "$line" >&2; done < "$stderr_pipe") & )
  local exit_code=0
  _otel_call "$@" --header="traceparent: $OTEL_TRACEPARENT" 2> "$stderr_pipe" || exit_code="$?"
  \rm "$stderr_pipe"
  return "$exit_code"
}

_otel_parse_wget_output() {
  local span_id="$span_id"
  local line="$line"
  if _otel_string_starts_with "$line" "HTTP request sent, awaiting response... "; then
    # HTTP request sent, awaiting response... 301 Moved Permanently
    # HTTP request sent, awaiting response... 200 OK
    otel_span_attribute "$span_id" http.response.status_code="$(\printf '%s' "$line" | \cut -d ' ' -f 6)"
  elif _otel_string_starts_with "$line" "Length: "; then
    # Length: unspecified [text/html]
    otel_span_attribute "$span_id" http.response.header.content-type="$(\printf '%s' "$line" | \cut -d ' ' -f 3 | \tr -d '[]')"
  elif _otel_string_contains "$line" " written to " || _otel_string_contains "$line" " saved "; then
    # 2024-04-01 11:32:28 (12.3 MB/s) - written to stdout [128]
    # 2024-04-01 11:23:16 (18.4 MB/s) - ‘index.html’ saved [18739]
    otel_span_attribute "$span_id" http.response.header.content-length="$(\printf '%s' "$line" \rev | \cut -d ' ' -f 1 | \rev | \tr -d '[]')"
  elif _otel_string_starts_with "$line" "Connecting to "; then
    # Connecting to www.google.at (www.google.at)|142.250.185.131|:80... connected.
    otel_span_attribute "$span_id" network.peer.address="$(\printf '%s' "$line" | \cut -d '|' -f 2)"
    otel_span_attribute "$span_id" network.peer.port="$(\printf '%s' "$line" | \cut -d '|' -f 3 | \tr -d ':.' | \cut -d ' ' -f 1)"
  elif _otel_string_starts_with "$line" "User-Agent: "; then # only available in debug mode
    otel_span_attribute "$span_id" user_agent.original="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
  elif _otel_string_starts_with "$line" "Content-Length: "; then # only available in debug mode
    otel_span_attribute "$span_id" http.response.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
  fi
}

_otel_alias_prepend wget 'OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT _otel_propagate_wget'
