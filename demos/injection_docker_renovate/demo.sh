export RENOVATE_TOKEN="$GITHUB_TOKEN"
. otel.sh
sudo -E docker run --env RENOVATE_TOKEN renovate/renovate --dry-run --rm plengauer/opentelemetry-bash
