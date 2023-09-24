ARG image=ubuntu:latest
ARG shell=bash

FROM $image
WORKDIR /tests

COPY . ./
RUN apt-get install ./package.deb

CMD bash run_tests.sh $shell
