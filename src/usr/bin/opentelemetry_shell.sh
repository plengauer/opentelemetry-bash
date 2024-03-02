#!/bin/sh
###############################################################################################################
# This file is doing auto-instrumentation, auto-injection and auto-context-propagation.                        #
# It should be sourced at the very top of any shell script that should be observed.                            #
# Only use the "otel_instrument" and "otel_outstrument" function directly.                                     #
# All other functions and variables are for internal use only and therefore subject to change without notice!  #
################################################################################################################

if [ "$_otel_shell_injected" = "TRUE" ]; then
  return 0
fi
_otel_shell_injected=TRUE

. /usr/bin/opentelemetry_shell_api.sh

if [ "$_otel_shell" = "bash" ] && [ -n "$BASHPID" ] && [ "$$" != "$BASHPID" ]; then
  echo "WARNING The OpenTelemetry shell file for auto-instrumentation is sourced in a subshell, automatic instrumentation will only be active within that subshell!" >&2
fi

case "$-" in
  *i*) _otel_is_interactive=TRUE;;
  *)   _otel_is_interactive=FALSE;;
esac

if [ "$_otel_is_interactive" = "TRUE" ]; then
  _otel_shell_auto_instrumentation_hint=""
elif [ -n "$OTEL_SHELL_AUTO_INSTRUMENTATION_HINT" ]; then
  _otel_shell_auto_instrumentation_hint="$OTEL_SHELL_AUTO_INSTRUMENTATION_HINT"
elif [ "$(\readlink -f "$(\which "$0")" | \rev | \cut -d/ -f1 | \rev)" = "$(\readlink -f /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)" ]; then
  _otel_shell_auto_instrumentation_hint=""
else
  _otel_shell_auto_instrumentation_hint="$0"
fi
unset OTEL_SHELL_AUTO_INSTRUMENTATION_HINT

if [ "$_otel_shell" = "bash" ]; then
  _otel_source_file_resolver='"${BASH_SOURCE[0]}"'
else
  _otel_source_file_resolver='"$0"'
fi
_otel_source_line_resolver='"$LINENO"'
_otel_source_func_resolver='"$FUNCNAME"'

if [ "$_otel_shell" = "bash" ]; then
  shopt -s expand_aliases &> /dev/null
fi

_otel_unquote() {
  \sed "s/^'\(.*\)'$/\1/"
}

_otel_line_split() {
  \tr ' ' '\n'
}

_otel_alias_prepend() {
  local original_command=$1
  local prepend_command=$2

  if [ -z "$(\alias $original_command 2> /dev/null)" ]; then # fastpath
    local new_command="$prepend_command $original_command"
  else
    local previous_command="$(\alias $original_command 2> /dev/null | \cut -d= -f2- | _otel_unquote)"
    if [ -z "$previous_command" ]; then local previous_command="$original_command"; fi
    if [ "${previous_command#OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE=}" != "$previous_command" ]; then local previous_command="$(\printf '%s' "$previous_command" | \cut -d" " -f2-)"; fi
    case "$previous_command" in
      *"$prepend_command"*) return 0 ;;
      *) ;;
    esac
    local previous_otel_command="$(\printf '%s' "$previous_command" | _otel_line_split | \grep '^_otel_' | _otel_line_join)"
    local previous_alias_command="$(\printf '%s' "$previous_command" | _otel_line_split | \grep -v '^_otel_' | _otel_line_join)"
    local new_command="$previous_otel_command $prepend_command $previous_alias_command"
  fi
  
  \alias $original_command='OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="code.filepath='$_otel_source_file_resolver',code.lineno='$_otel_source_line_resolver',code.function='$_otel_source_func_resolver'" '"$new_command"
}

_otel_shebang() {
  local path="$(\which $1)"
  if [ -z "$path" ] || [ ! -f "$path" ]; then return 1; fi
  read -r first_line < "$path"
  if [ "$(\echo "$first_line" | \cut -c1-2)" != '#!' ]; then return 2; fi
  \echo "$first_line" | \cut -c3- | \awk '{$1=$1};1'
}

_otel_deshebangify() {
  local cmd=$1 # e.g., "upgrade"
  if [ -n "$(\alias $1 2> /dev/null)" ]; then return 1; fi
  local shebang="$(_otel_shebang $1)" # e.g., "/bin/bash -x"
  if [ -z "$shebang" ]; then return 2; fi
  local shebang_cmd="$(\echo "$shebang" | \cut -d' ' -f1 | \rev | \cut -d/ -f1 | \rev)" # e.g., "bash"
  local aliased_shebang="$(\alias "$shebang_cmd" 2> /dev/null | \cut -d= -f2- | _otel_unquote)" # e.g., "otel_inject_shell_with_source bash"
  if [ -z "$aliased_shebang" ]; then return 3; fi
  \alias $1="$aliased_shebang $(\echo "$shebang" | \cut -s -d ' ' -f2-) $(\which $1)"  # e.g., upgrade => otel_inject_shell_with_source bash -x /usr/bin/upgrade
}

_otel_observe() {
  otel_observe "$@"
}

otel_instrument() {
  _otel_alias_prepend $1 '_otel_observe'
}

otel_outstrument() {
  \unalias $1 1> /dev/null 2> /dev/null || true
}

_otel_filter_commands_by_hint() {
  local hint="$1"
  if [ -n "$hint" ]; then
    if [ -f "$hint" ] && [ "$(\readlink -f /proc/$$/exe)" != "$(\readlink -f $hint)" ] && [ "$hint" != "/usr/bin/opentelemetry_shell.sh" ]; then local hint="$(\cat "$hint")"; fi
    \grep -xF "$(\echo "$hint" | \tr -s ' $=";(){}[]/\\!#~^'\' '\n' | \grep -E '^[a-zA-Z0-9 ._-]*$')"
  else
    \cat
  fi
}

_otel_filter_commands_by_instrumentation() {
  local pre_instrumented_executables="$(\alias | \grep -F '_otel_observe' | \sed 's/^alias //' | \cut -d= -f1)"
  if [ -n "$pre_instrumented_executables" ]; then
    \grep -xFv "$pre_instrumented_executables" 
  else
    \cat
  fi
}

_otel_list_path_executables() {
  \echo "$PATH" | \tr ' ' '\n' | \tr ':' '\n' | while read dir; do \find $dir -maxdepth 1 -type f,l -executable 2> /dev/null; done
}

_otel_list_path_commands() {
  _otel_list_path_executables | \rev | \cut -d / -f1 | \rev | \grep -vF '['
}

_otel_list_alias_commands() {
  \alias | \sed 's/^alias //' | \awk -F'=' '{ var=$1; sub($1 FS,""); } ! ($0 ~ "^'\''((OTEL_|_otel_).* )*" var "'\''$") { print var }'
}

_otel_list_builtin_commands() {
  \echo type
  if [ "$_otel_shell" = "bash" ]; then
    \echo history
  fi
}

_otel_list_all_commands() {
  _otel_list_path_commands
  _otel_list_alias_commands
  _otel_list_builtin_commands
}

_otel_auto_instrument() {
  local hint="$1"
  # both otel_filter_commands_by_file and _otel_filter_commands_by_instrumentation are functionally optional, but helps optimizing time because the following loop AND otel_instrument itself is expensive!
  local executables="$(_otel_list_all_commands | _otel_filter_commands_by_instrumentation | _otel_filter_commands_by_hint "$hint" | \sort -u | _otel_line_join)"
  for cmd in $executables; do _otel_deshebangify $cmd || true; done
  for cmd in $executables; do otel_instrument $cmd; done
}

_otel_alias_and_instrument() {
  local exit_code=0
  "$@" || local exit_code=$?
  shift
  local commands="$(\echo "$@" | _otel_line_split | \grep -m1 '=' 2> /dev/null | \cut -d= -f1)"
  for cmd in $commands; do otel_instrument $cmd; done
  return $exit_code
}

_otel_unalias_and_reinstrument() {
  local exit_code=0
  "$@" || local exit_code=$?
  shift
  if [ "-a" = "$*" ]; then
    local commands="$(_otel_list_all_commands | _otel_filter_commands_by_hint "$_otel_shell_auto_instrumentation_hint")"
  else
    local commands="$(_otel_list_all_commands | \grep -Fx "$(\echo "$@" | _otel_line_split 2> /dev/null)" 2> /dev/null)"
  fi
  for cmd in $commands; do otel_instrument $cmd; done
  return $exit_code
}

_otel_instrument_and_source() {
  local file="$2"
  if [ -f "$file" ]; then
    _otel_auto_instrument "$file"
  fi
  "$@"
}

_otel_propagate_wget() {
  local command="$(\echo "$*" | \sed 's/^_otel_observe //')"
  local url=$(\echo "$@" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local scheme=http # TODO
  local target=$(\echo /${url#*//*/})
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=GET
  OTEL_SHELL_SPAN_NAME_OVERRIDE="$command" OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" \
    OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="http.url=$url,http.scheme=$scheme,http.host=$host,http.target=$target,http.method=$method,$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0='--header=traceparent: $OTEL_TRACEPARENT' \
    "$@"
}

_otel_propagate_curl() {
  local command="$(\echo "$*" | \sed 's/^_otel_observe //')"
  local url=$(\echo "$@" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local scheme=http # TODO
  local target=$(\echo /${url#*//*/})
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=$(\echo "$@" | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  if [ -z "$method" ]; then
    local method=GET
  fi
  OTEL_SHELL_SPAN_NAME_OVERRIDE="$command" OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" \
    OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="http.url=$url,http.scheme=$scheme,http.host=$host,http.target=$target,http.method=$method,$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0='-H' OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1='traceparent: $OTEL_TRACEPARENT' \
    "$@"
}

_otel_inject_shell_args_with_copy() {
  local temporary_script="$1"
  shift
  local is_script=0
  # command
  if [ "$1" = "_otel_observe" ]; then _otel_escape_arg "$1"; \echo -n " "; shift; fi
  _otel_escape_arg "$1"; \echo -n " "
  shift
  # options and script or command string
  local found_inner=0
  while [ "$#" -gt 0 ]; do
    if [ "$1" = "-c" ]; then
      shift; local is_script=0; local found_inner=1; break
    else
      case "$1" in
        -*file) _otel_escape_arg "$1"; \echo -n " "; shift; _otel_escape_arg "$1";; \echo -n " " ;;
            -*) _otel_escape_arg "$1"; \echo -n " " ;;
             *) local is_script=1; local found_inner=1; break ;;
      esac
    fi
    shift
  done
  # abort in case its interactive or invalid aguments
  if [ "$found_inner" -eq 0 ]; then return 0; fi 
  # finish command
  _otel_escape_arg "$temporary_script"
  # setup temporary script
  local command="$1"
  shift
  \touch "$temporary_script"
  \chmod +x "$temporary_script"
  \echo "OTEL_SHELL_AUTO_INSTRUMENTATION_HINT=\"$temporary_script\"" >> "$temporary_script"
  \echo ". /usr/bin/opentelemetry_shell.sh" >> "$temporary_script"
  \echo "\set -- $(_otel_escape_args "$@")" >> "$temporary_script"
  (if [ "$is_script" -eq 1 ]; then \cat "$command"; else \echo "$command"; fi) >> "$temporary_script"
}

_otel_inject_shell_with_copy() {
  local cmdline="$({ set -- "$@"; if [ "$1" = "_otel_observe" ]; then shift; fi; \echo -n "$*"; })" 
  local temporary_script="$(\mktemp -u)"
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$(\echo "$cmdline" | _otel_line_join)" \
    \eval "$(_otel_inject_shell_args_with_copy "$temporary_script" "$@")" || local exit_code=$? # should we do \eval _otel_call "$(.....)" here? is it safer concerning transport of the OTEL control variables?
  \rm "$temporary_script" || true
  return $exit_code
}

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
        -*file) _otel_escape_arg "$1"; \echo -n " "; shift; _otel_escape_arg "$1" ;;
            -*) _otel_escape_arg "$1"; \echo -n " " ;;
             # we cant have a linebreak here to not garble the argument positions
             *) \echo -n "-c "; _otel_escape_arg ". /usr/bin/opentelemetry_shell.sh; . $1 "'"$@"'; \echo -n " "; local dollar_zero="$1"; local found_inner=1; break ;; # TODO lets use eval before $1 in case there is something fishy?
      esac
    fi
    shift
  done
  shift
  # abort in case its interactive or invalid aguments
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

_otel_inject_inner_command() {
  local more_args="$OTEL_SHELL_INJECT_INNER_COMMAND_MORE_ARGS"
  unset MORE_ARGS
  if [ "$1" = "_otel_observe" ]; then
    shift; local executable="_otel_observe $1"
  else
    local executable=$1
  fi
  local cmdline="$*"
  shift
  for arg in "$@"; do
    if ! [ "${arg%"${arg#?}"}" = "-" ] && ([ -n "$(\which $arg)" ] || [ -x "$arg" ]); then break; fi
    local executable="$executable $1"
    shift
  done
  if [ -z "$*" ]; then
    $executable
  else
    OTEL_SHELL_COMMANDLINE_OVERRIDE="${OTEL_SHELL_COMMANDLINE_OVERRIDE:-$cmdline}" OTEL_SHELL_SPAN_NAME_OVERRIDE="${OTEL_SHELL_COMMANDLINE_OVERRIDE:-$cmdline}" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$*" \
      $executable $more_args sh -c ". /usr/bin/opentelemetry_shell.sh
$(_otel_escape_args "$@")"
  fi
}

_otel_inject_sudo() {
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$*" OTEL_SHELL_INJECT_INNER_COMMAND_MORE_ARGS="--preserve-env=$(\printenv | \grep '^OTEL_' | \cut -d= -f1 | \sort -u | \tr '\n' ','),OTEL_SHELL_COMMANDLINE_OVERRIDE,OTEL_SHELL_AUTO_INJECTED,OTEL_SHELL_AUTO_INSTRUMENTATION_HINT" _otel_inject_inner_command "$@"
}

_otel_inject_xargs() {
  if [ "$(\expr "$*" : ".* -I .*")" -gt 0 ]; then
     _otel_inject_inner_command "$@"
  else
    if [ "$1" = "_otel_observe" ]; then
      shift; local executable="_otel_observe $1"
    else
      local executable=$1
    fi
    local cmdline="$*"
    shift
    if [ -z "$*" ]; then
      $executable
    else
      OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" _otel_inject_xargs $executable -I '{}' "$@" '{}' # TODO we should fake the commandline and span name and also adjust the test!
    fi
  fi
}

_otel_inject_find_arguments() {
  local in_exec=0
  local first=1
  for arg in "$@"; do
    if [ "$first" = 1 ]; then local first=0; else \echo -n ' '; fi
    if [ "$in_exec" -eq 0 ] && ([ "$arg" = "-exec" ] || [ "$arg" = "-execdir" ]); then
      local in_exec=1
      \echo -n "$arg sh -c '. /usr/bin/opentelemetry_shell.sh
"
    elif [ "$in_exec" -eq 1 ] && ([ "$arg" = ";" ] || [ "$arg" = "+" ]); then
      local in_exec=0
      \echo -n "' '' {} '$arg'"
    elif [ "$in_exec" -eq 1 ] && [ "$arg" = "{}" ]; then
      \echo -n '"$@"'
    else
      if [ "$(\expr "$arg" : ".* .*")" -gt 0 ] || [ "$(\expr "$arg" : ".*\*.*")" -gt 0 ]; then
        \echo -n '"'$arg'"'
      else
        \echo -n "$arg"
      fi
    fi
  done
}

_otel_inject_find() {
  if [ "$(\expr "$*" : ".* -exec .*")" -gt 0 ] || [ "$(\expr "$*" : ".* -execdir .*")" -gt 0 ]; then
    if [ "$1" = "_otel_observe" ]; then
      shift; local executable="_otel_observe $1"
    else
      local executable=$1
    fi
    local cmdline="$*"
    shift
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$*" \
      eval $executable "$(_otel_inject_find_arguments "$@")"
  else
    OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" $executable "$@"
  fi
}

_otel_record_exec() {
  local file="$1"
  local line="$2"
  if [ -n "$file" ] && [ -n "$line" ] && [ -f "$file" ]; then local command="$(\cat "$file" | \sed -n "$line"p | \grep -F 'exec' | \sed 's/^.*exec /exec /')"; fi
  if [ -z "$command" ]; then local command="exec"; fi
  local span_id=$(otel_span_start INTERNAL "$command")
  if [ "$(\printf '%s' "$command" | \sed 's/ [0-9]*>.*$//')" != "exec" ]; then
    otel_span_activate $span_id
  fi
  otel_span_end $span_id
  _otel_sdk_communicate 'SPAN_AUTO_END'
}

_otel_start_script() {
  otel_init || return $?
  if [ "$OTEL_SHELL_AUTO_INJECTED" != "TRUE" ]; then
    if [ -n "$SSH_CLIENT"  ] && [ -n "$SSH_CONNECTION" ]; then
      otel_root_span_id=$(otel_span_start SERVER ssh)
      otel_span_attribute $otel_root_span_id ssh.ip=$(\echo $SSH_CONNECTION | \cut -d' ' -f3)
      otel_span_attribute $otel_root_span_id ssh.port=$(\echo $SSH_CONNECTION | \cut -d' ' -f4)
      otel_span_attribute $otel_root_span_id net.peer.ip=$(\echo $SSH_CLIENT | \cut -d' ' -f1)
      otel_span_attribute $otel_root_span_id net.peer.port=$(\echo $SSH_CLIENT | \cut -d' ' -f2)
    elif [ -n "$SERVER_SOFTWARE"  ] && [ -n "$SCRIPT_NAME" ] && [ -n "$SERVER_NAME" ] && [ -n "$SERVER_PROTOCOL" ]; then
      otel_root_span_id=$(otel_span_start SERVER GET)
      otel_span_attribute $otel_root_span_id http.flavor=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f2)
      otel_span_attribute $otel_root_span_id http.host=$SERVER_NAME:$SERVER_PORT
      otel_span_attribute $otel_root_span_id http.route=$SCRIPT_NAME
      otel_span_attribute $otel_root_span_id http.scheme=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1 | \tr '[:upper:]' '[:lower:]')
      otel_span_attribute $otel_root_span_id http.method=GET
      otel_span_attribute $otel_root_span_id http.status_code=200
      otel_span_attribute $otel_root_span_id http.status_text=OK
      otel_span_attribute $otel_root_span_id http.target=$SCRIPT_NAME
      otel_span_attribute $otel_root_span_id http.url=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1 | \tr '[:upper:]' '[:lower:]')://$SERVER_NAME:$SERVER_PORT$SCRIPT_NAME
      otel_span_attribute $otel_root_span_id net.peer.ip=$REMOTE_ADDR
    elif [ "$(_otel_command_self | \cut -d' ' -f2 | \rev | \cut -d/ -f2- | \rev)" = "/var/lib/dpkg/info" ] || [ "$(_otel_command_self | \cut -d' ' -f2 | \rev | \cut -d/ -f2- | \rev)" = "/var/lib/dpkg/tmp.ci" ]; then
      if [ -z "$OTEL_TRACEPARENT" ]; then
        otel_root_span_id=$(otel_span_start SERVER $(_otel_command_self | \cut -d' ' -f2 | \rev | \cut -d/ -f1 | \cut -d. -f1 | \rev))
      else
        otel_root_span_id=$(otel_span_start INTERNAL $(_otel_command_self | \cut -d' ' -f2 | \rev | \cut -d/ -f1 | \cut -d. -f1 | \rev))
      fi
      otel_span_attribute $otel_root_span_id debian.package.operation=$(_otel_command_self | \cut -d' ' -f2 | \rev | \cut -d/ -f1 | \rev | \cut -d. -f2) $(_otel_command_self | \cut -d' ' -f3)
      otel_span_attribute $otel_root_span_id debian.package.name=$(_otel_command_self | \cut -d' ' -f2 | \rev | \cut -d/ -f1 | \rev | \cut -d. -f1)
    else
      otel_root_span_id=$(otel_span_start SERVER $(_otel_command_self))
    fi
    otel_span_activate $otel_root_span_id
  fi
  unset OTEL_SHELL_AUTO_INJECTED
}

_otel_end_script() {
  local exit_code=$?
  if [ -n "$otel_root_span_id" ]; then
    if [ "$exit_code" -ne "0" ]; then
      otel_span_error $otel_root_span_id
    fi
    otel_span_deactivate
    otel_span_end $otel_root_span_id
  fi
  otel_shutdown
}

_otel_alias_prepend wget _otel_propagate_wget
_otel_alias_prepend curl _otel_propagate_curl
_otel_alias_prepend sh _otel_inject_shell_with_copy # cant really know what kind of shell it actually is, so lets play it safe
_otel_alias_prepend ash _otel_inject_shell_with_copy # sourced files do not support arguments
_otel_alias_prepend dash _otel_inject_shell_with_copy # sourced files do not support arguments
_otel_alias_prepend bash _otel_inject_shell_with_c_flag
_otel_alias_prepend sudo _otel_inject_sudo
_otel_alias_prepend time _otel_inject_inner_command
_otel_alias_prepend timeout _otel_inject_inner_command
_otel_alias_prepend xargs _otel_inject_xargs
_otel_alias_prepend find _otel_inject_find

_otel_alias_prepend alias _otel_alias_and_instrument
_otel_alias_prepend unalias _otel_unalias_and_reinstrument
_otel_alias_prepend . _otel_instrument_and_source
if [ "$_otel_shell" = "bash" ]; then
  _otel_alias_prepend source _otel_instrument_and_source
fi

_otel_auto_instrument "$_otel_shell_auto_instrumentation_hint"

\alias exec='_otel_record_exec '$_otel_source_file_resolver' '$_otel_source_line_resolver'; exec'
trap _otel_end_script EXIT

_otel_start_script
