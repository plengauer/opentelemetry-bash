. otel.sh
repository=plengauer/opentelemetry-bash
per_page=100
url="https://api.github.com/repos/$repository/releases?per_page=$per_page"
curl --no-progress-meter --fail --retry 16 --retry-all-errors --head -H "$url" \
  | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
  | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
  | grep '^page=' | cut -d = -f 2 \
  | xargs seq 1 | xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors "$url"\&page={} ::: \
  | jq '.[] | .assets[] | .browser_download_url' -r | (grep '.deb$' || true) \
  | xargs wget
