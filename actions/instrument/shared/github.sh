#!/bin/false

gh_curl() {
  curl --no-progress-meter --fail --retry 16 -H "Authorization: Bearer $INPUT_GITHUB_TOKEN" "${GITHUB_API_URL:-https://api.github.com}"/repos/"$GITHUB_REPOSITORY""$@"
}
export -f gh_curl

gh_curl_paginated() {
  {
    gh_curl "$@" --head | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
      | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
      | grep '^page=' | cut -d = -f 2 \
      | xargs seq 1 || true
  } | while read -r page; do echo "$@"'&page='"$page"; done | xargs parallel gh_curl :::
}
export -f gh_curl_paginated

gh_releases() {
  GITHUB_REPOSITORY="$GITHUB_ACTION_REPOSITORY" gh_curl_paginated /releases'?per_page=100'
}
export -f gh_releases

gh_workflow_runs() {
  gh_curl_paginated /actions/runs'?per_page=100'
}
export -f gh_workflow_runs

gh_workflow_run() {
  gh_curl /actions/runs/"$1"/attempts/"$2"
}
export -f gh_workflow_run

gh_jobs() {
  gh_curl_paginated /actions/runs/"$1"/attempts/"$2"/jobs'?per_page=100'
}
export -f gh_jobs

gh_job() {
  gh_curl /actions/jobs/"$3"
}
export -f gh_job

gh_artifacts() {
  gh_curl_paginated /actions/runs/"$1"/artifacts'?per_page=100'
}
export -f gh_artifacts

gh_artifact_download() {
  local artifact_filename="$(mktemp)"
  gh_curl /actions/runs/"$1"/artifacts'?per_page=1&'name="$3" | tee /dev/stderr | jq '.artifacts[0].id' | grep -v '^null$' | xargs -t -r -I '{}' bash -xc 'gh_curl "$@"' bash /actions/artifacts/'{}'/zip --head | tr -d '\r' | grep '^location:' | cut -d ' ' -f 2- | xargs -t -r wget -O "$artifact_filename" && [ -r "$artifact_filename" ] && unzip "$artifact_filename" -d "$4"
}
export -f gh_artifact_download

gh_artifact_upload() {
  node -e '
    const path = require("path");
    const { DefaultArtifactClient } = require("@actions/artifact");
    new DefaultArtifactClient().uploadArtifact("'"$3"'", [ "'"$4"'" ], path.dirname("'"$4"'"));
  '
}
export -f gh_artifact_upload

gh_artifact_delete() {
  node -e '
    const { DefaultArtifactClient } = require("@actions/artifact");
    new DefaultArtifactClient().deleteArtifact("'"$3"'");
  '
}
export -f gh_artifact_delete
