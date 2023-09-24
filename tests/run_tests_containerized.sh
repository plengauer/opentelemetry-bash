#!/bin/bash
set -e
sudo apt-get intall -y docker.io
sudo docker build . --build-arg image=$1 --build-arg shell=$2 --tag test
sudo docker run test --name test
sudo docker container rm test
sudo docker image rm test
