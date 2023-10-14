#!/bin/sh
##################################################################################################
# This file is providing an API for creating and managing open telemetry spans.                  #
# It should be sourced at the very top of any shell script where the functions are to be used.   #
# All variables are for internal use only and therefore subject to change without notice!        #
##################################################################################################

otel_remote_sdk_pipe=$(mktemp -u)_opentelemetry_shell_$$.pipe
otel_shell=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
otel_commandline_override="$OTEL_SHELL_COMMANDLINE_OVERRIDE"
unset OTEL_SHELL_COMMANDLINE_OVERRIDE

otel_command_self() {
  if [ -n "$otel_commandline_override" ]; then
    \echo $otel_commandline_override
  else
    \ps -p $$ -o args | \grep -v COMMAND
  fi
}

otel_package_version() {
  # \apt show "$1" 2> /dev/null | \grep Version | \awk '{ print $2 }'
  # \apt-cache policy "$1" 2> /dev/null | \grep Installed | \awk '{ print $2 }'
  \dpkg -s "$1" | \grep Version | \awk '{ print $2 }'
}

otel_resource_attributes() {
  \echo telemetry.sdk.name=opentelemetry
  \echo telemetry.sdk.language=shell
  \echo telemetry.sdk.version=$(otel_package_version opentelemetry-shell)

  \echo process.pid=$$
  \echo process.executable.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
  \echo process.executable.path=$(\readlink /proc/$$/exe)
  \echo process.command=$(otel_command_self)
  \echo process.command_args=$(otel_command_self | \cut -d' ' -f2-)
  \echo process.owner=$(whoami)
  \echo process.runtime.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
  \echo process.runtime.version=$(otel_package_version $(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev))
  \echo process.runtime.options=$-
  case $otel_shell in
    sh)
      \echo process.runtime.description="Bourne Shell"
      ;;
    dash)
      \echo process.runtime.description="Debian Almquist Shell"
      ;;
    bash)
      \echo process.runtime.description="Bourne Again Shell"
      ;;
    zsh)
      \echo process.runtime.description="Z Shell"
      ;;
    ksh)
      \echo process.runtime.description="Korn Shell"
      ;;
    pdksh)
      \echo process.runtime.description="Public Domain Korn Shell"
      ;;
    posh)
      \echo process.runtime.description="Policy-compliant Ordinary Shell"
      ;;
    yash)
      \echo process.runtime.description="Yet Another Shell"
      ;;
    bosh)
      \echo process.runtime.description="Bourne Shell"
      ;;
    fish)
      \echo process.runtime.description="Friendly Interactive Shell"
      ;;
    *)
      \echo process.runtime.description=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
      ;;
  esac

  if [ -z "$OTEL_SERVICE_NAME" ]; then
    \echo service.name="unknown_service"
  else
    \echo service.name=$OTEL_SERVICE_NAME
  fi
  \echo service.version=$OTEL_SERVICE_VERSION
  \echo service.namespace=$OTEL_SERVICE_NAMESPACE
  \echo service.instance.id=$OTEL_SERVICE_INSTANCE_ID
}

otel_sdk_communicate() {
  \echo "$*" >&3
}

otel_init() {
  if [ -n "$OTEL_SHELL_SDK_OUTPUT_REDIRECT" ]; then
    local sdk_output=$OTEL_SHELL_SDK_OUTPUT_REDIRECT
  else
    if [ -e "/dev/stderr" ] && [ -e "$(\ls -l /dev/stderr)" ]; then
      local std_output=/dev/stderr
    else
      local sdk_output=/dev/null
    fi
  fi
  \mkfifo $otel_remote_sdk_pipe
  . /opt/opentelemetry_shell/venv/bin/activate
  (\python3 /usr/bin/opentelemetry_shell_sdk.py $otel_remote_sdk_pipe "shell" $(otel_package_version opentelemetry-shell) > "$sdk_output" 2> "$sdk_output" &)
  deactivate
  \exec 3> $otel_remote_sdk_pipe
  otel_resource_attributes | while IFS= read -r kvp; do
    otel_sdk_communicate "RESOURCE_ATTRIBUTE" "$kvp"
  done
  otel_sdk_communicate "INIT"
}

otel_shutdown() {
  otel_sdk_communicate "SHUTDOWN"
  \exec 3>&-
  \rm $otel_remote_sdk_pipe
}

otel_span_start() {
  local kind=$1
  shift
  local name="$*"
  if [ -z "$traceparent" ]; then
    local traceparent=$OTEL_TRACEPARENT
  fi
  local response_pipe=$(mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  otel_sdk_communicate "SPAN_START $response_pipe $traceparent $kind $name"
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

otel_span_end() {
  local span_id=$1
  otel_sdk_communicate "SPAN_END $span_id"
}

otel_span_error() {
  local span_id=$1
  otel_sdk_communicate "SPAN_ERROR $span_id"
}

otel_span_attribute() {
  local span_id=$1
  shift
  local kvp="$@"
  otel_sdk_communicate "SPAN_ATTRIBUTE $span_id $kvp"
}

otel_span_traceparent() {
  local span_id=$1
  local response_pipe=$(mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  otel_sdk_communicate "SPAN_TRACEPARENT $response_pipe $span_id"
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

otel_metric_create() {
  local metric_name=$1
  local response_pipe=$(mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  otel_sdk_communicate "METRIC_CREATE" "$response_pipe" "$metric_name"
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

otel_metric_attribute() {
  local metric_id=$1
  shift
  local kvp="$*"
  otel_sdk_communicate "METRIC_ATTRIBUTE" "$metric_id" "$kvp"
}

otel_metric_add() {
  local metric_id=$1
  local value=$2
  otel_sdk_communicate "METRIC_ADD" "$metric_id" "$value"
}

otel_log_record() {
  local traceparent=$1
  shift
  local line="$*"
  otel_sdk_communicate "LOG_RECORD" "$traceparent" "$line"
}

otel_observe() {
  if [ -z "$OTEL_SHELL_SPAN_NAME_OVERRIDE" ]; then
    local name="$*"
  else
    local name="$OTEL_SHELL_SPAN_NAME_OVERRIDE"
    unset OTEL_SHELL_SPAN_NAME_OVERRIDE
  fi
  if [ -z "$OTEL_SHELL_SPAN_KIND_OVERRIDE" ]; then
    local kind=INTERNAL
  else
    local kind="$OTEL_SHELL_SPAN_KIND_OVERRIDE"
    unset OTEL_SHELL_SPAN_KIND_OVERRIDE
  fi
  if [ -z "$OTEL_SHELL_COMMANDLINE_OVERRIDE" ]; then
    local command="$*"
  else
    local command="$OTEL_SHELL_COMMANDLINE_OVERRIDE"
    unset OTEL_SHELL_COMMANDLINE_OVERRIDE
  fi
  if [ -z "$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" ]; then
    local attributes=""
  else
    local attributes="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE"
    unset OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE
  fi

  local span_id=$(otel_span_start $kind "$name")
  otel_span_attribute $span_id subprocess.executable.name=$(\echo "$command" | \cut -d' ' -f1 | \rev | \cut -d'/' -f1 | \rev)
  if [ "$otel_shell" != "zsh" ]; then
    otel_span_attribute $span_id subprocess.executable.path="$(which $(\echo "$command" | \cut -d' ' -f1))"
  fi
  otel_span_attribute $span_id subprocess.command="$command"
  otel_span_attribute $span_id subprocess.command_args="$(\echo "$command" | \cut -d' ' -f2-)"
  otel_span_activate $span_id
  local traceparent=$OTEL_TRACEPARENT

  if [ -n "$OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0" ]; then
    set -- "$@" "$(eval \echo $OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0)"
  fi
  if [ -n "$OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1" ]; then
    set -- "$@" "$(eval \echo $OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1)"
  fi
  local stderr_pipe=$(mktemp -u).opentelemetry_shell_$$.pipe
  \mkfifo $stderr_pipe
  ((while IFS= read -r line; do otel_log_record $traceparent "$line"; echo "$line" >&2; done < $stderr_pipe) &)
  local exit_code=0
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" OTEL_SHELL_AUTO_INJECTED=$OTEL_SHELL_AUTO_INJECTED "$@" 2> $stderr_pipe || local exit_code=$?
  \rm $stderr_pipe

  otel_span_deactivate $span_id
  otel_span_attribute $span_id subprocess.exit_code=$exit_code
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error $span_id
  fi
  if [ -n "$attributes" ]; then
    local IFS=','
    if [ "$otel_shell" = "zsh" ]; then
      set -- ${=attributes}
    else
      set -- $attributes
    fi
    for attribute in "$@"; do
      if [ -n "$attribute" ]; then
        otel_span_attribute $span_id "$attribute"
      fi
    done
  fi
  otel_span_end $span_id
  return $exit_code
}
