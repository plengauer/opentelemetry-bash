#/bin/sh
set -e
# sh|dash|bash -e /.../*.sh
if [ -n "$GITHUB_RUN_ID" ] && [ -f "$3" ] && [ "$(echo "$3" | rev | cut -d . -f 1 | rev)" = "sh" ] && [ "$(echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev)" = "$(echo "$3" | rev | cut -d / -f 2- | rev)" ]; then
  file="$3"
  script="$(cat "$file")"
  script=". otel.sh
$script"
  echo "$script" > "$file"
fi
exec "$@"
