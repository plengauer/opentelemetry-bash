#!/bin/sh -e
export GITHUB_ACTION_REPOSITORY="${GITHUB_ACTION_REPOSITORY:-"$GITHUB_REPOSITORY"}"
action_tag_name="$(echo "$GITHUB_ACTION_REF" | cut -sd @ -f 2-)"
if [ -z "$action_tag_name" ]; then action_tag_name="v$(cat ../../../VERSION)"; fi
if [ "$GITHUB_REPOSITORY" = "$GITHUB_ACTION_REPOSITORY" ] && dpkg -l | grep -q opentelemetry-shell && false; then
  :
elif [ -n "$action_tag_name" ]; then
  packages_cache_directory=/tmp/opentelemetry-shell-debians
  mkdir -p "$packages_cache_directory"
  npm install '@actions/cache'
  cache_key="${GITHUB_ACTION_REPOSITORY}-${action_tag_name}-$(cat /etc/os-release | grep 'VERSION=' | cut -d = -f 2- | tr -d \")"
  node -e "require('@actions/cache').restoreCache(['$packages_cache_directory'], '$cache_key');"
  debian_file="$packages_cache_directory"/opentelemetry-shell.deb
  if ! [ -f "$debian_file" ]; then
    github repos/"$GITHUB_ACTION_REPOSITORY"/releases | ( [ "$action_tag_name" = main ] && jq '.[0]' || jq '.[] | select(.tag_name=="'"$action_tag_name"'")' ) | jq -r '.assets[].browser_download_url' | grep '.deb$' | xargs wget -O "$debian_file"
    # TODO download dependencies
    node -e "await require('@actions/cache').saveCache(['$packages_cache_directory'], '$cache_key');"
  fi
  sudo -E apt-get install -y "$packages_cache_directory"/*.deb
else
  wget -O - https://raw.githubusercontent.com/"$GITHUB_ACTION_REPOSITORY"/main/INSTALL.sh | sh
fi
npm install '@actions/artifact'
