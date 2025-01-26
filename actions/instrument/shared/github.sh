#!/bin/false

# TODO replace
github() {
  url="$GITHUB_API_URL"/"$1"?per_page=100
  curl --no-progress-meter --fail --retry 16 --retry-all-errors --header "Authorization: Bearer $INPUT_GITHUB_TOKEN" --head "$url" \
    | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
    | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
    | grep '^page=' | cut -d = -f 2 \
    | xargs seq 1 | while IFS= read -r page; do
      curl --no-progress-meter --fail --retry 16 --retry-all-errors --header "Authorization: Bearer $INPUT_GITHUB_TOKEN" "$url"\&page="$page"
    done
}
export -f github

# TODO replace
github_workflow() {
  github repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/"$1"
}
export -f github_workflow

gh_curl() {
  curl --no-progress-meter -H "Authorization: Bearer $INPUT_GITHUB_TOKEN" "${GITHUB_API_URL:-https://api.github.com}"/repos/"$GITHUB_REPOSITORY""$@"
}
export -f gh_curl

gh_curl_paginated() {
  {
    gh_curl "$@" --head | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
      | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
      | grep '^page=' | cut -d = -f 2 \
      | xargs seq 1 || true
  } | while read -r page; do echo "$@"'&page='"$page"; done | xargs parallel gh_curl :::
}
