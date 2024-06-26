#!/bin/false

# write | netcat 127.0.0.1 8080 | read
# netcat -l -p 8080 | read
# netcat -l -p 8080 -e respond

_otel_propagate_netcat_read() {
  \cat # TODO
}

_otel_propagate_netcat_write() {
  \cat # TODO  
}

_otel_propagate_netcat() {
  if _otel_args_contains -l "$@" || _otel_args_contains --listen "$@"; then
    # TODO
  else
    local exit_code_file="$(\mktemp)"
    \echo 0 > "$exit_code_file"
    local span_handle="$(otel_span_start CLIENT send/receive)"
    _otel_propagate_netcat_parse "$span_handle" "$@"
    otel_span_activate "$span_handle"
    _otel_propagate_netcat_write "$span_handle" | { _otel_call "$@" || \echo "$?" > "$exit_code_file"; } | _otel_propagate_netcat_read "$span_handle"
    otel_span_deactivate "$span_handle"
    otel_span_end "$span_handle"
    return "$(\cat "$exit_code_file")"
  fi
}

_otel_propagate_netcat_parse() {
  local span_handle="$1"
  # TODO use -u and --udp to set type to udp not tcp
  # TODO set bunch of default arguments
}

_otel_args_contains() {
  local needle="$1"; shift
  for _otel_netcat_arg in "$@"; do
    if \[ "$_otel_netcat_arg" = "$needle" ]; then return 0; fi
  done
  return 1
}

_otel_alias_prepend nc _otel_propagate_netcat
_otel_alias_prepend ncat _otel_propagate_netcat
_otel_alias_prepend netcat _otel_propagate_netcat
