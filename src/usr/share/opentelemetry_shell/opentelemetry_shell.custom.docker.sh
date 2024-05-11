#!/bin/false

_otel_inject_docker_args() {
  _otel_escape_arg "$1"
  shift
  while \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; do
    echo -n ' '
    _otel_escape_arg "$1"
    if _otel_string_contains "$1" =; then
      shift
      echo -n ' '
      _otel_escape_arg "$1"
    fi
    shift
  done
  local command="$1"
  echo -n ' '
  _otel_escape_arg "$1"
  shift
  if \[ "$command" = run ]; then
    _otel_escape_arg " --env OTEL_TRACEPARENT=$OTEL_TRACEPARENT"
  fi
  while \[ "$#" -gt 0 ]; do
    echo -n ' '
    _otel_escape_arg "$1"
    shift
  done
}

_otel_inject_docker() {
  \eval _otel_call "$(_otel_inject_docker_args "$@")"
}

_otel_alias_prepend docker _otel_inject_docker
