#!/bin/false

# bash => bash
# bash -E => bash -E
# bash -x ./script.sh foo bar => bash -x -c '. /otel.sh; . ./script.sh "$@"' ./my_script.sh foo bar
# bash -x -c 'echo hello world' => bash -x -c '. /otel.sh; echo hello world'
# bash -x -c 'echo $0 $1 $2' bash foo bar => bash -x -c '. /otel.sh; echo $0 $1 $2' bash foo bar

_otel_inject_shell_args_with_c_flag() {
  local injection=". /usr/bin/opentelemetry_shell.sh"
  # command
  if [ "$1" = "_otel_observe" ]; then _otel_escape_arg "$1"; \echo -n " "; shift; fi
  local dollar_zero="$1" # in case its not a script, $0 becomes the executable
  _otel_escape_arg "$1"; \echo -n " "
  shift
  # options and script or command string
  local found_inner=0
  while [ "$#" -gt 0 ]; do
    if [ "$1" = "-c" ]; then
      # we need a linebreak here for the aliases to work.
      shift; \echo -n "-c "; _otel_escape_arg ". /usr/bin/opentelemetry_shell.sh
$1"; \echo -n " "; local found_inner=1; local dollar_zero=""; break
    else
      case "$1" in
        -*file) _otel_escape_arg "$1"; \echo -n " "; shift; _otel_escape_arg "$1"; \echo -n " " ;;
            -*) _otel_escape_arg "$1"; \echo -n " " ;;
             # we cant have a linebreak here to not garble the argument positions
             *) \echo -n "-c "; _otel_escape_arg ". /usr/bin/opentelemetry_shell.sh; . $1 "'"$@"'; \echo -n " "; local dollar_zero="$1"; local found_inner=1; break ;; # TODO lets use eval before $1 in case there is something fishy?
      esac
    fi
    shift
  done
  shift
  # abort in case its interactive or invalid arguments
  if [ "$found_inner" -eq 0 ]; then return 0; fi 
  # arguments
  if [ -n "$dollar_zero" ]; then _otel_escape_arg "$dollar_zero"; \echo -n " "; fi
  for dollar_n in "$@"; do _otel_escape_arg "$dollar_n"; \echo -n " "; done
}

_otel_inject_shell_with_c_flag() {
  if [ "$1" = "_otel_observe" ]; then local cmdline="${@:2}"; else local cmdline="$*"; fi
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$(\echo "$cmdline" | _otel_line_join)" \
    \eval "$(_otel_inject_shell_args_with_c_flag "$@")" # should we do \eval _otel_call "$(.....)" here? is it safer concerning transport of the OTEL control variables?
}

_otel_alias_prepend bash _otel_inject_shell_with_c_flag
