ARG image
ARG update
ARG shell

FROM $image
ARG shell
ARG update
WORKDIR /tests

RUN apt-get update
COPY . ./
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ./package.deb && rm ./package.deb

RUN [ "$update" = TRUE ] && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y || true
RUN type "$shell" || DEBIAN_FRONTEND=noninteractive apt-get install -y "$shell"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jq psmisc wget curl debconf debconf-utils time sudo parallel moreutils ncat wget2 strace nodejs npm python3 python3-pip python3-venv

ENV shell="$shell"

CMD bash run_tests.sh "$shell"
