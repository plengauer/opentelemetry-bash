root_pid_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid"
traceparent_file="$(mktemp)"
sh root.sh "$traceparent_file" &
echo "$!" > "$root_pid_file"
