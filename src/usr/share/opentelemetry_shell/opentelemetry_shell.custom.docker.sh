#!/bin/false

_otel_inject_docker_args() {
  # docker command
  local executable="$1"
  local executable="${executable#\\}"
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
  if \[ "$OTEL_SHELL_EXPERIMENTAL_INJECT_CONTAINERS" = TRUE ] && \[ "$command" = run ] && \docker run --rm --entrypoint cat "$image" /etc/os-release | \grep -E '^NAME=' | \grep -qE 'Debian|Ubuntu|Alpine Linux'; then
    local pipes_dir="$(\mktemp -u)_opentelemetry_shell_$$.docker"; \mkdir -p "$pipes_dir"
    for file in $(\dpkg -L opentelemetry-shell | \grep -E '^/usr/bin/'); do \echo -n ' '; _otel_escape_args --mount type=bind,source="$file",target="$file",readonly; done
    \echo -n ' '; _otel_escape_args --mount type=bind,source=/usr/share/opentelemetry_shell,target=/usr/share/opentelemetry_shell
    for kvp in $(\printenv | \grep '^OTEL_' | \cut -d = -f 1); do \echo -n ' '; _otel_escape_args --env "$kvp"; done
    \echo -n ' '; _otel_escape_args --mount type=bind,source="$_otel_remote_sdk_pipe",target=/var/opentelemetry_shell"$_otel_remote_sdk_pipe"
    \echo -n ' '; _otel_escape_args --env OTEL_REMOTE_SDK_PIPE=/var/opentelemetry_shell"$_otel_remote_sdk_pipe"
    \echo -n ' '; _otel_escape_args --mount type=bind,source="$pipes_dir",target=/tmp"
    \echo -n ' '; _otel_escape_args --env OTEL_SHELL_RESPONSE_PIPE_MOUNT="$pipes_dir";
    \echo -n ' '; _otel_escape_args --env OTEL_SHELL_AUTO_INJECTED=TRUE
    \echo -n ' '; _otel_escape_args --env OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$("$executable" inspect "$image" | \jq -r '.[0].Config.Entrypoint[]?')"
    \echo -n ' '; _otel_escape_args --entrypoint /bin/sh
    \echo -n ' '; _otel_escape_arg "$1"; shift
    \echo -n ' '; _otel_escape_args -c '. otel.sh
eval "$(_otel_escape_args "$@")"' sh
    \echo -n ' '; "$executable" inspect "$image" | \jq -r '.[0].Config.Entrypoint[]?' | _otel_escape_stdin
    if \[ "$#" = 0 ]; then \echo -n ' '; "$executable" inspect "$image" | \jq -r '.[0].Config.Cmd[]?' | _otel_escape_stdin; fi
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
_otel_alias_prepend podman _otel_inject_docker
