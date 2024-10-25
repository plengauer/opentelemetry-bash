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

case "$extension" in
  deb)
    if [ "$(whoami)" = "root" ]; then
      apt-get install -y "$package"
    else
      sudo -E apt-get install -y "$package"
    fi
    ;;
  rpm)
    if [ "$(whoami)" = "root" ]; then
      rpm --install "$package"
    else
      sudo -E rpm --install "$package"
    fi
    ;;
  *) echo Here be dragons >&2; exit 1;;
esac

rm "$package"
