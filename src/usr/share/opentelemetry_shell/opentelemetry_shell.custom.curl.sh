#!/bin/false

# curl -v https://www.google.at => curl -v https://www.google.at -H 'traceparent: 00-XXXXXX-01'

_otel_propagate_curl() {
  case "$-" in
    *m*) local job_control=1; \set +m;;
    *) local job_control=0;;
  esac
  if _otel_string_contains "$(_otel_dollar_star "$@")" " -v "; then local is_verbose=1; fi
  local stderr_pipe="$(\mktemp -u)_opentelemetry_shell_$$.stderr.curl.pipe"
  \mkfifo "$stderr_pipe"
  _otel_pipe_curl_stderr "$is_verbose" < "$stderr_pipe" >&2 &
  local stderr_pid="$!"
  local exit_code=0
  LD_PRELOAD=/opt/opentelemtry_shell/libinjecthttpheader.so _otel_call "$@" -H "traceparent: $TRACEPARENT" -H "tracestate: $TRACESTATE" -v --no-progress-meter 2> "$stderr_pipe" || exit_code="$?"
  \wait "$stderr_pid"
  \rm "$stderr_pipe"
  if \[ "$job_control" = 1 ]; then \set -m; fi
  return "$exit_code"
}

# * processing: http://www.google.at
# *   Trying 142.250.185.131:80...
# * Connected to www.google.at (142.250.185.131) port 80
# > GET / HTTP/1.1
# > Host: www.google.at
# > User-Agent: curl/8.2.1
# > Accept: */*
# > 
# < HTTP/1.1 200 OK
# < Date: Mon, 01 Apr 2024 12:07:04 GMT
# < Expires: -1
# < Cache-Control: private, max-age=0
# < Content-Type: text/html; charset=ISO-8859-1
# < Content-Security-Policy-Report-Only: object-src 'none';base-uri 'self';script-src 'nonce-XyxOUCdoVMoXXWssicVB8w' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
# < Server: gws
# < X-XSS-Protection: 0
# < X-Frame-Options: SAMEORIGIN
# < Set-Cookie: AEC=Ae3NU9Nf2b8VcyzvNeUwJ8BRqswj9ZwLzRocK-cNggFOpCvbR23FNIaZnbs; expires=Sat, 28-Sep-2024 12:07:04 GMT; path=/; domain=.google.at; Secure; HttpOnly; SameSite=lax
# < Accept-Ranges: none
# < Vary: Accept-Encoding
# < Transfer-Encoding: chunked
# < 
# { [11811 bytes data]
# * Connection #0 to host www.google.at left intact

_otel_pipe_curl_stderr() {
  local is_verbose="$1"
  local span_handle=""
  local host=""
  local ip=""
  local port=""
  local is_receiving=1
  while read -r line; do
    if _otel_string_starts_with "$line" "* Connected to "; then
      local host="$(\printf '%s' "$line" | \cut -d ' ' -f 4)"
      local ip="$(\printf '%s' "$line" | \cut -d ' ' -f 5 | \tr -d '()')"
      local port="$(\printf '%s' "$line" | \cut -d ' ' -f 7)"
    fi
    if \[ -n "$span_handle" ] && _otel_string_starts_with "$line" "* processing: "; then otel_span_end "$span_handle"; local span_handle=""; fi
    if \[ -n "$span_handle" ] && _otel_string_starts_with "$line" "* Connected to "; then otel_span_end "$span_handle"; local span_handle=""; fi
    if \[ -n "$span_handle" ] && \[ "$is_receiving" = 1 ] && _otel_string_starts_with "$line" "> "; then otel_span_end "$span_handle"; local span_handle=""; fi
    if \[ -z "$span_handle" ] && \[ -n "$host" ] && \[ -n "$ip" ] && \[ -n "$port" ] && _otel_string_starts_with "$line" "> " && \[ "$is_receiving" = 1 ]; then
      local is_receiving=0
      local protocol="$(\printf '%s' "$line" | \cut -d ' ' -f 4 | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"
      if \[ "$protocol" = http ] && \[ "$port" = 443 ]; then local protocol=https; fi
      local path_and_query="$(\printf '%s' "$line" | \cut -d ' ' -f 3)"
      local span_handle="$(otel_span_start CLIENT "$(\printf '%s' "$line" | \cut -d ' ' -f 2)")"
      otel_span_attribute_typed "$span_handle" string network.transport=tcp
      otel_span_attribute_typed "$span_handle" string network.protocol.name="$protocol"
      otel_span_attribute_typed "$span_handle" string network.protocol.version="$(\printf '%s' "$line" | \cut -d ' ' -f 4 | \cut -d / -f 2)"
      otel_span_attribute_typed "$span_handle" string network.peer.address="$ip"
      otel_span_attribute_typed "$span_handle" int network.peer.port="$port"
      otel_span_attribute_typed "$span_handle" string server.address="$host"
      otel_span_attribute_typed "$span_handle" int server.port="$port"
      otel_span_attribute_typed "$span_handle" string url.full="$protocol://$host:$port$path_and_query"
      otel_span_attribute_typed "$span_handle" string url.path="$(\printf '%s' "$path_and_query" | \cut -d ? -f 1)"
      otel_span_attribute_typed "$span_handle" string url.query="$(\printf '%s' "$path_and_query" | \cut -sd ? -f 2-)"
      otel_span_attribute_typed "$span_handle" string url.scheme="$protocol"
      otel_span_attribute_typed "$span_handle" string http.request.method="$(\printf '%s' "$line" | \cut -d ' ' -f 2)"
      otel_span_attribute_typed "$span_handle" string user_agent.original=curl
    fi
    if \[ -n "$span_handle" ]; then
      if _otel_string_starts_with "$line" "< HTTP/"; then
        local response_code="$(\printf '%s' "$line" | \cut -d ' ' -f 3)"
        otel_span_attribute_typed "$span_handle" int http.response.status_code="$response_code"
        if \[ "$response_code" -ge 400 ]; then otel_span_error "$span_handle"; fi
      elif _otel_string_starts_with "$line" "} [" && _otel_string_contains "bytes data]"; then
        otel_span_attribute_typed "$span_handle" int http.request.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d '[')"
      elif _otel_string_starts_with "$line" "{ [" && _otel_string_contains "bytes data]"; then
        otel_span_attribute_typed "$span_handle" int http.response.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d '[')"
      elif _otel_string_starts_with "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "> user-agent: "; then
        otel_span_attribute_typed "$span_handle" string user_agent.original="$(\printf '%s' "$line" | \cut -d ' ' -f 3-)"
      elif _otel_string_starts_with "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "> content-length: "; then
        otel_span_attribute_typed "$span_handle" int http.request.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 3)"
      elif _otel_string_starts_with "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "< content-length: "; then
        otel_span_attribute_typed "$span_handle" int http.response.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 3)"
      fi
      if _otel_string_starts_with "$line" "> " && _otel_string_contains "$line" ": " && ! _otel_string_contains "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "authorization: " && ! _otel_string_contains "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "token: " && ! _otel_string_contains "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "key: "; then
        otel_span_attribute_typed "$span_handle" string[1] http.request.header."$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d ':' | \tr '[:upper:]' '[:lower:]')"="$(\printf '%s' "$line" | \cut -d ' ' -f 3-)"
      elif _otel_string_starts_with "$line" "< " && _otel_string_contains "$line" ": "; then
        otel_span_attribute_typed "$span_handle" string[1] http.response.header."$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d ':' | \tr '[:upper:]' '[:lower:]')"="$(\printf '%s' "$line" | \cut -d ' ' -f 3-)"
      fi
    fi
    if _otel_string_starts_with "$line" "< "; then local is_receiving=1; fi
    if \[ "$is_verbose" = 1 ] || ! ( _otel_string_starts_with "$line" "* " || _otel_string_starts_with "$line" "> " || _otel_string_starts_with "$line" "< " || _otel_string_starts_with "$line" "{ " || _otel_string_starts_with "$line" "} " ); then
      \echo "$line"
    fi
  done
  if \[ -n "$span_handle" ]; then otel_span_end "$span_handle"; fi
}

_otel_alias_prepend curl _otel_propagate_curl
