set -e

root4job_end() {
  otel_span_end "$span_handle"
  otel_shutdown
  exit 0
}
export -f root4job_end

root4job() {
  traceparent_file="$1"
  . otelapi.sh
  otel_init
  span_handle="$(otel_span_start CONSUMER "$GITHUB_WORKFLOW / $GITHUB_JOB")"
  otel_span_activate "$span_handle"
  echo "$OTEL_TRACEPARENT" > "$traceparent_file"
  otel_span_deactivate "$span_handle"
  trap root4job_end SIGUSR1
  while true; do sleep 1; done
}
export -f root4job

root_pid_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid"
traceparent_file="$(mktemp -u)"
nohup bash -c 'root4job "$@"' bash "$traceparent_file" &> /dev/null &
echo "$!" > "$root_pid_file"

while ! [ -f "$traceparent_file" ]; do sleep 1; done
export OTEL_TRACEPARENT="$(cat "$traceparent_file")"
rm "$traceparent_file"

printenv | grep '^OTEL_' >> "$GITHUB_ENV"
echo "Configured OpenTelemetry for subsequent steps" >&2

echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev | xargs find | grep '.sh$' | while read -r file; do
  script="$(cat "$file")"
  script=". otel.sh
$script"
  echo "$script" > "$file"
  echo "Injected OpenTelemetry into $file" >&2
done

my_dir="$(echo "$0" | rev | cut -d / -f 2- | rev)"
new_path_dir="$(mktemp -d)"
gcc -o "$new_path_dir"/sh_w_otel "$my_dir"/sh_w_otel.c
chmod +x "$new_path_dir"/sh_w_otel
ln --symbolic "$new_path_dir"/sh_w_otel "$new_path_dir"/sh
ln --symbolic "$new_path_dir"/sh_w_otel "$new_path_dir"/dash
ln --symbolic "$new_path_dir"/sh_w_otel "$new_path_dir"/bash
echo "$new_path_dir" >> "$GITHUB_PATH"
echo "Redirected shells to auto-injected executables" >&2
