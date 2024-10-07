#!/bin/false

_otel_inject_deep() {
  _otel_call_and_record_subprocesses "$(otel_span_current)" _otel_call "$@"
}

_otel_alias_prepend perl _otel_inject_deep

_otel_alias_prepend csh _otel_inject_deep
_otel_alias_prepend tcsh _otel_inject_deep
_otel_alias_prepend ksh _otel_inject_deep
_otel_alias_prepend zsh _otel_inject_deep
_otel_alias_prepend pdksh _otel_inject_deep
_otel_alias_prepend posh _otel_inject_deep
_otel_alias_prepend yash _otel_inject_deep
_otel_alias_prepend bosh _otel_inject_deep
_otel_alias_prepend fish _otel_inject_deep
