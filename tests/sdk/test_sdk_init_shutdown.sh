#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_api.sh

otel_init
assert_equals 0 $?
otel_shutdown
assert_equals 0 $?
