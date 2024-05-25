#!/bin/false

_otel_inject_node() {
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  local command="$1"
  shift
  if \[ "$OTEL_SHELL_EXPERIMENTAL_INJECT_DEEP" = TRUE ] && type npm &> /dev/null; then
    # \ln --symbolic /usr/share/opentelemetry_shell.custom.node.deep.package.json opentelemetry_shell.package.json
    \npm install --global --package /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.package.json
    local extra_flags="--require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.js"
  fi
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE _otel_call "$command" --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js $extra_flags "$@"
}

_otel_alias_prepend node _otel_inject_node
