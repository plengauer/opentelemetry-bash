ARG image
ARG update
ARG shell

FROM $image
ARG shell
ARG update
WORKDIR /tests
COPY . ./

RUN <<EOF
  packages="jq psmisc wget curl debconf debconf-utils time sudo parallel moreutils ncat wget2 strace nodejs npm python3 python3-pip python3-venv"
  if type apt-get; then
    apt-get update
    [ "$update" = TRUE ] && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y || true
    DEBIAN_FRONTEND=noninteractive apt-get install -y ./package.deb && rm ./package.deb
    type "$shell" || DEBIAN_FRONTEND=noninteractive apt-get install -y "$shell"
    DEBIAN_FRONTEND=noninteractive apt-get install -y $packages
  elif type dnf; then
    dnf upgrade --refresh
    rpm --install ./package.rpm
    type "$shell" || dnf install "$shell"
    dnf install $packages
  elif type zypper; then
    zypper dup
    rpm --install ./package.rpm
    type "$shell" || zypper install "$shell"
    zypper install $packages
  elif type yum; then
    yum update
    rpm --install ./package.rpm
    type "$shell" || yum install "$shell"
    yum install $packages
  else
    exit 1
  fi
EOF

ENV shell="$shell"

CMD bash run_tests.sh "$shell"
