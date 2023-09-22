#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_sdk.sh

otel_init
result=$(otel_observe echo "hello world")
assert_equals "hello world" "$result"
otel_shutdown
