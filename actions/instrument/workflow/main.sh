#/bin/bash
set -e
if [ -z "${INPUT_WORKFLOW_RUN_ID:-}" ] && [ -z "${INPUT_WORKFLOW_RUN_ATTEMPT:-}" ] && "$GITHUB_JOB" = observe; then exec bash ./main_legacy.sh; fi

. ../shared/github.sh
# TODO check based on input workflow run id, if this is same as own workflow id, cancel ourselves
OTEL_SHELL_CONFIG_INSTALL_DEEP=FALSE bash -e ../shared/install.sh

export OTEL_SERVICE_NAME="${OTEL_SERVICE_NAME:-"$(echo "$GITHUB_REPOSITORY" | cut -d / -f 2-) CI"}" # TODO where to get this from?

# TODO for now debug outout
export OTEL_TRACES_EXPORTER=console
export OTEL_SHELL_SDK_OUTPUT_REDIRECT=/dev/stderr

. otelapi.sh
# TODO configure sdk to not use resource detectors
# TODO configure api to not record process level resource attributes
# TODO what to use as span service? could we also get it from a foreign artifact?
trace_id=123 # TODO get it from a foreign artifact from the workflow
span_id=123 # TODO get it from a foreign artifact from the workflow
# TODO configure sdk to use the above trace_id and span_id if available for the first root span 
otel_init

workflow_json="$(mktemp)"
jq < "$GITHUB_EVENT_PATH" > "$workflow_json" .workflow_run
workflow_span_handle="$(otel_span_start CONSUMER "$(jq < "$workflow_json" -r .name)")" # TODO fix start time
otel_span_activate "$workflow_span_handle"
gh_curl_paginated /actions/runs/"$INPUT_WORKFLOW_RUN_ID"/attempt/"$INPUT_WORKFLOW_RUN_ATTEMPT"/jobs'?page=100' | jq -r '.jobs[] | [.id, .conclusion, .started_at, .completed_at, .name] | @csv' | while IFS=, read -r job_id job_conclusion job_started_at job_completed_at job_name; do
  # TODO check if job has been created by checking the artifacts, if so continue
  # TODO of not continue, and check which steps are missing?
  job_span_handle="$(otel_span_start CONSUMER "$job_name)")" # TODO fix start time
  otel_span_activate "$job_span_handle"
  gh_curl /actions/runs/"$INPUT_WORKFLOW_RUN_ID"/attempt/"$INPUT_WORKFLOW_RUN_ATTEMPT"/jobs/"$job_id" | jq -r '.steps[] | [.conclusion, .started_at, .completed_at, .name] | @csv' | while IFS=, read -r step_conclusion step_started_at step_completed_at step_name; do
    step_span_handle="$(otel_span_start INTERNAL "$step_name)")" # TODO fix start time
    # TODO fetch logs?
    if [ "$step_conclusion" = failure ]; then otel_span_error "$job_span_handle"; fi
    otel_span_end "$step_span_handle" # TODO fix end time
  done
  otel_span_deactivate "$job_span_handle"
  if [ "$job_conclusion" = failure ]; then otel_span_error "$job_span_handle"; fi
  otel_span_end "$job_span_handle" # TODO fix end time
done
otel_span_deactivate "$workflow_span_handle"
# TODO mark span as failed if conclusion is failure
otel_span_end "$workflow_span_handle" # TODO fix end time
otel_shutdown
