#!/bin/false

# curl -v https://www.google.at => curl -v https://www.google.at -H 'traceparent: 00-XXXXXX-01'

_otel_propagate_curl() {
  case "$-" in
    *m*) local job_control=1; \set +m;;
    *) local job_control=0;;
  esac
  local command="$(_otel_dollar_star "$@")"
  if _otel_string_contains "$command" " -v "; then local is_verbose=0; fi
  local url=$(printf '%s' "$command" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local span_id="$(otel_span_current)"
  otel_span_attribute "$span_id" network.protocol.name=http
  otel_span_attribute "$span_id" network.transport=tcp
  if _otel_string_contains "$command" " -X "; then
    otel_span_attribute "$span_id" http.request.method="$(\printf '%s' "$command" | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')"
  elif _otel_string_contains "$command" " -d " || _otel_string_contains "$command" " --data "; then
    otel_span_attribute "$span_id" http.request.method=POST
  elif _otel_string_contains "$command" " --head "; then
    otel_span_attribute "$span_id" http.request.method=HEAD
  else
    otel_span_attribute "$span_id" http.request.method=GET
  fi
  otel_span_attribute "$span_id" "server.address=$(\printf '%s' "$url" | \cut -d / -f 3 | \cut -d : -f 1)"
  otel_span_attribute "$span_id" "server.port=$(\printf '%s' "$url" | \cut -d / -f 3 | \cut -sd : -f 2)"
  otel_span_attribute "$span_id" "url.full=$url"
  otel_span_attribute "$span_id" "url.path=/$(\printf '%s' "$url" | \cut -d / -f 4- | \cut -d ? -f 1)"
  otel_span_attribute "$span_id" "url.query=$(\printf '%s' "$url" | \cut -sd ? -f 2-)"
  otel_span_attribute "$span_id" "url.scheme=$(\printf '%s' "$url" | \cut -sd : -f 1)"
  otel_span_attribute "$span_id" user_agent.original=curl
  local stderr_pipe="$(\mktemp -u)_opentelemetry_shell_$$.stderr.curl.pipe"
  \mkfifo "$stderr_pipe"
  while read -r line; do _otel_parse_curl_output "$span_id" "$line"; if \[ "$is_verbose" = 1 ]; then \echo "$line" >&2; fi; done < "$stderr_pipe" &
  local stderr_pid="$!"
  local exit_code=0
  _otel_call "$@" -H "traceparent: $OTEL_TRACEPARENT" -v 2> "$stderr_pipe" || exit_code="$?"
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

_otel_parse_curl_output() {
  local span_id="$1"
  local line="$2"
  if _otel_string_starts_with "$line" "* Connected to "; then
    otel_span_attribute "$span_id" network.peer.address="$(\printf '%s' "$line" | \cut -d ' ' -f 5 | \tr -d '()')"
    otel_span_attribute "$span_id" network.peer.port="$(\printf '%s' "$line" | \cut -d ' ' -f 7)"    
  elif _otel_string_starts_with "$line" "> HTTP/"; then
    otel_span_attribute "$span_id" http.response.status_code="$(\printf '%s' "$line" | \cut -d ' ' -f 3)"
  elif _otel_string_starts_with "$line" "{ [" && _otel_string_contains "bytes data]"; then
    otel_span_attribute "$span_id" http.response.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d '[')"
  elif _otel_string_starts_with "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "> user-agent: "; then
    otel_span_attribute "$span_id" user_agent.original="$(\printf '%s' "$line" | \cut -d ' ' -f 3-)"
  elif _otel_string_starts_with "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "> content-length: "; then
    otel_span_attribute "$span_id" http.request.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2-)"
  elif _otel_string_starts_with "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "< content-length: "; then
    otel_span_attribute "$span_id" http.response.body.size="$(\printf '%s' "$line" | \cut -d ' ' -f 2-)"
  fi
  if _otel_string_starts_with "$line" "> " && _otel_string_contains "$line" ": " && ! _otel_string_contains "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "authorization: " && ! _otel_string_contains "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "token: " && ! _otel_string_contains "$(\printf '%s' "$line" | \tr '[:upper:]' '[:lower:]')" "key: "; then
    otel_span_attribute "$span_id" http.request.header."$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d ':' | \tr '[:upper:]' '[:lower:]')"="$(\printf '%s' "$line" | \cut -d ' ' -f 3-)"
  elif _otel_string_starts_with "$line" "< " && _otel_string_contains "$line" ": "; then
    otel_span_attribute "$span_id" http.request.header."$(\printf '%s' "$line" | \cut -d ' ' -f 2 | \tr -d ':' | \tr '[:upper:]' '[:lower:]')"="$(\printf '%s' "$line" | \cut -d ' ' -f 3-)"
  fi
}

_otel_alias_prepend curl 'OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT _otel_propagate_curl'
