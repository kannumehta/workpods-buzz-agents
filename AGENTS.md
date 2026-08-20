# WorkPods Buzz Agents

This repo contains the non-secret runner setup for Buzz-connected coding agents.
The live machine-local env files and generated Nostr keys live under:

```text
/home/ubuntu/workpods-umbrella/.runtime/secrets/buzz-agents
```

Do not commit generated keys, service env files, auth tokens, logs, or runtime
state. Keep agent source changes in `buzz-source` and runner changes here.

## Multi-Agent Collaboration

This is a multi-agent collaboration project. Agents must always prefer a git
worktree and a new branch for repository work, and use issues to track
non-trivial tasks, coordination points, and follow-up work.

The deployed identities are intentionally stable:

```text
claude
codex
```

Model and permission mode are controlled per Buzz channel session with:

```text
@claude /model <model-id>
@claude /mode <plan|auto|edit>
@claude /session
@claude /reset-session
```

Only the owner or explicit allowlist members may change model/mode. Same-owner
sibling agents may prompt normally, but must not be granted control authority.

The client-facing permission modes are `plan`, `auto`, and `edit`; adapter
specific mode names stay hidden inside `buzz-acp`. The default permission mode
is `plan`. Use `/mode auto` only for a channel session where Musketeer
explicitly wants the agent to execute without approval prompts.

`scripts/start` refreshes `BUZZ_ACP_ADDITIONAL_DIRECTORIES` in the ignored
runtime env files from the current umbrella layout. Keep that behavior
machine-local; do not commit absolute workspace paths.

The service disables the compiled Buzz platform prompt and strips `BUZZ_*`
environment variables before spawning Claude/Codex. Treat the chat platform as
transport only for these coding agents.

The harness publishes final assistant text as the signed Buzz reply. Do not
configure agents to call `buzz messages send` for the ordinary response to the
triggering message.

## Pinned Buzz Build

The WorkPods `buzz-acp` and Hermes `buzz` CLI are built from the pinned upstream
revision and ordered patch series under `buzz-acp/`. Run
`buzz-acp/scripts/build` to produce ignored artifacts in `buzz-acp/dist/`.
The build must never install or replace `.runtime/bin/buzz-acp`; rolling out a
new coding-agent binary is a separate, explicitly approved operation.

Use `buzz-acp/scripts/refresh-patches SOURCE_WORKTREE` only with a clean local
Buzz worktree whose six commits descend from the revision in `UPSTREAM`. Use
`rebase-upstream` to rehearse an upstream update without modifying the tracked
series.

## Hermes Pods

`pods/` owns the reproducible, non-secret Hermes runtime for six Buzz
identities: content, GEO, lifecycle, performance, marketing, and support desk.
The internal container multiplexes the first four; it is not an identity.
Kanban, `workpod`, public profiles, skills, and email-management MCP are not
part of this runtime.

Configuration and SOUL files are image-owned and reconciled by the bootstrap
allowlist. USER files and all other state remain agent-owned. Do not add USER
files, secrets, identities, sessions, or skills to the image context.

Never deploy from a moving image tag. Build a unique revision tag, export the
current rollback image, rehearse the bootstrap against a throwaway pre-copy,
and obtain explicit deployment approval before changing live containers or
state. Building and validation must not invoke `docker compose up`.

Use `pods/scripts/build-image`; direct Docker builds may consume stale ignored
Buzz artifacts. Compose intentionally has no build stanza. Before cutover,
`pods/scripts/predeploy` must pass with `WORKPODS_ROLLBACK_ARCHIVE_ROOT` set to
the checksum-verified cold archive on a different filesystem. It also enforces
six regular, non-symlink identity files and six seeded Codex auth stores, all
owned by UID/GID 10000 with mode `0600`. `pods/scripts/validate` fetches the
pinned public Hermes source into a temporary checkout unless an explicit
`HERMES_SOURCE_WORKTREE` is supplied. Follow `pods/DEPLOY.md` as the only
executable migration and recovery runbook; never delete a damaged ACP session
mapping to make a restart succeed.

Buzz `relay_url` and `cli_path` live in the image-owned Hermes YAML. Compose
does not duplicate them. If an operator explicitly adds `BUZZ_RELAY_URL` or
`BUZZ_CLI_PATH`, Hermes gives that non-empty environment value precedence.
