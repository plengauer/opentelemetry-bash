const artifact = require('@actions/artifact');
const artifactName = process.argv[2];
const outputPath = process.argv[3];
artifact.downloadArtifact(artifactName, outputPath);
