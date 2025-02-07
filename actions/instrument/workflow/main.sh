#/bin/bash
set -e
if [ -z "${INPUT_WORKFLOW_RUN_ID:-}" ] && [ -z "${INPUT_WORKFLOW_RUN_ATTEMPT:-}" ] && "$GITHUB_JOB" = observe; then exec bash ./main_legacy.sh; fi

. ../shared/github.sh
OTEL_SHELL_CONFIG_INSTALL_DEEP=FALSE bash -e ../shared/install.sh

export OTEL_SERVICE_NAME="${OTEL_SERVICE_NAME:-"$(echo "$GITHUB_REPOSITORY" | cut -d / -f 2-) CI"}"

workflow_json="$(mktemp)"
jq < "$GITHUB_EVENT_PATH" > "$workflow_json" .workflow_run
if [ "$INPUT_WORKFLOW_RUN_ID" != "$(jq < "$workflow_json" .id)" ] || [ "$INPUT_WORKFLOW_RUN_ATTEMPT" != "$(jq < "$workflow_json" .run_attempt)" ]; then gh_workflow_run "$INPUT_WORKFLOW_RUN_ID" "$INPUT_WORKFLOW_RUN_ATTEMPT" > "$workflow_json"; fi
if [ "$(jq < "$workflow_json" -r .status)" != completed ]; then exit 1; fi

jobs_json="$(mktemp)"
gh_jobs "$INPUT_WORKFLOW_RUN_ID" "$INPUT_WORKFLOW_RUN_ATTEMPT" | jq .jobs[] > "$jobs_json"

artifacts_json="$(mktemp)"
gh_artifacts "$INPUT_WORKFLOW_RUN_ID" | jq -r .artifacts[] > "$artifacts_json"

echo "::notice ::Observing $(jq < "$workflow_json" -r .html_url)"

record_attributes() {
  local span_handle="$1"
  otel_span_attribute_typed $span_handle string github.workflow.name="$(jq < "$workflow_json" -r .name)"
  otel_span_attribute_typed $span_handle int github.workflow_run.id="$(jq < "$workflow_json" .id)"
  otel_span_attribute_typed $span_handle int github.workflow_run.attempt="$(jq < "$workflow_json" .run_attempt)"
  otel_span_attribute_typed $span_handle int github.workflow_run.number="$(jq < "$workflow_json" .run_number)"
  otel_span_attribute_typed $span_handle int github.actor.id="$(jq < "$workflow_json" .actor.id)"
  otel_span_attribute_typed $span_handle string github.actor.name="$(jq < "$workflow_json" -r .actor.login)"
  otel_span_attribute_typed $span_handle string github.event.name="$(jq < "$workflow_json" -r .event)"
  otel_span_attribute_typed $span_handle string github.event.ref="/refs/heads/$(jq < "$workflow_json" -r .head_branch)"
  otel_span_attribute_typed $span_handle string github.event.ref.sha="$(jq < "$workflow_json" -r .head_sha)"
  otel_span_attribute_typed $span_handle string github.event.ref.name="$(jq < "$workflow_json" -r .head_branch)"
}

. otelapi.sh
export OTEL_DISABLE_RESOURCE_DETECTION=TRUE # TODO re-add resource attributes based on workflow
_otel_resource_attributes_process() {
  :
}
gh_artifact_download "$INPUT_WORKFLOW_RUN_ID" "$INPUT_WORKFLOW_RUN_ATTEMPT" opentelemetry_workflow_run_"$INPUT_WORKFLOW_RUN_ATTEMPT" opentelemetry_workflow_run || true
if [ -r opentelemetry_workflow_run/traceparent ]; then export OTEL_ID_GENERATOR_OVERRIDE_TRACEPARENT="$(cat opentelemetry_workflow_run/traceparent)"; fi
rm -rf opentelemetry_workflow_run
otel_init

workflow_span_handle="$(otel_span_start @"$(jq < "$workflow_json" -r .run_started_at)" CONSUMER "$(jq < "$workflow_json" -r .name)")"
record_attributes "$workflow_span_handle"
otel_span_activate "$workflow_span_handle"
jq < "$jobs_json" -r '. | [.id, .conclusion, .started_at, .completed_at, .name] | @tsv' | sed 's/\t/ /g' | while read -r job_id job_conclusion job_started_at job_completed_at job_name; do
  if jq < "$artifacts_json" -r .name | grep -q '^opentelemetry_job_'"$job_id"'$'; then continue; fi
  job_span_handle="$(otel_span_start @"$job_started_at" CONSUMER "$job_name")"
  otel_span_attribute_typed $job_span_handle int github.job.id="$job_id"
  otel_span_attribute_typed $job_span_handle string github.job.name="$job_name"
  record_attributes "$job_span_handle"
  otel_span_activate "$job_span_handle"
  jq < "$jobs_json" -r '. | select(.id == '"$job_id"') | .steps[] | [.conclusion, .started_at, .completed_at, .name] | @tsv' | sed 's/\t/ /g' | while read -r step_conclusion step_started_at step_completed_at step_name; do
    step_span_handle="$(otel_span_start @"$step_started_at" INTERNAL "$step_name")"
    otel_span_attribute_typed $step_span_handle string github.step.name="$step_name"
    otel_span_attribute_typed $step_span_handle int github.job.id="$job_id"
    otel_span_attribute_typed $step_span_handle string github.job.name="$job_name"
    record_attributes "$step_span_handle"
    # TODO fetch logs?
    if [ "$step_conclusion" = failure ]; then otel_span_error "$job_span_handle"; fi
    otel_span_end "$step_span_handle" @"$step_completed_at"
  done
  otel_span_deactivate "$job_span_handle"
  if [ "$job_conclusion" = failure ]; then otel_span_error "$job_span_handle"; fi
  otel_span_end "$job_span_handle" @"$job_completed_at"
done
otel_span_deactivate "$workflow_span_handle"
if [ "$(jq < "$workflow_json" .conclusion -r)" = failure ]; then otel_span_error "$workflow_span_handle"; fi
otel_span_end "$workflow_span_handle" @"$(jq < "$jobs_json" -r .completed_at | sort -r | head -n 1)"

otel_shutdown
