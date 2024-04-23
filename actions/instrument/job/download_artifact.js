const artifact = require('@actions/artifact');
const artifactName = process.argv[2];
const outputPath = process.argv[3];
artifact.create().downloadArtifact(artifactName, outputPath);
