#!/bin/false

_otel_inject_deep() {
  _otel_call_and_record_subprocesses "$(otel_span_current)" _otel_call "$@"
}

_otel_alias_prepend perl _otel_inject_deep
