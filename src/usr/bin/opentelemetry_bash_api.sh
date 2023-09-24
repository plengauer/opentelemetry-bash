#!/bin/bash
otel_pipe_dir=/tmp
otel_remote_sdk_pipe=$otel_pipe_dir/opentelemetry_bash_$$_$(\echo $RANDOM | \md5sum | \cut -c 1-32).pipe
otel_sdk_version=$(\apt show opentelemetry-bash 2> /dev/null | \grep Version | \awk '{ print $2 }')

function otel_command_self {
  if [ -n "$OTEL_BASH_COMMANDLINE_OVERRIDE" ]; then
    \echo $OTEL_BASH_COMMANDLINE_OVERRIDE
  else
    # \cat /proc/$$/cmdline 2> /dev/null
    \echo $(\ps -p $$ -o args | \grep -v COMMAND)
  fi
}

function otel_resource_attributes {
  \echo telemetry.sdk.name=opentelemetry
  \echo telemetry.sdk.language=bash
  \echo telemetry.sdk.version=$otel_sdk_version
  \echo process.pid=$$
  \echo process.executable.name=bash
  \echo process.executable.path=$(\readlink /proc/$$/exe)
  \echo process.command=$(otel_command_self)
  \echo process.command_args=$(otel_command_self | \cut -d' ' -f2-)
  \echo process.owner=$(whoami)
  \echo process.runtime.name=bash
  \echo process.runtime.description="Bourne Again Shell"
  \echo process.runtime.version=$BASH_VERSINFO # $(\apt show bash 2> /dev/null | \grep Version | \awk '{ print $2 }')
  \echo host.name=$(\cat /etc/hostname)
  if [ -z "$OTEL_SERVICE_NAME" ]; then
    \echo service.name="unknown_service"
  else
    \echo service.name=$OTEL_SERVICE_NAME
  fi
  \echo service.version=$OTEL_SERVICE_VERSION
}

function otel_init {
  # TODO check double init
  \mkfifo $otel_remote_sdk_pipe
  source /opt/opentelemetry_bash/venv/bin/activate
  \python3 /usr/bin/opentelemetry_bash_sdk.py $otel_remote_sdk_pipe "bash" $otel_sdk_version 1>&2 &
  disown
  deactivate
  otel_resource_attributes | \sed 's/^/RESOURCE_ATTRIBUTE /' > $otel_remote_sdk_pipe
  \echo "INIT" > $otel_remote_sdk_pipe
}

function otel_shutdown {
  # TODO check double shutdown
  \echo "SHUTDOWN" > $otel_remote_sdk_pipe
  \rm $otel_remote_sdk_pipe
}

function otel_span_start {
  local kind=$1
  local name="${@:2}"
  if [ -z "$traceparent" ]; then
    local traceparent=$OTEL_TRACEPARENT
  fi
  local response_pipe=$otel_pipe_dir/opentelemetry_bash_$$_response_$(\echo $RANDOM | \md5sum | \cut -c 1-32).pipe
  \mkfifo $response_pipe
  \echo "SPAN_START $response_pipe $traceparent $kind $name" > $otel_remote_sdk_pipe
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

function otel_span_end {
  local span_id=$1
  \echo "SPAN_END $span_id" > $otel_remote_sdk_pipe
}

function otel_span_error {
  local span_id=$1
  \echo "SPAN_ERROR $span_id" > $otel_remote_sdk_pipe
}

function otel_span_attribute {
  local span_id=$1
  local key=$2
  local value=${@:3}
  \echo "SPAN_ATTRIBUTE $span_id $key $value" > $otel_remote_sdk_pipe
}

function otel_span_traceparent {
  local span_id=$1
  local response_pipe=$otel_pipe_dir/opentelemetry_bash_$$_response_$(\echo $RANDOM | \md5sum | \cut -c 1-32).pipe
  \mkfifo $response_pipe
  \echo "SPAN_TRACEPARENT $response_pipe $span_id" > $otel_remote_sdk_pipe
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

function otel_span_activate {
  local span_id=$1
  export OTEL_TRACEPARENT_STACK=$OTEL_TRACEPARENT/$OTEL_TRACEPARENT_STACK
  export OTEL_TRACEPARENT=$(otel_span_traceparent $span_id)
}

function otel_span_deactivate {
  export OTEL_TRACEPARENT=$(\echo $OTEL_TRACEPARENT_STACK | \cut -d'/' -f1)
  export OTEL_TRACEPARENT_STACK=$(\echo $OTEL_TRACEPARENT_STACK | \cut -d'/' -f2-)
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
  local span_id=$(otel_span_start $kind $name)
  otel_span_attribute $span_id subprocess.executable.name=$(\echo $command | \cut -d' ' -f1 | \rev | \cut -d'/' -f1 | \rev)
  otel_span_attribute $span_id subprocess.executable.path=$(which $(\echo $command | \cut -d' ' -f1))
  otel_span_attribute $span_id subprocess.command=$command
  otel_span_attribute $span_id subprocess.command_args=$(\echo $command | \cut -d' ' -f2-)
  IFS=',' read -ra attributes_array <<< $attributes
  for attribute in "${attributes_array[@]}"; do
    if [ -n "$attribute" ]; then
      otel_span_attribute $span_id $attribute
    fi
  done
  local traceparent=$(otel_span_traceparent $span_id)
  local exit_code=0
  OTEL_TRACEPARENT=$traceparent "$@" || local exit_code=$?
  otel_span_attribute $span_id subprocess.exit_code=$exit_code
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error $span_id
  fi
  otel_span_end $span_id
  return $exit_code
}
