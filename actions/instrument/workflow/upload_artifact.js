const artifact = require('@actions/artifact');
const artifactClient = artifact.create();

const artifactName = process.argv[2];
const file = process.argv[3];

const rootDirectory = file; // adapt this if your file is not at the root
const options = {
  continueOnError: false
};

artifactClient.uploadArtifact(artifactName, [file], rootDirectory, options);
