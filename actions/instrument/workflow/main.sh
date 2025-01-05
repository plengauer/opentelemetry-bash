#/bin/bash
set -e
if [ "$GITHUB_JOB" != observe ]; then echo "Job name must be 'observe'!" >&2; exit 1; fi

. ../shared/github.sh
OTEL_SHELL_CONFIG_INSTALL_DEEP=FALSE bash -e ../shared/install.sh

export OTEL_SERVICE_NAME="${OTEL_SERVICE_NAME:-"$(echo "$GITHUB_REPOSITORY" | cut -d / -f 2-) CI"}"

. otelapi.sh
otel_init
span_handle="$(otel_span_start CONSUMER "$GITHUB_WORKFLOW")"
otel_span_activate "$span_handle"
env_dir="$(mktemp -d)"
printenv | grep -E '^OTEL_|^TRACEPARENT=|^TRACESTATE=' | sort -R | openssl enc -aes-256-cbc -salt -pbkdf2 -pass pass:"$INPUT_GITHUB_TOKEN" | base64 > "$env_dir"/.env
node upload_artifact.js opentelemetry "$env_dir"/.env
rm -r "$env_dir"
otel_span_deactivate "$span_handle"
while [ "$(github_workflow jobs | jq -r '.jobs[] | select(.status != "completed") | .name' | wc -l)" -gt 1 ]; do sleep 3; done
if [ "$(github_workflow jobs | jq -r '.jobs[] | select(.status == "completed") | select(.conclusion == "failure") | .name' | wc -l)" -gt 0 ]; then otel_span_error "$span_handle"; fi
otel_span_end "$span_handle"
otel_shutdown
node delete_artifact.js opentelemetry
