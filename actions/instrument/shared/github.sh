#!/bin/false

gh_curl() {
  curl --no-progress-meter -H "Authorization: Bearer $INPUT_GITHUB_TOKEN" "${GITHUB_API_URL:-https://api.github.com}"/repos/"$GITHUB_REPOSITORY""$@"
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

gh_jobs() {
  gh_curl_paginated /actions/runs/"$1"/attempt/"$2"/jobs'?page=100'
}

gh_job() {
  gh_curl /actions/runs/"$1"/attempt/"$2"/jobs/"$3"
}

gh_download_artifact() {
  node -e '
    const { DefaultArtifactClient } = require("@actions/artifact");
    const artifactName = process.argv[2];
    const outputPath = process.argv[3];
    const client = new DefaultArtifactClient()
    client.listArtifacts()
      .then(response => response.artifacts.find(artifact => artifact.name == artifactName)?.id)
      .then(id => id ? client.downloadArtifact(id, { path: outputPath }) : null);
  ' "$@"
}

gh_upload_artifact() {
  node -e '
    const path = require('path');
    const { DefaultArtifactClient } = require('@actions/artifact');
    const artifactName = process.argv[2];
    const fullPath = process.argv[3];
    new DefaultArtifactClient().uploadArtifact(artifactName, [ fullPath ], path.dirname(fullPath));
  ' "$@"
}

gh_delete_artifact() {
  node -e '
    const { DefaultArtifactClient } = require('@actions/artifact');
    const artifactName = process.argv[2];
    new DefaultArtifactClient().deleteArtifact(artifactName);
  ' "$@"
}
