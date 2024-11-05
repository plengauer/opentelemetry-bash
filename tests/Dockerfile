ARG image
ARG update
ARG shell

FROM $image
ARG shell
ARG update
WORKDIR /tests
COPY . ./

RUN <<EOF
  packages="jq psmisc wget curl debconf debconf-utils time sudo parallel moreutils ncat wget2 strace nodejs npm python3 python3-pip"
  if type apt-get; then
    apt-get update
    [ "$update" = TRUE ] && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y || true
    DEBIAN_FRONTEND=noninteractive apt-get install -y ./package.deb && rm ./package.deb
    type "$shell" || DEBIAN_FRONTEND=noninteractive apt-get install -y "$shell"
    DEBIAN_FRONTEND=noninteractive apt-get install -y $packages
  elif type dnf; then
    [ "$update" = TRUE ] && dnf -y upgrade --refresh
    dnf -y install ./package.rpm
    type "$shell" || dnf -y install "$shell"
    dnf -y install $packages
  elif type yum; then
    [ "$update" = TRUE ] && yum -y upgrade
    yum -y install ./package.rpm
    type "$shell" || yum -y install "$shell"
    yum -y install $packages
  elif type zypper; then
    [ "$update" = TRUE ] && zypper --non-interactive update
    zypper --non-interactive install --allow-unsigned-rpm ./package.rpm
    type "$shell" || zypper --non-interactive install "$shell"
    zypper --non-interactive install $packages
  else
    exit 1
  fi
EOF

ENV shell="$shell"

CMD ! type "$shell" || bash run_tests.sh "$shell"
