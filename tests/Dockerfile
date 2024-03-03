ARG image
ARG shell

FROM $image
ARG shell
WORKDIR /tests

RUN apt-get update
COPY . ./
RUN apt-get dist-upgrade -y
RUN apt-get install -y jq psmisc wget curl debconf time sudo moreutils
RUN apt-get install -y $shell || true
RUN apt-get install -y ./package.deb && rm ./package.deb
ENV shell=$shell

CMD bash run_tests.sh $shell
