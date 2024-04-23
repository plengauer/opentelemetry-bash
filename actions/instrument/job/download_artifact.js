const artifact = require('@actions/artifact');
const artifactClient = artifact.create();
const artifactName = process.argv[2];
const outputPath = process.argv[3];
artifactClient.downloadArtifact(artifactName, outputPath);
