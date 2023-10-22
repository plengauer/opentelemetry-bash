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

otel_do_alias() {
  local new_command=$2
  local prev_command="$(\alias $1 2> /dev/null | \cut -d= -f2- | \tr -d \')" || true
  if [ -z "$prev_command" ]; then
    local new_command="$2 \\$1"
  else
    if [ "${prev_command#OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE=}" != "$prev_command" ]; then
      local prev_command="$(\printf '%s' "$prev_command" | \cut -d" " -f2-)"
    fi
    local new_command="$2 $prev_command"
  fi
  \alias $1='OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="code.function=$BASH_SOURCE,code.filepath=$0,code.lineno=$LINENO" '"$new_command"
}

otel_instrument() {
  otel_do_alias $1 'otel_observe'
}

otel_outstrument() {
  unalias $1 1> /dev/null 2> /dev/null || true
}

otel_filter_instrumentations() {
  if [ "-f" "$0" ] && [ "$(\grep -v '. /usr/bin/opentelemetry_shell.sh' "$0" | \grep -qF '. 
source ' && \echo 'TRUE' || \echo 'FALSE')" = "FALSE" ]; then
    \grep -xF "$(\tr -s ' ' '\n' < "$0" | \grep -E '^[a-zA-Z0-9 ._-]*$')"
  else
    \cat
  fi
}

if [ "$otel_shell" = "zsh" ]; then
  otel_executables=$(for dir in ${(s/:/)PATH}; do \find $dir -maxdepth 1 -type f,l -executable 2> /dev/null; done | \rev | \cut -d / -f1 | \rev | \sort -u | \grep -vF '[' | otel_filter_instrumentations | \xargs)
  for cmd in ${(s/ /)otel_executables}; do
    otel_instrument $cmd
  done
  unset otel_executables
else
  for cmd in $(IFS=': ' ; for dir in $PATH; do \find $dir -maxdepth 1 -type f,l -executable 2> /dev/null; done | \rev | \cut -d / -f1 | \rev | \sort -u | \grep -vF '[' | otel_filter_instrumentations | \xargs); do
    otel_instrument $cmd
  done
fi

otel_propagated_wget() {
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

otel_do_alias wget otel_propagated_wget

otel_propagated_curl() {
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

otel_do_alias curl otel_propagated_curl

otel_injected_shell_with_copy() {
  # resolve executable
  if [ "$1" = "otel_observe" ]; then
    shift; local cmdline="$*"; local executable="otel_observe $1"; shift
  else
    local cmdline="$*"; local executable=$1; shift
  fi
  # decompile command
  local options=""; local cmd=""; local args=""; local dollar_zero="$1"
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

otel_injected_shell_with_c_flag() {
  # type 0 - interactive or from stdin: bash, bash -x
  # type 1 - script: bash +x script.sh foo bar baz
  # type 2 - "-c": bash +x -c "echo $0" foo
  # resolve executable
  if [ "$1" = "otel_observe" ]; then
    shift; local cmdline="$*"; local executable="otel_observe $1"; shift
  else
    local cmdline="$*"; local executable=$1; shift
  fi
  # decompile command
  local options=""; local cmd=""; local args=""; local dollar_zero="$1"
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
  # compile command
  if [ -f "$cmd" ]; then
    local cmd=". $cmd"
  fi
  if [ "$otel_shell" = "zsh" ]; then
    set -- ${(z)=executable} ${(z)=options} -c ". /usr/bin/opentelemetry_shell.sh
$cmd $args" "$dollar_zero"
  else
    set -- $executable $options -c ". /usr/bin/opentelemetry_shell.sh
$cmd $args" "$dollar_zero"
  fi
  # run command
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_AUTO_INJECTED=TRUE "$@" || exit_code=$?
  return $exit_code
}

if [ "$otel_is_interactive" != "TRUE" ]; then # TODO do this always, not just when non-interactive. but then interactive injection must be handled properly!
  otel_do_alias sh otel_injected_shell_with_copy # cant really rely what kind of shell it actually is, so lets play it safe
  otel_do_alias ash otel_injected_shell_with_copy # sourced files do not support arguments
  otel_do_alias dash otel_injected_shell_with_copy # sourced files do not support arguments
  otel_do_alias bash otel_injected_shell_with_c_flag
  otel_do_alias zsh otel_injected_shell_with_c_flag
fi

otel_check_populate_cgi() {
  local span_id=$1
  if [ -n "$OTEL_TRACEPARENT" ]; then
    return 0 # somebody else already created a trace, lets assume they take care of it
  fi
  if [ -z "$SERVER_SOFTWARE"  ] || [ -z "$SCRIPT_NAME" ] || [ -z "$SERVER_NAME" ] || [ -z "$SERVER_PROTOCOL" ]; then
    return 0
  fi
  otel_span_attribute $span_id http.flavor=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f2)
  otel_span_attribute $span_id http.host=$SERVER_NAME:$SERVER_PORT
  otel_span_attribute $span_id http.route=$SCRIPT_NAME
  otel_span_attribute $span_id http.scheme=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1 | \tr '[:upper:]' '[:lower:]')
  otel_span_attribute $span_id http.status_code=200
  otel_span_attribute $span_id http.status_text=OK
  otel_span_attribute $span_id http.target=$SCRIPT_NAME
  otel_span_attribute $span_id http.url=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1 | \tr '[:upper:]' '[:lower:]')://$SERVER_NAME:$SERVER_PORT$SCRIPT_NAME
  otel_span_attribute $span_id net.peer.ip=$REMOTE_ADDR
}

otel_on_script_start() {
  otel_init || return $?
  if [ "$OTEL_SHELL_AUTO_INJECTED" != "TRUE" ]; then
    unset OTEL_SHELL_AUTO_INJECTED
    otel_root_span_id=$(otel_span_start SERVER $(otel_command_self))
    otel_check_populate_cgi $otel_root_span_id
    otel_span_activate $otel_root_span_id
  fi
}

otel_on_script_end() {
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

otel_on_script_exec() {
  if [ "$1" = "otel_observe" ]; then
    shift
  fi
  local span_id=$(otel_span_start INTERNAL "exec $*")
  local traceparent=$(otel_traceparent $span_id)
  otel_span_end $span_id
  otel_on_script_end
  export OTEL_TRACEPARENT=$traceparent
  \exec "$@"
}

trap otel_on_script_end EXIT
alias exec=otel_on_script_exec
otel_on_script_start
