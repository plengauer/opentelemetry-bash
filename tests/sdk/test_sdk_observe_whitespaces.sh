#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_api.sh

otel_init
function count {
  echo $#
}
assert_equals 0 $(otel_observe count)
assert_equals 1 $(otel_observe count foo)
assert_equals 2 $(otel_observe count foo bar)
assert_equals 1 $(otel_observe count "foo bar")
assert_equals 3 $(otel_observe count foo "foo bar" foo)
otel_shutdown
