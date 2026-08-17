---
name: enrichment-final-synthesis
description: Use only for final enrichment synthesis: reconcile enrichment outputs into a final context packet, findings, and next-step priorities.
---

## When To Use

Use after enrichment specialist steps finish, fail, time out, or are explicitly skipped. Consume direct-edge handoffs only.

## Inputs

Expect handoffs from site inventory, offering catalog, PageSpeed audit, search performance, technical audit, competitor expansion, prompt universe, answer scan submit/wait, answer analysis, content strategy, and lifecycle gaps. Some branches may be missing or insufficient.

## WorkPods Reads

Read brand overview, brand documents/context packets, pages, products, competitors, topics, prompt queries, answer analyses, visibility metrics, page quality rows, site issues, content clusters, lifecycle findings, existing findings, and recommendations. Use reads only to reconcile and verify persisted state.

## Procedure

1. Reconcile all enrichment findings into a final brand context packet.
2. Identify the highest-impact opportunities across GEO visibility, content, technical health, and lifecycle conversion.
3. Persist final synthesis/context and findings/recommendations when available.
4. Explicitly tolerate skipped, failed, timed-out, partial, and insufficient-data branches; state practical impact and next-best follow-up.
5. Reconcile upstream discovered/persisted/receipt counts and flag mismatches that affect confidence.
6. Keep the summary client-facing and operational.

## Do Not

- Do not rerun specialist research, browse, crawl, or call Browse directly.
- Do not mention Browse, Firecrawl, Pi, MCP, tokens, prompts, or internal implementation details in client-facing `summary` or `description`.
- Do not hide unavailable connected data or incomplete scans.

## Required Output Fields

Return the common JSON envelope plus:

- `final_synthesis_status`
- `context_packet_status`
- `findings_created_count`
- `final_synthesis_receipts`
- `final_synthesis_notes`

## Handoff

Include final priorities, durable record ids, unresolved blockers, skipped/failed/partial branch effects, count reconciliation, receipts, and recommended follow-up workflows.
