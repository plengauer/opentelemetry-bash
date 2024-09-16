export RENOVATE_TOKEN="$GITHUB_TOKEN"
. otel.sh
set -x
sudo -E docker run --env RENOVATE_TOKEN renovate/renovate --network=host --dry-run plengauer/opentelemetry-bash
