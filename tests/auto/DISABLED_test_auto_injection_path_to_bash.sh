#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash.sh

data=$(/bin/bash auto/fail_no_auto.sh)
assert_equals 0 $?
assert_not_equals "null" $(echo "$data" | jq '.name')
/bin/bash auto/fail.sh 42
assert_equals 42 $?
