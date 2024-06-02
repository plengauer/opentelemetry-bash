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

_otel_inject_node() {
  local cmdline="$(_otel_dollar_star "$@")"
  local cmdline="${cmdline#\\}"
  local command="$1"
  shift
  local extra_flags="--require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js"
  if \[ "$OTEL_SHELL_EXPERIMENTAL_INJECT_DEEP" = TRUE ] && ( \[ "$OTEL_TRACES_EXPORTER" = console ] || \[ "$OTEL_TRACES_EXPORTER" = otlp ] ); then
    set -x
    for _otel_node_arg in "$@"; do
      if \[ "$_otel_node_arg" = -r ] || \[ "$_otel_node_arg" = --require ]; then local skip=1; continue; fi
      if \[ "$skip" = 1 ] || _otel_string_starts_with "$_otel_node_arg" -; then local skip=0; continue; fi
      if _otel_string_ends_with "$_otel_node_arg".js || _otel_string_ends_with "$_otel_node_arg" .ts; then local script="$_otel_node_arg"; fi
      break
    done
    if \[ -f "$script" ]; then
      local dir="$(\echo "$script" | \rev | \cut -d / -f 2- | \rev)"
      while [ -n "$dir" ] && ! \[ -d "$dir"/node_modules ] && ! \[ -f "$dir"/package.json ] && ! \[ -f "$dir"/package-lock.json ]; do
        local dir="$(\echo "$dir" | \rev | \cut -d / -f 2- | \rev)"
      done
      if \[ -z "$dir" ]; then local dir="$(\echo "$script" | \rev | \cut -d / -f 2- | \rev)"; fi
      if _otel_is_node_injected "$dir"; then
        local extra_flags="$extra_flags --require /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.link.js"
      elif \type npm &> /dev/null; then
        local wd="$(\pwd)"
        \cd "$dir"
        if \true; then
          \cp package.json .package.json.otel.backup 2> /dev/null
          : && \
            ( \[ -L .otel.inject.js ] || \ln --symbolic /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.inject.js .otel.inject.js ) && \
            ( \[ -L .otel.instrument.js ] || \ln --symbolic /usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.instrument.js .otel.instrument.js ) && \
            \cp /usr/share/opentelemetry_shell/package.json package.json 2> /dev/null && \npm install --package-lock=false 2> /dev/null && \
            local extra_flags="$extra_flags --require $dir/.otel.inject.js --require $dir/.otel.instrument.js" || \true
          \cp .package.json.otel.backup package.json 2> /dev/null && \rm .package.json.otel.backup 2> /dev/null || \true          
        else
          \cp package.json .package.json.otel.backup 2> /dev/null || \true
          \cp /usr/share/opentelemetry_shell/package.json package.json 2> /dev/null && \npm install --package-lock=false 2> /dev/null && local extra_flags="$extra_flags --require $dir/.otel.inject.js --require $dir/.otel.instrument.js" || \true
          \cp .package.json.otel.backup package.json 2> /dev/null && \rm .package.json.otel.backup 2> /dev/null || \true
        fi
        \cd "$wd"
      fi
    fi
    set +x
  fi
  \echo "DEBUG DEBUG DEBUG $command $extra_flags $*" >&2
  OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE _otel_call "$command" $extra_flags "$@"
}

_otel_alias_prepend node _otel_inject_node
_otel_alias_prepend nodejs _otel_inject_node
