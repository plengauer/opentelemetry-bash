#!/bin/false

_otel_inject_python() {
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ] && \[ -d "/opt/opentelemetry_shell/venv" ] && _otel_string_starts_with "$(\eval "$1 -V" | \cut -d ' ' -f 2)" "3." && ! _otel_string_ends_with "$2" /pip && ! _otel_string_ends_with "$2" /pip3; then
    local cmdline="$(_otel_dollar_star "$@")"
    local cmdline="${cmdline#\\}"
    # if \[ -z "${OTEL_PYTHON_DISABLED_INSTRUMENTATIONS:-}" ]; then # TODO
    #   export OTEL_PYTHON_DISABLED_INSTRUMENTATIONS="aws-lambda"
    # else
    #   export OTEL_PYTHON_DISABLED_INSTRUMENTATIONS="$OTEL_PYTHON_DISABLED_INSTRUMENTATIONS,aws-lambda"
    # fi
    if _otel_python_is_customize_injectable; then
      local command="$1"; shift
      set -- "$command" /opt/opentelemetry_shell/venv/bin/opentelemetry-instrument "${command#\\}" "$@"
      OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/"$(\ls /opt/opentelemetry_shell/venv/lib/)"/site-packages/:"$PYTHONPATH" OTEL_BSP_MAX_EXPORT_BATCH_SIZE=1 _otel_call "$@"
    else
      \eval "set -- $(_otel_python_inject_args "$@")"
      local command="$1"; shift
      set -- "$command" /opt/opentelemetry_shell/venv/bin/opentelemetry-instrument "${command#\\}" "$@"
      if \[ "$_otel_python_code_source" = stdin ]; then
        unset _otel_python_code_source
        { \cat /usr/share/opentelemetry_shell/agent.instrumentation.python.deep.py; \cat; } | OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/"$(\ls /opt/opentelemetry_shell/venv/lib/)"/site-packages/:"$PYTHONPATH" OTEL_BSP_MAX_EXPORT_BATCH_SIZE=1 _otel_call "$@"
      else
        OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE PYTHONPATH=/opt/opentelemetry_shell/venv/lib/"$(\ls /opt/opentelemetry_shell/venv/lib/)"/site-packages/:"$PYTHONPATH" OTEL_BSP_MAX_EXPORT_BATCH_SIZE=1 _otel_call "$@"
      fi
    fi
  else
    _otel_call "$@"
  fi
}

_otel_inject_opentelemetry_instrument() {
  if \[ "$OTEL_SHELL_CONFIG_INJECT_DEEP" = TRUE ]; then
    local cmdline="$(_otel_dollar_star "$@")"
    local cmdline="${cmdline#\\}"
    \eval "set -- $(_otel_python_inject_args "$@")"
    if \[ "$_otel_python_code_source" = stdin ]; then
      unset _otel_python_code_source
      { \cat /usr/share/opentelemetry_shell/agent.instrumentation.python.deep.py; \cat; } | OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_BSP_MAX_EXPORT_BATCH_SIZE="${OTEL_BSP_MAX_EXPORT_BATCH_SIZE:-1}" _otel_call "$@"
    else
      OTEL_SHELL_COMMANDLINE_OVERRIDE="$cmdline" OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE="0" OTEL_SHELL_AUTO_INJECTED=TRUE OTEL_BSP_MAX_EXPORT_BATCH_SIZE="${OTEL_BSP_MAX_EXPORT_BATCH_SIZE:-1}" _otel_call "$@"
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

_otel_python_inject_args() {
  if \[ "${1#\\}" = opentelemetry-instrument ] || _otel_string_ends_with "$1" /opentelemetry-instrument; then
    _otel_escape_arg "$1"; shift
    \echo -n ' '
  fi
  _otel_escape_arg "$1"; shift
  while \[ "$#" -gt 0 ]; do
    \echo -n ' '
    local arg="$1"; shift
    if \[ -n "${injected:-}" ]; then
      _otel_escape_arg "$arg"
    elif \[ "$arg" = -c ]; then
      _otel_escape_arg "$arg"
      \echo -n ' '
      local arg="$1"; shift
      _otel_escape_arg "$(\cat /usr/share/opentelemetry_shell/agent.instrumentation.python.deep.py)
$arg"
      local injected=cmdline
    elif \[ -f "$arg" ]; then
      _otel_escape_args -c "$(\cat /usr/share/opentelemetry_shell/agent.instrumentation.python.deep.py)
with open('$arg', 'r') as file:
  exec(file.read())"
      local injected=file
    fi
  done
  if \[ -z "$injected" ]; then
    _otel_python_code_source=stdin
  fi
}

_otel_alias_prepend python _otel_inject_python
_otel_alias_prepend python3 _otel_inject_python
_otel_alias_prepend opentelemetry-instrument _otel_inject_opentelemetry_instrument
