const artifact = require('@actions/artifact');
const artifactName = process.argv[1];
artifact.create().deleteArtifact(artifactName);
