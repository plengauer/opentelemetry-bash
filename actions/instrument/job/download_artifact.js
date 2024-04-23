const path = require('path');
const { DefaultArtifactClient } = require('@actions/artifact');
const artifactName = process.argv[2];
const outputPath = process.argv[3];
const client = new DefaultArtifactClient()
client.listArtifacts()
  .then(response => response.artifacts.find(artifact => artifact.name == artifactName).id))
  .then(id => client.downloadArtifact(id, { path: path.dirname(outputPath) }));
