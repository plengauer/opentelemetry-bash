const { DefaultArtifactClient } = require('@actions/artifact');
const artifactName = process.argv[2];
const outputPath = process.argv[3];
new DefaultArtifactClient().downloadArtifact(artifactName, outputPath);
