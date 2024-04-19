#!/bin/sh -e
if [ -z "$GITHUB_ENV" ]; then exit 1; fi

root_pid_file="$(mktemp -u | rev | cut -d / -f 2- | rev)/opentelemetry_shell_$GITHUB_RUN_ID.pid"
traceparent_file="$(mktemp)"
sh root.sh "$traceparent_file" &
echo "$!" > "$root_pid_file"

while ! [ -f "$traceparent_file" ]; do
  sleep 1
done
export OTEL_TRACEPARENT="$(cat "$traceparent_file")"

printenv | grep '^OTEL_' >> "$GITHUB_ENV"
echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev | xargs find | grep '*.sh$' | while read -r file; do
  script="$(cat "$file")"
  script=". otel.sh
$script"
  echo "$script" > "$file"
done
