# WorkPods Buzz Agents

Two stable Buzz coding-agent identities run on the beta machine:

```text
claude
codex
```

They use `buzz-acp` from the local Buzz source and ACP adapters for Claude and
Codex. The working directory is the umbrella directory:

```text
/home/ubuntu/workpods-umbrella
```

The harness publishes each agent's final assistant text as the signed Buzz
reply. Agents should use `buzz messages send` only for intentional additional
messages, not for the ordinary response to the triggering message.

Runtime env files are machine-local and ignored:

```text
/home/ubuntu/workpods-umbrella/.runtime/secrets/buzz-agents/claude.env
/home/ubuntu/workpods-umbrella/.runtime/secrets/buzz-agents/codex.env
```

Useful commands:

```bash
./scripts/install-user-service
./scripts/start claude codex
./scripts/status
./scripts/logs claude
```

`scripts/start` refreshes `BUZZ_ACP_ADDITIONAL_DIRECTORIES` in the ignored
runtime env files. It derives those paths from the current umbrella layout, so
symlinked service checkouts are exposed to ACP sessions without committing
machine-specific absolute paths.

The service disables the compiled Buzz platform prompt and strips `BUZZ_*`
environment variables before spawning Claude/Codex. The chat platform is only
transport for these coding agents.

Session controls are per Buzz channel:

```text
@claude /model sonnet
@claude /mode auto
@codex /model gpt-5.5
@codex /mode plan
@claude /session
@claude /reset-session
```

The client-facing permission modes are `plan`, `auto`, and `edit`. The default
permission mode is `plan`. Use `/mode auto` only for a channel session where
Musketeer explicitly wants the agent to execute without approval prompts.

## Build Buzz Artifacts

`buzz-acp/UPSTREAM` pins the upstream Buzz revision, patched tree, Rust image,
and toolchain. Six ordered patches capture the WorkPods changes to `buzz-acp`.
The same build exports both the coding-agent harness and the CLI used by Hermes:

```bash
./buzz-acp/scripts/build
(cd buzz-acp/dist && sha256sum -c SHA256SUMS)
```

Artifacts and `provenance.json` are written to ignored `buzz-acp/dist/`. The
build does not install them. In particular, it never writes the live
`.runtime/bin/buzz-acp`; binary rollout and service restarts require a separate
deployment operation.

Persisted session mappings fail closed by default: a malformed, unreadable, or
unsupported state file aborts startup instead of silently creating new agent
sessions. Recovery is explicit. After preserving the bad file, set
`BUZZ_ACP_SESSION_STATE_ON_ERROR=reset` for one start; the harness atomically
moves a bad regular file to a unique `.corrupt.<uuid>` sibling and starts with
an empty mapping. Remove the override before the next start. Non-regular files,
symlinks, permission errors, and failed moves still abort.

To regenerate the tracked series from a clean local Buzz worktree:

```bash
./buzz-acp/scripts/refresh-patches /path/to/buzz-source-worktree
```

Review changes to all six patches and `UPSTREAM` before committing them.

## Hermes Pods

`pods/` packages six Hermes identities into three containers under the stable
Compose project `buzz-hermes`. Content, GEO, lifecycle, and performance are
multiplexed by the internal host; marketing and support desk run separately.
The host has no Buzz identity. Kanban, the former `workpod`, public profiles,
all skills, and the unfinished email-management MCP are intentionally absent.

The image owns each `SOUL.md` and `config.yaml`. On every start, the bootstrap
hash-reconciles only the 22 destinations in `pods/config/manifest.tsv`, creates
seven bundled-skill opt-out markers, and rejects any remaining `SKILL.md`.
It never manages `USER.md`, sessions, memories, credentials, or other runtime
state.

Validate and build without deploying:

```bash
./pods/scripts/validate
./pods/scripts/build-image
```

`build-image` always rebuilds the pinned Buzz CLI first, verifies its
provenance, and tags Hermes with the full Git revision. Compose has no build
stanza and refuses to render unless `WORKPODS_BUILD_REVISION` names that exact
image. This prevents a clean checkout from using absent or stale ignored
artifacts. Do not use `:local`, install the ACP artifact, or run `docker compose
up` as part of build validation.

Before a separately approved deployment, export the current image to cold
storage and run the fail-closed gate:

```bash
./pods/scripts/export-rollback workpods/hermes-codex:local "$COLD_ARCHIVE_ROOT"
WORKPODS_ROLLBACK_ARCHIVE_ROOT="$COLD_ARCHIVE_ROOT" ./pods/scripts/predeploy
```

`predeploy` requires all six identity files to be regular, non-symlink files
with mode `0600`; verifies the revision image and rollback archive; and renders
Compose without starting anything. See `pods/DEPLOY.md` for cutover, rollback,
and session-state recovery procedures.

Secret examples under `pods/env/` map to
`.runtime/secrets/hermes-pods/`. The four internal identity files are mounted
read-only at `profiles/<name>/.env` inside the internal state tree. Populate the
secret files by migrating the current files; never paste key values into Git.
`llm-gateway.env` uses `OPENAI_API_KEY` for the WorkPods gateway client token,
not an OpenAI credential, and must set `OPENAI_BASE_URL` to the internal gateway
`/v1` endpoint. Active Hermes state must not contain `auth.json`; archive any
legacy direct-provider credentials before deployment. The cold rollback image
and archived state remain available for an explicit rollback, but running pods
authenticate only to the gateway.
