#!/bin/sh
set -e

if type apt-get 1> /dev/null 2> /dev/null; then
  extension=deb
elif type rpm 1> /dev/null 2> /dev/null; then
  extension=rpm
else
  echo "Unsupported operating system (no apt-get and no rpm available)" >&2
  exit 1
fi

package="$(mktemp -u)"."$extension"
curl --no-progress-meter https://api.github.com/repos/plengauer/opentelemetry-bash/releases/latest | jq -r '.assets[].browser_download_url' | grep '.'"$extension"'$' | xargs wget -O "$package" \
 || curl -v --no-progress-meter https://github.com/plengauer/opentelemetry-bash/releases/latest/download/opentelemetry-shell."$extension" 2>&1 | grep location | awk -F\  '{ print $3 }' | awk -F/ '{ print $8 }' | awk -Fv '{ print $2 }' | xargs -I '{}' wget -O "$package" https://github.com/plengauer/opentelemetry-bash/releases/latest/download/opentelemetry-shell_'{}'."$extension"

if [ "$(whoami)" = "root" ]; then
  wrapper=sudo
else
  wrapper=''
fi

case "$extension" in
  deb)
    if type apt-get; then
      $wrapper apt-get install -y "$package"  
    elif type apt; then
      $wrapper apt install -y "$package"  
    else
      $wrapper dpkg --install "$package"  
    fi
    ;;
  rpm)
    if type dnf; then
      $wrapper dnf -y install "$package"
    elif type yum; then
      $wrapper yum -y install "$package"
    elif type zypper; then
      $wrapper zypper --non-interactive install --allow-unsigned-rpm "$package"
    else
      $wrapper rpm --install "$package"
    fi
    ;;
  *)
    echo Here be dragons >&2
    exit 1
    ;;
esac

rm "$package"
