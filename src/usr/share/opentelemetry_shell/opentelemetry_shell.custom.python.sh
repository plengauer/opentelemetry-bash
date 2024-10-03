#!/bin/false

_otel_inject_python() {
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ] && \[ -d "/opt/opentelemetry_shell/venv" ] && _otel_string_starts_with "$(\eval "$1 -V" | \cut -d ' ' -f 2)" "3."; then
    local cmdline="$(_otel_dollar_star "$@")"
    local cmdline="${cmdline#\\}"
    local command="$1"; shift
    set -- "$command" /opt/opentelemetry_shell/venv/bin/opentelemetry-instrument "${command#\\}" "$@"
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/"$(\ls /opt/opentelemetry_shell/venv/lib/)"/site-packages/:"$PYTHONPATH" OTEL_BSP_MAX_EXPORT_BATCH_SIZE=1 _otel_call "$@"
  else
    _otel_call "$@"
  fi
}

_otel_inject_opentelemetry_instrument() {
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ]; then
    local cmdline="$(_otel_dollar_star "$@")"
    local cmdline="${cmdline#\\}"
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_BSP_MAX_EXPORT_BATCH_SIZE="${OTEL_BSP_MAX_EXPORT_BATCH_SIZE:-1}" _otel_call "$@"
  else
    _otel_call "$@"
  fi
}

_otel_alias_prepend python _otel_inject_python
_otel_alias_prepend python3 _otel_inject_python
_otel_alias_prepend opentelemetry-instrument _otel_inject_opentelemetry_instrument
