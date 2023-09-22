#!/bin/bash
source /usr/bin/opentelemetry_bash_sdk.sh

shopt -s expand_aliases

function otel_do_alias {
  local exit_code=0
  alias $1 &> /dev/null || local exit_code=$?
  if [ "$exit_code" -eq "0" ]; then
    return 1
  fi
  alias $1="$2"
}

function otel_do_instrument {
  otel_do_alias $1 "otel_observe \\$1" || return 1
}

function otel_instrument {
  otel_do_instrument $1
  export OTEL_BASH_CUSTOM_INSTRUMENTATIONS=$OTEL_BASH_CUSTOM_INSTRUMENTATIONS/$1
}
IFS='/' read -ra custom_instrumentations_array <<< $OTEL_BASH_CUSTOM_INSTRUMENTATIONS
  for custom_instrumentation in "${custom_instrumentations_array[@]}"; do
    if [ -n "$custom_instrumentation" ]; then
      otel_instrument $custom_instrumentation
    fi
done

# otel_do_instrument echo
otel_do_instrument sed
otel_do_instrument awk
otel_do_instrument cut
otel_do_instrument sort
otel_do_instrument tr
otel_do_instrument wc
otel_do_instrument grep
otel_do_instrument egrep
otel_do_instrument fgrep

otel_do_instrument find
otel_do_instrument cat
otel_do_instrument cp
otel_do_instrument mv
otel_do_instrument rm

otel_do_instrument scp
otel_do_instrument rsync
otel_do_instrument dd
otel_do_instrument tar
otel_do_instrument gzip
otel_do_instrument gunzip
otel_do_instrument zip
otel_do_instrument unzip

otel_do_instrument ping
otel_do_instrument ssh

otel_do_instrument systemctl

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
