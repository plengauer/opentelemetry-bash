#!/bin/sh -e
if [ -z "$GITHUB_ENV" ]; then exit 1; fi

# start span and keep process

printenv | grep '^OTEL_' >> "$GITHUB_ENV"
echo "$GITHUB_ENV" | rev | cut -d / -f 3- | rev | xargs find | grep '*.sh$' | while read -r file; do
  script="$(cat "$file")"
  script=". otel.sh
$script"
  echo "$script" > "$file"
done
