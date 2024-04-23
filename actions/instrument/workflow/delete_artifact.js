const artifact = require('@actions/artifact');
const artifactName = process.argv[2];
artifact.create().deleteArtifact(artifactName);
