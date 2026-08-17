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
