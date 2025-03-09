#!/bin/false

_otel_inject_java() {
  # TODO injection into subprocesses
  # TODO activate context from env vars
  JAVA_TOOL_OPTIONS=-javagent:/opt/opentelemetry_shell/opentelemetry-javaagent.jar _otel_call "$@"
}

_otel_alias_prepend java _otel_inject_java
