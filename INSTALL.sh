set -e
package=$(mktemp -u)_opentelemetry_shell.deb
wget -O $package $(curl --no-progress-meter https://api.github.com/repos/plengauer/opentelemetry-bash/releases/latest | jq -r '.assets[].browser_download_url') || \
wget -O $package https://github.com/plengauer/opentelemetry-bash/releases/latest/download/opentelemetry-shell_$(curl -v --no-progress-meter https://github.com/plengauer/opentelemetry-bash/releases/latest/download/opentelemetry-shell.deb 2>&1 | grep location | awk -F\  '{ print $3 }' | awk -F/ '{ print $8 }' | awk -Fv '{ print $2 }').deb
if [ "$(whoami)" = "root" ]; then
  apt-get install -y $package
else
  sudo apt-get install -y $package
fi
rm $package
