#!/bin/false
##################################################################################################
# This file is providing an API for creating and managing open telemetry spans.                  #
# It should be sourced at the very top of any shell script where the functions are to be used.   #
# All variables are for internal use only and therefore subject to change without notice!        #
##################################################################################################

_otel_remote_sdk_pipe=$(\mktemp -u)_opentelemetry_shell_$$.pipe
_otel_shell=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
if \[ "$OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE" = "$PPID" ] || \[ "$OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE" = "0" ]; then _otel_commandline_override="$OTEL_SHELL_COMMANDLINE_OVERRIDE"; fi
unset OTEL_SHELL_COMMANDLINE_OVERRIDE
unset OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE
unset OTEL_SHELL_SPAN_NAME_OVERRIDE
unset OTEL_SHELL_SPAN_KIND_OVERRIDE
unset OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE
unset OTEL_SHELL_SUPPRESS_LOG_COLLECTION

_otel_command_real_self() {
  \ps -p $$ -o args | \grep -v COMMAND || \cat /proc/$$/cmdline | \tr -d '\000'
}

_otel_command_self() {
  if \[ -n "$_otel_commandline_override" ]; then
    \echo "$_otel_commandline_override"
  else
    _otel_command_real_self
  fi
}

_otel_package_version() {
  \dpkg -s "$1" 2> /dev/null | \grep Version | \awk '{ print $2 }' || \apt-cache policy "$1" 2> /dev/null | \grep Installed | \awk '{ print $2 }' || \apt show "$1" 2> /dev/null | \grep Version | \awk '{ print $2 }'
}

_otel_resource_attributes() {
  \echo telemetry.sdk.name=opentelemetry
  \echo telemetry.sdk.language=shell
  \echo telemetry.sdk.version=$(_otel_package_version opentelemetry-shell)

  \echo process.pid=$$
  \echo process.executable.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
  \echo process.executable.path=$(\readlink /proc/$$/exe)
  \echo process.command=$(_otel_command_self)
  \echo process.command_args=$(_otel_command_self | \cut -d' ' -f2-)
  \echo process.owner=$(\whoami)
  \echo process.runtime.name=$(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev)
  \echo process.runtime.version=$(_otel_package_version $(\readlink /proc/$$/exe | \rev | \cut -d/ -f1 | \rev))
  \echo process.runtime.options=$-
  case $_otel_shell in
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
  \echo "$*" >&7 # do not allow linefeeds in here
}

otel_init() {
  if \[ -n "$OTEL_SHELL_SDK_OUTPUT_REDIRECT" ]; then
    local sdk_output=$OTEL_SHELL_SDK_OUTPUT_REDIRECT
  else
    if \[ -e "/dev/stderr" ] && \[ -e "$(\readlink -f /dev/stderr)" ]; then
      local sdk_output=/dev/stderr
    else
      local sdk_output=/dev/null
    fi
  fi
  \mkfifo $_otel_remote_sdk_pipe
  \eval "$(\cat /opt/opentelemetry_shell/venv/bin/activate | \sed 's/\[/\\\[/g')"
  (\python3 /usr/bin/opentelemetry_shell_sdk.py $_otel_remote_sdk_pipe "shell" $(_otel_package_version opentelemetry-shell) > "$sdk_output" 2> "$sdk_output" &)
  deactivate
  \exec 7> $_otel_remote_sdk_pipe
  _otel_resource_attributes | while IFS= read -r kvp; do _otel_sdk_communicate "RESOURCE_ATTRIBUTE" "$kvp"; done
  _otel_sdk_communicate "INIT"
}

otel_shutdown() {
  _otel_sdk_communicate "SHUTDOWN"
  \exec 7>&-
  \rm $_otel_remote_sdk_pipe
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
  local kvp="$*"
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
  export OTEL_TRACEPARENT=$(\printf '%s' $OTEL_TRACEPARENT_STACK | \cut -d'/' -f1)
  export OTEL_TRACEPARENT_STACK=$(\printf '%s' $OTEL_TRACEPARENT_STACK | \cut -d'/' -f2-)
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

_otel_contains_linefeed() {
  case "$1" in
    *"
"*) return 0;;
    *) return 1;;
  esac
}

_otel_escape_arg_v1() {
   # that SO article shows why this is extra fun! https://stackoverflow.com/questions/16991270/newlines-at-the-end-get-removed-in-shell-scripts-why
  local do_escape=0
  if \[ -z "$1" ]; then
    local do_escape=1
  elif \[ "$1X" != "$(\echo "$1")"X ]; then # fancy check for "contains linefeed"
    local do_escape=1
  else
    case "$1X" in
      *[[:space:]\&\<\>\|\'\"\(\)\`!\$\;\\]*) local do_escape=1 ;;
      *) local do_escape=0 ;;
    esac
  fi
  if \[ "$do_escape" = 1 ]; then
    # need the extra X to preservice trailing linefeeds (yay)
    # local escaped="$(\printf '%s' "$1X" | \sed "s/'/'\\\\''/g")"
    local escaped="$(\printf '%s' "$1X" | \sed "s/'/'\\\\''/g")"
    if \[ "$no_quote" = 1 ]; then local format_string='%s'; else local format_string="'%s'"; fi
    \printf "$format_string" "${escaped%X}"
  else
    \printf '%s' "$1"
  fi
}

_otel_escape_arg_v2() {
  if \[ -z "$1" ]; then \printf "''";
  else
    # 
    # -e 's/ /\\ /g'
    \printf '%s' "$1" | \sed \
      -e 's/\\/\\\\/g' \
      -e 's/`/\\`/g' \
      -e 's/"/\\"/g' \
      -e "s/'/\\\'/g" \
      -e 's/(/\\(/g' \
      -e 's/)/\\)/g' \
      -e 's/!/\\!/g' \
      -e 's/</\\</g' \
      -e 's/>/\\>/g' \
      -e 's/|/\\|/g' \
      -e 's/&/\\&/g' \
      -e 's/;/\\;/g' \
      -e 's/\$/\\$/g' \
      -e 's/[[:space:]]/\\&/g'
      #
      #-e ':a' -e '/\\n$/!{N;ba' -e '}'
      #-e 's/\n/\\&/g'
  fi
}

_otel_escape_arg() {
  _otel_escape_arg_v1 "$1"
  # if _otel_contains_linefeed "$1"; then _otel_escape_arg_v1 "$1"; else _otel_escape_arg_v2 "$1"; fi
}

_otel_escape_args() {
  # for arg in "$@"; do \echo "$arg"; done | _otel_escape_in # this may seem correct, but it doesnt handle linefeeds in arguments correctly
  local first=1
  for arg in "$@"; do
    if \[ "$first" = 1 ]; then local first=0; else \echo -n " "; fi
    _otel_escape_arg "$arg"
  done
}

_otel_line_join() {
  \sed '/^$/d' | \tr '\n' ' ' | \sed 's/ $//'
}

_otel_call() {
  # the command is to be handled special when it starts with a \, because then it shouldnt be escaped to preserve behavior in eval
  # \\cat would make the most sense is considered as the literal command with the name "\cat"
  # '\cat' is interpreted as "do not alias" because of the quotes, and then the command \cat is not found
  # \cat is cat without aliases => thats what we want
  local command="$1"; shift
  case "$command" in
    "\\"*) ;;
    *) local command="$(_otel_escape_arg "$command")"
  esac
  # old versions of dash dont set env vars properly
  # more specifically they do not make variables that are set in front of commands part of the child process env vars but only of the local execution environment
  if \[ "$_otel_shell" = "dash" ]; then
    \eval "$( { \printenv; \set; } | \grep '^OTEL_' | \cut -d= -f1 | \sort -u | \awk '{ print $1 "=\"$" $1 "\"" }' | _otel_line_join)" "$command" "$(_otel_escape_args "$@")"
  else
    \eval "$command" "$(_otel_escape_args "$@")"
  fi
}

otel_observe() {
  # validate and clean arguments
  local name="${OTEL_SHELL_SPAN_NAME_OVERRIDE:-$*}"
  local name="${name#otel_observe }"
  local name="${name#_otel_observe }"
  local name="${name#\\}"
  local kind="${OTEL_SHELL_SPAN_KIND_OVERRIDE:-INTERNAL}"
  local command="${OTEL_SHELL_COMMANDLINE_OVERRIDE:-$*}"
  local command="${command#otel_observe }"
  local command="${command#_otel_observe }"
  local command="${command#\\}"
  local command_signature="${OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE:-$$}"
  local attributes="$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE"
  unset OTEL_SHELL_SPAN_NAME_OVERRIDE
  unset OTEL_SHELL_SPAN_KIND_OVERRIDE
  unset OTEL_SHELL_COMMANDLINE_OVERRIDE
  unset OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE
  # create span, set initial attributes
  local span_id=$(otel_span_start $kind "$name")
  otel_span_attribute $span_id subprocess.executable.name=$(\printf '%s' "$command" | \cut -d' ' -f1 | \rev | \cut -d'/' -f1 | \rev)
  otel_span_attribute $span_id subprocess.executable.path="$(\which $(\printf '%s' "$command" | \cut -d' ' -f1))"
  otel_span_attribute $span_id subprocess.command="$command"
  otel_span_attribute $span_id subprocess.command_args="$(\printf '%s' "$command" | \cut -sd' ' -f2-)"
  # run command
  otel_span_activate $span_id
  if \[ -n "$OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0" ]; then set -- "$@" "$(eval \\echo $OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0)"; fi
  if \[ -n "$OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1" ]; then set -- "$@" "$(eval \\echo $OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1)"; fi
  unset OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0
  unset OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1
  local exit_code=0
  if ! \[ -t 2 ] && \[ "$OTEL_SHELL_SUPPRESS_LOG_COLLECTION" != TRUE ]; then
    local traceparent=$OTEL_TRACEPARENT
    local stderr_pipe=$(\mktemp -u).opentelemetry_shell_$$.pipe
    \mkfifo $stderr_pipe
    ( (while IFS= read -r line; do otel_log_record $traceparent "$line"; \echo "$line" >&2; done < $stderr_pipe) & )
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="$command_signature" _otel_call "$@" 2> $stderr_pipe || local exit_code=$?
    \rm $stderr_pipe
  else
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="$command_signature" _otel_call "$@" || local exit_code=$?
  fi
  otel_span_deactivate $span_id
  # set custom attributes, set final attributes, finish span
  otel_span_attribute $span_id subprocess.exit_code=$exit_code
  if \[ "$exit_code" -ne "0" ]; then
    otel_span_error $span_id
  fi
  if \[ -n "$attributes" ]; then
    local IFS=','
    set -- $attributes
    for attribute in "$@"; do
      if \[ -n "$attribute" ]; then
        otel_span_attribute $span_id "$attribute"
      fi
    done
  fi
  otel_span_end $span_id
  return $exit_code
}
