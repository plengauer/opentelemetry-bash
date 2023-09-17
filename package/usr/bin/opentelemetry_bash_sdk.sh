#!/bin/bash
otel_remote_sdk_pipe=/tmp/opentelemetry_bash_$$_$(echo $RANDOM | md5sum | cut -c 1-32).pipe

function otel_resource_attributes {
  echo telemetry.sdk.name=opentelemetry
  echo telemetry.sdk.language=bash
  echo telemetry.sdk.version=$(apt show opentelemetry-bash 2> /dev/null | grep Version | awk '{ print $2 }')
  echo process.pid=$$
  echo process.executable.name=bash
  echo process.executable.path​=$(which $(ps -p $$ -o args | grep -v COMMAND | cut -d' ' -f1))
  echo process.command=$(ps -p $$ -o args | grep -v COMMAND)
  echo process.command_args=$(ps -p $$ -o args | grep -v COMMAND | cut -d' ' -f2-)
  echo process.owner=$(whoami)
  echo process.runtime.name=bash
  echo process.runtime.description="Bourne Again Shell"
  echo process.runtime.version=$(apt show bash 2> /dev/null | grep Version | awk '{ print $2 }')
  echo host.name=$(cat /etc/hostname)
  echo service.name=$OTEL_SERVICE_NAME
  echo service.version=$OTEL_SERVICE_VERSION
}
otel_resource_attributes

function otel_init {
  mkfifo $otel_remote_sdk_pipe
  source /opt/opentelemetry_bash/venv/bin/activate
  python3 /usr/bin/opentelemetry_bash_remote_sdk.py $otel_remote_sdk_pipe "bash" $(apt show opentelemetry-bash 2> /dev/null | grep Version | awk '{ print $2 }') 2> /dev/null 1>&2 &
  disown
  deactivate
  otel_resource_attributes | sed 's/^/RESOURCE_ATTRIBUTE /' > $otel_remote_sdk_pipe
  echo "INIT" > $otel_remote_sdk_pipe
}

function otel_shutdown {
  echo "SHUTDOWN" > $otel_remote_sdk_pipe
  rm $otel_remote_sdk_pipe
}

function otel_span_start {
  echo "SPAN_START $@" > $otel_remote_sdk_pipe
}

function otel_span_end {
  echo "SPAN_END" > $otel_remote_sdk_pipe
}

function otel_span_error {
  echo "SPAN_ERROR" > $otel_remote_sdk_pipe
}

function otel_span_attribute {
  echo "SPAN_ATTRIBUTE $@" > $otel_remote_sdk_pipe
}

function otel_observe {
  otel_span_start INTERNAL $@
  otel_span_attribute subprocess.executable.name=$(echo "$@" | cut -d' ' -f1 | rev | cut -d'/' -f1 | rev)
  otel_span_attribute subprocess.executable.path​=$(which $(echo "$@" | cut -d' ' -f1))
  otel_span_attribute subprocess.command="$@"
  otel_span_attribute subprocess.command_args=$(echo "$@" | cut -d' ' -f2-)
  eval $@
  exit_code=$?
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error "subprocess.exit_code=$exit_code"
  fi
  otel_span_end
  return $exit_code
}
