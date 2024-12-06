#!/bin/bash
set -e

my_dir="$(echo "$0" | rev | cut -d / -f 2- | rev)"
. "$my_dir"/../shared/github.sh
bash -e "$my_dir"/../shared/install.sh

echo "$GITHUB_ACTION" > /tmp/opentelemetry_shell_action_name

new_path_dir="/tmp/otel/bin"
mkdir -p "$new_path_dir"
gcc -o "$new_path_dir"/sh "$my_dir"/forward.c -DEXECUTABLE="$(which sh)" -DARG1="$my_dir"/decorate_action_run.sh -DARG2="$(which sh)"
gcc -o "$new_path_dir"/dash "$my_dir"/forward.c -DEXECUTABLE="$(which dash)" -DARG1="$my_dir"/decorate_action_run.sh -DARG2="$(which dash)"
gcc -o "$new_path_dir"/bash "$my_dir"/forward.c -DEXECUTABLE="$(which bash)" -DARG1="$my_dir"/decorate_action_run.sh -DARG2="$(which bash)"
echo "$new_path_dir" >> "$GITHUB_PATH"

for node_path in /home/runner/runners/*/externals/node*/bin/node; do
  dir_path_new="$(echo "$node_path" | rev | cut -d / -f 2- | rev).original"
  mkdir "$dir_path_new"
  node_path_new="$dir_path_new"/node
  mv "$node_path" "$node_path_new"
  gcc -o "$node_path" "$my_dir"/forward.c -DEXECUTABLE=/bin/bash -DARG1="$my_dir"/decorate_action_node.sh -DARG2="$node_path_new"
done

# cant use the same path trick as for the shells, because path is resolved at the very start, so paths must not change
docker_path="$(which docker)"
sudo mv "$docker_path" "$my_dir"
sudo gcc -o "$docker_path" "$my_dir"/forward.c -DEXECUTABLE=/bin/bash -DARG1="$my_dir"/decorate_action_docker.sh -DARG2="$my_dir"/docker

if github_workflow jobs | jq -r '.jobs[] | select(.status != "completed") | .name' | grep -q '^observe$'; then
  while ! github_workflow artifacts | jq -r '.artifacts[].name' | grep -q '^opentelemetry$'; do sleep 3; done
fi
env_dir="$(mktemp -d)"
node download_artifact.js opentelemetry "$env_dir" || true
if [ -f "$env_dir"/.env ]; then
  while read -r line; do
    export "$line"
  done < "$env_dir"/.env
fi
rm -r "$env_dir"

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
