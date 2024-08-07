#!/bin/false
################################################################################################################
# This file is doing auto-instrumentation, auto-injection and auto-context-propagation.                        #
# It should be sourced at the very top of any shell script that should be observed.                            #
# Only use the "otel_instrument" and "otel_outstrument" functions directly.                                    #
# All other functions and variables are for internal use only and therefore subject to change without notice!  #
################################################################################################################

if \[ "$_otel_shell_injected" = "TRUE" ]; then
  return 0
fi
_otel_shell_injected=TRUE

_otel_shell_conservative_exec="$OTEL_SHELL_CONSERVATIVE_EXEC"
unset OTEL_SHELL_CONSERVATIVE_EXEC

\. /usr/share/opentelemetry_shell/opentelemetry_shell_api.sh
_otel_package_version opentelemetry-shell > /dev/null # to build the cache outside a subshell

if \[ "$_otel_shell" = "bash" ] && \[ -n "$BASHPID" ] && \[ "$$" != "$BASHPID" ]; then
  \echo "WARNING The OpenTelemetry shell file for auto-instrumentation is sourced in a subshell, automatic instrumentation will only be active within that subshell!" >&2
fi

case "$-" in
  *i*) _otel_is_interactive=TRUE;;
  *)   _otel_is_interactive=FALSE;;
esac

if \[ -n "$OTEL_SHELL_AUTO_INSTRUMENTATION_HINT" ]; then
  _otel_shell_auto_instrumentation_hint="$OTEL_SHELL_AUTO_INSTRUMENTATION_HINT"
  unset OTEL_SHELL_AUTO_INSTRUMENTATION_HINT
elif \[ "$_otel_is_interactive" = "TRUE" ]; then
  _otel_shell_auto_instrumentation_hint=""
elif \[ -f "$0" ] && \[ "$(\readlink -f "$0" | \rev | \cut -d / -f 1 | \rev)" != "$(\readlink -f "/proc/$$/exe" | \rev | \cut -d / -f 1 | \rev)" ]; then
  _otel_shell_auto_instrumentation_hint="$0"
else
  _otel_shell_auto_instrumentation_hint="$(_otel_resolve_command_self)"
fi

if \[ "$_otel_shell" = "bash" ]; then
  _otel_source_file_resolver='${BASH_SOURCE[0]}'
else
  _otel_source_file_resolver='$0'
fi
_otel_source_line_resolver='$LINENO'
_otel_source_func_resolver='$FUNCNAME'

if \[ "$_otel_shell" = "bash" ]; then
  shopt -s expand_aliases 1> /dev/null 2> /dev/null
fi

_otel_auto_instrument() {
  local hint="$1"
  local IFS=' 
'

  # cached?
  ## we really have three options for the cache key
  ## (1) using the hint - will not work when scripts are changing or called the same but very fast!
  ## (2) using the resolved hint - will not work when new executables are added onto the system or their shebang changes or new bash.rc aliases are added
  ## (3) using the filtered list of commands - will work in every case but slowest
  local cache_key="$({ _otel_list_path_commands | _otel_filter_commands_by_special | _otel_filter_commands_by_hint "$hint" | \sort -u; \alias; \echo "$_otel_shell_conservative_exec" "$OTEL_SHELL_EXPERIMENTAL_INSTRUMENT_MINIMALLY"; } | \md5sum | \cut -d ' ' -f 1)"
  local cache_file="$(\mktemp -u | \rev | \cut -d / -f 2- | \rev)/opentelemetry_shell_$(_otel_package_version opentelemetry-shell)"_"$_otel_shell"_instrumentation_cache_"$cache_key".aliases
  if \[ -f "$cache_file" ]; then
    # \eval "$(\grep -vh '_otel_alias_prepend ' $(_otel_list_special_auto_instrument_files))"
    for otel_custom_file in $(_otel_list_special_auto_instrument_files); do \eval "$(\sed '/_otel_alias_prepend /\true /g' < "$otel_custom_file")"; done
    \. "$cache_file"
    return $?
  fi

  # special instrumentations
  _otel_alias_prepend alias _otel_alias_and_instrument
  _otel_alias_prepend unalias _otel_unalias_and_reinstrument
  _otel_alias_prepend . _otel_instrument_and_source
  if \[ "$_otel_shell" = bash ]; then _otel_alias_prepend source _otel_instrument_and_source; fi

  # deshebangify commands, do special instrumentations, propagate special instrumentations into aliases, instrument all commands
  ## (both otel_filter_commands_by_file and _otel_filter_commands_by_instrumentation are functionally optional, but helps optimizing time because the following loop AND otel_instrument itself is expensive!)
  ## avoid piping directly into the loops, then it will be considered a subshell and aliases won't take effect here
  for cmd in $(_otel_list_path_commands | _otel_filter_commands_by_special | _otel_filter_commands_by_hint "$hint" | \sort -u); do _otel_deshebangify "$cmd" || \true; done
  for otel_custom_file in $(_otel_list_special_auto_instrument_files); do \. "$otel_custom_file"; done
  for cmd in $(_otel_list_alias_commands | _otel_filter_commands_by_special | \sort -u); do _otel_dealiasify "$cmd" || \true; done
  for cmd in $(_otel_list_all_commands | _otel_filter_commands_by_special | _otel_filter_commands_by_instrumentation | _otel_filter_commands_by_mode | _otel_filter_commands_by_hint "$hint" | \sort -u); do otel_instrument "$cmd"; done

  # super special instrumentations
  \alias .='_otel_instrument_and_source "$#" "$@" .'
  if \[ "$_otel_shell" = bash ]; then \alias source='_otel_instrument_and_source "$#" "$@" source'; fi
  if \[ "$_otel_shell_conservative_exec" = TRUE ]; then
    if \[ -n "$LINENO" ]; then
      \alias exec='eval "$(_otel_inject_and_exec_by_location "'$_otel_source_file_resolver'" "'$_otel_source_line_resolver'")"; exec'
    else
      \alias exec='_otel_record_exec; exec'
    fi
  else
    \alias exec='_otel_inject_and_exec_directly exec'
  fi

  # cache
  \[ "$(\alias | \wc -l)" -gt 25 ] && \alias | \sed 's/^alias //' | { \[ -n "$hint" ] && \grep "$(_otel_resolve_instrumentation_hint "$hint" | \sed 's/[]\.^*[]/\\&/g' | \awk '$0="^"$0"="')" || \cat; } | \awk '{print "\\alias " $0 }'  > "$cache_file" || \true
}

_otel_list_special_auto_instrument_files() {
  \echo /usr/share/opentelemetry_shell/opentelemetry_shell.custom.*.sh
}

_otel_list_all_commands() {
  _otel_list_path_commands
  _otel_list_alias_commands
  _otel_list_aliased_commands
  _otel_list_builtin_commands
}

_otel_list_path_commands() {
  _otel_list_path_executables | \rev | \cut -d / -f 1 | \rev
}

_otel_list_path_executables() {
  \echo "$PATH" | \tr ':' '\n' | while read dir; do if \[ "$_otel_shell" = 'busybox sh' ]; then "$(\which find)" "$dir" -maxdepth 1 -type f,l -executable 2> /dev/null; else \find "$dir" -maxdepth 1 -type f,l -executable 2> /dev/null; fi; done
}

_otel_list_alias_commands() {
  \alias | \sed 's/^alias //' | \grep -vF '[=' | \awk -F'=' '{ var=$1; sub($1 FS,""); } ! ($0 ~ "^'\''((OTEL_|_otel_).* )*" var "'\''$") { print var }'
}

_otel_list_aliased_commands() {
  \alias | \cut -d = -f 2- | _otel_line_split | _otel_filter_by_validity
}

_otel_list_builtin_commands() {
  \echo type
  \echo printenv
  \echo cd
  \echo pwd
  \echo wait
  \echo ulimit
  \echo umask
  if \[ "$_otel_shell" = "bash" ]; then
    \echo pushd
    \echo popd
    \echo hash
    \echo history
  fi
}

_otel_filter_commands_by_hint() {
  local hint="$1"
  if \[ -n "$hint" ]; then
    if \[ "$_otel_shell" = 'busybox sh' ]; then
      "$(\which grep)" -xF "$(_otel_resolve_instrumentation_hint "$hint")"
    else
      \grep -xF "$(_otel_resolve_instrumentation_hint "$hint")"
    fi
  else
    \cat
  fi
}

_otel_resolve_instrumentation_hint() {
  local hint="$1"
  { \[ -f "$hint" ] && \[ "$(\readlink -f "$hint")" != "$(\readlink -f "/proc/$$/exe")" ] && \[ "$(\readlink -f "$hint")" != "/usr/share/opentelemetry_shell/opentelemetry_shell.sh" ] && \cat "$hint" || \echo "$hint"; } | \tr -s ' $=";(){}/\\!#~^'\' '\n' | _otel_filter_by_validity | \sort -u
}

_otel_filter_commands_by_instrumentation() {
  local pre_instrumented_executables="$(\alias | \grep -F '_otel_observe' | \sed 's/^alias //' | \cut -d = -f 1)"
  if \[ -n "$pre_instrumented_executables" ]; then
    \grep -xFv "$pre_instrumented_executables" 
  else
    \cat
  fi
}

_otel_filter_commands_by_mode() {
  if \[ "$OTEL_SHELL_EXPERIMENTAL_INSTRUMENT_MINIMALLY" = TRUE ]; then
    \grep -F "$(\alias | \grep OTEL_SHELL_SPAN_KIND_OVERRIDE | \grep -v OTEL_SHELL_SPAN_KIND_OVERRIDE=INTERNAL | \sed 's/^alias //g' | \cut -d = -f 1)"
  else
    \cat
  fi
}

_otel_filter_commands_by_special() {
  \grep -vE '^(alias|unalias|\.|source|exec)$' | \grep -vE '^(OTEL_|_otel_|otel_)'
}

_otel_filter_by_validity() {
  \grep -E '^[a-zA-Z0-9._\[][a-zA-Z0-9 ._-]*$'
}

_otel_deshebangify() {
  local cmd="$1" # e.g., "upgrade"
  if \[ "$(_otel_command_type "$cmd")" != file ]; then return 1; fi
  local shebang="$(_otel_resolve_shebang "$1")" # e.g., "/bin/bash -x"
  if \[ -z "$shebang" ]; then return 2; fi
  \alias "$1=OTEL_SHELL_COMMAND_TYPE_OVERRIDE=file $shebang $(\which "$1")" # e.g., alias upgrade='/bin/bash -x /usr/bin/upgrade'
}

_otel_resolve_shebang() {
  local path="$(\which "$1")"
  if \[ -z "$path" ] || ! \[ -x "$path" ]; then return 1; fi
  read -r first_line < "$path"
  if ! _otel_string_starts_with "$first_line" "#!"; then return 2; fi
  \echo "${first_line#"#!"}"
}

_otel_dealiasify() {
  # e.g., alias upgrade='/bin/bash -x /usr/bin/upgrade'
  # e.g., alias bash='_otel_inject_shell _otel_observe bash'
  # e.g., alias ai=bash-ai -v
  # e.g., alias bash-ai='/bin/bash -x /usr/bin/bash-ai'
  # e.g., alias l=ls --color=auto
  # e.g., alias ls=ls --color=auto
  local cmd="$1" # e.g., "upgrade", "ai", "l"
  if ! _otel_has_alias "$cmd"; then return 1; fi
  local full_alias="$(_otel_resolve_alias "$cmd")"
  while _otel_string_starts_with "$full_alias" 'OTEL_'; do local full_alias="${full_alias#* }"; done
  if ! _otel_string_starts_with "$full_alias" / && ! _otel_string_starts_with "$full_alias" .; then return 2; fi
  local cmd_alias="$(\printf '%s' "$full_alias" | _otel_line_split | \grep -v '^OTEL_' | \grep -v '^_otel_' | \head -n1 | \rev | \cut -d / -f 1 | \rev)" # e.g., upgrade => bash
  if \[ -z "$cmd_alias" ]; then return 3; fi
  local cmd_aliased="$(_otel_resolve_alias $cmd_alias)" # e.g., bash => _otel_inject_shell bash
  if \[ -z "$cmd_aliased" ]; then return 4; fi
  local otel_cmds="$(\printf '%s' "$cmd_aliased" | _otel_line_split | \grep '^_otel_' | \grep -v '^_otel_observe' | _otel_line_join)" # e.g., _otel_inject_shell bash => _otel_inject_shell
  if \[ -z "$otel_cmds" ]; then return 5; fi
  _otel_alias_prepend "$cmd" "$otel_cmds" # e.g., alias upgrade='_otel_inject_shell /bin/bash -x /usr/bin/upgrade'
}

_otel_has_alias() {
  \alias "$1" 1> /dev/null 2> /dev/null # for some reason &> does not work in built-in alias
}

_otel_resolve_alias() {
  \alias "$1" 2> /dev/null | \cut -d = -f 2- | _otel_unquote # TODO maybe use parameter expansion for the cut to save a process? limited benefit because unquote will stay an external process
}

otel_instrument() {
  _otel_alias_prepend "$1" '_otel_observe'
}

otel_outstrument() {
  \unalias "$1" 1> /dev/null 2> /dev/null || true
}

_otel_alias_prepend() {
  local original_command="$1"
  local prepend_command="$2"

  if ! _otel_has_alias "$original_command"; then # fastpath
    local new_command="$(\printf '%s' "OTEL_SHELL_COMMAND_TYPE_OVERRIDE=$(_otel_command_type "$original_command") $prepend_command '\\$original_command'")" # need to use printf to handle backslashes consistently across shells
  else
    local previous_command="$(_otel_resolve_alias "$original_command")"
    for prepend_command_part in $prepend_command; do
      if _otel_string_contains "$previous_command" "$prepend_command_part"; then return 0; fi      
    done
    if _otel_string_contains "$previous_command" "OTEL_SHELL_COMMAND_TYPE_OVERRIDE="; then local command_type="$(\printf '%s' "$previous_command" | _otel_line_split | \grep '^OTEL_SHELL_COMMAND_TYPE_OVERRIDE=' | \cut -d = -f 2)"; else local command_type="alias"; fi
    if _otel_string_contains "$previous_command" "OTEL_SHELL_SPAN_KIND_OVERRIDE="; then local span_kind="$(\printf '%s' "$previous_command" | _otel_line_split | \grep '^OTEL_SHELL_SPAN_KIND_OVERRIDE=' | \cut -d = -f 2)"; fi
    while _otel_string_starts_with "$previous_command" "OTEL_"; do local previous_command="${previous_command#* }"; done
    local overrides="OTEL_SHELL_COMMAND_TYPE_OVERRIDE=$command_type"
    if \[ -n "$span_kind" ]; then local overrides="$overrides OTEL_SHELL_SPAN_KIND_OVERRIDE=$span_kind"; fi
    local previous_otel_command="$(\printf '%s' "$previous_command" | _otel_line_split | \grep '^_otel_' | _otel_line_join)"
    local previous_alias_command="$(\printf '%s' "$previous_command" | _otel_line_split | \grep -v '^_otel_' | _otel_line_join)"
    case "$previous_alias_command" in
      "$original_command") local previous_alias_command="$(\printf '%s' "'\\$original_command'")";;
      "$original_command "*) local previous_alias_command="$(\printf '%s' "'\\$original_command' $(_otel_string_contains "$previous_alias_command" " " && \printf '%s' "${previous_alias_command#* }" || \printf '%s' "$previous_alias_command")")";; 
      "\\$original_command") local previous_alias_command="$(\printf '%s' "'\\$original_command'")";;
      "\\$original_command "*) local previous_alias_command="$(\printf '%s' "'\\$original_command' $(_otel_string_contains "$previous_alias_command" " " && \printf '%s' "${previous_alias_command#* }" || \printf '%s' "$previous_alias_command")")";;
      *) ;;
    esac
    local new_command="$overrides $prepend_command $previous_otel_command $previous_alias_command"
  fi

  \alias "$original_command"='OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="code.filepath='$_otel_source_file_resolver',code.lineno='$_otel_source_line_resolver',code.function='$_otel_source_func_resolver'" '"$new_command"
}

_otel_unquote() {
  \sed -e 's/'\''\\'\'''\''/'\''/g' -e 's/'\''"'\''"'\''/'\''/g' -e 's/'\''"'\''"/'\'''\''/g' -e "s/^'\(.*\)'$/\1/" 
}

_otel_observe() {
  otel_observe "$@"
}

_otel_alias_and_instrument() {
  shift
  local exit_code=0
  \eval "'alias'" "$(_otel_escape_args "$@")" || local exit_code="$?"
  if \[ -n "$*" ] && \[ "${*#*=*}" != "$*" ]; then
    _otel_auto_instrument "$(_otel_dollar_star "$@" | _otel_line_split | \grep -m1 '=' 2> /dev/null | \tr '=' ' ')"
  fi
  return "$exit_code"
}

_otel_unalias_and_reinstrument() {
  shift
  local exit_code=0
  \eval "'unalias'" "$(_otel_escape_args "$@")" || local exit_code="$?"
  if \[ "-a" = "$*" ]; then
    _otel_auto_instrument "$_otel_shell_auto_instrumentation_hint"
  else
    _otel_auto_instrument "$(_otel_dollar_star "$@")"
  fi
  return "$exit_code"
}

_otel_instrument_and_source() {
  local n="$1"
  shift
  local command="$(eval '\echo $'"$(($n+1))")"
  local file="$(eval '\echo $'"$(($n+2))")"
  if \[ -f "$file" ]; then _otel_auto_instrument "$file"; fi
  \eval "'$command' '$file' $(if \[ $# -gt $(($n + 2)) ]; then \seq $(($n + 2 + 1)) $#; else \seq 1 $n; fi | while read i; do \echo '"$'"$i"'"'; done | _otel_line_join)"
}

_otel_inject_and_exec_directly() { # this function assumes there is no fd fuckery
  if \[ "$#" = 1 ]; then
    export OTEL_SHELL_CONSERVATIVE_EXEC=TRUE
    \eval '"exec"' "$(\xargs -0 sh -c '. otelapi.sh; _otel_escape_args "$@"' sh < /proc/$$/cmdline)"
  fi
  
  local span_id="$(otel_span_start INTERNAL "$@")"
  otel_span_activate "$span_id"
  local my_traceparent="$TRACEPARENT"
  otel_span_deactivate "$span_id"
  otel_span_end "$span_id"
  _otel_sdk_communicate 'SPAN_AUTO_END'
  
  export TRACEPARENT="$my_traceparent"
  export OTEL_SHELL_AUTO_INJECTED=TRUE
  export OTEL_SHELL_COMMANDLINE_OVERRIDE="$(_otel_command_self)"
  export OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="$PPID"
  shift
  \exec sh -c '. otel.sh
eval "$(_otel_escape_args "$@")"' sh "$@"
}

_otel_inject_and_exec_by_location() {
  local file="$1"
  local line="$2"
  if \[ -n "$file" ] && \[ -n "$line" ] && \[ -f "$file" ]; then local command="$(\cat "$file" | \sed -n "$line"p | \grep -F 'exec' | \sed 's/^.*exec /exec /')"; fi
  if _otel_string_contains "$command" ';'; then local command="$(\printf '%s' "$command" | \cut -d ';' -f 1)"; fi
  if \[ -z "$command" ] || \[ "$(\printf '%s' "$command" | \sed 's/ [0-9]*>.*$//')" = "exec" ]; then return 0; fi
  local command="$(\printf '%s' "$command" | \cut -d ' ' -f 2-)"

  local span_id="$(otel_span_start INTERNAL exec)"
  otel_span_activate "$span_id"
  local my_traceparent="$TRACEPARENT"
  otel_span_deactivate "$span_id"
  otel_span_end "$span_id"
  _otel_sdk_communicate 'SPAN_AUTO_END'

  \printf '%s\n' "$(_otel_escape_args export TRACEPARENT="$my_traceparent")"
  \printf '%s\n' "$(_otel_escape_args export OTEL_SHELL_AUTO_INJECTED=TRUE)"
  \printf '%s\n' "$(_otel_escape_args export OTEL_SHELL_COMMANDLINE_OVERRIDE="$(_otel_command_self)")"
  \printf '%s\n' "$(_otel_escape_args export OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="$PPID")"
  \echo -n '"exec" '; _otel_escape_args sh -c '. otel.sh
'"$command"; \echo -n ' "$0" "$@"'
}

_otel_record_exec() {
  local span_id="$(otel_span_start INTERNAL exec)"
  otel_span_activate "$span_id"
  local my_traceparent="$TRACEPARENT"
  otel_span_deactivate "$span_id"
  otel_span_end "$span_id"
  _otel_sdk_communicate 'SPAN_AUTO_END'
  export TRACEPARENT="$my_traceparent"
}

command() {
  if \[ "$#" = 2 ] && \[ "$1" = -v ] && _otel_string_contains "$(\alias "$2")" " OTEL_SHELL_COMMAND_TYPE_OVERRIDE=file "; then
    \which "$2"
  else
    \command "$@"
  fi
}

_otel_inject() {
  if _otel_string_contains "$1" /; then
    local command="$(\readlink -f "$1" | \rev | \cut -d / -f 1 | \rev)"
    shift
    set -- "$command" "$@"
    if ! \[ "$(\which "$(\echo "$1" | \rev | \cut -d / -f 1 | \rev)")" = "$1" ]; then
      local PATH="$(\readlink -f "$1" | \rev | \cut -d / -f 2- | \rev):$PATH"
      _otel_auto_instrument "$_otel_shell_auto_instrumentation_hint"
    fi
  fi
  \eval "$(_otel_escape_args "$@")"
}

_otel_start_script() {
  otel_init || return $?
  if \[ -n "$SSH_CLIENT"  ] && \[ -n "$SSH_CONNECTION" ] && \[ "$PPID" != 0 ] && \[ "$(\cat /proc/$PPID/cmdline | \tr -d '\000' | \cut -d ' ' -f 1)" = "sshd:" ]; then
    _root_span_handle="$(otel_span_start SERVER ssh)"
    otel_span_attribute_typed $_root_span_handle string ssh.ip="$(\echo $SSH_CONNECTION | \cut -d ' ' -f 3)"
    otel_span_attribute_typed $_root_span_handle int ssh.port="$(\echo $SSH_CONNECTION | \cut -d ' ' -f 4)"
    otel_span_attribute_typed $_root_span_handle string network.peer.ip="$(\echo $SSH_CLIENT | \cut -d ' ' -f 1)"
    otel_span_attribute_typed $_root_span_handle int network.peer.port="$(\echo $SSH_CLIENT | \cut -d ' ' -f 2)"
  elif \[ -n "$SERVER_SOFTWARE"  ] && \[ -n "$SCRIPT_NAME" ] && \[ -n "$SERVER_NAME" ] && \[ -n "$SERVER_PROTOCOL" ] && ! \[ "$OTEL_SHELL_AUTO_INJECTED" = "TRUE" ] && \[ "$PPID" != 0 ] && \[ "$(\cat "/proc/$PPID/cmdline" | \tr '\000' ' ' | \cut -d ' ' -f 1 | \rev | \cut -d / -f 1 | \rev)" = "python3" ]; then
    _root_span_handle="$(otel_span_start SERVER GET)"
    otel_span_attribute_typed $_root_span_handle string network.protocol.name=http
    otel_span_attribute_typed $_root_span_handle string network.transport=tcp
    otel_span_attribute_typed $_root_span_handle string network.peer.address="$REMOTE_ADDR"
    otel_span_attribute_typed $_root_span_handle string http.request.method=GET
    otel_span_attribute_typed $_root_span_handle string http.route="$SCRIPT_NAME"
    otel_span_attribute_typed $_root_span_handle string server.address="$SERVER_NAME"
    otel_span_attribute_typed $_root_span_handle int server.port="$SERVER_PORT"
    otel_span_attribute_typed $_root_span_handle string url.full="$(\echo "$SERVER_PROTOCOL" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')://$SERVER_NAME:$SERVER_PORT$SCRIPT_NAME"
    otel_span_attribute_typed $_root_span_handle string url.path="$SCRIPT_NAME"
    otel_span_attribute_typed $_root_span_handle string url.query=""
    otel_span_attribute_typed $_root_span_handle string url.scheme="$(\echo "$SERVER_PROTOCOL" | \cut -d / -f 1 | \tr '[:upper:]' '[:lower:]')"
    otel_span_attribute_typed $_root_span_handle string http.response.status_code=200
  elif _otel_command_self | \grep -q '/var/lib/dpkg/' > /dev/null; then
    local cmdline="$(_otel_command_self | \sed 's/^.* \(\/var\/lib\/dpkg\/.*\)$/\1/')"
    _root_span_handle="$(otel_span_start SERVER "$(\echo "$cmdline" | \cut -d . -f 2- | \cut -d ' ' -f 1)")"
    otel_span_attribute_typed $_root_span_handle string debian.package.name="$(\echo "$cmdline" | \rev | \cut -d / -f 1 | \rev | \cut -d . -f 1)"
    otel_span_attribute_typed $_root_span_handle string debian.package.operation="$(\echo "$cmdline" | \cut -d . -f 2-)"
  elif \[ "$GITHUB_ACTIONS" = true ] && \[ -n "$GITHUB_RUN_ID" ] && \[ -n "$GITHUB_WORKFLOW" ] && ( \[ "$OTEL_SHELL_IS_GITHUB_ACTION_ROOT" = TRUE ] || \[ "$PPID" != 0 ] && \[ "$(\cat /proc/$PPID/cmdline | \tr '\000-\037' ' ' | \cut -d ' ' -f 1 | \rev | \cut -d / -f 1 | \rev)" = "Runner.Worker" ] ); then
    unset OTEL_SHELL_IS_GITHUB_ACTION_ROOT
    local name="$GITHUB_WORKFLOW"
    local kind=CONSUMER
    if \[ -n "$GITHUB_JOB" ]; then local name="$name / $GITHUB_JOB"; local kind=CONSUMER; fi
    if \[ -n "$GITHUB_STEP" ]; then local name="$name / $GITHUB_STEP"; local kind=SERVER
    elif \[ -n "$GITHUB_ACTION" ]; then local name="$name / $GITHUB_ACTION"; local kind=INTERNAL; fi
    _root_span_handle="$(otel_span_start "$kind" "$name")"
  elif ! \[ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ] && \[ -z "$TRACEPARENT" ]; then
    _root_span_handle="$(otel_span_start SERVER "$(_otel_command_self)")"
  elif ! \[ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ] && \[ -n "$TRACEPARENT" ]; then
    _root_span_handle="$(otel_span_start INTERNAL "$(_otel_command_self)")"
  fi
  if \[ -n "$_root_span_handle" ]; then otel_span_activate "$_root_span_handle"; fi
  unset OTEL_SHELL_AUTO_INJECTED
}

_otel_end_script() {
  local exit_code="$?"
  if \[ -n "$_root_span_handle" ]; then
    if \[ "$exit_code" -ne 0 ]; then
      otel_span_error "$_root_span_handle"
    fi
    otel_span_deactivate
    otel_span_end "$_root_span_handle"
  fi
  otel_shutdown
}

_otel_auto_instrument "$_otel_shell_auto_instrumentation_hint"
trap _otel_end_script EXIT

_otel_start_script
