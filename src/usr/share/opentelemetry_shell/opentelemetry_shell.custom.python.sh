#!/bin/false

_otel_inject_python_args() {
  _otel_escape_arg /opt/opentelemetry_shell/venv/bin/opentelemetry-instrument
  \echo -n ' '
  while \[ "$#" -gt 0 ]; do \echo -n ' '; _otel_escape_arg "$1"; shift; done
}

_otel_inject_python() {
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ] && \[ -d "/opt/opentelemetry_shell/venv" ]; && _otel_string_starts_with "$("$1" -V | \cut -d ' ' f 2)" "3." then
    local cmdline="$(_otel_dollar_star "$@")"
    local cmdline="${cmdline#\\}"
    OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/python3.*/site-packages/ \eval _otel_call "$(_otel_inject_python_args "$@")"
  else
    _otel_call "$@"
  fi
}

_otel_alias_prepend python _otel_inject_python
_otel_alias_prepend python3 _otel_inject_python
