#!/bin/false

_otel_inject_node() {
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  local command="$1"
  shift
  if \[ "$OTEL_SHELL_EXPERIMENTAL_INJECT_DEEP" = TRUE ] && \type npm &> /dev/null; then
    \cp package.json package.json.otel.backup 2> /dev/null || \true
    \cp /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.package.json package.json
    \npm install --package-lock=false > /dev/null && local extra_flags="--require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.js"
    \cp package.json.otel.backup package.json 2> /dev/null || \true
    \echo 'DEBUG DEBUG DEBUG' "$@" >&2
  fi
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE _otel_call "$command" --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js $extra_flags "$@"
}

_otel_alias_prepend node _otel_inject_node
