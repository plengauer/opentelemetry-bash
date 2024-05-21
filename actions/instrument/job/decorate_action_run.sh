#!/bin/sh
set -e
# sh|dash|bash -e /.../*.sh
if [ -n "$GITHUB_RUN_ID" ] && [ -f "$3" ] && [ "$(echo "$3" | rev | cut -d . -f 1 | rev)" = "sh" ] && [ "$(echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev)" = "$(echo "$3" | rev | cut -d / -f 2- | rev)" ]; then
  # export GITHUB_STEP="$(curl --no-progress-meter --fail --retry 12 --retry-all-errors "$GITHUB_API_URL"/repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/jobs | jq -r ".jobs[] | select(.name == \"$GITHUB_JOB\") | select(.run_attempt == $GITHUB_RUN_ATTEMPT) | .steps[] | select(.status == \"in_progress\") | .name")"
  file="$3"
  script="$(cat "$file")"
  script=". otel.sh
$script"
  echo "$script" > "$file"
  exit_code=0
  "$0" "$@" || exit_code="?"
  if [ "$exit_code" != 0 ]; then touch /tmp/opentelemetry_shell.github.error; fi
  exit "$?"
else
  exec "$@"
fi
