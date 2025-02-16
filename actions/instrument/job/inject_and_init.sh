#!/bin/bash
set -e

. ../shared/config_validation.sh
. ../shared/github.sh
bash -e ../shared/install.sh

echo "$GITHUB_ACTION" > /tmp/opentelemetry_shell_action_name

# setup injections
## setup injection for shell actions
new_path_dir="/tmp/otel/bin"
mkdir -p "$new_path_dir"
gcc -o "$new_path_dir"/sh forward.c -DEXECUTABLE="$(which sh)" -DARG1="$(pwd)"/decorate_action_run.sh -DARG2="$(which sh)"
gcc -o "$new_path_dir"/dash forward.c -DEXECUTABLE="$(which dash)" -DARG1="$(pwd)"/decorate_action_run.sh -DARG2="$(which dash)"
gcc -o "$new_path_dir"/bash forward.c -DEXECUTABLE="$(which bash)" -DARG1="$(pwd)"/decorate_action_run.sh -DARG2="$(which bash)"
echo "$new_path_dir" >> "$GITHUB_PATH"
## setup injections into node actions
for node_path in /home/runner/runners/*/externals/node*/bin/node; do
  dir_path_new="$(echo "$node_path" | rev | cut -d / -f 2- | rev).original"
  mkdir "$dir_path_new"
  node_path_new="$dir_path_new"/node
  mv "$node_path" "$node_path_new"
  gcc -o "$node_path" forward.c -DEXECUTABLE=/bin/bash -DARG1="$(pwd)"/decorate_action_node.sh -DARG2="$node_path_new"
done
## setup injections into docker actions
### cant use the same path trick as for the shells, because path is resolved at the very start, so paths must not change
docker_path="$(which docker)"
sudo mv "$docker_path" "$(pwd)"
sudo gcc -o "$docker_path" forward.c -DEXECUTABLE=/bin/bash -DARG1="$(pwd)"/decorate_action_docker.sh -DARG2="$(pwd)"/docker

# guess job id for proper linking
OTEL_SHELL_GITHUB_JOB="$GITHUB_JOB"
job_arguments="$(printf '%s' "$INPUT___JOB_MATRIX" | jq -r '. | [.. | scalars] | @tsv' | sed 's/\t/, /g')"
if [ -n "$job_arguments" ]; then OTEL_SHELL_GITHUB_JOB="$OTEL_SHELL_GITHUB_JOB ($job_arguments)"; fi
export OTEL_SHELL_GITHUB_JOB
GITHUB_JOB_ID="$(gh_jobs "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" | jq --unbuffered -r '. | .jobs[] | [.id, .name] | @tsv' | sed 's/\t/ /g' | grep " $OTEL_SHELL_GITHUB_JOB"'$' | cut -d ' ' -f 1)"
if [ "$(printf '%s' "$GITHUB_JOB_ID" | wc -l)" -le 1 ]; then export GITHUB_JOB_ID; fi
echo "Guessing GitHub job id to be $GITHUB_JOB_ID" >&2

# configure collector if required
set -x
if [ "$INPUT_COLLECTOR" = true ] || ([ "$INPUT_COLLECTOR" = auto ] && ([ -n "${OTEL_EXPORTER_OTLP_HEADERS:-}" ] || [ -n "${OTEL_EXPORTER_OTLP_LOGS_HEADERS:-}" ] || [ -n "${OTEL_EXPORTER_OTLP_METRICS_HEADERS:-}" ] || [ -n "${OTEL_EXPORTER_OTLP_TRACES_HEADERS:-}" ])); then
  if ! type docker; then echo "::error ::Cannot use collector because docker is unavailable." && false; fi
  section_exporter_logs="$(mktemp)"; section_exporter_metrics="$(mktemp)"; section_exporter_traces="$(mktemp)"
  section_pipeline_logs="$(mktemp)"; section_pipeline_metrics="$(mktemp)"; section_pipeline_traces="$(mktemp)"
  if [ "${OTEL_LOGS_EXPORTER:-otlp}" = otlp ]; then
    if [ "${OTEL_EXPORTER_OTLP_PROTOCOL:-http/protobuf}" ]; then collector_exporter=otlphttp; else collector_exporter=otlp; fi
    cat > "$section_exporter_logs" <<EOF
  $collector_exporter/logs:
    endpoint: "${OTEL_EXPORTER_OTLP_LOGS_ENDPOINT:-$OTEL_EXPORTER_OTLP_ENDPOINT}"
    headers:
$(echo "$OTEL_EXPORTER_OTLP_HEADERS","$OTEL_EXPORTER_OTLP_LOGS_HEADERS" | tr ',' '\n' | grep -v '^$' | sed 's/=/: /g' | sed 's/^/      /g')
EOF
    cat > "$section_pipeline_logs" <<EOF
    logs:
      receivers: [otlp]
      exporters: [$collector_exporter/logs]
      processors: [batch]
EOF
    unset OTEL_EXPORTER_OTLP_LOGS_HEADERS
  fi
  if [ "${OTEL_METRICS_EXPORTER:-otlp}" = otlp ]; then
    if [ "${OTEL_EXPORTER_OTLP_PROTOCOL:-http/protobuf}" ]; then collector_exporter=otlphttp; else collector_exporter=otlp; fi
    cat > "$section_exporter_metrics" <<EOF
  $collector_exporter/metrics:
    endpoint: "${OTEL_EXPORTER_OTLP_METRICS_ENDPOINT:-$OTEL_EXPORTER_OTLP_ENDPOINT}"
    headers:
$(echo "$OTEL_EXPORTER_OTLP_HEADERS","$OTEL_EXPORTER_OTLP_METRICS_HEADERS" | tr ',' '\n' | grep -v '^$' | sed 's/=/: /g' | sed 's/^/      /g')
EOF
    cat > "$section_pipeline_metrics" <<EOF
    logs:
      receivers: [otlp]
      exporters: [$collector_exporter/metrics]
      processors: [batch]
EOF
    unset OTEL_EXPORTER_OTLP_METRICS_HEADERS
  fi
  if [ "${OTEL_TRACES_EXPORTER:-otlp}" = otlp ]; then
    if [ "${OTEL_EXPORTER_OTLP_PROTOCOL:-http/protobuf}" ]; then collector_exporter=otlphttp; else collector_exporter=otlp; fi
    cat > "$section_exporter_traces" <<EOF
  $collector_exporter/logs:
    endpoint: "${OTEL_EXPORTER_OTLP_TRACES_ENDPOINT:-$OTEL_EXPORTER_OTLP_ENDPOINT}"
    headers:
$(echo "$OTEL_EXPORTER_OTLP_HEADERS","$OTEL_EXPORTER_OTLP_TRACES_HEADERS" | tr ',' '\n' | grep -v '^$' | sed 's/=/: /g' | sed 's/^/      /g')
EOF
    cat > "$section_pipeline_traces" <<EOF
    logs:
      receivers: [otlp]
      exporters: [$collector_exporter/logs]
      processors: [batch]
EOF
    unset OTEL_EXPORTER_OTLP_TRACES_HEADERS
  fi
  unset OTEL_EXPORTER_OTLP_HEADERS
  cat > collector.yaml <<EOF
receivers:
  otlp:
    protocols:
      http:
        endpoint: localhost:4318
exporters:
$(cat $section_exporter_logs)
$(cat $section_exporter_metrics)
$(cat $section_exporter_traces)
processors:
  batch:
service:
  pipelines:
$(cat $section_pipeline_logs)
$(cat $section_pipeline_metrics)
$(cat $section_pipeline_traces)
EOF
  export OTEL_TRACES_EXPORTER=otlp
  export OTEL_EXPORTER_OTLP_ENDPOINT=https://localhost:4318
  export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
  unset OTEL_EXPORTER_OTLP_LOGS_ENDPOINT OTEL_EXPORTER_OTLP_METRICS_ENDPOINT OTEL_EXPORTER_OTLP_TRACES_ENDPOINT
  unset OTEL_LOGS_EXPORTER OTEL_METRICS_EXPORTER OTEL_TRACES_EXPORTER
  export OTEL_SHELL_COLLECTOR_IMAGE="$(cat Dockerfile | grep '^FROM ' | cut -d ' ' -f 2-)"
  sudo docker pull "$collector_image" &
#  if [ -n "$INPUT_DEBUG" ]; then
    cat collector.yaml
#  fi
fi
set +x

# resolve parent (does not exist yet - see workflow action) and make sure all jobs are of the same trace and have the same deferred parent 
opentelemetry_root_dir="$(mktemp -d)"
while ! gh_artifact_download "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" opentelemetry_workflow_run_"$GITHUB_RUN_ATTEMPT" "$opentelemetry_root_dir" || ! [ -r "$opentelemetry_root_dir"/traceparent ]; do
  . otelapi.sh
  otel_init
  otel_span_traceparent "$(otel_span_start INTERNAL dummy)" > "$opentelemetry_root_dir"/traceparent
  gh_artifact_upload "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" opentelemetry_workflow_run_"$GITHUB_RUN_ATTEMPT" "$opentelemetry_root_dir"/traceparent || true
  rm "$opentelemetry_root_dir"/traceparent
  otel_shutdown
done
export TRACEPARENT="$(cat "$opentelemetry_root_dir"/traceparent)"
rm -rf "$opentelemetry_root_dir"

export OTEL_SERVICE_NAME="${OTEL_SERVICE_NAME:-"$(echo "$GITHUB_REPOSITORY" | cut -d / -f 2-) CI"}"

# end job span
root4job_end() {
  if [ -f /tmp/opentelemetry_shell.github.error ]; then
    otel_span_attribute_typed "$span_handle" string github.actions.job.conclusion=failure
    otel_span_error "$span_handle"
  else
    otel_span_attribute_typed "$span_handle" string github.actions.job.conclusion=success
  fi
  otel_span_end "$span_handle"
  otel_shutdown
  [ -z "${OTEL_SHELL_COLLECTOR_CONTAINER:-}" ] || sudo docker stop "$OTEL_SHELL_COLLECTOR_CONTAINER"
  exit 0
}
export -f root4job_end

# start job span
root4job() {
  [ -z "${OTEL_SHELL_COLLECTOR_CONTAINER:-}" ] || export OTEL_SHELL_COLLECTOR_CONTAINER="$(sudo docker start --restart unless-stopped --network=host --mount type=bind,source="$(pwd)"/collector.yaml,target=/etc/otelcol/config.yaml "$OTEL_SHELL_COLLECTOR_IMAGE")"
  rm /tmp/opentelemetry_shell.github.error 2> /dev/null
  ( while true; do cat "$OTEL_SHELL_SDK_OUTPUT_REDIRECT"; done >> "$OTEL_SHELL_SDK_LOG_FILE" ) 1> /dev/null 2> /dev/null &
  traceparent_file="$1"
  . otelapi.sh
  otel_init
  span_handle="$(otel_span_start CONSUMER "${OTEL_SHELL_GITHUB_JOB:-$GITHUB_JOB}")"
  otel_span_attribute_typed $span_handle string github.actions.type=job
  if [ -n "$GITHUB_JOB_ID" ]; then
    otel_span_attribute_typed $span_handle string github.actions.url="${GITHUB_SERVER_URL:-https://github.com}"/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/job/"$GITHUB_JOB_ID"
  fi
  otel_span_attribute_typed $span_handle int github.actions.job.id="${GITHUB_JOB_ID:-}"
  otel_span_attribute_typed $span_handle string github.actions.job.name="${OTEL_SHELL_GITHUB_JOB:-$GITHUB_JOB}"
  otel_span_attribute_typed $span_handle string github.actions.runner.name="$RUNNER_NAME"
  otel_span_attribute_typed $span_handle string github.actions.runner.os="$RUNNER_OS"
  otel_span_attribute_typed $span_handle string github.actions.runner.arch="$RUNNER_ARCH"
  otel_span_attribute_typed $span_handle string github.actions.runner.environment="$RUNNER_ENVIRONMENT"
  otel_span_activate "$span_handle"
  echo "$TRACEPARENT" > "$traceparent_file"
  if [ -n "${GITHUB_JOB_ID:-}" ]; then
    opentelemetry_job_dir="$(mktemp -d)"
    echo "$TRACEPARENT" > "$opentelemetry_job_dir"/traceparent
    gh_artifact_upload "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" opentelemetry_job_"$GITHUB_JOB_ID" "$opentelemetry_job_dir"/traceparent
    rm -rf "$opentelemetry_job_dir"
  fi
  otel_span_deactivate "$span_handle"
  trap root4job_end SIGUSR1
  while true; do sleep 1; done
}
export -f root4job

# redirect output and create job span
tmp_dir="$(mktemp -d)"
chmod 777 "$tmp_dir"
echo otel_shell_sdk_output_redirect="${OTEL_SHELL_SDK_OUTPUT_REDIRECT:-/dev/null}" >> "$GITHUB_STATE"
export OTEL_SHELL_SDK_OUTPUT_REDIRECT="$(mktemp -u -p "$tmp_dir")"
mkfifo "$OTEL_SHELL_SDK_OUTPUT_REDIRECT"
chmod 777 "$OTEL_SHELL_SDK_OUTPUT_REDIRECT"
export OTEL_SHELL_SDK_LOG_FILE="$(mktemp -u -p "$tmp_dir")"
echo "log_file=$OTEL_SHELL_SDK_LOG_FILE" >> "$GITHUB_STATE"
traceparent_file="$(mktemp -u)"
nohup bash -c 'root4job "$@"' bash "$traceparent_file" &> /dev/null &
echo "pid=$!" >> "$GITHUB_STATE"

# wait for traceparent to be available
while ! [ -f "$traceparent_file" ]; do sleep 1; done
export TRACEPARENT="$(cat "$traceparent_file")"
rm "$traceparent_file"

# some default configurations
export OTEL_SHELL_CONFIG_MUTE_BUILTINS="${OTEL_SHELL_CONFIG_MUTE_BUILTINS:-TRUE}"
export OTEL_SHELL_CONFIG_INJECT_DEEP="${OTEL_SHELL_CONFIG_INJECT_DEEP:-TRUE}"
export OTEL_SHELL_CONFIG_OBSERVE_SUBPROCESSES="${OTEL_SHELL_CONFIG_OBSERVE_SUBPROCESSES:-TRUE}"
export OTEL_SHELL_CONFIG_OBSERVE_SIGNALS="${OTEL_SHELL_CONFIG_OBSERVE_SIGNALS:-TRUE}"
export OTEL_SHELL_CONFIG_OBSERVE_PIPES="${OTEL_SHELL_CONFIG_OBSERVE_PIPES:-TRUE}"

# propagate all config to all other actions
printenv | grep -E '^OTEL_|^TRACEPARENT=|^TRACESTATE=' >> "$GITHUB_ENV"
