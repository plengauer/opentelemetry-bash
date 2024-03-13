#!/bin/false

# sh => sh
# sh -E => sh -E
# sh -x ./script.sh foo bar => ... its complicated ...
# bash -x -c 'echo hello world' => ... its complicated ...
# bash -x -c 'echo $0 $1 $2' bash foo bar => ... its complicated ...

_otel_inject_shell_args_with_copy() {
  local temporary_script="$1"
  shift
  local is_script=0
  # command
  if \[ "$1" = "_otel_observe" ]; then _otel_escape_arg "$1"; \echo -n " "; shift; fi
  local shell="$1"
  _otel_escape_arg "$1"; \echo -n " "
  shift
  # options and script or command string
  local found_inner=0
  while \[ "$#" -gt 0 ]; do
    if \[ "$1" = "-c" ]; then
      shift; local is_script=0; local found_inner=1; break
    else
      case "$1" in
        -*file) _otel_escape_arg "$1"; \echo -n " "; shift; _otel_escape_arg "$1"; \echo -n " " ;;
            -*) _otel_escape_arg "$1"; \echo -n " " ;;
             *) local is_script=1; local found_inner=1; break ;;
      esac
    fi
    shift
  done
  local command="$1"
  shift
  # abort in case its interactive or invalid aguments
  if \[ "$found_inner" -eq 0 ]; then return 0; fi 
  # finish command
  _otel_escape_arg "-c"
  \echo -n " "
  _otel_escape_arg ". '$temporary_script'"
  \echo -n " "
  if \[ "$is_script" -eq 1 ]; then _otel_escape_arg "$command"; elif \[ "$#" -gt 0 ]; then _otel_escape_arg "$1"; shift; else _otel_escape_arg "$shell"; fi
  # setup temporary script
  \touch "$temporary_script"
  \chmod +x "$temporary_script"
  \echo "OTEL_SHELL_AUTO_INSTRUMENTATION_HINT=\"$temporary_script\"" >> "$temporary_script"
  \echo ". /usr/bin/opentelemetry_shell.sh" >> "$temporary_script"
  \echo "\set -- $(_otel_escape_args "$@")" >> "$temporary_script"
  (if \[ "$is_script" -eq 1 ]; then \cat "$command"; else \echo "$command"; fi) >> "$temporary_script"
}

_otel_inject_shell_with_copy() {
  local cmdline="$({ set -- "$@"; if \[ "$1" = "_otel_observe" ]; then shift; fi; \echo -n "$*"; })"
  local temporary_script="$(\mktemp -u)"
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$(\echo "$cmdline" | _otel_line_join)" \
    \eval "$(_otel_inject_shell_args_with_copy "$temporary_script" "$@")" || local exit_code=$? # should we do \eval _otel_call "$(.....)" here? is it safer concerning transport of the OTEL control variables?
  \rm "$temporary_script" || true
  return $exit_code
}

_otel_alias_prepend sh _otel_inject_shell_with_copy # cant really know what kind of shell it actually is, so lets play it safe
_otel_alias_prepend ash _otel_inject_shell_with_copy # sourced files do not support arguments
_otel_alias_prepend dash _otel_inject_shell_with_copy # sourced files do not support arguments
