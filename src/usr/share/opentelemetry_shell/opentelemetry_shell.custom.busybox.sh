#!/bin/false

# busybox find -iname '*.txt' => busybox sh -c '.otel.sh; eval "$(_otel_escape_args "$@")' sh find -iname '*.txt'

_otel_inject_find_arguments() {
  local IFS=' 
'
  _otel_escape_arg "$1"
  shift
  local in_exec=0
  for arg in "$@"; do
    \echo -n ' '
    if \[ "$in_exec" -eq 0 ] && (\[ "$arg" = "-exec" ] || \[ "$arg" = "-execdir" ]); then
      local in_exec=1
      \echo -n "$arg $_otel_shell -c '. otel.sh
"
    elif \[ "$in_exec" -eq 1 ] && \[ "$arg" = "{}" ]; then
      \echo -n '"$@"'
    elif \[ "$in_exec" -eq 1 ] && (\[ "$arg" = ";" ] || \[ "$arg" = "+" ]); then
      local in_exec=0
      \echo -n "' find {} '$arg'"
    else
      if \[ "$in_exec" = 1 ]; then
        no_quote=1 _otel_escape_arg "$(_otel_escape_arg "$arg")"
      else
        _otel_escape_arg "$arg"
      fi
    fi
  done
}

_otel_inject_busybox() {
  if \[ "$#" -gt 0 ] && _otel_string_starts_with "$1" -; then
    _otel_call "$@"
    return "$?"
  fi
  local command="$1"; shift
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$cmdline" "$command" sh -c '.otel.sh
eval "$(_otel_escape_args "$@")' sh "$@"
}

_otel_alias_prepend busybox _otel_inject_busybox
