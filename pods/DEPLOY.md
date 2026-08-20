# Hermes Pods Deployment

Deployment requires explicit approval. Validation and image builds do not
authorize a cutover, ACP binary installation, session-state changes, or a
Compose restart.

## Build And Gate

Run from a clean checkout at the revision being deployed:

```bash
./pods/scripts/validate
./pods/scripts/build-image
./pods/scripts/export-rollback workpods/hermes-codex:local "$COLD_ARCHIVE_ROOT"
```

`validate` fetches the pinned public Hermes revision into a temporary checkout.
Set `HERMES_SOURCE_WORKTREE` only to reuse a checkout that contains that exact
commit. Copy the rollback tar and checksum to storage on a different filesystem
before continuing; `predeploy` enforces that boundary.

## State Migration

The commands in this file are the only executable migration runbook. Run the
pre-copy while the old pods are live:

```bash
UMBRELLA=/home/ubuntu/workpods-umbrella
LIVE="$UMBRELLA/buzz-deploy/hermes"
STATE="$UMBRELLA/.runtime/state/hermes-pods"
SECRETS="$UMBRELLA/.runtime/secrets/hermes-pods"

sudo install -d -m 0700 \
  "$STATE/internal-workpods" "$STATE/marketing-pod" "$STATE/support-desk-pod"
sudo chown 10000:10000 \
  "$STATE/internal-workpods" "$STATE/marketing-pod" "$STATE/support-desk-pod"
sudo install -d -m 0700 "$SECRETS"

for pod in internal-workpods marketing-pod support-desk-pod; do
  sudo rsync -aHAX --numeric-ids \
    --exclude='skills/' \
    --exclude='.skills_prompt_snapshot.json' \
    "$LIVE/agents/$pod/" "$STATE/$pod/"
done
```

Stop the old writers. This is the first command in the runbook that affects a
running Hermes container, so it requires explicit cutover approval:

```bash
sudo docker compose -p buzz-hermes -f "$LIVE/compose.hermes.yml" stop

for pod in internal-workpods marketing-pod support-desk-pod; do
  sudo rsync -aHAX --numeric-ids \
    --exclude='skills/' \
    --exclude='.skills_prompt_snapshot.json' \
    "$LIVE/agents/$pod/" "$STATE/$pod/"
done

sudo install -m 0600 \
  "$LIVE/agents/internal-workpods/profiles/content-pod/.env" \
  "$SECRETS/content-pod.env"
sudo install -m 0600 \
  "$LIVE/agents/internal-workpods/profiles/geo-pod/.env" \
  "$SECRETS/geo-pod.env"
sudo install -m 0600 \
  "$LIVE/agents/internal-workpods/profiles/lifecycle-pod/.env" \
  "$SECRETS/lifecycle-pod.env"
sudo install -m 0600 \
  "$LIVE/agents/internal-workpods/profiles/performance-pod/.env" \
  "$SECRETS/performance-pod.env"
sudo install -m 0600 \
  "$LIVE/secrets/marketing-pod.env" "$SECRETS/marketing-pod.env"
sudo install -m 0600 \
  "$LIVE/secrets/support-desk-pod.env" "$SECRETS/support-desk-pod.env"
sudo chown 10000:10000 "$SECRETS/"*-pod.env
for name in composio workpods-mcp pagespeed-mcp; do
  sudo install -m 0600 \
    "$LIVE/secrets/$name.env" "$SECRETS/$name.env"
done
```

Remove retired state only from the destination, then seed Codex credentials
into each identity home. The seed script preserves any other Hermes providers,
sets `auth.json` to UID/GID 10000, and verifies authentication as that runtime
user:

```bash
sudo find "$STATE" -type d -name skills -prune -exec rm -rf -- {} +
sudo find "$STATE" -type d -name kanban -prune -exec rm -rf -- {} +
sudo find "$STATE" \
  \( -name 'kanban.db*' -o -name '*.dispatch.lock' -o -name '*.init.lock' \
     -o -name '.skills_prompt_snapshot.json' -o -name '.bundled_manifest' \
     -o -name '.curator_state' \) -type f -delete
sudo rm -rf "$STATE/internal-workpods/profiles/workpod"
sudo find "$STATE/internal-workpods/profiles" -mindepth 2 -maxdepth 2 \
  -name .env -type f -delete
sudo chown -R 10000:10000 "$STATE"

cd "$UMBRELLA/workpods-buzz-agents"
IMAGE="workpods/hermes-codex:$(git rev-parse HEAD)"
./pods/scripts/seed-codex-auth "$STATE" "$IMAGE"
WORKPODS_ROLLBACK_ARCHIVE_ROOT="$COLD_ARCHIVE_ROOT" \
  ./pods/scripts/predeploy
```

`predeploy` rejects a dirty checkout, a rollback directory on the umbrella
filesystem, a missing or mismatched image/archive, an invalid Compose or
rollback model, identity files that are not UID/GID 10000 mode `0600`, or any
identity home without valid UID/GID 10000 mode `0600` Codex credentials. It
prints no key or token values.

Take the separately specified ACP session dump immediately before the ACP
binary is ever replaced. Hermes migration does not replace that binary.

## Cutover

After the state migration and gate above, change the source path in the umbrella
manifest, set the full revision, and deploy only Hermes:

```bash
export WORKPODS_BUILD_REVISION=$(git rev-parse HEAD)
WORKPODS_ROLLBACK_ARCHIVE_ROOT="$COLD_ARCHIVE_ROOT" ./pods/scripts/predeploy
cd /home/ubuntu/workpods-umbrella
./workpodsctl deploy hermes
```

Do not delete or move the old runtime tree during the soak period. Verify all
six identity npubs, presence, turn-long typing, MCP access, writable `USER.md`,
and the absence of Kanban and skills.

## Rollback

The archive preserves a tag because `docker image load` does not reconstruct a
registry digest reference. Restore and assert the expected image ID:

```bash
cd "$COLD_ARCHIVE_ROOT"
sha256sum -c hermes-codex-rollback-bc2171345764.tar.sha256
sudo docker image load -i hermes-codex-rollback-bc2171345764.tar
sudo docker image tag \
  sha256:bc2171345764d6d205053557fdbca139d350093b4115db3d37b92d41cf62582b \
  workpods/hermes-codex:rollback-bc2171345764
export WORKPODS_BUILD_REVISION=$(git rev-parse HEAD)
sudo docker compose -p buzz-hermes \
  -f pods/compose.pods.yml -f pods/hermes.rollback.yml \
  up -d --no-build
```

The rollback override runs the old image against the new durable state, so
normal rollback does not restore the cold state snapshot or discard post-cutover
writes.

## Buzz Configuration Precedence

The image-owned `config.yaml` files are authoritative for `relay_url` and
`cli_path`. Compose intentionally does not duplicate `BUZZ_RELAY_URL` or
`BUZZ_CLI_PATH`. Hermes' Buzz adapter gives a non-empty environment variable
precedence over the corresponding YAML value, so adding either variable is an
explicit runtime override that must be reviewed as deployment configuration.

## ACP Session Recovery

The new ACP binary aborts before connecting to Buzz when its persisted session
mapping is malformed, unreadable, or unsupported. Preserve and inspect the file
first. For a confirmed bad regular file, set
`BUZZ_ACP_SESSION_STATE_ON_ERROR=reset` for one start only. The harness moves it
atomically to `<state-file>.corrupt.<uuid>` and starts empty. Remove the override
before the next start.

Reset deliberately loses the mappings in that one file. It refuses directories,
symlinks, permission errors, and failed moves. Prefer restoring a verified
session dump when continuity matters.
