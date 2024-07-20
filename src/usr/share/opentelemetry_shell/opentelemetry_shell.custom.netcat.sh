#!/bin/false

# write | netcat 127.0.0.1 8080 | read
# netcat -l -p 8080 | read
# netcat -l -p 8080 -e respond

# Limitations:
# *) first line will be buffered on both request and response, so if there is a prompt/challenge like protocol that works on single byte sequences without linefeed, that case will deadlock
# *) as soon as a request or response (individually) looks like HTTP, the instrumentation assumes its valid HTTP exchange and may deadlock if its not. meaning, lets imagine that there is netcat that always response with a valid HTTP response without actually receiving an HTTP request, or not respecting the protocol.

_otel_inject_netcat() {
  local name=send/receive
  if _otel_args_contains -l "$@" || _otel_args_contains --listen "$@" || _otel_args_contains -e "$@" || _otel_args_contains --exec "$@" || _otel_args_contains -c "$@" || _otel_args_contains --sh-exec "$@"; then
    if _otel_args_contains -e "$@" || _otel_args_contains --exec "$@" || _otel_args_contains -c "$@" || _otel_args_contains --sh-exec "$@"; then
      OTEL_SHELL_COMMANDLINE_OVERRIDE="$(_otel_dollar_star "$@")" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE=0 \eval _otel_call "$(_otel_inject_netcat_listen_and_respond_args "$@")"
    else
      local span_handle_file="$(\mktemp)"
      local exit_code_file="$(\mktemp)"
      \echo 0 > "$exit_code_file"
      local span_handle="$(otel_span_start CONSUMER "$name")"
      otel_span_activate "$span_handle"
      _otel_netcat_parse_args 0 "$span_handle" "$@" > /dev/null
      _otel_netcat_parse_response 1 "$span_handle_file" | { _otel_call "$@" || \echo "$?" > "$exit_code_file"; } | _otel_netcat_parse_request 1 "$span_handle_file" "$@"
      otel_span_deactivate "$span_handle"
      otel_span_end "$span_handle"
      local exit_code="$(\cat "$exit_code_file")"
      \rm "$span_handle_file" "$exit_code_file" 2> /dev/null
      return "$exit_code"
    fi
  else
    local span_handle_file="$(\mktemp)"
    local exit_code_file="$(\mktemp)"
    \echo 0 > "$exit_code_file"
    local span_handle="$(otel_span_start PRODUCER "$name")"
    otel_span_activate "$span_handle"
    _otel_netcat_parse_args 0 "$span_handle" "$@" > /dev/null
    _otel_netcat_parse_request 0 "$span_handle_file" "$@" | { _otel_call "$@" || \echo "$?" > "$exit_code_file"; } | _otel_netcat_parse_response 0 "$span_handle_file"
    otel_span_deactivate "$span_handle"
    otel_span_end "$span_handle"
    local exit_code="$(\cat "$exit_code_file")"
    \rm "$span_handle_file" "$exit_code_file" 2> /dev/null
    return "$exit_code"
  fi
}

_otel_inject_netcat_listen_and_respond_args() {
  local netcat_command="$(_otel_escape_args "$@")"
  _otel_escape_arg "$1"
  shift
  while \[ "$#" -gt 0 ]; do
    \echo -n ' '
    if (\[ "$1" = -e ] || \[ "$1" = --exec ] || \[ "$1" = -c ] || \[ "$1" = --sh-exec ]) && \[ "$#" -gt 1 ]; then
      local command="$2"; shift; shift
      # TODO the following injection doesnt maintain the exit code, does it matter though? is it important for netcat
      if \[ "$OTEL_SHELL_CONFIG_NETCAT_ASSUME_REQUEST_RESPONSE" = TRUE ]; then
        _otel_escape_args -c '
OTEL_SHELL_AUTO_INJECTED=TRUE
exit_code_file="$(mktemp)"
echo 0 > "$exit_code_file"
span_handle_file_0="$(mktemp -u)_opentelemetry_shell_$$.netcat.request.span_handle"
span_handle_file_1="$(mktemp -u)_opentelemetry_shell_$$.netcat.command.span_handle"
span_handle_file_2="$(mktemp -u)_opentelemetry_shell_$$.netcat.response.span_handle"
mkfifo "$span_handle_file_0" "$span_handle_file_1" "$span_handle_file_2"
(cat "$span_handle_file_0" | tee "$span_handle_file_1" | tee "$span_handle_file_2" > /dev/null &)
. otel.sh
span_handle="$(otel_span_start CONSUMER send/receive)"
otel_span_activate "$span_handle"
_otel_netcat_parse_args 1 "$span_handle" '"$netcat_command"' > /dev/null
_otel_netcat_parse_request 1 "$span_handle_file_0" '"$netcat_command"' | { otel_span_activate "$(\cat "$span_handle_file_1")"; '"$command"' || \echo "$!" > "$exit_code_file"; } | _otel_netcat_parse_response 1 "$span_handle_file_2"
otel_span_deactivate "$span_handle"
otel_span_end "$span_handle"
\rm "$span_handle_file_0" "$span_handle_file_1" "$span_handle_file_2" 2> /dev/null
exit "$(\cat "$exit_code_file")"
'
      else
        _otel_escape_args -c '
OTEL_SHELL_AUTO_INJECTED=TRUE
. otel.sh
span_handle="$(otel_span_start CONSUMER send/receive)"
otel_span_activate "$span_handle"
_otel_netcat_parse_args 1 "$span_handle" '"$netcat_command"' > /dev/null
exit_code=0
'"$command"' || exit_code=$?
otel_span_deactivate "$span_handle"
otel_span_end "$span_handle"
exit $exit_code
'
      fi
    else
      _otel_escape_arg "$1"; shift
    fi
  done
}

_otel_netcat_parse_request() {
  local is_server_side="$1"; shift
  local span_handle_file="$1"; shift
  if ! _otel_binary_read line; then
    \printf '%s' "$line" | _otel_binary_write
    return 0
  fi
  if _otel_binary_contains_null "$line" || ! _otel_string_starts_with "$(\printf '%s' "$line" | _otel_binary_write | \cut -sd ' ' -f 3)" HTTP/; then
    \printf '%s' "$line" | _otel_binary_write
    \printf '\n'
    \cat
    return 0
  fi
  local nc_span_handle="$(otel_span_current)"
  local nc_traceparent="$TRACEPARENT"
  local nc_tracestate="$TRACESTATE"
  local line="$(\printf '%s' "$line" | _otel_binary_write | \tr -d '\r')"
  local protocol="$(\printf '%s' "$line" | \cut -sd ' ' -f 3)"
  local method="$(\printf '%s' "$line" | \cut -sd ' ' -f 1)"
  local path_and_query="$(\printf '%s' "$line" | \cut -sd ' ' -f 2)"
  local headers="$(\mktemp)"
  while read -r line; do
    local line="$(\printf '%s' "$line" | \tr -d '\r')"
    if \[ "${#line}" = 0 ]; then break; fi
    \echo "$line" >> "$headers"
    if \[ "$is_server_side" = 1 ]; then
      local key="$(\printf '%s' "$line" | \cut -d ' ' -f 1 | \tr -d : | \tr '[:upper:]' '[:lower:]')"
      local value="$(\printf '%s' "$line" | \cut -d ' ' -f 2-)"
      if \[ "$key" = traceparent ]; then export TRACEPARENT="$value"; fi
      if \[ "$key" = tracestate ]; then export TRACESTATE="$value"; fi
      if \[ "$key" = 'content-length' ]; then local content_length="$value"; fi
    fi
  done
  if \[ "$is_server_side" = 1 ]; then local span_handle="$(otel_span_start SERVER "$method")"; else local span_handle="$(otel_span_start CLIENT "$method")"; fi
  \echo "$span_handle" > "$span_handle_file"
  if \[ "$TRACEPARENT" != "$nc_traceparent" ] || \[ "$TRACESTATE" != "$nc_tracestate" ]; then
    otel_span_activate "$span_handle"
    otel_link_add "$(otel_link_create "$TRACEPARENT" "$TRACESTATE")" "$nc_span_handle"
    otel_link_add "$(otel_link_create "$nc_traceparent" "$nc_tracestate")" "$span_handle"
    otel_span_deactivate
  fi
  local host_and_port="$(_otel_netcat_parse_args "$is_server_side" "$span_handle" "$@")"
  otel_span_attribute_typed "$span_handle" string network.protocol.name="$(\printf '%s' "$protocol" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"
  otel_span_attribute_typed "$span_handle" string network.protocol.version="$(\printf '%s' "$protocol" | \cut -d / -f 2-)"
  otel_span_attribute_typed "$span_handle" string url.full="$(\printf '%s' "$protocol" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')://$host_and_port$path_and_query"
  otel_span_attribute_typed "$span_handle" string url.path="$(\printf '%s' "$path_and_query" | \cut -d ? -f 1)"
  otel_span_attribute_typed "$span_handle" string url.query="$(\printf '%s' "$path_and_query" | \cut -sd ? -f 2-)"
  otel_span_attribute_typed "$span_handle" string url.scheme="$(\printf '%s' "$protocol" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"
  otel_span_attribute_typed "$span_handle" string http.request.method="$method"
  otel_span_attribute_typed "$span_handle" int http.request.body.size="${content_length:-0}"
  if \[ "$is_server_side" = 0 ]; then otel_span_attribute_typed "$span_handle" string user_agent.original=netcat; fi
  \printf '%s\r\n' "$method $path_and_query $protocol"
  if \[ "$is_server_side" = 0 ]; then
    otel_span_activate "$span_handle"
    \printf '%s\r\n' "traceparent: $TRACEPARENT"
    \printf '%s\r\n' "tracestate: $TRACESTATE"
    otel_span_deactivate "$span_handle"
  fi
  while read -r line; do
    \printf '%s\r\n' "$line"
    local key="$(\printf '%s' "$line" | \cut -d ' ' -f 1 | \tr -d : | \tr '[:upper:]' '[:lower:]')"
    local value="$(\printf '%s' "$line" | \cut -d ' ' -f 2-)"
    otel_span_attribute_typed "$span_handle" string[1] http.request.header."$key"="$value"
  done < "$headers"
  \printf '\r\n'
  if \[ -n "$length" ]; then # TODO this shoudl transparently pipe the entire request through, even if it is not in line with content-length (or content-length hasn't been set at all)
    \head -c "$length"
  fi
  \rm "$headers" 2> /dev/null
}

_otel_netcat_parse_response() {
  local is_server_side="$1"; shift
  local span_handle_file="$1"; shift  
  if ! _otel_binary_read line; then
    \printf '%s' "$line" | _otel_binary_write
    return 0
  fi
  if _otel_binary_contains_null "$line" || ! _otel_string_starts_with "$(\printf '%s' "$line" | _otel_binary_write)" HTTP/; then
    \printf '%s' "$line" | _otel_binary_write
    \printf '\n'
    \cat
    return 0
  fi
  local span_handle="$(\cat "$span_handle_file")"
  if \[ -z "$span_handle" ]; then
    \printf '%s' "$line" | _otel_binary_write
    \printf '\n'
    \cat
    return 0
  fi
  local line="$(\printf '%s' "$line" | _otel_binary_write | \tr -d '\r')"
  local protocol="$(\printf '%s' "$line" | \cut -sd ' ' -f 1)"
  local response_code="$(\printf '%s' "$line" | \cut -sd ' ' -f 2)"
  otel_span_attribute_typed "$span_handle" int http.response.status_code="$response_code"
  if \[ "$is_server_side" = 0 ] && \[ "$response_code" -ge 400 ]; then otel_span_error "$span_handle"; fi
  if \[ "$is_server_side" = 1 ] && \[ "$response_code" -ge 500 ]; then otel_span_error "$span_handle"; fi
  \printf '%s\r\n' "$line"
  while read -r line; do
    local line="$(\printf '%s' "$line" | \tr -d '\r')"
    \printf '%s\r\n' "$line"
    if \[ "${#line}" = 0 ]; then break; fi
    local key="$(\printf '%s' "$line" | \cut -d ' ' -f 1 | \tr -d : | \tr '[:upper:]' '[:lower:]')"
    local value="$(\printf '%s' "$line" | \cut -d ' ' -f 2-)"
    otel_span_attribute_typed "$span_handle" string[1] http.response.header."$key"="$value"
  done
  local body_size_pipe="$(\mktemp -u)"
  local body_size_file="$(\mktemp)"
  \mkfifo "$body_size_pipe"
  \wc -c < "$body_size_pipe" > "$body_size_file" &
  local pid="$!"
  \tee "$body_size_pipe"
  \wait "$pid"
  otel_span_attribute_typed "$span_handle" int http.response.body.size="$(\cat "$body_size_file")"
  \rm "$body_size_file" "$body_size_pipe" 2> /dev/null
  otel_span_end "$span_handle"
}

_otel_netcat_parse_args() {
  local is_server_side="$1"; shift
  local span_handle="$1"; shift
  local transport="${NCAT_PROTO:-tcp}"
  local host=""
  local ip=""
  local port=31337
  if \[ -n "$NCAT_PROTO" ]; then
    otel_span_attribute_typed "$span_handle" string network.peer.address="$NCAT_REMOTE_ADDR"
    otel_span_attribute_typed "$span_handle" int network.peer.port="$NCAT_REMOTE_PORT"
    if \[ "$is_server_side" = 1 ]; then
      otel_span_attribute_typed "$span_handle" string server.address="$NCAT_LOCAL_ADDR"
      otel_span_attribute_typed "$span_handle" int server.port="$NCAT_LOCAL_PORT"
      otel_span_attribute_typed "$span_handle" string client.address="$NCAT_REMOTE_ADDR"
      otel_span_attribute_typed "$span_handle" int client.port="$NCAT_REMOTE_PORT"
      local port="$NCAT_LOCAL_PORT"
    else
      otel_span_attribute_typed "$span_handle" string server.address="$NCAT_REMOTE_ADDR"
      otel_span_attribute_typed "$span_handle" int server.port="$NCAT_REMOTE_PORT"
      otel_span_attribute_typed "$span_handle" string client.address="$NCAT_LOCAL_ADDR"
      otel_span_attribute_typed "$span_handle" int client.port="$NCAT_LOCAL_PORT"
      local host="$NCAT_REMOTE_ADDR"
      local port="$NCAT_REMOTE_PORT"
    fi
  fi
  while \[ "$#" -gt 0 ]; do
      if \[ "$1" = -u ] || \[ "$1" = --udp ]; then local transport=udp
      elif \[ "$1" = --sctp ]; then local transport=sctp
      elif \[ "$1" = -p ] && \[ "$#" -ge 2 ]; then local port="$2"; shift
      elif _otel_string_starts_with "$1" - && \[ "$#" -gt 1 ] && _otel_is_netcat_arg_arg "$1"; then shift
      elif _otel_string_starts_with "$1" -; then \true
      else
        if \[ "$1" -eq "$1" ] 2> /dev/null; then
          local port="$1"
        elif _otel_is_ip "$1"; then
          local ip="$1"
          local host="$1"
        else
          local host="$1"
        fi
      fi
      shift
    done
    otel_span_attribute_typed "$span_handle" string network.transport="$transport"
    if \[ "$is_server_side" != 1 ]; then
      if \[ -n "$ip" ]; then otel_span_attribute_typed "$span_handle" string network.peer.address="$ip"; fi
      if \[ -n "$port" ]; then otel_span_attribute_typed "$span_handle" int network.peer.port="$port"; fi
    fi
    if \[ -n "$host" ]; then otel_span_attribute_typed "$span_handle" string server.address="$host"; fi
    if \[ -n "$port" ]; then otel_span_attribute_typed "$span_handle" int server.port="$port"; fi
    \echo "$host:$port"
}

_otel_is_ip() {
  case "$1" in
    *.*.*.*)
      for part in $(\echo "$1" | \tr '.' ' '); do
        case "$part" in
          ""|*[!0-9]*) return 1;;
        esac
      done
      return 0;;
    *:*:*:*:*:*:*:*)
      for part in $(\echo "$1" | \tr ':' ' '); do
        case "$part" in
          ""|*[!0-9a-fA-F]*) return 1;;
        esac
      done
      return 0;;
  esac
  return 1
}

_otel_is_netcat_arg_arg() {
  # https://man7.org/linux/man-pages/man1/ncat.1.html
  case "$1" in
    -i|--idle-timeout) return 0;;
    -P) return 0;;
    -T) return 0;;
    -w|--wait) return 0;;
    -x) return 0;;
    -X) return 0;;
    -L) return 0;;
    -e|--exec) return 0;;
    -c|--sh-exec) return 0;;
    --lua-exec) return 0;;
    -g) return 0;;
    -G) return 0;;
    -b) return 0;;
    -q) return 0;;
    -m|--max-conns) return 0;;
    -I) return 0;;
    -O) return 0;;
    -S) return 0;;
    -R) return 0;;
    -d|--delay) return 0;;
    -o|--output) return 0;;
    -x|--hexdump) return 0;;
    -p|--source-port) return 0;;
    -s|--source) return 0;;
    --proxy|--proxy-type|--proxy-auth|--proxy-dns) return 0;;
     *) return 1;;
  esac
}

_otel_binary_contains_null() {
  local string="$1"
  if ! _otel_string_contains "$string" 00; then return 1; fi
  local i=0
  while \[ "$i" -lt "${#string}" ]; do
    if \[ "$(\printf '%s' "$string" | \cut -c $((i + 1))-$((i + 1 + 2 - 1)))" = 00 ]; then return 0; fi
    local i=$(($i + 2))
  done
  return 1
}

_otel_binary_read() {
  local var="$1"
  local __line=""
  local eos=0
  while \true; do
    local byte="$(\dd bs=1 count=1 2> /dev/null | \xxd -p)"
    if \[ "$byte" = '' ]; then local eos=1; break; fi
    if \[ "$byte" = 0a ]; then break; fi
    local __line="$__line$byte"
  done
  \eval "$var='$__line'"
  return "$eos"
}

_otel_binary_write() {
  \xxd -r -p
}

_otel_args_contains() {
  local needle="$1"; shift
  for _otel_netcat_arg in "$@"; do
    if \[ "$_otel_netcat_arg" = "$needle" ]; then return 0; fi
  done
  return 1
}

_otel_alias_prepend nc _otel_inject_netcat
_otel_alias_prepend ncat _otel_inject_netcat
_otel_alias_prepend netcat _otel_inject_netcat
