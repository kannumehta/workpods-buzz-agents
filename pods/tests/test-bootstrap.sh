#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
bootstrap="$repo_root/pods/scripts/bootstrap"
config="$repo_root/pods/config"
manifest="$repo_root/pods/config/manifest.tsv"
tmp=$(mktemp -d)
cleanup() {
  rm -rf "$tmp" 2>/dev/null || sudo rm -rf "$tmp"
}
trap cleanup EXIT

run_bootstrap() {
  local set=$1 dest=$2 manifest_path=${3:-$manifest}
  sudo env \
    WORKPODS_HERMES_CONFIG_ROOT="$config" \
    WORKPODS_HERMES_CONFIG_MANIFEST="$manifest_path" \
    WORKPODS_HERMES_CONFIG_SET="$set" \
    HERMES_HOME="$dest" \
    "$bootstrap" --check-only
}

for set in internal-workpods marketing-pod support-desk-pod; do
  dest="$tmp/$set"
  mkdir -p "$dest/memories" "$dest/sessions"
  printf 'agent memory\n' > "$dest/memories/USER.md"
  printf 'session state\n' > "$dest/sessions/current.json"
  run_bootstrap "$set" "$dest"
  [[ $(<"$dest/memories/USER.md") == "agent memory" ]]
  [[ $(<"$dest/sessions/current.json") == "session state" ]]
done

internal="$tmp/internal-workpods"
[[ $(readlink "$internal/profiles/content-pod/config.yaml") == ../../profile-configs/internal-buzz-pod.yaml ]]
before=$(stat -c '%Y' "$internal/config.yaml")
sleep 1
run_bootstrap internal-workpods "$internal"
[[ $(stat -c '%Y' "$internal/config.yaml") == "$before" ]]

printf 'drift\n' | sudo tee "$internal/config.yaml" >/dev/null
run_bootstrap internal-workpods "$internal"
cmp "$config/internal-workpods/config.yaml" "$internal/config.yaml"

sudo mkdir -p "$internal/skills/deleted-skill"
printf 'forbidden\n' | sudo tee "$internal/skills/deleted-skill/SKILL.md" >/dev/null
if run_bootstrap internal-workpods "$internal" >/dev/null 2>&1; then
  echo "bootstrap accepted a SKILL.md" >&2
  exit 1
fi
sudo rm -rf "$internal/skills"

bad="$tmp/bad.tsv"
printf 'internal-workpods\tfile\t0644\tinternal-workpods/SOUL.md\t../escape\n' > "$bad"
if run_bootstrap internal-workpods "$internal" "$bad" >/dev/null 2>&1; then
  echo "bootstrap accepted traversal" >&2
  exit 1
fi

printf '%s\n' \
  $'internal-workpods\tmarker\t0644\t-\tduplicate' \
  $'internal-workpods\tmarker\t0644\t-\tduplicate' > "$bad"
if run_bootstrap internal-workpods "$internal" "$bad" >/dev/null 2>&1; then
  echo "bootstrap accepted duplicate destinations" >&2
  exit 1
fi

outside="$tmp/outside"
mkdir -p "$outside"
sudo rm -rf "$internal/profiles"
sudo ln -s "$outside" "$internal/profiles"
if run_bootstrap internal-workpods "$internal" >/dev/null 2>&1; then
  echo "bootstrap followed a destination symlink outside HERMES_HOME" >&2
  exit 1
fi

echo "bootstrap tests passed"
