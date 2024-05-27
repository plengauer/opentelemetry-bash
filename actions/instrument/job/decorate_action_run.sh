#!/bin/sh
set -e
if [ -z "$GITHUB_RUN_ID" ] || [ "$(cat /proc/$PPID/cmdline | tr '\000-\037' ' ' | cut -d ' ' -f 1 | rev | cut -d / -f 1 | rev)" != "Runner.Worker" ]; then exec "$@"; fi
file="$(eval echo '"$'"$#"'"')"
if ! [ -f "$file" ] || ! [ "$(echo "$file" | rev | cut -d . -f 1 | rev)" = "sh" ] || ! [ "$(echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev)" = "$(echo "$file" | rev | cut -d / -f 2- | rev)" ]; then exec "$@"; fi
# export GITHUB_STEP="$(curl --no-progress-meter --fail --retry 12 --retry-all-errors "$GITHUB_API_URL"/repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/jobs | jq -r ".jobs[] | select(.name == \"$GITHUB_JOB\") | select(.run_attempt == $GITHUB_RUN_ATTEMPT) | .steps[] | select(.status == \"in_progress\") | .name")"
script="$(cat "$file")"
script=". otel.sh
$script"
echo "$script" > "$file"
exit_code=0
"$@" || exit_code="$?"
if [ "$exit_code" != 0 ]; then touch /tmp/opentelemetry_shell.github.error; fi
exit "$exit_code"
