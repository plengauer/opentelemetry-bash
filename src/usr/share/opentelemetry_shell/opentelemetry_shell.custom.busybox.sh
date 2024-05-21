#!/bin/false

_otel_inject_busybox() {
  if \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; then
    _otel_call "$@"
    return "$?"
  fi
  local command="$1"; shift
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  export OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline"
  export OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0"
  export OTEL_SHELL_AUTO_INJECTED=TRUE
  export OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$cmdline"
  \eval _otel_call "$(_otel_escape_args "$command" sh -c 'printenv | grep -E "^OTEL"
. otel.sh
alias
eval "$(_otel_escape_args "$@")"' sh "$@")"
}

_otel_alias_prepend busybox _otel_inject_busybox
