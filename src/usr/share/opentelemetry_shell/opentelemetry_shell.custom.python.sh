#!/bin/false

_otel_inject_python() {
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ] && \[ -d "/opt/opentelemetry_shell/venv" ] && _otel_string_starts_with "$(\eval "$1 -V" | \cut -d ' ' -f 2)" "3." && ! _otel_string_ends_with "$2" /pip && ! _otel_string_ends_with "$2" /pip3; then
    if _otel_python_is_customize_injectable; then
      local cmdline="$(_otel_dollar_star "$@")"
      local cmdline="${cmdline#\\}"
      local command="$1"; shift
      set -- "$command" /opt/opentelemetry_shell/venv/bin/opentelemetry-instrument "${command#\\}" "$@"
      OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/"$(\ls /opt/opentelemetry_shell/venv/lib/)"/site-packages/:"$PYTHONPATH" OTEL_BSP_MAX_EXPORT_BATCH_SIZE=1 _otel_call "$@"
    elif _otel_python_is_venv_active; then
      # TODO parse -c or stdin or file
      _otel_call "$@"
    else
      _otel_call "$@"
    fi
  else
    _otel_call "$@"
  fi
}

_otel_python_is_customize_injectable() {
 ! _otel_python_is_venv_active || _otel_python_is_venv_customize_injectable
}

_otel_python_is_venv_active() {
  \[ -n "${VIRTUAL_ENV:-}" ]
}

_otel_python_is_venv_customize_injectable() {
  \[ -d "${VIRTUAL_ENV:-}" ] && \cat "$VIRTUAL_ENV"/pyvenv.cfg | \grep -q -- '^include-system-site-packages = true$'
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
