#!/bin/sh -e
export GITHUB_ACTION_REPOSITORY="${GITHUB_ACTION_REPOSITORY:-"$GITHUB_REPOSITORY"}"
action_tag_name="$(echo "$GITHUB_ACTION_REF" | cut -sd @ -f 2-)"
if [ -z "$action_tag_name" ]; then action_tag_name="v$(cat ../../../VERSION)"; fi
if [ -n "$action_tag_name" ]; then
  packages_cache_directory=/tmp/opentelemetry-shell-debians
  mkdir -p "$packages_cache_directory"
  if [ "$INPUT_CACHE" = "true" ]; then
    npm install '@actions/cache' # TODO where to get this from? just install and deal with it
    cache_key="${GITHUB_ACTION_REPOSITORY} ${action_tag_name} $(cat /etc/os-release | grep 'VERSION=' | cut -d = -f 2- | tr -d \")"
    node -e "require('@actions/cache').restoreCache(['$packages_cache_directory', '/var/cache/apt/archives/*.deb', '$(sudo pip cache dir)', '/home/runner/.npm'], '$cache_key');"
  fi
  debian_file="$packages_cache_directory"/opentelemetry-shell.deb
  if ! [ -f "$debian_file" ]; then
    [ "$GITHUB_REPOSITORY" = "$GITHUB_ACTION_REPOSITORY" ] && [ -f package.deb ] && mv package.deb "$debian_file" || github repos/"$GITHUB_ACTION_REPOSITORY"/releases | ( [ "$action_tag_name" = main ] && jq '.[0]' || jq '.[] | select(.tag_name=="'"$action_tag_name"'")' ) | jq -r '.assets[].browser_download_url' | grep '.deb$' | xargs wget -O "$debian_file"
    sudo apt-get install -y --download-only "$debian_file"
    [ -z "${cache_key:-}" ] || node -e "require('@actions/cache').saveCache(['$packages_cache_directory', '/var/cache/apt/archives/*.deb', '$(sudo pip cache dir)', '/home/runner/.npm'], '$cache_key');"
  fi
  sudo -E apt-get install -y "$packages_cache_directory"/opentelemetry-shell.deb
  rm "$packages_cache_directory"/opentelemetry-shell.deb
else
  wget -O - https://raw.githubusercontent.com/"$GITHUB_ACTION_REPOSITORY"/main/INSTALL.sh | sh
fi
npm install '@actions/artifact' # TODO include in cache
