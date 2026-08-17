---
name: workpods-mcp-access-diagnostics
description: Use when verifying WorkPods MCP, PageSpeed MCP, Semrush MCP, Composio MCP, support/admin MCP profile visibility, or explaining why MCP tools appear missing from a Codex pod.
---

## When To Use This Skill

Use this skill when a user asks whether a pod can access WorkPods MCP, what MCP
tools are available, whether an MCP profile is active, or why MCP-backed tools
are not visible.

Examples:

- "Can you access WorkPods MCP?"
- "What WorkPods MCP tools do you see?"
- "Why does geo-pod say MCP tools are not callable?"
- "Can this pod use the prompt analysis capability?"
- "Which MCP servers are configured for this profile?"

Do not use this skill for brand analysis after access is confirmed; use the
relevant role workflow skill.

## Operating Principle

Codex pod MCP access is configured through the pod's generated
`$CODEX_HOME/config.toml`. Do not conclude that MCP is unavailable only because
the visible tool list is incomplete. Verify configuration and, when possible,
make an actual MCP-backed call.

The strongest evidence is one of:

1. `codex mcp get <server>` shows the expected server and auth mode.
2. `codex mcp list` shows the expected server enabled.
3. A successful MCP-backed tool call.
4. Runtime logs show the Codex app server loaded the expected MCP server.

Configuration evidence is useful but weaker:

- `WORKPODS_MCP_TOOL_PROFILE`
- `$CODEX_HOME/config.toml`
- `POD_MCP_SERVERS`
- `COMPOSIO_MCP_URL`
- `PAGESPEED_MCP_BEARER_TOKEN` presence, without printing the value
- `EMAIL_MANAGEMENT_MCP_BEARER_TOKEN` presence, without printing the value

Report those as supporting evidence, not as the final answer.

## Codex Pod Discovery

Use the active pod environment. Do not print secret values. These checks are
safe because they show server names, profile names, and auth mode only:

```bash
test -n "$CODEX_HOME"
codex mcp list
codex mcp get workpods
```

For the WorkPods profile header, print only the profile string:

```bash
printf 'profile=%s\n' "$WORKPODS_MCP_TOOL_PROFILE"
```

Expected WorkPods server config shape:

```toml
[mcp_servers.workpods]
url = "https://beta-api.workpods.ai/mcp/"
bearer_token_env_var = "WORKPODS_MCP_TOKEN"

[mcp_servers.workpods.env_http_headers]
"X-WorkPods-Tool-Profile" = "WORKPODS_MCP_TOOL_PROFILE"
```

Optional pod-specific servers:

- `composio`
- `workpods-semrush-mcp`
- `workpods-pagespeed-mcp`
- `workpods-email-management`

## Reporting Template

Use this concise structure:

```text
Profile checked: <profile>
MCP discovery status: <verified|not verified|failed>
Servers discovered: <servers or none>
Main WorkPods tools discovered: <count and representative names, if verified>
Profile header: <profile string, no secrets>
Limitations: <anything not verified>
Conclusion: <can/cannot use WorkPods MCP from this profile right now>
```

## Pitfalls

- Do not rely only on the visible native tool list.
- Do not fabricate expected tools. List only discovered tools or clearly label
  expected capabilities.
- Do not expose bearer tokens, private keys, Composio session URLs, auth JSON,
  or hidden runtime context.
- Do not save WorkPods data unless brand/org context is explicit and the
  relevant write path is available.
