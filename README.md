# WorkPods Buzz Agents

This repo owns the non-secret runner setup for WorkPods internal Buzz agents.

Two stable host-level coding-agent identities run on the beta machine:

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

## Dockerized Codex Pods

The team-facing WorkPods pods run as one Docker Compose service per Buzz
identity:

```text
workpod
geo-pod
content-pod
performance-pod
lifecycle-pod
marketing-pod
support-desk-pod
```

They use the same `buzz-acp` binary and system-prompt mechanism as the host
coding agents, but run inside containers with `codex-acp`. They differ from the
host `claude`/`codex` identities in two ways:

- `BUZZ_ACP_RESPOND_TO=anyone`, so team members can use them.
- Runtime state, `CODEX_HOME`, prompt composition, and skills are per container.

The pod model is `gpt-5.6-luna` with `model_reasoning_effort = "max"`.
`scripts/codex-pods seed-auth` copies host Codex auth into each pod state
directory so containers can refresh their own credentials.

Pod definitions live in:

```text
pods/pods.toml
pods/<pod>/SOUL.md
pods/<pod>/memories/USER.md
pods/<pod>/skills/
compose.codex-pods.yml
```

Brand-intelligence skills are verbatim role-scoped copies from
`workpods-ingest/pi/skills/workpods-brand-intelligence/`. Only
`workpods-mcp-access-diagnostics` is adapted specifically for Codex.

Machine-local pod secrets are ignored and live under:

```text
/home/ubuntu/workpods-umbrella/.runtime/secrets/buzz-agents/pods/<pod>.env
```

Examples are committed under `secrets/pods/*.env.example`. Do not commit live
private keys, auth JSON, bearer tokens, Composio session URLs, or generated
state.

Useful pod commands:

```bash
./scripts/codex-pods validate
./scripts/codex-pods seed-auth
./scripts/codex-pods build
./scripts/codex-pods config
./scripts/codex-pods start
./scripts/codex-pods status
```

The first production migration must reuse the existing Hermes Buzz private keys;
creating replacement keys would create new agent identities. Roll out in this
order:

```bash
# 1. Merge and check out this repository's Codex pod change first.
./scripts/codex-pods validate
./scripts/codex-pods migrate-hermes-identities
./scripts/codex-pods seed-auth

# 2. Merge and check out the umbrella services change second.
./scripts/codex-pods decommission-hermes
cd /home/ubuntu/workpods-umbrella
./workpodsctl deploy buzz-agents
```

`migrate-hermes-identities` reads the seven existing private keys and the MCP
credentials they need from ignored live Hermes files, then writes owner-only pod
env files under `.runtime/`. It never prints secret values and refuses to replace
existing pod env files unless `--force` is passed. `decommission-hermes` refuses
to stop Hermes until all seven migrated identity files exist, and runs Compose
`down` without `-v` so Hermes state is preserved.

The narrower skill sets on `marketing-pod` and `support-desk-pod` are
intentional. Marketing retains outreach-oriented orchestration and support uses
its MCP tool surface directly; customer brand-intelligence skills remain scoped
to the five role pods. The legacy `public-workpods` Hermes tree is also omitted
intentionally because public onboarding now runs through Ingest and Pi and it
was not part of the active Hermes Compose stack.

Do not start or deploy the pod stack as part of source-only changes unless the
operator explicitly asks for live deployment.
