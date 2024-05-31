#!/bin/false

_otel_inject_node() {
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  local command="$1"
  shift
  if \[ "$OTEL_SHELL_EXPERIMENTAL_INJECT_DEEP" = TRUE ] && ( \[ "$OTEL_TRACES_EXPORTER" = console ] || \[ "$OTEL_TRACES_EXPORTER" = otlp ] ) && \type npm &> /dev/null && \false; then
    for _otel_node_arg in "$@"; do
      if \[ "$_otel_node_arg" = -r ] || \[ "$_otel_node_arg" = --require ]; then local skip=1; continue; fi
      if \[ "$skip" = 1 ] || _otel_string_starts_with "$_otel_node_arg" -; then local skip=0; continue; fi
      if _otel_string_ends_with "$_otel_node_arg" .js; then local script="$_otel_node_arg"; fi
      break
    done
    if \[ -f "$script" ]; then
      local wd="$(\pwd)"
      local dir="$(\echo "$script" | \rev | \cut -d / -f 2- | \rev)"
      while [ -n "$dir" ] && ! \[ -d "$dir"/node_modules ]; do
        local dir="$(\echo "$dir" | \rev | \cut -d / -f 2- | \rev)"
      done
      if \[ -d "$dir"/node_modules ]; then
        \cd "$dir"
        \cp package.json .package.json.otel.backup 2> /dev/null || \true
        \cp /usr/share/opentelemetry_shell/package.json package.json
        \npm install --package-lock=false &> /dev/null && local extra_flags="--require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.js" || \true
        \cp .package.json.otel.backup package.json 2> /dev/null && \rm .package.json.otel.backup 2> /dev/null || \true
        \cd "$wd"
      fi
    fi
  fi
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE _otel_call "$command" --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js $extra_flags "$@"
}

_otel_alias_prepend node _otel_inject_node
_otel_alias_prepend nodejs _otel_inject_node
