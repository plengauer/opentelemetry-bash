#!/bin/false

_otel_inject_node() {
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  local command="$1"
  shift
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" _otel_call "$command" --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js "$@"
}

_otel_alias_prepend node _otel_inject_node
