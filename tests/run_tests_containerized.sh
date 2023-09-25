#!/bin/bash
sudo docker build --build-arg=image=$1 --build-arg=shell=$2 --tag test --network=host .
sudo docker run --name test test
exit_code=$?
sudo docker container rm test
sudo docker image rm test
exit $exit_code
