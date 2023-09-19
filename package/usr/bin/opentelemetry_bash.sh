#!/bin/bash
source /usr/bin/opentelemetry_bash_sdk.sh

otel_init

otel_span_start SERVER $(ps -p $$ -o args | grep -v COMMAND)

function otel_on_script_end {
  exit_code=$?
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error "process.exit_code"=$exit_code
  fi
  otel_span_end
  otel_shutdown
}
trap otel_on_script_end EXIT

function otel_instrumented_wget {
  wget --header="traceparent: $OTEL_TRACEPARENT" "$@"
}
alias wget=otel_instrumented_wget

function otel_instrumented_curl {
  curl -H "traceparent: $OTEL_TRACEPARENT" "$@"
}
alias curl=otel_instrumented_curl

function otel_instrumented_bash {
  bash -c "source /usr/bin/opentelemetry_bash.sh; source $@"
}
alias bash=otel_instrumented_bash

shopt -s expand_aliases
