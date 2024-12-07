#!/bin/sh -e
export GITHUB_ACTION_REPOSITORY="${GITHUB_ACTION_REPOSITORY:-"$GITHUB_REPOSITORY"}"
action_tag_name="$(echo "$GITHUB_ACTION_REF" | cut -sd @ -f 2-)"
if [ -z "$action_tag_name" ]; then action_tag_name="v$(cat ../../../VERSION)"; fi
if [ -n "$action_tag_name" ]; then
  if [ "$INPUT_CACHE" = "true" ]; then
    npm install '@actions/cache' # TODO where to get this from? just install and deal with it
    cache_key="${GITHUB_ACTION_REPOSITORY} ${action_tag_name} $(cat /etc/os-release | grep 'VERSION=' | cut -d = -f 2- | tr -d \")"
    sudo node -e "require('@actions/cache').restoreCache(['/tmp/opentelemetry-shell.deb', '/var/cache/apt/archives/*.deb', '$(sudo pip cache dir)', '$(sudo npm config get cache)'], '$cache_key');"
  fi
  debian_file=/tmp/opentelemetry-shell.deb
  if ! [ -f "$debian_file" ]; then
    [ "$GITHUB_REPOSITORY" = "$GITHUB_ACTION_REPOSITORY" ] && [ -f package.deb ] && mv package.deb "$debian_file" || github repos/"$GITHUB_ACTION_REPOSITORY"/releases | ( [ "$action_tag_name" = main ] && jq '.[0]' || jq '.[] | select(.tag_name=="'"$action_tag_name"'")' ) | jq -r '.assets[].browser_download_url' | grep '.deb$' | xargs wget -O "$debian_file"
    sudo apt-get install -y --download-only "$debian_file"
    [ -z "${cache_key:-}" ] || sudo node -e "require('@actions/cache').saveCache(['/tmp/opentelemetry-shell.deb', '/var/cache/apt/archives/*.deb', '$(sudo pip cache dir)', '$(sudo npm config get cache)'], '$cache_key');"
  fi
  sudo -E -H apt-get install -y /tmp/opentelemetry-shell.deb
  rm "$debian_file"
else
  wget -O - https://raw.githubusercontent.com/"$GITHUB_ACTION_REPOSITORY"/main/INSTALL.sh | sh
fi
npm install '@actions/artifact' # TODO include in cache
