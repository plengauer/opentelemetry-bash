#!/bin/false

# write | netcat 127.0.0.1 8080 | read
# netcat -l -p 8080 | read
# netcat -l -p 8080 -e respond

_otel_inject_netcat() {
  if _otel_args_contains -l "$@" || _otel_args_contains --listen "$@" || _otel_args_contains -e "$@" || _otel_args_contains --exec "$@" || _otel_args_contains -c "$@" || _otel_args_contains --sh-exec "$@"; then
    if _otel_args_contains -e || _otel_args_contains --exec || _otel_args_contains -c || _otel_args_contains --sh-exec; then
      \eval _otel_call "$(_otel_inject_netcat_listen_and_respond_args "$@")"
    else
      local span_handle_file="$(\mktemp -u)"
      \mkfifo "$span_handle_file"
      local exit_code_file="$(\mktemp)"
      \echo 0 > "$exit_code_file"
      { _otel_call "$@" || \echo "$?" > "$exit_code_file"; } | _otel_netcat_parse_request 1 "$span_handle_file" "$@" | { local span_handle="$(\cat "$span_handle_file")"; \cat; otel_span_end "$span_handle"; }
      return "$(\cat "$exit_code_file")"
    fi
  else
    local span_handle_file="$(\mktemp -u)"
    \mkfifo "$span_handle_file"
    local exit_code_file="$(\mktemp)"
    \echo 0 > "$exit_code_file"
    _otel_netcat_parse_request 0 "$span_handle_file" "$@" | { _otel_call "$@" || \echo "$?" > "$exit_code_file"; } | _otel_netcat_parse_response 0 "$span_handle_file"
    return "$(\cat "$exit_code_file")"
  fi
}

_otel_inject_netcat_listen_and_respond_args() {
  _otel_escape_arg "$1"
  shift
  while \[ "$#" -gt 0 ]; do
    \echo -n ' '
    if (\[ "$1" = -e ] || \[ "$1" = --exec ] || \[ "$1" = -c ] || \[ "$1" = --sh-exec ]) && \[ "$#" -gt 1 ]; then
      local command="$2"; shift; shift
      local span_handle_file="$(\mktemp -u)"
      local span_handle_file_inner="$(\mktemp -u)"
      (\tee "$span_handle_file_inner" > "$span_handle_file" &)
      # TODO the following injection doesnt maintain the exit code, does it matter though? is it important for netcat?
      _otel_escape_args -c "OTEL_SHELL_AUTO_INJECTED=FALSE
. otel.sh
\mkfifo '$span_handle_file' '$span_handle_file_inner'
(\tee '$span_handle_file_inner' > '$span_handle_file' &)
_otel_netcat_parse_request 1 '$span_handle_file' $(_otel_escape_args "$@") | { otel_span_activate \$(\cat '$span_handle_file_inner'); $command; } | _otel_netcat_parse_response 1 '$span_handle_file'
\rm '$span_handle_file' '$span_handle_file_inner' 2> /dev null"
    else
      _otel_escape_arg "$1"; shift
    fi
  done
}

_otel_netcat_parse_request() {
  local is_server_side="$1"; shift
  local span_handle_file="$1"; shift
  read -r method path_and_query protocol
  if ! _otel_string_starts_with "$protocol" HTTP/; then
    if \[ "$is_server_side" = 1 ]; then local span_handle="$(otel_span_start SERVER send/receive)"; else local span_handle="$(otel_span_start CLIENT send/receive)"; fi
    \echo "$span_handle" > "$span_handle_file"
    _otel_netcat_parse_args "$span_handle" "$@" > /dev/null
    \echo "$method" "$path_and_query" "$protocol"
    \cat
    return 0
  fi
  if \[ "$is_server_side" = 1 ]; then local span_handle="$(otel_span_start SERVER "$method")"; else local span_handle="$(otel_span_start CLIENT "$method")"; fi
  \echo "$span_handle" > "$span_handle_file"
  local host_and_port="$(_otel_netcat_parse_args "$span_handle" "$@")"
  otel_span_attribute_typed "$span_handle" string network.protocol.name="$(\printf '%s' "$protocol" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"
  otel_span_attribute_typed "$span_handle" string network.protocol.version="$(\printf '%s' "$protocol" | \cut -d / -f 2-)"
  otel_span_attribute_typed "$span_handle" string url.full=""$(\printf '%s' "$protocol" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"://$host_and_port$path_and_query"
  otel_span_attribute_typed "$span_handle" string url.path="$(\printf '%s' "$path_and_query" | \cut -d ? -f 1)"
  otel_span_attribute_typed "$span_handle" string url.query="$(\printf '%s' "$path_and_query" | \cut -sd ? -f 2-)"
  otel_span_attribute_typed "$span_handle" string url.scheme="$(\printf '%s' "$protocol" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"
  otel_span_attribute_typed "$span_handle" string http.request.method="$method"
  otel_span_attribute_typed "$span_handle" string user_agent.original=netcat
  \echo "$method" "$path_and_query" "$protocol"
  otel_span_activate "$span_handle"  
  \echo traceparent: "$TRACEPARENT"
  \echo tracestate: "$TRACESTATE"
  otel_span_deactivate "$span_handle"
  while read -r line; do
    \echo "$line"
    if \[ "${#line}" = 1 ]; then break; fi
    local key="$(\printf '%s' "$line" | \cut -d ' ' -f 1 | \tr -d : | \tr '[:upper:]' '[:lower:]')"
    local value="$(\printf '%s' "$line" | \cut -d ' ' -f 2-)"
    otel_span_attribute_typed "$span_handle" string[1] http.request.header."$key"="$value"
  done
  local body_size_pipe="$(\mktemp -u)"
  local body_size_file="$(\mktemp)"
  \mkfifo "$body_size_pipe"
  \wc -c < "$body_size_pipe" > "$body_size_file" &
  local pid="$!"
  \tee "$body_size_pipe"
  \wait "$pid"
  otel_span_attribute_typed "$span_handle" int http.request.body.size="$(\cat "$body_size_file")"
  \rm "$body_size_file" "$body_size_pipe" 2> /dev/null
}

_otel_netcat_parse_response() {
  local is_server_side="$1"; shift
  local span_handle_file="$1"; shift
  local span_handle="$(\cat "$span_handle_file")"
  read -r protocol response_code response_message
  \echo "$protocol" "$response_code" "$response_message"
  if ! _otel_string_starts_with "$protocol" HTTP/; then
    \cat
    otel_span_end "$span_handle"
    return 0
  fi
  otel_span_attribute_typed "$span_handle" int http.response.status_code="$response_code"
  if \[ "$is_server_side" = 0 ] && \[ "$response_code" -ge 400 ]; then otel_span_error "$span_handle"; fi
  if \[ "$is_server_side" = 1 ] && \[ "$response_code" -ge 500 ]; then otel_span_error "$span_handle"; fi
  while read -r line; do
    \echo "$line"
    if \[ "${#line}" = 1 ]; then break; fi
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
  local span_handle="$1"; shift
  local transport=tcp
  local host=""
  local ip=""
  local port=31337
  local is_listening=0
  shift
  while \[ "$#" -gt 0 ]; do
    if \[ "$1" = -l ] || \[ "$1" = --listen ]; then
      local is_listening=1
    elif \[ "$1" = -u ] || \[ "$1" = --udp ]; then
      local transport=udp
    elif \[ "$1" = --sctp ]; then
      local transport=sctp
    elif _otel_string_starts_with "$1" - && \[ "$#" -gt 1 ] && _otel_is_netcat_arg_arg "$1"; then
      shift
    elif _otel_string_starts_with "$1" -; then
      \true
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
  if \[ "$is_listening" = 0 ]; then
    otel_span_attribute_typed "$span_handle" string network.peer.address="$ip"
    otel_span_attribute_typed "$span_handle" int network.peer.port="$port"
  fi
  otel_span_attribute_typed "$span_handle" string server.address="$host"
  otel_span_attribute_typed "$span_handle" int server.port="$port"
  \echo "$host:$port"
}

_otel_is_ip() {
  case "$1" in
    *.*.*.*)
      for part in $(echo "$1" | tr '.' ' '); do
        case "$part" in
          ""|*[!0-9]*) return 1;;
        esac
      done
      return 0;;
    *:*:*:*:*:*:*:*)
      for part in $(echo "$1" | tr ':' ' '); do
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
