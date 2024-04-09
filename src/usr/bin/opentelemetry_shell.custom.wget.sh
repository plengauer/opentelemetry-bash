#!/bin/false

# wget -O - https://www.google.at => wget -O - https://www.google.at '--header=traceparent: 00-XXXXXX-01'

_otel_propagate_wget() {
  case "$-" in
    *m*) local job_control=1; \set +m;;
    *) local job_control=0;;
  esac
  local url=$(_otel_dollar_star "$@" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local span_handle="$(otel_span_current)"
  otel_span_attribute_typed "$span_handle" string network.protocol.name=http
  otel_span_attribute_typed "$span_handle" string network.transport=tcp
  otel_span_attribute_typed "$span_handle" string http.request.method=GET
  otel_span_attribute_typed "$span_handle" string "server.address=$(\printf '%s' "$url" | \cut -d / -f 3 | \cut -d : -f 1)"
  otel_span_attribute_typed "$span_handle" int "server.port=$(\printf '%s' "$url" | \cut -d / -f 3 | \cut -sd : -f 2)"
  otel_span_attribute_typed "$span_handle" string "url.full=$url"
  otel_span_attribute_typed "$span_handle" string "url.path=/$(\printf '%s' "$url" | \cut -d / -f 4- | \cut -d ? -f 1)"
  otel_span_attribute_typed "$span_handle" string "url.query=$(\printf '%s' "$url" | \cut -sd ? -f 2-)"
  otel_span_attribute_typed "$span_handle" string "url.scheme=$(\printf '%s' "$url" | \cut -sd : -f 1)"
  otel_span_attribute_typed "$span_handle" string user_agent.original=wget
  local stderr_pipe="$(\mktemp -u)_opentelemetry_shell_$$.stderr.wget.pipe"
  \mkfifo "$stderr_pipe"
  while read -r line; do _otel_parse_wget_stderr_line "$span_handle" "$line"; \echo "$line" >&2; done < "$stderr_pipe" &
  local stderr_pid="$!"
  local exit_code=0
  _otel_call "$@" --header="traceparent: $OTEL_TRACEPARENT" 2> "$stderr_pipe" || exit_code="$?"
  \wait "$stderr_pid"
  \rm "$stderr_pipe"
  if \[ "$job_control" = 1 ]; then \set -m; fi
  return "$exit_code"
}

_otel_parse_wget_stderr_line() {
  local span_handle="$1"
  local line="$2"
  if _otel_string_starts_with "$line" "HTTP request sent, awaiting response... "; then
    # HTTP request sent, awaiting response... 301 Moved Permanently
    # HTTP request sent, awaiting response... 200 OK
    otel_span_attribute_typed "$span_handle" int http.response.status_code="$(\printf '%s' "$line" | \cut -d ' ' -f 6)"
  elif _otel_string_starts_with "$line" "Length: "; then
    # Length: unspecified [text/html]
    # Length: 17826 (17K) [application/octet-stream]
    otel_span_attribute_typed "$span_handle" string http.response.header.content-type="$(\printf '%s' "$line" | \cut -d '[' -f 2 | \tr -d '[]')"
    otel_span_attribute_typed "$span_handle" string http.response.header.content-length="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
  elif _otel_string_contains "$line" " written to " || _otel_string_contains "$line" " saved "; then
    # 2024-04-01 11:32:28 (12.3 MB/s) - written to stdout [128]
    # 2024-04-01 11:23:16 (18.4 MB/s) - ‘index.html’ saved [18739]
    # 2024-04-06 17:37:30 (102 MB/s) - written to stdout [17826/17826]
    otel_span_attribute_typed "$span_handle" string http.response.header.content-length="$(\printf '%s' "$line" | \cut -d '[' -f 1 | \tr -d '[]' | \cut -d / -f 1)"
  elif _otel_string_starts_with "$line" "Connecting to "; then
    # Connecting to www.google.at (www.google.at)|142.250.185.131|:80... connected.
    otel_span_attribute_typed "$span_handle" string network.peer.address="$(\printf '%s' "$line" | \cut -d '|' -f 2)"
    otel_span_attribute_typed "$span_handle" int network.peer.port="$(\printf '%s' "$line" | \cut -d '|' -f 3 | \tr -d ':.' | \cut -d ' ' -f 1)"
  elif _otel_string_starts_with "$line" "HTTP/"; then # only available in debug mode, but splits up the usual response code line
    otel_span_attribute_typed "$span_handle" int http.response.status_code="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
  elif _otel_string_starts_with "$line" "User-Agent: "; then # only available in debug mode
    otel_span_attribute_typed "$span_handle" string user_agent.original="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
  elif _otel_string_starts_with "$line" "Content-Length: "; then # only available in debug mode
    otel_span_attribute_typed "$span_handle" int http.response.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
  fi
}

_otel_alias_prepend wget 'OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT _otel_propagate_wget'
