#!/bin/false

# busybox find -iname '*.txt' => busybox sh -c '.otel.sh; eval "$(_otel_escape_args "$@")' sh find -iname '*.txt'

_otel_inject_busybox() {
  if \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; then
    _otel_call "$@"
    return "$?"
  fi
  shift
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$cmdline" _otel_call _otel_escape_args \busybox sh -c '. otel.sh
eval "$(_otel_escape_args "$@")"' sh "$@"
}

_otel_alias_prepend busybox _otel_inject_busybox
