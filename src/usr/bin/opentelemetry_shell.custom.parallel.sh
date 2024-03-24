#!/bin/false

# parallel -j 10 rm -f -- ./file1.txt ./file2.txt ./file3.txt => parallel -j 10 sh -c '. /otel.sh; rm -f "$1"' parallel -- ./file1.txt ./file2.txt ./file3.txt
# parallel -i -j 10 rm -f {} -- ./file1.txt ./file2.txt ./file3.txt => parallel -i -j 10 sh -c '. /otel.sh; rm -f {}' parallel -- ./file1.txt ./file2.txt ./file3.txt
# parallel -j 10 -- 'rm ./file1.txt' 'rm ./file2.txt' 'rm ./file3.txt' => parallel -j 10 -- 'sh -c \'. /otel.sh; rm -f ./file1.txt\' parallel' 'sh -c \'. /otel.sh; rm -f ./file2.txt\' parallel' 'sh -c \'. /otel.sh; rm -f ./file3.txt\' parallel'

_otel_inject_parallel_moreutils_arguments() {
  case "$1" in
    "\\"*) \printf '%s' "$1";;
    *) _otel_escape_arg "$1";;
  esac
  if \[ "$1" = "_otel_observe" ]; then shift; \echo -n " "; _otel_escape_arg "$1"; fi
  shift
  local in_exec=0
  local explicit_pos=0
  local inject_all_args=0
  for arg in "$@"; do
    \echo -n ' '
    if \[ "$in_exec" -eq 0 ] && ! \[ "${arg%"${arg#?}"}" = "-" ] && \[ -x "$(\which "$arg")" ]; then
      local in_exec=1
      \echo -n "sh -c '. /usr/bin/opentelemetry_shell.sh
$arg"
    elif \[ "$in_exec" -eq 1 ] && \[ "$arg" = "--" ]; then
      local in_exec=0
      if \[ "$explicit_pos" = 0 ]; then \echo -n '"$@"'; fi
      \echo -n "' parallel --"
    elif \[ "$in_exec" -eq 0 ] && \[ "$arg" = "--" ]; then
      local inject_all_args=1
      \echo -n "--"
    else
      if \[ "$in_exec" = 1 ]; then
        no_quote=1 _otel_escape_arg "$(_otel_escape_arg "$arg")"
      else
        if \[ "$inject_all_args" = 1 ]; then 
          \echo -n "'sh -c '\''. /usr/bin/opentelemetry_shell.sh
$arg'\'' parallel'"
        else
          if \[ "$arg" = "-i" ]; then local explicit_pos=1; fi
          _otel_escape_arg "$arg"
        fi
      fi
    fi
  done
}

# parallel rm -f ::: ./file1.txt ./file2.txt ./file3.txt => parallel sh -c '. ./otel.sh; rm -f "$@"' parallel ::: ./file1.txt ./file2.txt ./file3.txt
# parallel rm -f {} ::: ./file1.txt ./file2.txt ./file3.txt => parallel sh -c '. ./otel.sh; rm -f {} "$@" parallel ::: ./file1.txt ./file2.txt ./file3.txt
# parallel rm -f => parallel sh -c '. ./otel.sh; rm -f "$@"' parallel

# TODO TODO TODO it looks like the command is not properly quotes when its put in a subbash. meaning, we need to do it manually
# evidence this works: parallel -v sh -c 'echo\ \$0\ A\$1O' parallel ':::' c1 c2 c3
# evidence this doesnt work: parallel -v sh -c 'echo $0 A$1O' parallel ':::' c1 c2 c3

_otel_inject_parallel_gnu_arguments() {
  case "$1" in
    "\\"*) \printf '%s' "$1";;
    *) _otel_escape_arg "$1";;
  esac
  if \[ "$1" = "_otel_observe" ]; then shift; \echo -n " "; _otel_escape_arg "$1"; fi
  shift
  local in_exec=0
  for arg in "$@"; do
    \echo -n ' '
    if \[ "$in_exec" -eq 0 ] && ! \[ "${arg%"${arg#?}"}" = "-" ] && \[ -x "$(\which "$arg")" ]; then
      local in_exec=1
      \echo -n "-q sh -c '. /usr/bin/opentelemetry_shell.sh
"
      no_quote=1 _otel_escape_arg "$arg"
    if \[ "$in_exec" -eq 0 ] && ! \[ "${arg%"${arg#?}"}" = "-" ] && \[ "$_otel_shell" = bash ] && \type "$arg" 2> /dev/null | \head -n1 | \grep -q ' function$'; then
      local in_exec=1
      local func_name=_otel_func_wrapper_"$arg"
      \eval "$func_name"'() { \source /usr/bin/opentelemetry_shell.sh; '"$arg"' "$@"; }'
      \export -f "$func_name"
      no_quote=1 _otel_escape_arg "$func_name"
    elif \[ "$in_exec" -eq 1 ] && \[ "$arg" = ":::${arg#":::"}" ]; then
      local in_exec=0
      \echo -n '"$@"'"' 'parallel' $arg"
    else
      if \[ "$in_exec" = 1 ]; then
        no_quote=1 _otel_escape_arg "$(_otel_escape_arg "$arg")"
      else
        _otel_escape_arg "$arg"
      fi
    fi
  done
  if \[ "$in_exec" -eq 1 ]; then
    \echo -n ' "$@"'"' 'parallel'"
  fi
}

_otel_inject_parallel_arguments() {
  local cmd="$({ set -- "$@"; if \[ "$1" = "_otel_observe" ]; then shift; fi; \printf '%s' "$1"; })"
  if \[ -n "$(\eval "$cmd" -help | \grep ':::')" ]; then
    _otel_inject_parallel_gnu_arguments "$@"
  else
    _otel_inject_parallel_moreutils_arguments "$@"
  fi
}

_otel_inject_parallel() {
    local cmdline="$({ set -- "$@"; if \[ "$1" = "_otel_observe" ]; then shift; fi; _otel_dollar_star "$@"; })"
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_SPAN_NAME_OVERRIDE="$cmdline" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_SHELL_AUTO_INSTRUMENTATION_HINT="$cmdline" \
      \eval "$(_otel_inject_parallel_arguments "$@")"
}

_otel_alias_prepend parallel _otel_inject_parallel
_otel_alias_prepend parallel.moreutils _otel_inject_parallel
