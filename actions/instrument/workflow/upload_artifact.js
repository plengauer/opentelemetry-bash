const { DefaultArtifactClient } = require('@actions/artifact');
const path = require('path');
const fs = require('fs');
const artifactName = process.argv[2];
const fullPath = process.argv[3];
new DefaultArtifactClient().uploadArtifact(artifactName, [ fullPath ]);
