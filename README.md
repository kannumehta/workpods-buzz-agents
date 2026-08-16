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

Session controls are per Buzz channel:

```text
@claude /model sonnet
@claude /mode dontAsk
@codex /model gpt-5.5
@codex /mode plan
@claude /session
@claude /reset-session
```

The default permission mode is `plan`. Use `/mode dontAsk` only for a channel
session where Musketeer explicitly wants the agent to execute without approval
prompts.
