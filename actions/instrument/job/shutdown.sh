set -e
root_pid="$(cat "$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid")"
kill -USR1 "$root_pid"
while kill -0 "$root_pid" 2> /dev/null; do sleep 1; done
cat "$STATE_log_file" >&2
