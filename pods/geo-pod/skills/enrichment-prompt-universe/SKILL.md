---
name: enrichment-prompt-universe
description: Use only for enrichment prompt universe: expand tracked prompts across topics, competitors, lifecycle stages, and buyer intents.
---

## When To Use

Use after competitor expansion and baseline prompt program. Do not submit scans or analyze observations here.

## Inputs

Expect baseline prompt program, competitor expansion, offering catalog, content clusters when available, search topics/keyword themes, geography, and funnel context.

## WorkPods Reads

Read tracked topics, tracked keyword queries, tracked prompt queries, competitors, products/offers, content clusters, and prior prompt receipts.

## Procedure

1. Expand tracked prompts into a bounded universe with brand-mentioned, non-brand, comparison, alternatives, use-case, local/geography, and buying-decision prompts.
2. Attach prompts to relevant topics with intent, funnel stage, priority, and brand classification.
3. Avoid near-duplicate prompts and speculative categories.
4. Persist prompt queries and topics through the scoped WorkPods write surface.
5. Reconcile candidate, created, reused, duplicate, skipped, topic-linked, and receipt counts.
6. If offering or competitor evidence is partial, expand only supported prompt groups and report missing coverage.

## Do Not

- Do not browse, search, submit scans, or analyze observations.
- Do not name provider-specific prompt-analysis systems; use generic answer-engine terminology.
- Do not create prompts for unsupported categories or competitors.

## Required Output Fields

Return the common JSON envelope plus:

- `prompt_universe_status`
- `tracked_prompt_queries_created_count`
- `topics_created_count`
- `prompt_universe_receipts`
- `prompt_universe_notes`

## Handoff

Include prompt groups, topic references, scan-ready subset guidance, competitor/offering coverage gaps, count reconciliation, receipts, and skipped prompt reasons.
