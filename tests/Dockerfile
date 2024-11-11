ARG image
ARG update
ARG shell

FROM $image
ARG shell
ARG update
WORKDIR /tests
COPY . ./

RUN <<EOF
  packages_mandatory="jq psmisc wget curl time sudo gcc"
  packages_optional="parallel moreutils ncat wget2 nodejs npm python3 python3-pip"
  if type apt-get; then
    apt-get update
    [ "$update" = TRUE ] && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y || true
    DEBIAN_FRONTEND=noninteractive apt-get install -y ./package.deb && rm ./package.deb
    type "$shell" || DEBIAN_FRONTEND=noninteractive apt-get install -y "$shell"
    DEBIAN_FRONTEND=noninteractive apt-get install -y $packages_mandatory debconf debconf-utils python3-venv
    DEBIAN_FRONTEND=noninteractive apt-get install -y $packages_optional || true
  elif type dnf; then
    [ "$update" = TRUE ] && dnf -y upgrade --refresh
    dnf -y install ./package.rpm
    type "$shell" || dnf -y install "$shell"
    dnf -y install $packages_mandatory
    dnf -y install $packages_optional || true
  elif type yum; then
    [ "$update" = TRUE ] && yum -y upgrade
    yum -y install ./package.rpm
    type "$shell" || yum -y install "$shell"
    yum -y install $packages_mandatory
    yum -y install $packages_optional || true
  elif type zypper; then
    [ "$update" = TRUE ] && zypper --non-interactive update
    zypper --non-interactive install --allow-unsigned-rpm ./package.rpm
    type "$shell" || zypper --non-interactive install "$shell"
    zypper --non-interactive install $packages_mandatory
    zypper --non-interactive install $packages_optional || true
  else
    exit 1
  fi
EOF

ENV shell="$shell"

CMD ! type "$shell" || bash run_tests.sh "$shell"
