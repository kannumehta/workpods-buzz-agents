---
name: baseline-synthesis
description: Use only for the baseline synthesis step: summarize baseline findings, persist a context packet, and create prioritized findings.
---

## When To Use

Use after baseline specialist steps finish, fail, time out, or are explicitly skipped. This step reconciles direct handoffs only.

## Inputs

Expect direct-edge handoffs from `baseline-brand-foundation` and `baseline-market-position`. Missing prompt analysis, technical, lifecycle, Semrush, PageSpeed, and deep inventory branches are expected because they belong to enrichment.

## WorkPods Reads

Read brand overview, brand documents/context packets, pages, products, competitors, topics, keyword queries, findings, and prior baseline receipts. Use reads only to reconcile and verify persisted state.

## Procedure

1. Reconcile baseline facts into a compact brand context packet: positioning, offers, audience, geography, primary competitors, market/search topics, and known limitations.
2. Explicitly tolerate skipped, failed, timed-out, and insufficient-data branches. Explain impact in client-facing language without naming internal systems.
3. Create findings only for evidenced opportunities/problems; separate facts, implications, and recommendations.
4. Prioritize findings by severity, confidence, business impact, and answer visibility/onboarding readiness.
5. Persist the context packet/document and findings/recommendations when write surfaces are available.
6. Reconcile counts from upstream found/persisted/receipt fields and call out mismatches that affect confidence.

## Do Not

- Do not rerun specialist research, browse, crawl, or call Browse directly.
- Do not mention Browse, Firecrawl, Pi, MCP, tokens, prompt internals, or implementation details in client-facing `summary` or `description`.
- Do not hide missing branches; describe their practical effect.

## Required Output Fields

Return the common JSON envelope plus:

- `baseline_synthesis_status`
- `context_packet_status`
- `findings_created_count`
- `synthesis_receipts`
- `synthesis_notes`

## Handoff

Include baseline decision summary, durable context/finding ids, unresolved blockers, enrichment priorities, missing-data caveats, upstream count reconciliation, and receipts.
