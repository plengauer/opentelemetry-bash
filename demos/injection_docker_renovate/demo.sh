export RENOVATE_TOKEN="$GITHUB_TOKEN"
. otel.sh
sudo -E docker run --env RENOVATE_TOKEN renovate/renovate --network=host --dry-run plengauer/opentelemetry-bash
