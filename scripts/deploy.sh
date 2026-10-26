#!/usr/bin/env bash
set -euo pipefail

# Run on your Mac. SSH uses the existing homeserver alias and its credentials.
host=homeserver
destination=/home/arnab/dev/portfolio-website
mode=${1:-deploy}
case "$mode" in
  deploy|--rollback) ;;
  --help|-h)
    echo 'Usage: ./scripts/deploy.sh [--rollback]'
    echo 'Deploy the committed checkout to homeserver, or restore the previous release.'
    exit 0 ;;
  *) echo "Unknown option: $mode" >&2; exit 1 ;;
esac
[[ $# -le 1 ]] || { echo 'Too many arguments.' >&2; exit 1; }

repo=$(git -C "$(dirname "$0")" rev-parse --show-toplevel)
archive=
remote_archive=
cleanup() {
  [[ -z "$archive" ]] || rm -f "$archive"
  if [[ -n "$remote_archive" ]]; then
    ssh -o BatchMode=yes "$host" "rm -f -- '$remote_archive'" || true
  fi
}
trap cleanup EXIT

revision=
if [[ "$mode" == deploy ]]; then
  if [[ -n "$(git -C "$repo" status --porcelain)" ]]; then
    echo 'Commit or stash your changes first. Deployment includes committed files only.' >&2
    exit 1
  fi
  revision=$(git -C "$repo" rev-parse HEAD)
  archive=$(mktemp "${TMPDIR:-/tmp}/portfolio-deploy.XXXXXXXX")
  git -C "$repo" archive --format=tar "$revision" > "$archive"
  remote_archive=$(ssh -o BatchMode=yes "$host" 'mktemp /tmp/portfolio-deploy.XXXXXXXX')
  [[ "$remote_archive" =~ ^/tmp/portfolio-deploy\.[a-zA-Z0-9]+$ ]] || {
    echo 'Unexpected remote temporary path.' >&2; remote_archive=; exit 1;
  }
  scp -q -o BatchMode=yes "$archive" "$host:$remote_archive"
fi

ssh -o BatchMode=yes "$host" bash -s -- "$destination" "$mode" "$revision" "$remote_archive" <<'REMOTE'
set -euo pipefail
root=$1
mode=$2
revision=$3
archive=$4
mkdir -p "$root/releases"
exec 9>"$root/.deploy.lock"
flock -n 9 || { echo 'Another portfolio deployment is running.' >&2; exit 1; }
docker compose version >/dev/null
command -v curl >/dev/null

staging=
cleanup() {
  [[ -z "$staging" ]] || rm -rf -- "$staging"
  [[ -z "$archive" ]] || rm -f -- "$archive"
}
trap cleanup EXIT

current=
[[ ! -f "$root/current" ]] || current=$(cat "$root/current")
if [[ "$mode" == --rollback ]]; then
  [[ -s "$root/previous" ]] || { echo 'No previous release is available.' >&2; exit 1; }
  revision=$(cat "$root/previous")
else
  # Build before replacing the running container. A failed build leaves it alone.
  staging=$(mktemp -d "$root/releases/.build.XXXXXXXX")
  tar -xf "$archive" -C "$staging"
  docker build --tag "portfolio-website:$revision" "$staging"
  if [[ ! -d "$root/releases/$revision" ]]; then
    mv "$staging" "$root/releases/$revision"
    staging=
  fi
fi

activate() {
  local release=$1
  [[ "$release" =~ ^[0-9a-f]{40}$ ]] || return 1
  [[ -f "$root/releases/$release/compose.yaml" ]] || return 1
  PORTFOLIO_IMAGE="portfolio-website:$release" PORTFOLIO_PORT=8083 \
    docker compose --project-name portfolio-website \
      --project-directory "$root/releases/$release" \
      --file "$root/releases/$release/compose.yaml" \
      up -d --no-build --wait --wait-timeout 90 || return 1
  curl --fail --silent --show-error --max-time 10 http://127.0.0.1:8083/health >/dev/null || return 1
  curl --fail --silent --show-error --max-time 10 http://127.0.0.1:8083/ >/dev/null || return 1
}

if ! activate "$revision"; then
  echo 'Deployment failed its startup checks.' >&2
  if [[ -n "$current" ]]; then
    echo "Restoring $current..." >&2
    activate "$current" || { echo 'Automatic restore failed; inspect the portfolio container.' >&2; exit 1; }
  else
    echo 'No previous deployment exists to restore.' >&2
  fi
  exit 1
fi

if [[ -n "$current" && "$current" != "$revision" ]]; then
  printf '%s\n' "$current" > "$root/previous.tmp"
  mv "$root/previous.tmp" "$root/previous"
fi
printf '%s\n' "$revision" > "$root/current.tmp"
mv "$root/current.tmp" "$root/current"
echo "Deployed $revision to $root"
echo 'Healthy at http://127.0.0.1:8083'
echo 'Cloudflare tunnel service: http://127.0.0.1:8083'
echo 'Public hostname: portfolio.arnabroy.co.in (configure the tunnel separately)'
REMOTE
