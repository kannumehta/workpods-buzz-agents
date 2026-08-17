---
name: enrichment-prompt-universe
description: Use only for enrichment prompt universe: expand tracked prompts across topics, competitors, lifecycle stages, and buyer intents.
---

## When To Use

Use after competitor expansion and baseline prompt program. Do not submit scans or analyze observations here.

## Inputs

Use competitors, offerings, content clusters when available, baseline prompt themes, search topics, and funnel context.

## Source Priority

1. Existing tracked topics/queries and competitor tiers.
2. Product/offering and content strategy context.
3. Search result language and customer intent patterns.

## Procedure

1. Expand tracked prompts into a bounded universe with brand-mentioned, non-brand, comparison, alternatives, use-case, local/geography, and buying-decision prompts.
2. Attach prompts to relevant topics with intent, funnel stage, priority, and brand classification.
3. Avoid near-duplicate prompts and speculative categories.
4. Persist prompt queries and topics through the scoped WorkPods write surface.

## Required Output Fields

Return the common JSON envelope plus:

- `prompt_universe_status`
- `tracked_prompt_queries_created_count`
- `topics_created_count`
- `prompt_universe_receipts`
- `prompt_universe_notes`

## Handoff

Include prompt groups, topic references, scan-ready subset guidance, and coverage gaps.
