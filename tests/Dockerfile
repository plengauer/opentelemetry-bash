ARG image=ubuntu:latest
ARG shell=bash

FROM $image
WORKDIR /tests

RUN apt-get update
COPY . ./
RUN apt-get install -y jq
RUN apt-get install -y ./package.deb && rm ./package.deb

CMD bash run_tests.sh $shell
