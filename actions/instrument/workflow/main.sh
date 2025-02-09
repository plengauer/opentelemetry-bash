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

. otelapi.sh
export OTEL_DISABLE_RESOURCE_DETECTION=TRUE
_otel_resource_attributes_process() {
  _otel_resource_attribute string github.repository.id="$(jq < "$workflow_json" -r .repository.id)"
  _otel_resource_attribute string github.repository.name="$(jq < "$workflow_json" -r .repository.name)"
  _otel_resource_attribute string github.repository.owner.id="$(jq < "$workflow_json" -r .repository.owner.id)"
  _otel_resource_attribute string github.repository.owner.name="$(jq < "$workflow_json" -r .repository.owner.login)"
  _otel_resource_attribute string github.actions.workflow.id="$(jq < "$workflow_json" -r .workflow_id)"
  _otel_resource_attribute string github.actions.workflow.name="$(jq < "$workflow_json" -r .name)"
  _otel_resource_attribute string github.actions.workflow.ref="$(jq < "$workflow_json" -r .repository.owner.login)"/"$(jq < "$workflow_json" -r .repository.name)"/"$(jq < "$workflow_json" -r .path)"@/refs/heads/"$(jq < "$workflow_json" -r .head_branch)"
  _otel_resource_attribute string github.actions.workflow.sha="$(jq < "$workflow_json" -r .head_sha)"
}
gh_artifact_download "$INPUT_WORKFLOW_RUN_ID" "$INPUT_WORKFLOW_RUN_ATTEMPT" opentelemetry_workflow_run_"$INPUT_WORKFLOW_RUN_ATTEMPT" opentelemetry_workflow_run || true
if [ -r opentelemetry_workflow_run/traceparent ]; then export OTEL_ID_GENERATOR_OVERRIDE_TRACEPARENT="$(cat opentelemetry_workflow_run/traceparent)"; fi
rm -rf opentelemetry_workflow_run
otel_init

link="${GITHUB_SERVER_URL:-https://github.com}"/"$(jq < "$workflow_json" -r .repository.owner.login)"/"$(jq < "$workflow_json" -r .repository.name)"/actions/runs/"$(jq < "$workflow_json" -r .id)"
workflow_started_at="$(jq < "$workflow_json" -r .run_started_at)"
workflow_span_handle="$(otel_span_start @"$workflow_started_at" CONSUMER "$(jq < "$workflow_json" -r .name)")"
otel_span_attribute_typed $workflow_span_handle string github.actions.type=workflow
otel_span_attribute_typed $workflow_span_handle string github.actions.url="$link"/attempts/"$(jq < "$workflow_json" -r .run_attempt)"
otel_span_attribute_typed $workflow_span_handle string github.actions.workflow.id="$(jq < "$workflow_json" -r .workflow_id)"
otel_span_attribute_typed $workflow_span_handle string github.actions.workflow.name="$(jq < "$workflow_json" -r .name)"
otel_span_attribute_typed $workflow_span_handle int github.actions.workflow_run.id="$(jq < "$workflow_json" .id)"
otel_span_attribute_typed $workflow_span_handle int github.actions.workflow_run.attempt="$(jq < "$workflow_json" .run_attempt)"
otel_span_attribute_typed $workflow_span_handle int github.actions.workflow_run.number="$(jq < "$workflow_json" .run_number)"
otel_span_attribute_typed $workflow_span_handle string github.workflow_run.conclusion="$(jq < "$workflow_json" -r .conclusion)"
otel_span_attribute_typed $workflow_span_handle int github.actions.actor.id="$(jq < "$workflow_json" .actor.id)"
otel_span_attribute_typed $workflow_span_handle string github.actions.actor.name="$(jq < "$workflow_json" -r .actor.login)"
otel_span_attribute_typed $workflow_span_handle string github.actions.event.name="$(jq < "$workflow_json" -r .event)"
otel_span_attribute_typed $workflow_span_handle string github.actions.event.ref="/refs/heads/$(jq < "$workflow_json" -r .head_branch)"
otel_span_attribute_typed $workflow_span_handle string github.actions.event.ref.sha="$(jq < "$workflow_json" -r .head_sha)"
otel_span_attribute_typed $workflow_span_handle string github.actions.event.ref.name="$(jq < "$workflow_json" -r .head_branch)"
otel_span_activate "$workflow_span_handle"
jq < "$jobs_json" -r '. | [.id, .conclusion, .started_at, .completed_at, .name] | @tsv' | sed 's/\t/ /g' | while read -r job_id job_conclusion job_started_at job_completed_at job_name; do
  if [[ "$job_started_at" < "$workflow_started_at" ]]; then continue; fi
  if jq < "$artifacts_json" -r .name | grep -q '^opentelemetry_job_'"$job_id"'$'; then continue; fi
  job_span_handle="$(otel_span_start @"$job_started_at" CONSUMER "$job_name")"
  otel_span_attribute_typed $job_span_handle string github.actions.type=job
  otel_span_attribute_typed $job_span_handle string github.actions.url="$link"/job/"$job_id"
  otel_span_attribute_typed $job_span_handle int github.actions.job.id="$job_id"
  otel_span_attribute_typed $job_span_handle string github.actions.job.name="$job_name"
  otel_span_attribute_typed $job_span_handle string github.actions.job.conclusion="$job_conclusion"
  otel_span_activate "$job_span_handle"
  jq < "$jobs_json" -r '. | select(.id == '"$job_id"') | .steps[] | [.number, .conclusion, .started_at, .completed_at, .name] | @tsv' | sed 's/\t/ /g' | while read -r step_number step_conclusion step_started_at step_completed_at step_name; do
    step_span_handle="$(otel_span_start @"$step_started_at" INTERNAL "$step_name")"
    otel_span_attribute_typed $step_span_handle string github.actions.type=step
    otel_span_attribute_typed $step_span_handle string github.actions.url="$link"/job/"$job_id"'#'step:"$step_number":1
    otel_span_attribute_typed $step_span_handle string github.actions.step.name="$step_name"
    otel_span_attribute_typed $step_span_handle string github.actions.step.conclusion="$step_conclusion"
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
