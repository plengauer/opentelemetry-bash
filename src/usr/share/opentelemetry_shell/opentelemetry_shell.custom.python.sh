#!/bin/false

_otel_inject_python() {
  set -x
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ] && \[ -d "/opt/opentelemetry_shell/venv" ] && _otel_string_starts_with "$(\eval "$1 -V" | \cut -d ' ' -f 2)" "3."; then
    local cmdline="$(_otel_dollar_star "$@")"
    local cmdline="${cmdline#\\}"
    if \[ "$1" != opentelemetry-instrument ] && ! _otel_string_ends_with "$1" /opentelemetry-instrument; then
      set -- /opt/opentelemetry_shell/venv/bin/opentelemetry-instrument "$@"
    fi
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/python3.*/site-packages/ _otel_call "$@"
  else
    _otel_call "$@"
  fi
  set +x
}

_otel_alias_prepend python _otel_inject_python
_otel_alias_prepend python3 _otel_inject_python
_otel_alias_prepend opentelemetry-instrument _otel_inject_python
