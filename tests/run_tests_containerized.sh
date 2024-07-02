#!/bin/bash -e
set -e
retry=1
while [ "$retry" -lt $((60 * 60 * 3)) ] && ! sudo docker build --build-arg=image="$1" --build-arg=update="$2" --build-arg=shell="$3" --tag test --network=host .; do sleep "$retry"; retry=$((retry * 2)); done
exit_code=0
sudo docker run --rm --name test --network=host test || exit_code=$?
sudo docker image rm test || true
exit $exit_code
