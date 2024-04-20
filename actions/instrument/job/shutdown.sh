set -e
root_pid_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid"
root_pid="$(cat $root_pid_file)"
kill -2 "$root_pid"
while kill -0 "$root_pid" 2> /dev/null; do sleep 1; ps -ef | grep "$root_pid"; done
