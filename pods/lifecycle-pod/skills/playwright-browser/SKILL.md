---
name: playwright-browser
description: Use when a workflow step or operator request requires a real rendered browser to inspect pages, interact with UI, capture screenshots, observe console/network behavior, or verify client-side rendering beyond static HTTP fetches.
---

## CRITICAL: When To Use This Skill

Use this skill only when static fetch, WorkPods MCP data, PageSpeed, or Semrush data is insufficient.

Good use cases:

- A page requires JavaScript rendering before meaningful content appears.
- You need to inspect visible layout, forms, navigation, modals, or interactive UI.
- You need a screenshot, PDF, console log, network signal, or accessibility snapshot.
- A workflow explicitly asks for rendered-page browser verification.

Avoid browser work for simple URL fetches, metadata extraction, or broad crawling. Browser sessions are slower and more expensive than direct HTTP/MCP checks.

## Tooling

Use the installed Playwright CLI in the Pi container:

```bash
playwright-cli --help
```

Common commands:

```bash
playwright-cli open --browser chromium https://example.com
playwright-cli goto https://example.com
playwright-cli snapshot
playwright-cli screenshot --filename /tmp/page.png
playwright-cli click <ref>
playwright-cli fill <ref> "value"
playwright-cli press Enter
playwright-cli close
```

If `playwright-cli` is unavailable, try:

```bash
npx playwright-cli --help
```

## Process

1. Open only the target URL or a small number of directly relevant URLs.
2. Capture a snapshot before interacting with the page.
3. Prefer accessibility refs from snapshots for clicks and form interactions.
4. Save screenshots/artifacts only when they are needed for evidence or debugging.
5. Summarize visible findings compactly with source URL and relevant artifacts.
6. Do not enter credentials, solve CAPTCHAs, or bypass access controls.

## Output

Return the page URL, rendered-page finding, relevant evidence, and any artifact paths. Keep screenshots and snapshots referenced by path rather than embedding large content.
