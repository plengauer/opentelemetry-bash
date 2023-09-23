#!/bin/bash
if [ "$OTEL_BASH_AUTO_INJECTED" != "" ]; then
  return 0
fi
OTEL_BASH_AUTO_INJECTED=TRUE

source /usr/bin/opentelemetry_bash_sdk.sh

shopt -s expand_aliases

function otel_do_alias {
  local exit_code=0
  alias $1 &> /dev/null || local exit_code=$?
  # TODO instead of failing we could actually _prepend_ our alias
  # and we should probably also alias the alias command (and trap command) to not be overwritten
  if [ "$exit_code" -eq "0" ]; then
    return 1
  fi
  alias $1="$2"
}

function otel_do_instrument {
  otel_do_alias $1 "otel_observe \\$1" || return $?
}

function otel_instrument {
  otel_do_instrument $1 || return $?
  export OTEL_BASH_CUSTOM_INSTRUMENTATIONS=$OTEL_BASH_CUSTOM_INSTRUMENTATIONS/$1
}

IFS='/' read -ra custom_instrumentations_array <<< $OTEL_BASH_CUSTOM_INSTRUMENTATIONS
for custom_instrumentation in "${custom_instrumentations_array[@]}"; do
  if [ -n "$custom_instrumentation" ]; then
    otel_instrument $custom_instrumentation
  fi
done
while read cmd; do otel_do_instrument $cmd; done < /etc/opentelemetry_bash_auto_instrumentations.conf

function otel_instrumented_wget {
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=GET
  name="wget $*" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="wget $*" \
    otel_observe \wget --header="traceparent: $OTEL_TRACEPARENT" "$@"
}
otel_do_alias wget otel_instrumented_wget

function otel_instrumented_curl {
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  if [ -z "$method" ]; then
    local method=GET
  fi
  name="curl $*" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="curl $*" \
    otel_observe \curl -H "traceparent: $OTEL_TRACEPARENT" "$@"
}
otel_do_alias curl otel_instrumented_curl

function otel_instrumented_bash {
  local args=""
  for arg in "${@}"; do
    local args="$args \"$arg\""
  done
  OTEL_BASH_COMMAND_OVERRIDE="bash $@" OTEL_BASH_ROOT_SPAN_KIND_OVERRIDE=INTERNAL \bash -c "source /usr/bin/opentelemetry_bash.sh; source $args"
}
otel_do_alias bash otel_instrumented_bash

function otel_on_script_start {
  otel_init || return $?
  local kind=SERVER
  if [ -n "$OTEL_BASH_ROOT_SPAN_KIND_OVERRIDE" ]; then
    kind=$OTEL_BASH_ROOT_SPAN_KIND_OVERRIDE
    unset OTEL_BASH_ROOT_SPAN_KIND_OVERRIDE
  fi
  otel_span_start $kind $(otel_command_self)
}
function otel_on_script_end {
  local exit_code=$?
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error
  fi
  otel_span_end
  otel_shutdown
}
trap otel_on_script_end EXIT
otel_on_script_start
