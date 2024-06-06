#!/bin/false

_otel_is_node_injected() {
  local dir="$dir"
  if \[ -f "$dir"/package-lock.json ]; then
    \cat "$dir"/package-lock.json | \grep -q '"@opentelemetry/'
  elif \[ -d "$dir"/node_modules ]; then
    \find "$dir"/node_modules | \grep -q '/@opentelemetry/'
  elif \[ -f "$dir"/package.json ]; then
    \cat "$dir"/package.json | \grep -q '"@opentelemetry/'
  else
    return 1
  fi
}

_otel_inject_node_args() {
  _otel_escape_args command "${1#\\}"
  shift
  \echo -n ' '; _otel_escape_args --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js
  while \[ "$#" -gt 0 ]; do
    \echo -n ' '
    if \[ "$skip" = 1 ]; then
      _otel_escape_arg "$1"; shift; local skip=0
    elif \[ "$1" = -e ] || \[ "$1" = --eval ] || \[ "$1" = -p ] || \[ "$1" = --print ]; then
      _otel_escape_arg "$1"; shift; local skip=1
    elif \[ "$1" = -r ] || \[ "$1" = --require ]; then
      _otel_escape_arg "$1"; shift; local skip=1
    elif ( _otel_string_ends_with "$1" .js || _otel_string_ends_with "$1" .ts ) && \[ -f "$1" ]; then
      if \[ "$OTEL_SHELL_EXPERIMENTAL_INJECT_DEEP" = TRUE ] && \[ -d "/usr/share/opentelemetry_shell/node_modules" ]; then
        local script="$1"
        local dir="$(\echo "$script" | \rev | \cut -d / -f 2- | \rev)"
        while [ -n "$dir" ] && ! \[ -d "$dir"/node_modules ] && ! \[ -f "$dir"/package.json ] && ! \[ -f "$dir"/package-lock.json ]; do
          local dir="$(\echo "$dir" | \rev | \cut -d / -f 2- | \rev)"
        done
        if \[ -z "$dir" ]; then local dir="$(\echo "$script" | \rev | \cut -d / -f 2- | \rev)"; fi
        if ( \[ "$OTEL_TRACES_EXPORTER" = console ] || \[ "$OTEL_TRACES_EXPORTER" = otlp ] ) && ! _otel_is_node_injected "$dir"; then
          _otel_escape_args --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.instrument.js; \echo -n ' '
        fi
        _otel_escape_args -e "const opentelemetry = require('@opentelemetry/api'); opentelemetry.context.with(opentelemetry.trace.setSpanContext(opentelemetry.context.active(), opentelemetry.propagation.extract(opentelemetry.context.active(), { traceparent: process.env.OTEL_TRACEPARENT })), () => { require('$script') });"
        shift
      else
        break
      fi
    elif _otel_string_starts_with "$1" -; then
      _otel_escape_arg "$1"; shift
    else
      break
    fi
  done
  while \[ "$#" -gt 0 ]; do \echo -n ' '; _otel_escape_arg "$1"; shift; done
}

_otel_inject_node() {
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  _otel_inject_node_args "$@" >&2
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE \eval _otel_call "$(_otel_inject_node_args "$@")"
}

_otel_alias_prepend node _otel_inject_node
_otel_alias_prepend nodejs _otel_inject_node
