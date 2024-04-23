const artifact = require('@actions/artifact');
const path = require('path');
const fs = require('fs');
const artifactName = process.argv[2];
const filePath = process.argv[3];
const fullPath = path.resolve(filePath);
const rootDirectory = path.dirname(fullPath);
const options = { continueOnError: false };
artifact.create().uploadArtifact(artifactName, [ fullPath ], rootDirectory, options);
