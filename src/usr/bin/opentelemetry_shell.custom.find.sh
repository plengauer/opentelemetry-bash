#!/bin/false

# find . => find .
# find . -iname "*.txt" => find . -iname "*.txt"
# find . -exec rm {} ';' -iname "*.txt" => find . -exec sh -c '. /otel.sh; rm "$@"' find {} ';' -iname "*.txt"
# find . -exec rm {} + -iname "*.txt" => find . -exec sh -c '. /otel.sh; rm "$@"' find {} + -iname "*.txt"
# find . -execdir rm {} ';' -iname "*.txt" => find . -execdir sh -c '. /otel.sh; rm "$@"' find {} ';' -iname "*.txt"
# find . -execdir rm {} + -iname "*.txt" => find . -execdir sh -c '. /otel.sh; rm "$@"' find {} + -iname "*.txt"

_otel_inject_find_arguments() {
  local in_exec=0
  local first=1
  for arg in "$@"; do
    if [ "$first" = 1 ]; then local first=0; else \echo -n ' '; fi
    if [ "$in_exec" -eq 0 ] && ([ "$arg" = "-exec" ] || [ "$arg" = "-execdir" ]); then
      local in_exec=1
      \echo -n "$arg sh -c '. /usr/bin/opentelemetry_shell.sh
"
    elif [ "$in_exec" -eq 1 ] && [ "$arg" = "{}" ]; then
      \echo -n '"$@"'
    elif [ "$in_exec" -eq 1 ] && ([ "$arg" = ";" ] || [ "$arg" = "+" ]); then
      local in_exec=0
      \echo -n "' find {} '$arg'"
    else
      if [ "$in_exec" = 1 ]; then
        no_quote=1 _otel_escape_arg "$(_otel_escape_arg "$arg")"
      else
        _otel_escape_arg "$arg"
      fi
    fi
  done
}

_otel_inject_find() {
  if [ "$(\expr "$*" : ".* -exec .*")" -gt 0 ] || [ "$(\expr "$*" : ".* -execdir .*")" -gt 0 ]; then
    local cmdline="$({ set -- "$@"; if [ "$1" = "_otel_observe" ]; then shift; fi; \echo -n "$*"; })"
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$*" \
      eval "$(_otel_inject_find_arguments "$@")"
  else
    "$@"
  fi
}

_otel_alias_prepend find _otel_inject_find
