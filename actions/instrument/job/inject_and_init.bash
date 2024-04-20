set -e

root4job() {
  traceparent_file="$1"
  . otelapi.sh
  otel_init
  span_kind=CONSUMER
  span_name="$GITHUB_JOB"
  if [ -n "$OTEL_TRACEPARENT" ]; then span_kind=INTERNAL; span_name="$GITHUB_WORKFLOW / $span_name"; fi
  span_handle="$(otel_span_start "$span_kind" "$span_name")"
  otel_span_activate "$span_handle"
  echo "$OTEL_TRACEPARENT" > "$traceparent_file"
  otel_span_deactivate
  otel_span_attribute "$span_handle" github.repository="$GITHUB_REPOSITORY"
  otel_span_attribute "$span_handle" github.ref="$GITHUB_REF"
  otel_span_attribute "$span_handle" github.actor.id="$GITHUB_ACTOR_ID"
  otel_span_attribute "$span_handle" github.actor.name="$GITHUB_ACTOR"
  otel_span_attribute "$span_handle" github.event.name="$GITHUB_EVENT_NAME"  
  otel_span_attribute "$span_handle" github.workflow.run_id="$GITHUB_RUN_ID"
  otel_span_attribute "$span_handle" github.workflow.ref="$GITHUB_WORKFLOW_REF"
  otel_span_attribute "$span_handle" github.workflow.name="$GITHUB_WORKFLOW"
  otel_span_attribute "$span_handle" github.job.name="$GITHUB_JOB"
  # TODO how many of the above should be resource attributes?
  dummy() { echo 'received SIGINT' >&2; }
  trap dummy SIGINT
  wait
  otel_span_end "$span_handle"
  otel_shutdown
}
export -f root4job

root_pid_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid"
traceparent_file="$(mktemp)"
bash -c root4job bash "$traceparent_file" &
echo "$!" > "$root_pid_file"

while ! [ -f "$traceparent_file" ]; do sleep 1; done
export OTEL_TRACEPARENT="$(cat "$traceparent_file")"

printenv | grep '^OTEL_' >> "$GITHUB_ENV"
echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev | xargs find | grep '*.sh$' | while read -r file; do
  script="$(cat "$file")"
  script=". otel.sh
$script"
  echo "$script" > "$file"
done
