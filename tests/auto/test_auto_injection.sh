#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash.sh

bash auto/fail_no_auto.sh
bash auto/fail.sh 42
assert_equals 42 $?
