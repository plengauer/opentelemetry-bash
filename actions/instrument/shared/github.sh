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

gh_workflow_run() {
  gh_curl /actions/runs/"$1"/attempts/"$2"
}

gh_jobs() {
  gh_curl_paginated /actions/runs/"$1"/attempts/"$2"/jobs'?per_page=100'
}

gh_job() {
  gh_curl /actions/jobs/"$3"
}

gh_artifacts() {
  gh_curl_paginated /actions/runs/"$GITHUB_RUN_ID"/attempts/"$GITHUB_RUN_ATTEMPT"/artifacts'?per_page=100'
}

gh_artifact_download() {
  node -e '
    const { DefaultArtifactClient } = require("@actions/artifact");
    const artifactName = process.argv[2];
    const outputPath = process.argv[3];
    const client = new DefaultArtifactClient()
    const findBy = {
      token: "'"$INPUT_GITHUB_TOKEN"'",
      repositoryOwner: "'"${GITHUB_REPOSITORY%%/*}"'",
      repositoryName: "'"${GITHUB_REPOSITORY#*/}"'",
      workflowRunId: '"$1"',
    }
    client.listArtifacts({ findBy })
      .then(response => response.artifacts.find(artifact => artifact.name == artifactName)?.id)
      .then(id => id ? client.downloadArtifact(id, { path: outputPath, findBy }) : null);
  ' "$3" "$4"
}

gh_artifact_upload() {
  node -e '
    const path = require("path");
    const { DefaultArtifactClient } = require("@actions/artifact");
    const artifactName = process.argv[2];
    const fullPath = process.argv[3];
    new DefaultArtifactClient().uploadArtifact(artifactName, [ fullPath ], path.dirname(fullPath));
  ' "$3" "$4"
}

gh_artifact_delete() {
  node -e '
    const { DefaultArtifactClient } = require("@actions/artifact");
    const artifactName = process.argv[2];
    new DefaultArtifactClient().deleteArtifact(artifactName);
  ' "$3"
}
