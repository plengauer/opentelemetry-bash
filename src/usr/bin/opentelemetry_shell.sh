#!/bin/sh
###############################################################################################################
# This file is doing auto-instrumentation, auto-injection and auto-context-propagation.                        #
# It should be sourced at the very top of any shell script that should be observed.                            #
# Only use the "otel_instrument" and "otel_outstrument" function directly.                                     #
# All other functions and variables are for internal use only and therefore subject to change without notice!  #
################################################################################################################

if [ "$OTEL_SHELL_INJECTED" != "" ]; then
  return 0
fi
OTEL_SHELL_INJECTED=TRUE

. /usr/bin/opentelemetry_shell_api.sh

if [ "$otel_shell" = "bash" ]; then
  shopt -s expand_aliases &> /dev/null
fi
if [ "$otel_shell" = "zsh" ]; then
  setopt aliases &> /dev/null
fi
case "$-" in
  *i*) otel_is_interactive=TRUE;;
  *)   otel_is_interactive=FALSE;;
esac

otel_alias_prepend() {
  local original_command=$1
  local prepend_command=$2
  
  local previous_command="$(\alias $original_command 2> /dev/null | \cut -d= -f2- | \tr -d \')"
  if [ -z "$previous_command" ]; then local previous_command="$original_command"; fi
  if [ "${previous_command#OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE=}" != "$previous_command" ]; then local previous_command="$(\printf '%s' "$previous_command" | \cut -d" " -f2-)"; fi
  case "$previous_command" in
    *"$prepend_command"*) return 0 ;;
    *) ;;
  esac

  local previous_otel_command="$(\echo -n "$previous_command" | \tr ' ' '\n' | \grep '^otel_' | \xargs)"
  local previous_alias_command="$(\echo -n "$previous_command" | \tr ' ' '\n' | \grep -v '^otel_' | \xargs)"
  local new_command="$previous_otel_command $prepend_command \\$previous_alias_command"
  \alias $original_command='OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="code.function=$BASH_SOURCE,code.filepath=$0,code.lineno=$LINENO" '"$new_command"
}

otel_instrument() {
  otel_alias_prepend $1 'otel_observe'
}

otel_outstrument() {
  \unalias $1 1> /dev/null 2> /dev/null || true
}

otel_filter_instrumentations() {
  local file_hint="$1"
  if [ "$file_hint" != "" ] && [ -f "$file_hint" ] && [ "$(\readlink -f /proc/$$/exe)" != "$(\readlink -f $file_hint)" ] && [ "$file_hint" != "/usr/bin/opentelemetry_shell.sh" ]; then
    \grep -xF "$(\tr -s ' $=";(){}[]/\\!#~^'\' '\n' < "$file_hint" | \grep -E '^[a-zA-Z0-9 ._-]*$')"
  else
    \cat
  fi
}

otel_list_path_executables() {
  if [ "$otel_shell" = "zsh" ]; then
    for dir in ${(s/:/)PATH}; do \find $dir -maxdepth 1 -type f,l -executable 2> /dev/null; done
  else
    IFS=': ' ; for dir in $PATH; do \find $dir -maxdepth 1 -type f,l -executable 2> /dev/null; done
  fi
}

otel_list_path_commands() {
  otel_list_path_executables | \rev | \cut -d / -f1 | \rev | \grep -vF '['
}

otel_list_alias_commands() {
  \alias | \cut -d' ' -f2- | while read alias_entry; do
    local alias_key="$(\echo "$alias_entry" | \cut -d= -f1)"
    local alias_val="$(\echo "$alias_entry" | \cut -d= -f2- | \sed "s/^'\(.*\)'$/\1/")"
    if [ "$(\echo "$alias_val" | \tr ' ' '\n' | \grep -vP '\b(OTEL_|otel_)\w*\b' | \xargs)" != "$alias_key" ]; then \echo $alias_key; fi
  done
}

otel_list_builtin_commands() {
  \echo type
  if [ "$otel_shell" = "bash" ] || [ "$otel_shell" = "zsh" ]; then
    \echo history
  fi
}

otel_list_all_commands() {
  otel_list_path_commands
  otel_list_alias_commands
  otel_list_builtin_commands
}

otel_auto_instrument() {
  local file_hint="$1"
  local executables="$(otel_list_all_commands | \sort -u | otel_filter_instrumentations "$file_hint" | \xargs)"
  if [ "$otel_shell" = "zsh" ]; then
    for cmd in ${(s/ /)executables}; do otel_instrument $cmd; done
  else
    for cmd in $executables; do otel_instrument $cmd; done
  fi
}

otel_alias_and_instrument() {
  local exit_code=0
  "$@" || exit_code=$?
  local commands="$(\echo "$@" | \tr ' ' '\n' | \grep -m1 '=' 2> /dev/null | \cut -d= -f1)"
  if [ "$otel_shell" = "zsh" ]; then
    for cmd in ${(s/ /)commands}; do otel_instrument $cmd; done
  else
    for cmd in $commands; do otel_instrument $cmd; done
  fi
  return $exit_code
}

otel_unalias_and_reinstrument() {
  local exit_code=0
  "$@" || exit_code=$?
  local commands="$(otel_list_all_commands | \grep -F "$(\echo "$@" | \tr ' ' '\n' | \grep -vx '-a' 2> /dev/null)" 2> /dev/null)"
  # this seems to re-instrument the world
  if [ "$otel_shell" = "zsh" ]; then
    for cmd in ${(s/ /)commands}; do otel_instrument $cmd; done
  else
    for cmd in $commands; do otel_instrument $cmd; done
  fi
  return $exit_code
}

otel_instrument_and_source() {
  local file="$2"
  if [ -f "$file" ]; then
    otel_auto_instrument "$file"
  fi
  "$@"
}

otel_propagate_wget() {
  local command="$(\echo "$*" | \sed 's/^otel_observe //')"
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

otel_propagate_curl() {
  local command="$(\echo "$*" | \sed 's/^otel_observe //')"
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

otel_inject_shell_with_copy() {
  # resolve executable
  if [ "$1" = "otel_observe" ]; then
    shift; local cmdline="$*"; local executable="otel_observe $1"; local dollar_zero="$1"; shift
  else
    local cmdline="$*"; local executable=$1; local dollar_zero="$1"; shift
  fi
  # decompile command
  local options=""; local cmd=""; local args="";
  local is_next_command_string="FALSE"; local is_parsing_arguments="FALSE"; local is_next_option="FALSE";
  for arg in "$@"; do
    if [ "$arg" = "-c" ]; then
      local is_next_command_string="TRUE"
    elif [ "$is_next_command_string" = "TRUE" ]; then
      local cmd="$arg"
      local is_next_command_string="FALSE"
    elif [ "$is_parsing_command" = "TRUE" ]; then
      local args="$args \"$arg\""
    elif [ "$is_next_option" = "TRUE" ]; then
      local options="$options $arg"
      local is_next_option="FALSE"
    else
      case "$arg" in
        -*file) local options="$options $arg"; local is_next_option="TRUE" ;;
        -*) local options="$options $arg" ;;
        *) local is_parsing_command="TRUE"; local cmd="$arg"; local dollar_zero="$arg" ;;
      esac
    fi
  done
  # prepare temporary script
  local temporary_script=$(\mktemp -u)
  \touch $temporary_script
  \echo "set -- $args" >> $temporary_script
  \echo ". /usr/bin/opentelemetry_shell.sh" >> $temporary_script
  if [ -f "$cmd" ]; then
    \cat $cmd >> $temporary_script
  else
    \echo "$cmd" >> $temporary_script
  fi
  \chmod +x $temporary_script
  # compile command
  if [ "$otel_shell" = "zsh" ]; then
    set -- ${(z)=executable} ${(z)=options} $temporary_script
  else
    set -- $executable $options $temporary_script
  fi
  # run command
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_AUTO_INJECTED=TRUE "$@" || exit_code=$?
  \rm $temporary_script
  return $exit_code
}

otel_inject_shell_with_c_flag() {
  # type 0 - interactive or from stdin: bash, bash -x
  # type 1 - script: bash +x script.sh foo bar baz
  # type 2 - "-c": bash +x -c "echo $0" foo
  # resolve executable
  if [ "$1" = "otel_observe" ]; then
    shift; local cmdline="$*"; local executable="otel_observe $1"; local dollar_zero="$1"; shift
  else
    local cmdline="$*"; local executable=$1; local dollar_zero="$1"; shift
  fi
  # decompile command
  local options=""; local cmd=""; local args="";
  local is_next_command_string="FALSE"; local is_parsing_arguments="FALSE"; local is_next_option="FALSE";
  for arg in "$@"; do
    if [ "$arg" = "-c" ]; then
      local is_next_command_string="TRUE"
    elif [ "$is_next_command_string" = "TRUE" ]; then
      local cmd="
$arg"
      # aliases need at least a linefeed or a source to become active in a -c command. Dunno why, but its like that
      # also, we cant just introduce ALWAYS a linefeed, because then argument ordering is confused for sourced scripts
      local is_next_command_string="FALSE"
    elif [ "$is_parsing_command" = "TRUE" ]; then
      local args="$args \"$arg\""
    elif [ "$is_next_option" = "TRUE" ]; then
      local options="$options $arg"
      local is_next_option="FALSE"
    else
      case "$arg" in
        -*file) local options="$options $arg"; local is_next_option="TRUE" ;;
        -*) local options="$options $arg" ;;
        *) local is_parsing_command="TRUE"; local cmd="$arg"; local dollar_zero="$arg" ;;
      esac
    fi
  done
  # compile command
  if [ -f "$cmd" ]; then
    local cmd=". $cmd"
  fi
  if [ "$otel_shell" = "zsh" ]; then
    set -- ${(z)=executable} ${(z)=options} -c ". /usr/bin/opentelemetry_shell.sh; $cmd $args" "$dollar_zero"
  else
    set -- $executable $options -c ". /usr/bin/opentelemetry_shell.sh; $cmd $args" "$dollar_zero"
  fi
  # run command
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_AUTO_INJECTED=TRUE "$@" || exit_code=$?
  return $exit_code
}

otel_start_script() {
  unset OTEL_SHELL_SPAN_NAME_OVERRIDE
  unset OTEL_SHELL_SPAN_KIND_OVERRIDE
  unset OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE
  otel_init || return $?
  if [ "$OTEL_SHELL_AUTO_INJECTED" != "TRUE" ]; then
    unset OTEL_SHELL_AUTO_INJECTED
    otel_root_span_id=$(otel_span_start SERVER $(otel_command_self))
    if [ -n "$SSH_CLIENT"  ] && [ -n "$SSH_CONNECTION" ]; then
      otel_span_attribute $otel_root_span_id ssh.ip=$(\echo $SSH_CONNECTION | \cut -d' ' -f3)
      otel_span_attribute $otel_root_span_id ssh.port=$(\echo $SSH_CONNECTION | \cut -d' ' -f4)
      otel_span_attribute $otel_root_span_id net.peer.ip=$(\echo $SSH_CLIENT | \cut -d' ' -f1)
      otel_span_attribute $otel_root_span_id net.peer.port=$(\echo $SSH_CLIENT | \cut -d' ' -f2)
    elif [ -n "$SERVER_SOFTWARE"  ] && [ -n "$SCRIPT_NAME" ] && [ -n "$SERVER_NAME" ] && [ -n "$SERVER_PROTOCOL" ]; then
      otel_span_attribute $otel_root_span_id http.flavor=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f2)
      otel_span_attribute $otel_root_span_id http.host=$SERVER_NAME:$SERVER_PORT
      otel_span_attribute $otel_root_span_id http.route=$SCRIPT_NAME
      otel_span_attribute $otel_root_span_id http.scheme=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1 | \tr '[:upper:]' '[:lower:]')
      otel_span_attribute $otel_root_span_id http.status_code=200
      otel_span_attribute $otel_root_span_id http.status_text=OK
      otel_span_attribute $otel_root_span_id http.target=$SCRIPT_NAME
      otel_span_attribute $otel_root_span_id http.url=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1 | \tr '[:upper:]' '[:lower:]')://$SERVER_NAME:$SERVER_PORT$SCRIPT_NAME
      otel_span_attribute $otel_root_span_id net.peer.ip=$REMOTE_ADDR
    fi
    otel_span_activate $otel_root_span_id
  fi
}

otel_end_script() {
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

otel_end_script_and_exec() {
  if [ "$1" = "otel_observe" ]; then shift; fi
  if [ -n "$*" ]; then
    local span_id=$(otel_span_start INTERNAL "exec $*")
    local traceparent=$(otel_traceparent $span_id)
    otel_span_end $span_id
    otel_end_script
    export OTEL_TRACEPARENT=$traceparent
  fi
  "$@"
}

otel_alias_prepend wget otel_propagate_wget
otel_alias_prepend curl otel_propagate_curl
if [ "$otel_is_interactive" != "TRUE" ]; then # TODO do this always, not just when non-interactive. but then interactive injection must be handled properly!
  otel_alias_prepend sh otel_inject_shell_with_copy # cant realy relly what kind of shell it actually is, so lets play it safe
  otel_alias_prepend ash otel_inject_shell_with_copy # sourced files do not support arguments
  otel_alias_prepend dash otel_inject_shell_with_copy # sourced files do not support arguments
  otel_alias_prepend bash otel_inject_shell_with_c_flag
  otel_alias_prepend zsh otel_inject_shell_with_c_flag
fi

otel_alias_prepend alias otel_alias_and_instrument 
otel_alias_prepend unalias otel_unalias_and_reinstrument
otel_alias_prepend . otel_instrument_and_source
if [ "$otel_shell" = "bash" ] || [ "$otel_shell" = "zsh" ]; then
  otel_alias_prepend source otel_instrument_and_source
fi
otel_auto_instrument "$0"

otel_alias_prepend exec otel_end_script_and_exec
trap otel_end_script EXIT

\alias >&2
otel_start_script
