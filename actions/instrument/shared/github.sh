#!/bin/false

github() {
  printenv >&2
  url="$GITHUB_API_URL"/"$1"?per_page=100
  curl --no-progress-meter --fail --retry 16 --retry-all-errors --header "Authorization: Bearer $INPUT__GITHUB_TOKEN" --head "$url" \
    | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
    | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
    | grep '^page=' | cut -d = -f 2 \
    | xargs seq 1 | while IFS= read -r page; do
      curl --no-progress-meter --fail --retry 16 --retry-all-errors --header "Authorization: Bearer $INPUT__GITHUB_TOKEN" "$url"\&page="$page"
    done
}
export -f github

github_workflow() {
  github repos/"$GITHUB_REPOSITORY"/actions/runs/"$GITHUB_RUN_ID"/"$1"
}
export -f github_workflow
