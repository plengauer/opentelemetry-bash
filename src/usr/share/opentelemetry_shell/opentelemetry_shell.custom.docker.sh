#!/bin/false

# TODO make it experimental configurable

_otel_inject_docker_args() {
  # docker command
  _otel_escape_arg "$1"; shift
  # skip arguments
  while \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; do
    \echo -n ' '; _otel_escape_arg "$1"
    if ! _otel_string_contains "$1" = && ! _otel_string_starts_with "$2" -; then
      shift
      \echo -n ' '; _otel_escape_arg "$1"
    fi
    shift
  done
  # extract and skip command
  local command="$1"
  \echo -n ' '; _otel_escape_arg "$1"; shift
  # skip more arguments
  while \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; do
    \echo -n ' '; _otel_escape_arg "$1"
    if ! _otel_string_contains "$1" = && ! _otel_string_starts_with "$2" -; then
      shift
      \echo -n ' '; _otel_escape_arg "$1"
    fi
    shift
  done
  # extract image
  local image="$1"
  if \[ "$command" = run ] && \docker run --rm --entrypoint cat "$image" /etc/os-release | \grep -E '^NAME=' | \grep -qE 'Debian|Ubuntu|Alpine Linux'; then
    for kvp in $(\printenv | \grep '^OTEL_' | \cut -d = -f 1); do \echo -n ' '; _otel_escape_args --env "$kvp"; done
    for file in $(\dpkg -L opentelemetry-shell | \grep -vE '^/.$' | \grep -vE '^/usr$' | \grep -vE '^/usr/bin$' | \grep -vE '^/usr/share$' | \grep -vE '^/opt/'); do \echo -n ' '; _otel_escape_args --mount type=bind,source="$file",target="$file",readonly; done
    # \echo -n ' '; _otel_escape_args --mount type=bind,source=/tmp,target=/tmp # TODO use TMPDIR?, also this is a huge security risk!
    \echo -n ' '; _otel_escape_args --mount type=bind,source="$_otel_remote_sdk_pipe",target="$_otel_remote_sdk_pipe"; \chmod 666 "$_otel_remote_sdk_pipe"
    \echo -n ' '; _otel_escape_args --env OTEL_REMOTE_SDK_PIPE="$_otel_remote_sdk_pipe"
    \echo -n ' '; _otel_escape_args --env OTEL_SHELL_AUTO_INJECTED=TRUE
    \echo -n ' '; _otel_escape_args --entrypoint /bin/sh
    \echo -n ' '; _otel_escape_arg "$1"; shift
    \echo -n ' '; _otel_escape_args -c ". otel.sh
$(\docker inspect "$image" | \jq -r '.[0].Config.Entrypoint[]' | _otel_line_join) "'"$@"' sh
    if \[ "$#" = 0 ]; then \echo -n ' '; \docker inspect "$image" | \jq -r '.[0].Config.Cmd[]?' | _otel_escape_stdin; fi
  else
    \echo -n ' '; _otel_escape_arg "$1"; shift
  fi
  # just skip the rest
  while \[ "$#" -gt 0 ]; do \echo -n ' '; _otel_escape_arg "$1"; shift; done
}

_otel_inject_docker() {
  \eval _otel_call "$(_otel_inject_docker_args "$@")"
}

_otel_alias_prepend docker _otel_inject_docker
