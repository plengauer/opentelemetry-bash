#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash.sh

alias echo=ls
otel_instrument echo
assert_not_equals 0 $?

