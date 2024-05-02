#!/bin/sh
set -e
root_pid="$(cat "$GITHUB_STATE" | grep '^PID=' | cut -d = -f 2-)"
kill -USR1 "$root_pid"
while kill -0 "$root_pid" 2> /dev/null; do sleep 1; done
