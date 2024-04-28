const path = require('path');
const { DefaultArtifactClient } = require('@actions/artifact');
const artifactName = process.argv[2];
const fullPath = process.argv[3];
new DefaultArtifactClient().uploadArtifact(artifactName, [ fullPath ], path.dirname(fullPath));
