#!/bin/false
###############################################################################################################
# This file is doing auto-instrumentation, auto-injection and auto-context-propagation.                        #
# It should be sourced at the very top of any shell script that should be observed.                            #
# Only use the "otel_instrument" and "otel_outstrument" functions directly.                                    #
# All other functions and variables are for internal use only and therefore subject to change without notice!  #
################################################################################################################

if \[ "$_otel_shell_injected" = "TRUE" ]; then
  return 0
fi
_otel_shell_injected=TRUE

\. /usr/bin/opentelemetry_shell_api.sh

if \[ "$_otel_shell" = "bash" ] && \[ -n "$BASHPID" ] && \[ "$$" != "$BASHPID" ]; then
  echo "WARNING The OpenTelemetry shell file for auto-instrumentation is sourced in a subshell, automatic instrumentation will only be active within that subshell!" >&2
fi

case "$-" in
  *i*) _otel_is_interactive=TRUE;;
  *)   _otel_is_interactive=FALSE;;
esac

if \[ "$_otel_is_interactive" = "TRUE" ]; then
  _otel_shell_auto_instrumentation_hint=""
elif \[ -n "$OTEL_SHELL_AUTO_INSTRUMENTATION_HINT" ]; then
  _otel_shell_auto_instrumentation_hint="$OTEL_SHELL_AUTO_INSTRUMENTATION_HINT"
elif \[ "$(\readlink -f "$(\which "$0")" | \rev | \cut -d/ -f1 | \rev)" = "$(\readlink -f /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)" ]; then
  _otel_shell_auto_instrumentation_hint=""
else
  _otel_shell_auto_instrumentation_hint="$0"
fi
unset OTEL_SHELL_AUTO_INSTRUMENTATION_HINT

if \[ "$_otel_shell" = "bash" ]; then
  _otel_source_file_resolver='${BASH_SOURCE[0]}'
else
  _otel_source_file_resolver='$0'
fi
_otel_source_line_resolver='$LINENO'
_otel_source_func_resolver='$FUNCNAME'

if \[ "$_otel_shell" = "bash" ]; then
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

  if \[ -z "$(\alias $original_command 2> /dev/null)" ]; then # fastpath
    local new_command="$prepend_command $original_command"
  else
    local previous_command="$(\alias $original_command 2> /dev/null | \cut -d= -f2- | _otel_unquote)"
    if \[ -z "$previous_command" ]; then local previous_command="$original_command"; fi
    if \[ "${previous_command#OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE=}" != "$previous_command" ]; then local previous_command="$(\printf '%s' "$previous_command" | \cut -d" " -f2-)"; fi
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

_otel_has_alias() {
  \alias $1 1> /dev/null 2> /dev/null # for some reason &> does not work in built-in alias
}

_otel_resolve_shebang() {
  local path="$(\which $1)"
  if \[ -z "$path" ] || \[ ! -f "$path" ]; then return 1; fi
  read -r first_line < "$path"
  if \[ "$(\echo "$first_line" | \cut -c1-2)" != '#!' ]; then return 2; fi
  \echo "$first_line" | \cut -c3- | \awk '{$1=$1};1'
}

_otel_deshebangify() {
  local cmd=$1 # e.g., "upgrade"
  if _otel_has_alias $cmd; then return 1; fi
  local shebang="$(_otel_resolve_shebang $1)" # e.g., "/bin/bash -x"
  if \[ -z "$shebang" ]; then return 2; fi
  \alias $1="$shebang $(\which $1)" # e.g., alias upgrade='/bin/bash -x /usr/bin/upgrade'
}

_otel_resolve_alias() {
  \alias $1 2> /dev/null | \cut -d= -f2- | _otel_unquote
}

_otel_resolve_alias_stripped() {
  _otel_resolve_alias $1 | _otel_line_split | \grep -v '^OTEL_' | \grep -v '^_otel_' | _otel_line_join
}

_otel_resolve_alias_stripped_cmd() {
  _otel_resolve_alias $1 | _otel_line_split | \grep -v '^OTEL_' | \grep -v '^_otel_' | \head -n1 | \rev | \cut -d/ -f1 | \rev
}

_otel_dealiasify() {
  # e.g., alias upgrade='/bin/bash -x /usr/bin/upgrade'
  # e.g., alias bash='_otel_inject_shell _otel_observe bash'
  # e.g., alias ai=bash-ai -v
  # e.g., alias bash-ai='/bin/bash -x /usr/bin/bash-ai'
  # e.g., alias l=ls --color=auto
  # e.g., alias ls=ls --color=auto
  local cmd=$1 # e.g., "upgrade", "ai", "l"
  local cmd_alias="$(_otel_resolve_alias_stripped_cmd $cmd)" # e.g., upgrade => bash, ai => bash-ai # additional indirection here needed #, l => ls
  if \[ -z "$cmd_alias" ]; then return 1; fi
#  && ! _otel_resolve_alias $cmd_alias | _otel_line_split | \grep -q '^_otel_'
#  if ! \[ "$no_indirect_resolve" = TRUE ] && \[ "$cmd" != "$cmd_alias" ] && _otel_has_alias $cmd_alias; then # e.g., bash => no, bash-ai => yes, ls => yes
#    # this check "feels" like there may be cases where we potentially expand aliases too much
#    \alias $cmd="$(_otel_resolve_alias $cmd_alias) $(_otel_resolve_alias_stripped $cmd | \cut -sd' ' -f2-)" # e.g., alias ai='/bin/bash -x /usr/bin/bash-ai -v', alias l='ls --color=auto --color=auto'
#    no_indirect_resolve=TRUE _otel_dealiasify $cmd
#    return $?
#  fi
  local cmd_aliased="$(_otel_resolve_alias $cmd_alias)" # e.g., bash => _otel_inject_shell bash
  if \[ -z "$cmd_aliased" ]; then return 2; fi
  local otel_cmds="$(\echo "$cmd_aliased" | _otel_line_split | \grep '^_otel_' | \grep -v '^_otel_observe' | _otel_line_join)" # e.g., _otel_inject_shell bash => _otel_inject_shell
  if \[ -z "$otel_cmds" ]; then return 3; fi
  _otel_alias_prepend $cmd "$otel_cmds" # e.g., alias upgrade='_otel_inject_shell /bin/bash -x /usr/bin/upgrade', e.g., alias ai='_otel_inject_shell /bin/bash -x /usr/bin/bash-ai -v'
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

_otel_grep_valid_command() {
  \grep -E '^[a-zA-Z0-9._\[][a-zA-Z0-9 ._-]*$'
}

_otel_filter_commands_by_hint() {
  local hint="$1"
  if \[ -n "$hint" ]; then
    if \[ -f "$hint" ] && \[ "$(\readlink -f /proc/$$/exe)" != "$(\readlink -f $hint)" ] && \[ "$hint" != "/usr/bin/opentelemetry_shell.sh" ]; then local hint="$(\cat "$hint")"; fi
    \grep -xF "$(\echo "$hint" | \tr -s ' $=";(){}/\\!#~^'\' '\n' | _otel_grep_valid_command)"
  else
    \cat
  fi
}

_otel_filter_commands_by_instrumentation() {
  local pre_instrumented_executables="$(\alias | \grep -F '_otel_observe' | \sed 's/^alias //' | \cut -d= -f1)"
  if \[ -n "$pre_instrumented_executables" ]; then
    \grep -xFv "$pre_instrumented_executables" 
  else
    \cat
  fi
}

_otel_filter_commands_by_special() {
  \grep -v '^alias$' | \grep -v '^unalias$' | \grep -v '^\.$' | \grep -v '^source$' | \grep -v '^exec$' | \grep -v '^OTEL_' | \grep -v '^_otel_' | \grep -v '^otel_'
}

_otel_list_path_executables() {
  \echo "$PATH" | \tr ' ' '\n' | \tr ':' '\n' | while read dir; do \find $dir -maxdepth 1 -type f,l -executable 2> /dev/null; done
}

_otel_list_path_commands() {
  _otel_list_path_executables | \rev | \cut -d / -f1 | \rev
}

_otel_list_alias_commands() {
  \alias | \sed 's/^alias //' | \grep -vF '[=' | \awk -F'=' '{ var=$1; sub($1 FS,""); } ! ($0 ~ "^'\''((OTEL_|_otel_).* )*" var "'\''$") { print var }'
}

_otel_list_aliased_commands() {
  \alias | \cut -d= -f2- | _otel_line_split | _otel_grep_valid_command
}

_otel_list_builtin_commands() {
  \echo type
  if \[ "$_otel_shell" = "bash" ]; then
    \echo history
  fi
}

_otel_list_all_commands() {
  _otel_list_path_commands
  _otel_list_alias_commands
  _otel_list_aliased_commands
  _otel_list_builtin_commands
}

_otel_auto_instrument() {
  local hint="$1"

  # cached?
  ## we really have three options for the cache key
  ## (1) using the hint - will not work when scripts are changing or called the same but very fast!
  ## (2) using the resolved hint - will not work when new executables are added onto the system or their shebang changes or new bash.rc aliases are added
  ## (3) using the filtered list of commands - will work in every case but slowest
  local cache_key="$(_otel_list_all_commands | _otel_filter_commands_by_special | _otel_filter_commands_by_hint "$hint" | \sort -u | \md5sum | \cut -d' ' -f1)"
  local cache_file="$(\mktemp -u | \rev | \cut -d'/' -f2- | \rev)/opentelemetry_shell_$(_otel_package_version opentelemetry-shell)"_"$_otel_shell"_instrumentation_cache_"$cache_key".sh
  if \[ -f "$cache_file" ]; then
    eval "$(\cat $cache_file | \grep -v '^#' | \awk '{print "\\alias " $0 }')"
    return $?
  fi
  
  # special instrumentations
  _otel_alias_prepend alias _otel_alias_and_instrument
  _otel_alias_prepend unalias _otel_unalias_and_reinstrument
  _otel_alias_prepend . _otel_instrument_and_source
  if \[ "$_otel_shell" = "bash" ]; then _otel_alias_prepend source _otel_instrument_and_source; fi
  
  # custom instrumentations (injections and propagations)
  for otel_custom_file in $(\ls /usr/bin | \grep '^opentelemetry_shell.custom.' | \grep '.sh$'); do \. "$otel_custom_file"; done
  
  # deshebangify commands, propagate special instrumentations into aliases, instrument all commands
  ## (both otel_filter_commands_by_file and _otel_filter_commands_by_instrumentation are functionally optional, but helps optimizing time because the following loop AND otel_instrument itself is expensive!)
  ## avoid piping directly into the loops, then it will be considered a subshell and aliases won't take effect here
  for cmd in $(_otel_list_path_commands | _otel_filter_commands_by_special | _otel_filter_commands_by_hint "$hint" | \sort -u | _otel_line_join); do _otel_deshebangify $cmd || true; done
  for cmd in $(_otel_list_alias_commands | _otel_filter_commands_by_special | _otel_line_join); do _otel_dealiasify $cmd || true; done
  for cmd in $(_otel_list_all_commands | _otel_filter_commands_by_special | _otel_filter_commands_by_instrumentation | _otel_filter_commands_by_hint "$hint" | \sort -u | _otel_line_join); do otel_instrument $cmd; done
  
  # super special instrumentations
  \alias .='_otel_instrument_and_source "$#" "$@" .'
  if \[ "$_otel_shell" = "bash" ]; then \alias source='_otel_instrument_and_source "$#" "$@" source'; fi
  \alias exec='_otel_record_exec '$_otel_source_file_resolver' '$_otel_source_line_resolver'; exec'

  # cache
  if \[ "$(\alias | \wc -l)" -gt 50 ]; then \alias | \sed 's/^alias //' > "$cache_file"; else true; fi
}

_otel_alias_and_instrument() {
  local exit_code=0
  "$@" || local exit_code=$?
  shift
  if \[ -n "$*" ] && [ "${*#*=*}" != "$*" ]; then
    _otel_auto_instrument "$(\echo "$@" | _otel_line_split | \grep -m1 '=' 2> /dev/null | \tr '=' ' ')"
  fi
  return $exit_code
}

_otel_unalias_and_reinstrument() {
  local exit_code=0
  "$@" || local exit_code=$?
  shift
  if \[ "-a" = "$*" ]; then
    _otel_auto_instrument "$_otel_shell_auto_instrumentation_hint"
  else
    _otel_auto_instrument "$*"
  fi
  return $exit_code
}

_otel_instrument_and_source() {
  local n="$1"
  shift
  local command="$(eval '\echo $'"$(($n+1))")"
  local file="$(eval '\echo $'"$(($n+2))")"
  if \[ -f "$file" ]; then _otel_auto_instrument "$file"; fi
  eval "'$command' '$file' $(if \[ $# -gt $(($n + 2)) ]; then \seq $(($n + 2 + 1)) $#; else \seq 1 $n; fi | while read i; do \echo '"$'"$i"'"'; done | _otel_line_join)"
}

_otel_record_exec() {
  local file="$1"
  local line="$2"
  if \[ -n "$file" ] && \[ -n "$line" ] && \[ -f "$file" ]; then local command="$(\cat "$file" | \sed -n "$line"p | \grep -F 'exec' | \sed 's/^.*exec /exec /')"; fi
  if \[ -n "$command" ] && \echo "$command" | \grep -q '^exec [0-9]>'; then return 0; fi
  if \[ -z "$command" ]; then local command="exec"; fi
  local span_id=$(otel_span_start INTERNAL "$command")
  if \[ "$(\printf '%s' "$command" | \sed 's/ \[0-9]*>.*$//')" != "exec" ]; then
    otel_span_activate $span_id
  fi
  otel_span_end $span_id
  _otel_sdk_communicate 'SPAN_AUTO_END'
}

_otel_start_script() {
  otel_init || return $?
  if \[ -n "$SSH_CLIENT"  ] && \[ -n "$SSH_CONNECTION" ] && \[ "$(\cat /proc/$PPID/cmdline | \tr -d '\000' | \cut -d' ' -f1)" = "sshd:" ]; then
    otel_root_span_id="$(otel_span_start SERVER ssh)"
    otel_span_attribute $otel_root_span_id ssh.ip=$(\echo $SSH_CONNECTION | \cut -d' ' -f3)
    otel_span_attribute $otel_root_span_id ssh.port=$(\echo $SSH_CONNECTION | \cut -d' ' -f4)
    otel_span_attribute $otel_root_span_id net.peer.ip=$(\echo $SSH_CLIENT | \cut -d' ' -f1)
    otel_span_attribute $otel_root_span_id net.peer.port=$(\echo $SSH_CLIENT | \cut -d' ' -f2)
  elif \[ -n "$SERVER_SOFTWARE"  ] && \[ -n "$SCRIPT_NAME" ] && \[ -n "$SERVER_NAME" ] && \[ -n "$SERVER_PROTOCOL" ] && ! \[ "$OTEL_SHELL_AUTO_INJECTED" = "TRUE" ] && \[ "$(\cat /proc/$PPID/cmdline | \tr -d '\000' | \cut -d' ' -f1 | \rev | \cut -d'/' -f1 | \rev)" = "python3" ]; then
    otel_root_span_id="$(otel_span_start SERVER GET)"
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
  elif _otel_command_self | grep -q '/var/lib/dpkg/info' > /dev/null; then
    local cmdline="$(_otel_command_self | \sed 's/^.* \(\/var\/lib\/dpkg\/info\/.*\)$/\1/')"
    otel_root_span_id="$(otel_span_start SERVER "$(\echo "$cmdline" | \cut -d'.' -f2- | \cut -d' ' -f1)")"
    otel_span_attribute $otel_root_span_id debian.package.name="$(\echo "$cmdline" | \rev | \cut -d'/' -f1 | \rev | \cut -d'.' -f1)"
    otel_span_attribute $otel_root_span_id debian.package.operation="$(\echo "$cmdline" | \cut -d'.' -f2-)"
  elif ! \[ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ] && \[ -z "$OTEL_TRACEPARENT" ]; then
    otel_root_span_id="$(otel_span_start SERVER "$(_otel_command_self)")"
  elif ! \[ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ] && \[ -n "$OTEL_TRACEPARENT" ]; then
    otel_root_span_id="$(otel_span_start INTERNAL "$(_otel_command_self)")"
  fi
  if [ -n "$otel_root_span_id" ]; then otel_span_activate $otel_root_span_id; fi
  unset OTEL_SHELL_AUTO_INJECTED
}

_otel_end_script() {
  local exit_code=$?
  if \[ -n "$otel_root_span_id" ]; then
    if \[ "$exit_code" -ne "0" ]; then
      otel_span_error $otel_root_span_id
    fi
    otel_span_deactivate
    otel_span_end $otel_root_span_id
  fi
  otel_shutdown
}

_otel_auto_instrument "$_otel_shell_auto_instrumentation_hint"
trap _otel_end_script EXIT

_otel_start_script
