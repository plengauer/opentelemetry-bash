ARG image
ARG update
ARG shell

FROM $image
WORKDIR /tests

RUN apt-get update
COPY . ./
RUN apt-get install -y ./package.deb && rm ./package.deb

RUN [ "$update" = TRUE ] && apt-get dist-upgrade -y || true
RUN type "$shell" || apt-get install -y "$shell"

RUN apt-get install -y jq psmisc wget curl debconf time sudo parallel moreutils

ENV shell="$shell"

CMD bash run_tests.sh "$shell"
