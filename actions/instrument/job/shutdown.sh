set -e
root_pid="$(cat "$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid")"
kill -USR1 "$root_pid"
while kill -0 "$root_pid" 2> /dev/null; do sleep 1; done
out_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.out"
if \[ -f "$out_file" ]; then cat "$out_file" >&2; fi
