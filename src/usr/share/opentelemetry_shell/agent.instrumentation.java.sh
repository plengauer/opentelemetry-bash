#!/bin/false

_otel_inject_java() {
  JAVA_TOOL_OPTIONS=/opt/opentelemetry_shell/opentelemetry-javaagent.jar _otel_call "$@"
}

_otel_alias_prepend java _otel_inject_java
