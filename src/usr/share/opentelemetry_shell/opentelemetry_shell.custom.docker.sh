#!/bin/false

# TODO check if docker container is compatible
# TODO make it experimental configurable
# TODO maybe the remote pipe shouldnt be variable (to avoid clashes for temp files)

_otel_inject_docker_args() {
  # docker command
  _otel_escape_arg "$1"; shift
  # skip arguments
  while \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; do
    \echo -n ' '; _otel_escape_arg "$1"
    if ! _otel_string_contains "$1" =; then
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
    if ! _otel_string_contains "$1" =; then
      shift
      \echo -n ' '; _otel_escape_arg "$1"
    fi
    shift
  done
  # extract image
  local image="$1"
  if \[ "$command" = run ]; then
    for kvp in $(\printenv | \grep '^OTEL_'); do \echo -n ' '; _otel_escape_args --env "$kvp"; done
    for file in $(\dpkg -L opentelemetry-shell); do \echo -n ' '; _otel_escape_args --mount type=bind,source="$file",target="$file",readonly; done
    \echo -n ' '; _otel_escape_args --mount type=bind,source="$_otel_remote_sdk_pipe",target="/opt/opentelemetry_shell/pipe"
    \echo -n ' '; _otel_escape_args --env "OTEL_SHELL_AUTO_INJECTED=TRUE"
    \echo -n ' '; _otel_escape_args --entrypoint /bin/sh
    \echo -n ' '; _otel_escape_arg "$1"; shift
    \echo -n ' '; _otel_escape_args -c '. otel.sh
"$@"' 'sh'
    \echo -n ' '; \docker inspect "$image" | \jq -r .[0].Config.Entrypoint[] | _otel_escape_stdin
    \echo -n ' '; \docker inspect "$image" | \jq -r .[0].Config.Cmd[] | _otel_escape_stdin
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
