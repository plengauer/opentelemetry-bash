#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash.sh

assert_equals 0 $(bash auto/count_fail_no_auto.sh)
assert_equals 1 $(bash auto/count_fail_no_auto.sh foo)
assert_equals 2 $(bash auto/count_fail_no_auto.sh foo bar)
assert_equals 1 $(bash auto/count_fail_no_auto.sh "foo bar")
