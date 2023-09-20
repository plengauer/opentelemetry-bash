#!/bin/bash
otel_remote_sdk_pipe=/tmp/opentelemetry_bash_$$_$(echo $RANDOM | md5sum | cut -c 1-32).pipe

function otel_command_self {
  if [ -n "$OTEL_BASH_COMMAND_OVERRIDE" ]; then
    \echo $OTEL_BASH_COMMAND_OVERRIDE
  else
    \echo $(ps -p $$ -o args | grep -v COMMAND)
  fi
}

function otel_resource_attributes {
  \echo telemetry.sdk.name=opentelemetry
  \echo telemetry.sdk.language=bash
  \echo telemetry.sdk.version=$(\apt show opentelemetry-bash 2> /dev/null | \grep Version | \awk '{ print $2 }')
  \echo process.pid=$$
  \echo process.executable.name=bash
  \echo process.executable.path​=$(which $(otel_command_self | \cut -d' ' -f1))
  \echo process.command=$(otel_command_self)
  \echo process.command_args=$(otel_command_self | \cut -d' ' -f2-)
  \echo process.owner=$(whoami)
  \echo process.runtime.name=bash
  \echo process.runtime.description="Bourne Again Shell"
  \echo process.runtime.version=$(\apt show bash 2> /dev/null | \grep Version | \awk '{ print $2 }')
  \echo host.name=$(\cat /etc/hostname)
  \echo service.name=$OTEL_SERVICE_NAME
  \echo service.version=$OTEL_SERVICE_VERSION
}

function otel_init {
  \mkfifo $otel_remote_sdk_pipe
  source /opt/opentelemetry_bash/venv/bin/activate
  \python3 /usr/bin/opentelemetry_bash_remote_sdk.py $otel_remote_sdk_pipe "bash" $(\apt show opentelemetry-bash 2> /dev/null | \grep Version | \awk '{ print $2 }') 1>&2 &
  disown
  deactivate
  otel_resource_attributes | \sed 's/^/RESOURCE_ATTRIBUTE /' > $otel_remote_sdk_pipe
  \echo "INIT" > $otel_remote_sdk_pipe
}

function otel_shutdown {
  \echo "SHUTDOWN" > $otel_remote_sdk_pipe
  \rm $otel_remote_sdk_pipe
}

function otel_span_start {
  local response_pipe=/tmp/opentelemetry_bash_$$_response_$(\echo $RANDOM | \md5sum | \cut -c 1-32).pipe
  \mkfifo $response_pipe
  \echo "SPAN_START $response_pipe $OTEL_TRACEPARENT $@" > $otel_remote_sdk_pipe
  local response=$(\cat $response_pipe)
  OTEL_TRACEPARENT_STACK=$OTEL_TRACEPARENT/$OTEL_TRACEPARENT_STACK
  export OTEL_TRACEPARENT=$response
  \rm $response_pipe
}

function otel_span_end {
  \echo "SPAN_END" > $otel_remote_sdk_pipe
  export OTEL_TRACEPARENT=$(\echo $OTEL_TRACEPARENT_STACK | \cut -d'/' -f1)
  OTEL_TRACEPARENT_STACK=$(\echo $OTEL_TRACEPARENT_STACK | \cut -d'/' -f2-)
}

function otel_span_error {
  \echo "SPAN_ERROR" > $otel_remote_sdk_pipe
}

function otel_span_attribute {
  \echo "SPAN_ATTRIBUTE $@" > $otel_remote_sdk_pipe
}

function otel_observe {
  if [ -z "$name" ]; then
    local name=$@
  fi
  if [ -z "$kind" ]; then
    local kind=INTERNAL
  fi
  if [ -z "$command" ]; then
    local command=$@
  fi
  otel_span_start $kind $name
  otel_span_attribute subprocess.executable.name=$(\echo $command | \cut -d' ' -f1 | \rev | \cut -d'/' -f1 | \rev)
  otel_span_attribute subprocess.executable.path​=$(which $(\echo $command | \cut -d' ' -f1))
  otel_span_attribute subprocess.command=$command
  otel_span_attribute subprocess.command_args=$(\echo $command | \cut -d' ' -f2-)
  IFS=',' read -ra attributes_array <<< $attributes
  for attribute in "${attributes_array[@]}"; do
    if [ -n "$attribute" ]; then
      otel_span_attribute $attribute
    fi
  done
  local exit_code=0
  "$@" || local exit_code=$?
  otel_span_attribute subprocess.exit_code=$exit_code
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error
  fi
  otel_span_end
  return $exit_code
}
