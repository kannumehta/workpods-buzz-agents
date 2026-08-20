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
WORKPODS_ROLLBACK_ARCHIVE_ROOT="$COLD_ARCHIVE_ROOT" ./pods/scripts/predeploy
```

Copy the rollback tar and checksum to storage on a different filesystem before
cutover. `predeploy` rejects a missing checksum, missing revision image, missing
rollback tag, dirty checkout, or any missing, symlinked, or non-`0600` identity
file. Identity env files are bind-mounted into Hermes profile homes, so they
must be owned by the container identity:

```bash
sudo chown 10000:10000 "$UMBRELLA/.runtime/secrets/hermes-pods/"*-pod.env
sudo chmod 600 "$UMBRELLA/.runtime/secrets/hermes-pods/"*-pod.env
```

Take the separately specified ACP session dump immediately before the ACP binary
is ever replaced; Hermes deployment does not replace that binary.

## Cutover

Perform the approved state pre-copy and final stopped sync from the migration
issue before changing the source path in the umbrella manifest. Then set the
full revision and deploy only Hermes:

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
