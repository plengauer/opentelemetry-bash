#!/bin/bash -e
set -e
sudo docker build --build-arg=image="$1" --build-arg=update="$2" --build-arg=shell="$3" --tag test --network=host .
exit_code=0
sudo docker run --rm --name test --network=host test || exit_code=$?
sudo docker image rm test || true
exit $exit_code
