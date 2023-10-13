#!/bin/sh
###############################################################################################################
# This file is doing auto-instrumentation, auto-injection and auto-context-propagation.                        #
# It should be sourced at the very top of any shell script that should be observed.                            #
# Only use the "otel_instrument" function directly.                                                            #
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

# TODO alias the alias command transparently to print warnings (or just error) if somebody overrides our aliases

otel_do_alias() {
  local new_command=$2
  local prev_command=$(\alias $1 2> /dev/null | \cut -d= -f2- | \tr -d \') || true
  if [ -z "$prev_command" ]; then
    local new_command="$2 \\$1"
  else
    if [ "${prev_command#OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE=}" != "$prev_command" ]; then
      local prev_command=$(\printf '%s' "$prev_command" | \cut -d" " -f2-)
    fi
    local new_command="$2 $prev_command"
  fi
  \alias $1='OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="code.function=$BASH_SOURCE,code.filepath=$0,code.lineno=$LINENO" '"$new_command"
}

otel_instrument() {
  otel_do_alias $1 'otel_observe' || return $?
  export OTEL_SHELL_CUSTOM_INSTRUMENTATIONS=$(\echo "$OTEL_SHELL_CUSTOM_INSTRUMENTATIONS $1" | \xargs)
}

otel_outstrument() {
  unalias $1 1> /dev/null 2> /dev/null || true
}

for cmd in "$OTEL_SHELL_CUSTOM_INSTRUMENTATIONS"; do
  otel_instrument $cmd
done
while read cmd; do otel_do_alias $cmd 'otel_observe'; done < /etc/opentelemetry_shell_auto_instrumentations.conf

otel_propagated_wget() {
  local command=$(\echo $* | \sed 's/^otel_observe //')
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
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
  local command=$(\echo $* | \sed 's/^otel_observe //')
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local scheme=http # TODO
  local target=$(\echo /${url#*//*/})
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  if [ -z "$method" ]; then
    local method=GET
  fi
  OTEL_SHELL_SPAN_NAME_OVERRIDE="$command" OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" \
    OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="http.url=$url,http.scheme=$scheme,http.host=$host,http.target=$target,http.method=$method,$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0='-H' OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1='traceparent: $OTEL_TRACEPARENT' \
    "$@"
}
otel_do_alias curl otel_propagated_curl

otel_injected_shell_with_c_flag() {
  if [ "$1" = "otel_observe" ]; then
    shift
    local cmdline="$*"
    local cmd="otel_observe $1"
    shift
  else
    local cmdline="$*"
    local cmd=$1
    shift
  fi
  local args=""
  for arg in "$@"; do
    local args="$args \"$arg\""
  done
  if [ "$otel_shell" = "zsh" ]; then
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
      OTEL_SHELL_AUTO_INJECTED=TRUE \
      ${(z)=cmd} -c ". /usr/bin/opentelemetry_shell.sh; . $args"
  else
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
      OTEL_SHELL_AUTO_INJECTED=TRUE \
      $cmd -c ". /usr/bin/opentelemetry_shell.sh; . $args"
  fi
}
otel_do_alias bash otel_injected_shell_with_c_flag
otel_do_alias zsh otel_injected_shell_with_c_flag

otel_injected_shell_with_copy() {
  if [ "$1" = "otel_observe" ]; then
    shift
    local cmdline="$*"
    local cmd="otel_observe $1"
    shift
  else
    local cmdline="$*"
    local cmd=$1
    shift
  fi
  local script=$1
  shift
  local args=""
  for arg in "$@"; do
    local args="$args \"$arg\""
  done
  local temporary_script=$(\mktemp -u)
  \touch $temporary_script
  \echo "set -- $args" >> $temporary_script
  \echo ". /usr/bin/opentelemetry_shell.sh" >> $temporary_script
  \cat $script >> $temporary_script
  \chmod +x $temporary_script
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_AUTO_INJECTED=TRUE \
    $cmd $temporary_script || exit_code=$?
  \rm $temporary_script
  return $exit_code
}
otel_do_alias sh otel_injected_shell_with_copy
otel_do_alias ash otel_injected_shell_with_copy
otel_do_alias dash otel_injected_shell_with_copy

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
  exec "$@"
}
trap otel_on_script_end EXIT
alias exec=otel_on_script_exec
otel_on_script_start
