#!/bin/sh
otel_remote_sdk_pipe=$(mktemp -u)_opentelemetry_shell_$$.pipe
otel_sdk_version=$(\apt show opentelemetry-shell 2> /dev/null | \grep Version | \awk '{ print $2 }')
otel_shell=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)

otel_command_self() {
  if [ -n "$OTEL_SHELL_COMMANDLINE_OVERRIDE" ]; then
    \echo $OTEL_SHELL_COMMANDLINE_OVERRIDE
  else
    # \cat /proc/$$/cmdline 2> /dev/null
    \ps -p $$ -o args | \grep -v COMMAND
  fi
}

otel_resource_attributes() {
  \echo telemetry.sdk.name=opentelemetry
  \echo telemetry.sdk.language=shell
  \echo telemetry.sdk.version=$otel_sdk_version

  \echo process.pid=$$
  \echo process.executable.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
  \echo process.executable.path=$(\readlink /proc/$$/exe)
  \echo process.command=$(otel_command_self)
  \echo process.command_args=$(otel_command_self | \cut -d' ' -f2-)
  \echo process.owner=$(whoami)
  case $otel_shell in
    sh)
      \echo process.runtime.name=sh
      \echo process.runtime.description="Bourne Shell"
      ;;
    dash)
      \echo process.runtime.name=dash
      \echo process.runtime.description="Debian Almquist Shell"
      ;;
    bash)
      \echo process.runtime.name=bash
      \echo process.runtime.description="Bourne Again Shell"
      \echo process.runtime.version=$BASH_VERSINFO
      ;;
    zsh)
      \echo process.runtime.name=zsh
      \echo process.runtime.description="Z Shell"
      \echo process.runtime.version=$(\apt show zsh 2> /dev/null | \grep Version | \awk '{ print $2 }')
      ;;
    csh)
      \echo process.runtime.name=csh
      \echo process.runtime.description="C Shell"
      \echo process.runtime.version=$(\apt show csh 2> /dev/null | \grep Version | \awk '{ print $2 }')
      ;;
    tcsh)
      \echo process.runtime.name=tcsh
      \echo process.runtime.description="TENEX C Shell"
      \echo process.runtime.version=$(\apt show tcsh 2> /dev/null | \grep Version | \awk '{ print $2 }')
      ;;
    ksh)
      \echo process.runtime.name=ksh
      \echo process.runtime.description="Korn Shell"
      \echo process.runtime.version=$(\apt show ksh 2> /dev/null | \grep Version | \awk '{ print $2 }')
      ;;
    fish)
      \echo process.runtime.name=fish
      \echo process.runtime.description="Fish Shell"
      \echo process.runtime.version=$(\apt show fish 2> /dev/null | \grep Version | \awk '{ print $2 }')
      ;;
    *)
      \echo process.runtime.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
      \echo process.runtime.description=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
      \echo process.runtime.version=$(\apt show $(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev) 2> /dev/null | \grep Version | \awk '{ print $2 }')
      ;;
  esac

  if [ -z "$OTEL_SERVICE_NAME" ]; then
    \echo service.name="unknown_service"
  else
    \echo service.name=$OTEL_SERVICE_NAME
  fi
  \echo service.version=$OTEL_SERVICE_VERSION
}

otel_init() {
  if [ -n "$OTEL_SHELL_SDK_OUTPUT_REDIRECT" ]; then
    local sdk_output=$OTEL_SHELL_SDK_OUTPUT_REDIRECT
  else
    local sdk_output=/dev/null
  fi
  \mkfifo $otel_remote_sdk_pipe
  . /opt/opentelemetry_bash/venv/bin/activate
  \python3 /usr/bin/opentelemetry_shell_sdk.py $otel_remote_sdk_pipe "shell" $otel_sdk_version > $sdk_output &
  otel_sdk_pid=$!
  if [ "$otel_shell" = "bash" ]; then
    disown $otel_sdk_pid
  fi
  deactivate
  otel_resource_attributes | \sed 's/^/RESOURCE_ATTRIBUTE /' > $otel_remote_sdk_pipe
  \echo "INIT" > $otel_remote_sdk_pipe
}

otel_shutdown() {
  \echo "SHUTDOWN" > $otel_remote_sdk_pipe
  wait $otel_sdk_pid
  \rm $otel_remote_sdk_pipe
}

otel_span_start() {
  local kind=$1
  shift
  local name="$@"
  if [ -z "$traceparent" ]; then
    local traceparent=$OTEL_TRACEPARENT
  fi
  local response_pipe=$(mktemp -u)_opentelemetry_shell_$$_response.pipe
  \mkfifo $response_pipe
  \echo "SPAN_START $response_pipe $traceparent $kind $name" > $otel_remote_sdk_pipe
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

otel_span_end() {
  local span_id=$1
  \echo "SPAN_END $span_id" > $otel_remote_sdk_pipe
}

otel_span_error() {
  local span_id=$1
  \echo "SPAN_ERROR $span_id" > $otel_remote_sdk_pipe
}

otel_span_attribute() {
  local span_id=$1
  shift
  local kvp=$@
  \echo "SPAN_ATTRIBUTE $span_id $kvp" > $otel_remote_sdk_pipe
}

otel_span_traceparent() {
  local span_id=$1
  local response_pipe=$(mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  \echo "SPAN_TRACEPARENT $response_pipe $span_id" > $otel_remote_sdk_pipe
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

otel_span_activate() {
  local span_id=$1
  export OTEL_TRACEPARENT_STACK=$OTEL_TRACEPARENT/$OTEL_TRACEPARENT_STACK
  export OTEL_TRACEPARENT=$(otel_span_traceparent $span_id)
}

otel_span_deactivate() {
  export OTEL_TRACEPARENT=$(\echo $OTEL_TRACEPARENT_STACK | \cut -d'/' -f1)
  export OTEL_TRACEPARENT_STACK=$(\echo $OTEL_TRACEPARENT_STACK | \cut -d'/' -f2-)
}

otel_observe() {
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
  otel_span_attribute $span_id subprocess.executable.path=$(which $(\echo \$command | \cut -d' ' -f1))
  otel_span_attribute $span_id subprocess.command=$command
  otel_span_attribute $span_id subprocess.command_args=$(\echo $command | \cut -d' ' -f2-)
  local traceparent=$(otel_span_traceparent $span_id)
  local exit_code=0
  OTEL_TRACEPARENT=$traceparent "$@" || local exit_code=$?
  otel_span_attribute $span_id subprocess.exit_code=$exit_code
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error $span_id
  fi
  local IFS=','
  if [ "$otel_shell" = "zsh" ]; then
    set -- ${=attributes}
  else
    set -- $attributes
  fi
  for attribute in "$@"; do
    if [ -n "$attribute" ]; then
      otel_span_attribute $span_id $attribute
    fi
  done
  otel_span_end $span_id
  return $exit_code
}
