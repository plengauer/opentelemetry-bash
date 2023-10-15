#!/bin/sh
set -e
package=$(mktemp -u)_opentelemetry_shell.deb
wget -O $package $(curl --no-progress-meter https://api.github.com/repos/plengauer/opentelemetry-bash/releases/latest | jq -r '.assets[].browser_download_url')
if [ "$(whoami)" = "root" ]; then
  apt-get install $package
else
  sudo apt-get install $package
fi
rm $package
