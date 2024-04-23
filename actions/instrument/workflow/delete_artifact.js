const artifact = require('@actions/artifact');
const artifactClient = artifact.create();
const artifactName = process.argv[2];
artifactClient.deleteArtifact(artifactName);
