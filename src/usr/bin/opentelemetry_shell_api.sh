#!/bin/sh
##################################################################################################
# This file is providing an API for creating and managing open telemetry spans.                  #
# It should be sourced at the very top of any shell script where the functions are to be used.   #
# All variables are for internal use only and therefore subject to change without notice!        #
##################################################################################################

otel_remote_sdk_pipe=$(\mktemp -u)_opentelemetry_shell_$$.pipe
otel_shell=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
otel_commandline_override="$OTEL_SHELL_COMMANDLINE_OVERRIDE"
unset OTEL_SHELL_COMMANDLINE_OVERRIDE
unset OTEL_SHELL_SPAN_NAME_OVERRIDE
unset OTEL_SHELL_SPAN_KIND_OVERRIDE
unset OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE
unset OTEL_SHELL_SUPPRESS_LOG_COLLECTION

otel_command_self() {
  if [ -n "$otel_commandline_override" ]; then
    \echo $otel_commandline_override
  else
    \ps -p $$ -o args | \grep -v COMMAND || \cat /proc/$$/cmdline
  fi
}

otel_package_version() {
  \dpkg -s "$1" 2> /dev/null | \grep Version | \awk '{ print $2 }' || \apt-cache policy "$1" 2> /dev/null | \grep Installed | \awk '{ print $2 }' || \apt show "$1" 2> /dev/null | \grep Version | \awk '{ print $2 }'
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
  \echo process.owner=$(\whoami)
  \echo process.runtime.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
  \echo process.runtime.version=$(otel_package_version $(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev))
  \echo process.runtime.options=$-
  case $otel_shell in
       sh) \echo process.runtime.description="Bourne Shell" ;;
     dash) \echo process.runtime.description="Debian Almquist Shell" ;;
     bash) \echo process.runtime.description="Bourne Again Shell" ;;
      zsh) \echo process.runtime.description="Z Shell" ;;
      ksh) \echo process.runtime.description="Korn Shell" ;;
    pdksh) \echo process.runtime.description="Public Domain Korn Shell" ;;
     posh) \echo process.runtime.description="Policy-compliant Ordinary Shell" ;;
     yash) \echo process.runtime.description="Yet Another Shell" ;;
     bosh) \echo process.runtime.description="Bourne Shell" ;;
     fish) \echo process.runtime.description="Friendly Interactive Shell" ;;
        *) \echo process.runtime.description=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev) ;;
  esac

  \echo service.name="${OTEL_SERVICE_NAME:-unknown_service}"
  \echo service.version=$OTEL_SERVICE_VERSION
  \echo service.namespace=$OTEL_SERVICE_NAMESPACE
  \echo service.instance.id=$OTEL_SERVICE_INSTANCE_ID
}

_otel_sdk_communicate() {
  \echo "$*" >&7
}

otel_init() {
  if [ -n "$OTEL_SHELL_SDK_OUTPUT_REDIRECT" ]; then
    local sdk_output=$OTEL_SHELL_SDK_OUTPUT_REDIRECT
  else
    if [ -e "/dev/stderr" ] && [ -e "$(\readlink -f /dev/stderr)" ]; then
      local sdk_output=/dev/stderr
    else
      local sdk_output=/dev/null
    fi
  fi
  \mkfifo $otel_remote_sdk_pipe
  \. /opt/opentelemetry_shell/venv/bin/activate
  (\python3 /usr/bin/opentelemetry_shell_sdk.py $otel_remote_sdk_pipe "shell" $(otel_package_version opentelemetry-shell) > "$sdk_output" 2> "$sdk_output" &)
  deactivate
  \exec 7> $otel_remote_sdk_pipe
  otel_resource_attributes | while IFS= read -r kvp; do _otel_sdk_communicate "RESOURCE_ATTRIBUTE" "$kvp"; done
  _otel_sdk_communicate "INIT"
}

otel_shutdown() {
  _otel_sdk_communicate "SHUTDOWN"
  \exec 7>&-
  \rm $otel_remote_sdk_pipe
}

otel_span_start() {
  local kind=$1
  shift
  local name="$*"
  local response_pipe=$(\mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  _otel_sdk_communicate "SPAN_START $response_pipe $OTEL_TRACEPARENT $kind $name"
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

otel_span_end() {
  local span_id=$1
  _otel_sdk_communicate "SPAN_END $span_id"
}

otel_span_error() {
  local span_id=$1
  _otel_sdk_communicate "SPAN_ERROR $span_id"
}

otel_span_attribute() {
  local span_id=$1
  shift
  local kvp="$@"
  _otel_sdk_communicate "SPAN_ATTRIBUTE $span_id $kvp"
}

otel_span_traceparent() {
  local span_id=$1
  local response_pipe=$(\mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  _otel_sdk_communicate "SPAN_TRACEPARENT $response_pipe $span_id"
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
  local response_pipe=$(\mktemp -u)_opentelemetry_shell_$$.pipe
  \mkfifo $response_pipe
  _otel_sdk_communicate "METRIC_CREATE" "$response_pipe" "$metric_name"
  \cat $response_pipe
  \rm $response_pipe &> /dev/null
}

otel_metric_attribute() {
  local metric_id=$1
  shift
  local kvp="$*"
  _otel_sdk_communicate "METRIC_ATTRIBUTE" "$metric_id" "$kvp"
}

otel_metric_add() {
  local metric_id=$1
  local value=$2
  _otel_sdk_communicate "METRIC_ADD" "$metric_id" "$value"
}

otel_log_record() {
  local traceparent=$1
  shift
  local line="$*"
  _otel_sdk_communicate "LOG_RECORD" "$traceparent" "$line"
}

_otel_escape() {
   # that SO article shows why this is extra fun! https://stackoverflow.com/questions/16991270/newlines-at-the-end-get-removed-in-shell-scripts-why
  local do_escape=0
  if [ -z "$1" ]; then
    local do_escape=1
  elif [ "$1X" != "$(\echo "$1")"X ]; then # fancy check for "contains linefeed"
    local do_escape=1
  else
    case "$1X" in
      *[[:space:]\&\<\>\|\'\"\(\)\`!\$\;]*) local do_escape=1 ;;
      *) local do_escape=0 ;;
    esac
  fi
  if [ "$do_escape" = 1 ]; then
    local escaped="$(\printf '%s' "$1X" | \sed "s/'/'\\\\''/g")"
    \printf "'%s'" "${escaped%X}"
  else
    \printf '%s' "$1"
  fi
}

_otel_escape_in() {
  local first=1
  while read line; do
    if [ "$first" = 1 ]; then local first=0; else \echo -n " "; fi
    _otel_escape "$line"
  done
}

_otel_escape_args() {
  # for arg in "$@"; do \echo "$arg"; done | _otel_escape_in # this may seem correct, but it doesnt handle linefeeds in arguments correctly
  local first=1
  for arg in "$@"; do
    if [ "$first" = 1 ]; then local first=0; else \echo -n " "; fi
    _otel_escape "$arg"
  done
}

_otel_call() {
  # old versions of dash dont set env vars properly
  # more specifically they do not make variables that are set in front of commands part of the child process env vars but only of the local execution environment
  if [ "$OTEL_SHELL_CALL_FORCE_FASTPATH" = TRUE ] || [ "$(\type "$1")" = "$1 is $(\which "$1")" ]; then
    unset OTEL_SHELL_CALL_FORCE_FASTPATH
    \eval "\\$(_otel_escape_args "$@")"
  else
    if [ -z "" ]; then
      \eval \env "$( { \printenv; \set; } | \grep '^OTEL_' | \sed "s/'//g" | \sort -u | _otel_escape_in)" "\\$(_otel_escape_args "$@")" 
    else
      local my_env="$(\printenv | \grep '^OTEL_' | \sed "s/'//g")"
      local my_set="$(     \set | \grep '^OTEL_' | \sed "s/'//g")"
      \eval $(\echo "$my_set" | \awk '{print "export \"" $0 "\""}')
      local exit_code=0
      OTEL_SHELL_CALL_FORCE_FASTPATH=TRUE _otel_call "$@" || local exit_code=$?
      \eval $(\echo "$my_set" | \cut -d= -f1 | \awk '{print "unset " $0}')
      \eval $(\echo "$my_env" | \awk '{print "export \"" $0 "\""}')
      return $exit_code
    fi
  fi
}

otel_observe() {
  # validate and clean arguments
  local name="${OTEL_SHELL_SPAN_NAME_OVERRIDE:-$*}"
  local name="${name#otel_observe }"
  local kind="${OTEL_SHELL_SPAN_KIND_OVERRIDE:-INTERNAL}"
  local command="${OTEL_SHELL_COMMANDLINE_OVERRIDE:-$*}"
  local command="${command#otel_observe }"
  local attributes="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE"
  if [ -n "$OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0" ]; then set -- "$@" "$(eval \\echo $OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0)"; fi
  if [ -n "$OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1" ]; then set -- "$@" "$(eval \\echo $OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1)"; fi
  unset OTEL_SHELL_SPAN_NAME_OVERRIDE
  unset OTEL_SHELL_SPAN_KIND_OVERRIDE
  unset OTEL_SHELL_COMMANDLINE_OVERRIDE
  unset OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE
  unset OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0
  unset OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1
  # create span, set initial attributes
  local span_id=$(otel_span_start $kind "$name")
  otel_span_attribute $span_id subprocess.executable.name=$(\echo "$command" | \cut -d' ' -f1 | \rev | \cut -d'/' -f1 | \rev)
  otel_span_attribute $span_id subprocess.executable.path="$(\which $(\echo "$command" | \cut -d' ' -f1))"
  otel_span_attribute $span_id subprocess.command="$command"
  otel_span_attribute $span_id subprocess.command_args="$(\echo "$command" | \cut -sd' ' -f2-)"
  # run command
  otel_span_activate $span_id
  local exit_code=0
  if [ "$OTEL_SHELL_SUPPRESS_LOG_COLLECTION" != TRUE ]; then
    local traceparent=$OTEL_TRACEPARENT
    local stderr_pipe=$(\mktemp -u).opentelemetry_shell_$$.pipe
    \mkfifo $stderr_pipe
    (while IFS= read -r line; do otel_log_record $traceparent "$line"; \echo "$line" >&2; done < $stderr_pipe) &
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" _otel_call "$@" 2> $stderr_pipe || local exit_code=$?
    \rm $stderr_pipe
  else
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" _otel_call "$@" || local exit_code=$?
  fi
  otel_span_deactivate $span_id
  # set custom attributes, set final attributes, finish span
  otel_span_attribute $span_id subprocess.exit_code=$exit_code
  if [ "$exit_code" -ne "0" ]; then
    otel_span_error $span_id
  fi
  if [ -n "$attributes" ]; then
    local IFS=','
    set -- $attributes
    for attribute in "$@"; do
      if [ -n "$attribute" ]; then
        otel_span_attribute $span_id "$attribute"
      fi
    done
  fi
  otel_span_end $span_id
  return $exit_code
}
