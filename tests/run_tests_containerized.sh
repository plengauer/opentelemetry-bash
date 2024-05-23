#!/bin/bash
sudo docker build --build-arg=image=$1 --build-arg=update=$2 --build-arg=shell=$3 --tag test --network=host .
sudo docker run --name test --network=host test
exit_code=$?
sudo docker container rm test
sudo docker image rm test
exit $exit_code
