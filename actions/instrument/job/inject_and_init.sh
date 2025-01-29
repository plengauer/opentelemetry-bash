#!/bin/bash
set -e

. ../shared/github.sh
bash -e ../shared/install.sh

echo "$GITHUB_ACTION" > /tmp/opentelemetry_shell_action_name

new_path_dir="/tmp/otel/bin"
mkdir -p "$new_path_dir"
gcc -o "$new_path_dir"/sh forward.c -DEXECUTABLE="$(which sh)" -DARG1="$(pwd)"/decorate_action_run.sh -DARG2="$(which sh)"
gcc -o "$new_path_dir"/dash forward.c -DEXECUTABLE="$(which dash)" -DARG1="$(pwd)"/decorate_action_run.sh -DARG2="$(which dash)"
gcc -o "$new_path_dir"/bash forward.c -DEXECUTABLE="$(which bash)" -DARG1="$(pwd)"/decorate_action_run.sh -DARG2="$(which bash)"
echo "$new_path_dir" >> "$GITHUB_PATH"

for node_path in /home/runner/runners/*/externals/node*/bin/node; do
  dir_path_new="$(echo "$node_path" | rev | cut -d / -f 2- | rev).original"
  mkdir "$dir_path_new"
  node_path_new="$dir_path_new"/node
  mv "$node_path" "$node_path_new"
  gcc -o "$node_path" forward.c -DEXECUTABLE=/bin/bash -DARG1="$(pwd)"/decorate_action_node.sh -DARG2="$node_path_new"
done

# cant use the same path trick as for the shells, because path is resolved at the very start, so paths must not change
docker_path="$(which docker)"
sudo mv "$docker_path" "$(pwd)"
sudo gcc -o "$docker_path" forward.c -DEXECUTABLE=/bin/bash -DARG1="$(pwd)"/decorate_action_docker.sh -DARG2="$(pwd)"/docker

jobs_json="$(mktemp)"
if gh_jobs "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" | jq .jobs[] | tee "$jobs_json" | jq -r '. | select(.status != "completed") | .name' | grep -q '^observe$'; then
  while ! gh_artifacts "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" | jq -r '.artifacts[].name' | grep -q '^opentelemetry$'; do sleep 3; done
  env_dir="$(mktemp -d)"
  gh_artifact_download "$GITHUB_RUN_ID" "$GITHUB_RUN_ATTEMPT" opentelemetry "$env_dir" || true
  if [ -f "$env_dir"/.env ]; then
    # mv "$env_dir"/.env "$env_dir"/.env.encrypted
    # cat "$env_dir"/.env.encrypted | base64 --decode | openssl enc -d -aes-256-cbc -pbkdf2 -pass pass:"$INPUT_GITHUB_TOKEN" > "$env_dir"/.env
    while read -r line; do
      export "$line"
    done < "$env_dir"/.env
  fi
  rm -r "$env_dir"
else
  printenv | grep '^INPUT_'
  OTEL_SHELL_GITHUB_JOB="$GITHUB_JOB"
  job_arguments="$(printf '%s' "$INPUT___JOB_MATRIX" | jq -r '. | [.. | scalars] | @tsv' | sed 's/\t/, /g')"
  if [ -n "$job_arguments" ]; then OTEL_SHELL_GITHUB_JOB="$OTEL_SHELL_GITHUB_JOB ($job_arguments)"; fi
  export OTEL_SHELL_GITHUB_JOB
  GITHUB_JOB_ID="$(cat "$jobs_json" | jq -r '. | [.id, .name] | @tsv' | sed 's/\t/ /g' | grep " $OTEL_SHELL_GITHUB_JOB"'$' | cut -d ' ' -f 1)"
  if [ "$(printf '%s' "$GITHUB_JOB_ID" | wc -l)" = 1 ]; then export GITHUB_JOB_ID; fi
  echo "Guessing GitHub job id to be $GITHUB_JOB_ID" >&2
  
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
fi
rm "$jobs_json"

export OTEL_SERVICE_NAME="${OTEL_SERVICE_NAME:-"$(echo "$GITHUB_REPOSITORY" | cut -d / -f 2-) CI"}"

root4job_end() {
  if [ -f /tmp/opentelemetry_shell.github.error ]; then
    otel_span_error "$span_handle"
  fi
  otel_span_end "$span_handle"
  otel_shutdown
  exit 0
}
export -f root4job_end

root4job() {
  rm /tmp/opentelemetry_shell.github.error 2> /dev/null
  ( while true; do cat "$OTEL_SHELL_SDK_OUTPUT_REDIRECT"; done >> "$OTEL_SHELL_SDK_LOG_FILE" ) 1> /dev/null 2> /dev/null &
  traceparent_file="$1"
  . otelapi.sh
  otel_init
  span_handle="$(otel_span_start CONSUMER "$GITHUB_WORKFLOW / $GITHUB_JOB")"
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

tmp_dir="$(mktemp -d)"
chmod 777 "$tmp_dir"
export OTEL_SHELL_SDK_OUTPUT_REDIRECT="$(mktemp -u -p "$tmp_dir")"
mkfifo "$OTEL_SHELL_SDK_OUTPUT_REDIRECT"
chmod 777 "$OTEL_SHELL_SDK_OUTPUT_REDIRECT"
export OTEL_SHELL_SDK_LOG_FILE="$(mktemp -u -p "$tmp_dir")"
echo "log_file=$OTEL_SHELL_SDK_LOG_FILE" >> "$GITHUB_STATE"
traceparent_file="$(mktemp -u)"
nohup bash -c 'root4job "$@"' bash "$traceparent_file" &> /dev/null &
echo "pid=$!" >> "$GITHUB_STATE"

while ! [ -f "$traceparent_file" ]; do sleep 1; done
export TRACEPARENT="$(cat "$traceparent_file")"
rm "$traceparent_file"

export OTEL_SHELL_CONFIG_INJECT_DEEP="${OTEL_SHELL_CONFIG_INJECT_DEEP:-TRUE}"
export OTEL_SHELL_CONFIG_OBSERVE_SUBPROCESSES="${OTEL_SHELL_CONFIG_OBSERVE_SUBPROCESSES:-TRUE}"
export OTEL_SHELL_CONFIG_OBSERVE_SIGNALS="${OTEL_SHELL_CONFIG_OBSERVE_SIGNALS:-TRUE}"
export OTEL_SHELL_CONFIG_OBSERVE_PIPES="${OTEL_SHELL_CONFIG_OBSERVE_PIPES:-TRUE}"

printenv | grep -E '^OTEL_|^TRACEPARENT=|^TRACESTATE=' >> "$GITHUB_ENV"
