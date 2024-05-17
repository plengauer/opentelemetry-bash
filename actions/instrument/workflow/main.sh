set -e
if [ "$GITHUB_JOB" != observe ]; then echo "Job name must be 'observe'!" >&2; exit 1; fi 

github() {
  url="$GITHUB_API_URL"/"$1"?per_page=100
  curl --no-progress-meter --fail --retry 16 --retry-all-errors --head "$url" \
    | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
    | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
    | grep '^page=' | cut -d = -f 2 \
    | xargs seq 1 | while IFS= read -r page; do
      command curl --no-progress-meter --fail --retry 12 --retry-all-errors "$url"\&page="$page"
    done
}

github_workflow() {
  github repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/"$1"
}

if [ -z "$GITHUB_ACTION_REPOSITORY" ]; then export GITHUB_ACTION_REPOSITORY="$GITHUB_REPOSITORY"; fi
action_tag_name="$(echo "$GITHUB_ACTION_REF" | cut -sd @ -f 2-)"
if [ -n "$action_tag_name" ]; then
  debian_file="$(mktemp)"
  github repos/"$GITHUB_ACTION_REPOSITORY"/releases | { if [ "$action_tag_name" = main ]; then jq '.[0]'; else jq '.[] | select(.tag_name=="'"$action_tag_name"'")'; fi } | jq -r '.assets[] | .browser_download_url' | xargs wget -O "$debian_file"
  sudo apt-get install -y "$debian_file"
  rm "$debian_file"
else
  wget -O - https://raw.githubusercontent.com/"$GITHUB_ACTION_REPOSITORY"/main/INSTALL.sh | sh
fi
npm install '@actions/artifact'

if [ -z "$OTEL_SERVICE_NAME" ]; then
  export OTEL_SERVICE_NAME="$(echo "$GITHUB_REPOSITORY" | cut -d / -f 2-) CI"
fi

. otelapi.sh
otel_init
span_handle="$(otel_span_start CONSUMER "$GITHUB_WORKFLOW")"
otel_span_activate "$span_handle"
env_dir="$(mktemp -d)"
printenv | grep '^OTEL_' | grep -v HEADERS > "$env_dir"/.env
node upload_artifact.js opentelemetry "$env_dir"/.env
rm -r "$env_dir"
otel_span_deactivate "$span_handle"
while [ "$(github_workflow jobs | jq -r '.jobs[] | select(.status != "completed") | .name' | wc -l)" -gt 1 ]; do sleep 3; done
if [ "$(github_workflow jobs | jq -r '.jobs[] | select(.status == "completed") | select(.conclusion == "failure") | .name' | wc -l)" -gt 0 ]; then otel_span_error "$span_handle"; fi
otel_span_end "$span_handle"
otel_shutdown
node delete_artifact.js opentelemetry
