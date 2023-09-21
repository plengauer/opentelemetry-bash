#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_sdk.sh

otel_init
function print {
  echo "$@" 1>&2
}
result=$(otel_observe print hello world 2>&1)
assert_equals "hello world" "$result"
otel_shutdown
