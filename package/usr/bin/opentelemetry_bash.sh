#!/bin/bash
source /usr/bin/opentelemetry_bash_sdk.sh

shopt -s expand_aliases

function otel_instrument {
  alias $1="otel_observe \\"$1
  export OTEL_BASH_CUSTOM_INSTRUMENTATIONS=$OTEL_BASH_CUSTOM_INSTRUMENTATIONS/$1
}
IFS='/' read -ra custom_instrumentations_array <<< $OTEL_BASH_CUSTOM_INSTRUMENTATIONS
  for custom_instrumentation in "${custom_instrumentations_array[@]}"; do
    if [ -n "$custom_instrumentation" ]; then
      otel_instrument $custom_instrumentation
    fi
done

function otel_instrumented_wget {
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=GET
  name="wget $@" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="wget $@" \
    otel_observe \wget --header="traceparent: $OTEL_TRACEPARENT" "$@"
}
alias wget=otel_instrumented_wget

function otel_instrumented_curl {
  local url=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local target=$(\echo ${url#*//*/}/)
  local host=$(\echo ${url} | \awk -F/ '{print $3}')
  local method=$(\echo $@ | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  name="curl $@" kind=CLIENT \
    attributes="http.url=$url,http.host=$host,http.target=$target,http.method=$method" \
    command="wget $@" \
    otel_observe \curl -H "traceparent: $OTEL_TRACEPARENT" "$@"
}
alias curl=otel_instrumented_curl

function otel_instrumented_bash {
  OTEL_BASH_ROOT_SPAN_NAME_OVERRIDE="bash $@" \bash -c "source /usr/bin/opentelemetry_bash.sh; source $*"
}
alias bash=otel_instrumented_bash

function otel_on_script_end {
  exit_code=$?
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error
  fi
  otel_span_end
  otel_shutdown
}
trap otel_on_script_end EXIT
otel_init
otel_span_start SERVER $(otel_command_self)
