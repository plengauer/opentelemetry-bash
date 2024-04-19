#/bin/sh -e
root_pid_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid"
kill -11 "$(cat $root_pid_file)"
