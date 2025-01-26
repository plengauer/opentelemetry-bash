const { DefaultArtifactClient } = require('@actions/artifact');
const artifactName = process.argv[2];
new DefaultArtifactClient().deleteArtifact(artifactName);
