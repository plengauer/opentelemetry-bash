#!/bin/sh
if [ "$OTEL_SHELL_AUTO_INJECTED" != "" ]; then
  return 0
fi
OTEL_SHELL_AUTO_INJECTED=TRUE

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
    local new_command="$2 $prev_command"
  fi
  \alias $1="$new_command"
}

otel_instrument() {
  otel_do_alias $1 otel_observe || return $?
  export OTEL_SHELL_CUSTOM_INSTRUMENTATIONS=$(\echo "$OTEL_SHELL_CUSTOM_INSTRUMENTATIONS $1" | \xargs)
}

for cmd in "$OTEL_SHELL_CUSTOM_INSTRUMENTATIONS"; do
  otel_instrument $cmd
done
while read cmd; do otel_do_alias $cmd otel_observe; done < /etc/opentelemetry_shell_auto_instrumentations.conf

otel_instrumented_wget() {
  # TODO scheme
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=GET
  local cmdline="$*"
  local cmd=$1
  shift
  name="$cmdline" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="$cmdline" \
    otel_observe $cmd --header="traceparent: $OTEL_TRACEPARENT" "$@"
}
otel_do_alias wget otel_instrumented_wget

otel_instrumented_curl() {
  # TODO scheme
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  if [ -z "$method" ]; then
    local method=GET
  fi
  local cmdline="$*"
  local cmd=$1
  shift
  name="$cmdline" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="$cmdline" \
    otel_observe $cmd -H "traceparent: $OTEL_TRACEPARENT" "$@"
}
otel_do_alias curl otel_instrumented_curl

otel_instrumented_shell_with_c_flag() {
  local cmdline="$*"
  local cmd=$1
  shift
  local args=""
  for arg in "$@"; do
    local args="$args \"$arg\""
  done
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE=INTERNAL $cmd -c ". /usr/bin/opentelemetry_shell.sh; . $args"
}
otel_do_alias bash otel_instrumented_shell_with_c_flag
otel_do_alias zsh otel_instrumented_shell_with_c_flag

otel_instrumented_shell_with_copy() {
  local cmdline="$*"
  local cmd=$1
  shift
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
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE=INTERNAL $cmd $temporary_script || exit_code=$?
  rm $temporary_script
  return $exit_code
}
otel_do_alias sh otel_instrumented_shell_with_copy
otel_do_alias dash otel_instrumented_shell_with_copy

otel_check_populate_cgi() {
  local span_id=$1
  if [ -z "$SERVER_SOFTWARE"  ] || [ -z "$SCRIPTNAME" ] || [ -z "$SERVER_NAME" ] || [ -z "$SERVER_PROTOCOL" ]; then
    return 0
  fi
  otel_span_attribute $span_id http.flavor=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f2)
  otel_span_attribute $span_id http.host=$SERVER_NAME:$SERVER_PORT
  otel_span_attribute $span_id http.route=$SCRIPT_NAME
  otel_span_attribute $span_id http.scheme=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1)
  otel_span_attribute $span_id http.status_code=200
  otel_span_attribute $span_id http.status_text=OK
  otel_span_attribute $span_id http.target=$SCRIPT_NAME
  otel_span_attribute $span_id http.url=$(\echo $SERVER_PROTOCOL | \cut -d'/' -f1)://$SERVER_NAME:$SERVER_PORT/$SCRIPT_NAME
  otel_span_attribute $span_id net.peer.ip=$REMOTE_ADDR
}

otel_on_script_start() {
  otel_init || return $?
  local kind=SERVER
  if [ -n "$OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE" ]; then
    kind=$OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE
    unset OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE
  fi
  root_span_id=$(otel_span_start $kind $(otel_command_self))
  otel_check_populate_cgi $root_span_id
  otel_span_activate $root_span_id
}
otel_on_script_end() {
  local exit_code=$?
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error $root_span_id
  fi
  otel_span_deactivate
  otel_span_end $root_span_id
  otel_shutdown
}
trap otel_on_script_end EXIT
# TODO we should alias exec, to be sure we shutdown properly and not leak the companion process
otel_on_script_start
