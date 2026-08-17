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

The team-facing internal WorkPods pods are Dockerized Codex ACP agents:

```text
workpod
geo-pod
content-pod
performance-pod
lifecycle-pod
marketing-pod
support-desk-pod
```

Keep their source configuration under `pods/`, `compose.codex-pods.yml`, and
the pod scripts in `scripts/`. Live pod env files must stay under
`.runtime/secrets/buzz-agents/pods/` in the umbrella checkout and must never be
committed.

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

## Codex Pod Rules

- Use one container per Buzz-visible pod identity.
- Use `BUZZ_ACP_RESPOND_TO=anyone` for pods; host `claude` and `codex` remain
  owner/allowlist controlled.
- Keep `gpt-5.6-luna` and `model_reasoning_effort = "max"` in generated Codex
  config unless a future issue changes the model policy.
- Keep pod skills structurally scoped under `pods/<pod>/skills/`.
- Do not add Hermes or Kanban runtime dependencies. Archived Hermes patches may
  live in `workpods-buzz`, but the active pod path is Codex + `buzz-acp`.
- Seed Codex auth by copying into each pod state directory; do not mount the
  host `~/.codex` read-only into the containers.
- Run `./scripts/codex-pods validate` after changing pod manifests, prompts,
  Compose, or skill sets.
