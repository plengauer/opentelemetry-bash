#!/bin/false

_otel_inject_node() {
  # TODO lets make it super dirty for now!
  shift # TODO lets assume first arg is simply "node"
  _otel_call \\node --require /usr/share/opentelemetry_shell.custom.node.js "$@"
}

_otel_alias_prepend node _otel_inject_node
