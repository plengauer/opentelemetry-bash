#!/bin/false

# time cat ./file.txt => time sh -c '. /otel.sh; cat ./file.txt' 'time'
# timeout 10s cat ./file.txt => timeout 10s time.output sh -c '. /otel.sh; cat ./file.txt' 'time'
# flock .lock npm install package => flock .lock sh -c '. /otel.sh; npm install package' 'flock'

_otel_inject_inner_command_args() {
  local more_args="$OTEL_SHELL_INJECT_INNER_COMMAND_MORE_ARGS"
  unset OTEL_SHELL_INJECT_INNER_COMMAND_MORE_ARGS
  # command
  case "$1" in
    "\\"*) \echo -n "$1";;
    *) _otel_escape_arg "$1";;
  esac
  if \[ "$1" = "_otel_observe" ]; then shift; \echo -n " "; _otel_escape_arg "$1"; fi
  local command="$1"
  shift
  # options
  # -option or not executable file 
  while \[ "$#" -gt 0 ] && ( \[ "${1%"${1#?}"}" = "-" ] || ! ( \[ -x "$1" ] || \[ -x "$(\which "$1")" ] ) ); do \echo -n " "; _otel_escape_arg "$1"; shift; done
  # opt out if there is no command
  if \[ -z "$*" ]; then return 0; fi
  # more options
  for arg in $more_args; do \echo -n " ";  _otel_escape_arg "$arg"; done
  # wrap command
  \echo -n " sh -c '. /usr/bin/opentelemetry_shell.sh
"
  while \[ "$#" -gt 0 ]; do \echo -n " "; no_quote=1 _otel_escape_arg "$(_otel_escape_arg "$1")"; shift; done
  \echo -n "' $(_otel_escape_arg "$command")"
}

_otel_inject_inner_command() {
  local cmdline="$({ set -- "$@"; if \[ "$1" = "_otel_observe" ]; then shift; fi; \echo -n "$*"; })"
  OTEL_SHELL_COMMANDLINE_OVERRIDE="${OTEL_SHELL_COMMANDLINE_OVERRIDE:-$cmdline}" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_SPAN_NAME_OVERRIDE="${OTEL_SHELL_SPAN_NAME_OVERRIDE:-$cmdline}" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$*" \
    \eval "$(_otel_inject_inner_command_args "$@")"
}

# _otel_alias_prepend env _otel_inject_inner_command # injecting via changing the command is dangerous because there are some options affecting signal handling
_otel_alias_prepend taskset _otel_inject_inner_command
_otel_alias_prepend nice _otel_inject_inner_command
_otel_alias_prepend ionice _otel_inject_inner_command
# _otel_alias_prepend stdbuf _otel_inject_inner_command # injecting via changing the command defeats the purpose of stdbuf
# _otel_alias_prepend nohup _otel_inject_inner_command # injecting via changing the command defeats the purpose of nohup
# _otel_alias_prepend strace _otel_inject_inner_command # injecting via changing the command defeats the purpose of strace
_otel_alias_prepend time _otel_inject_inner_command
_otel_alias_prepend timeout _otel_inject_inner_command
_otel_alias_prepend watch _otel_inject_inner_command
_otel_alias_prepend at _otel_inject_inner_command
_otel_alias_prepend flock _otel_inject_inner_command

# sudo apt-get update => sudo sh -c '. /otel.sh; apt-get update' 'sudo'

_otel_inject_sudo() {
  OTEL_SHELL_INJECT_INNER_COMMAND_MORE_ARGS="--preserve-env=$(\printenv | \grep '^OTEL_' | \cut -d= -f1 | \sort -u | \tr '\n' ','),OTEL_SHELL_COMMANDLINE_OVERRIDE,OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE,OTEL_SHELL_AUTO_INJECTED,OTEL_SHELL_AUTO_INSTRUMENTATION_HINT" _otel_inject_inner_command "$@"
}

_otel_alias_prepend sudo _otel_inject_sudo

# xargs -I {} rm -rf {} => xargs -I {} sh -c '. /otel.sh; rm -rf {}'
# xargs rm -rf => xargs -I {} rm -rf {} => xargs -I {} sh -c '. /otel.sh; rm -rf {}'

_otel_inject_xargs() {
  case "$*" in
    *' -I '*) _otel_inject_inner_command "$@" ;;
    *)
      if \[ "$1" = "_otel_observe" ]; then
        shift; local executable="_otel_observe $1"
      else
        local executable="$1"
      fi
      local cmdline="$*"
      shift
      if \[ -z "$*" ]; then
        $executable
      else
        OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" _otel_inject_xargs $executable -I '{}' "$@" '{}'
      fi
      ;;
  esac
}

_otel_alias_prepend xargs _otel_inject_xargs
