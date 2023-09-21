#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash.sh

alias cat=echo
otel_instrument cat
assert_not_equals 0 $?

