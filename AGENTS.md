# WorkPods Buzz Agents

This repo contains the non-secret runner setup for Buzz-connected coding agents.
The live machine-local env files and generated Nostr keys live under:

```text
/home/ubuntu/workpods-umbrella/.runtime/secrets/buzz-agents
```

Do not commit generated keys, service env files, auth tokens, logs, or runtime
state. Keep agent source changes in `buzz-source` and runner changes here.

The deployed identities are intentionally stable:

```text
claude
codex
```

Model and permission mode are controlled per Buzz channel session with:

```text
@claude /model <model-id>
@claude /mode <default|acceptEdits|dontAsk|plan>
@claude /session
@claude /reset-session
```

Only the owner or explicit allowlist members may change model/mode. Same-owner
sibling agents may prompt normally, but must not be granted control authority.

The default permission mode is `plan`. Use `/mode dontAsk` only for a channel
session where Musketeer explicitly wants the agent to execute without approval
prompts.

The harness publishes final assistant text as the signed Buzz reply. Do not
configure agents to call `buzz messages send` for the ordinary response to the
triggering message.
