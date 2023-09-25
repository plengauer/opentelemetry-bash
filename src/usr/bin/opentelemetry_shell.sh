#!/bin/sh
if [ "$OTEL_SHELL_AUTO_INJECTED" != "" ]; then
  return 0
fi
OTEL_SHELL_AUTO_INJECTED=TRUE

source /usr/bin/opentelemetry_shell_api.sh

shopt -s expand_aliases

# TODO alias the alias command transparently to print warnings (or just error) if somebody overrides our aliases

function otel_do_alias {
  local new_command=$2
  local prev_command=$(\alias $1 2> /dev/null | \cut -d= -f2- | \tr -d \') || true
  if [ "$prev_command" == "" ]; then
    local new_command="$2 \\$1"
  else
    local new_command="$2 $prev_command"
  fi
  \alias $1="$new_command"
}

function otel_instrument {
  otel_do_alias $1 otel_observe || return $?
  export OTEL_SHELL_CUSTOM_INSTRUMENTATIONS=$OTEL_SHELL_CUSTOM_INSTRUMENTATIONS/$1
}

IFS='/' read -ra custom_instrumentations_array <<< $OTEL_SHELL_CUSTOM_INSTRUMENTATIONS
for custom_instrumentation in "${custom_instrumentations_array[@]}"; do
  if [ -n "$custom_instrumentation" ]; then
    otel_instrument $custom_instrumentation
  fi
done
while read cmd; do otel_do_alias $cmd otel_observe; done < /etc/opentelemetry_shell_auto_instrumentations.conf

function otel_instrumented_wget {
  # TODO scheme
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=GET
  name="$*" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="$*" \
    otel_observe $1 --header="traceparent: $OTEL_TRACEPARENT" "${@:2}"
}
otel_do_alias wget otel_instrumented_wget

function otel_instrumented_curl {
  # TODO scheme
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  if [ -z "$method" ]; then
    local method=GET
  fi
  name="$*" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="$*" \
    otel_observe $1 -H "traceparent: $OTEL_TRACEPARENT" "${@:2}"
}
otel_do_alias curl otel_instrumented_curl

function otel_instrumented_bash {
  local args=""
  for arg in "${@:2}"; do
    local args="$args \"$arg\""
  done
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$*" OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE=INTERNAL $1 -c "source /usr/bin/opentelemetry_shell.sh; source $args"
}
otel_do_alias bash otel_instrumented_bash

function otel_on_script_start {
  otel_init || return $?
  local kind=SERVER
  if [ -n "$OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE" ]; then
    kind=$OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE
    unset OTEL_SHELL_ROOT_SPAN_KIND_OVERRIDE
  fi
  root_span_id=$(otel_span_start $kind $(otel_command_self))
  otel_span_activate $root_span_id
}
function otel_on_script_end {
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
