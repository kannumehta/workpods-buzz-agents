---
name: baseline-prompt-program
description: Use only for the baseline prompt-program step: create and persist a small tracked prompts seed set from brand, market, and tiered competitor context.
---

## When To Use

Use for `baseline-prompt-program` after brand evidence, search market, and baseline competitor map are complete. Do not run answer scans or analyze observations here.

## Inputs

Expect direct handoffs from:

- `baseline-brand-evidence`: brand identity, category, audience, geography, offering hints.
- `baseline-competitor-map`: tiered primary/secondary competitors and rationale.
- `baseline-search-market`: tracked topics, keyword themes, geography, intent/funnel coverage.

## WorkPods Reads

Read tracked topics, tracked keyword queries, existing tracked prompt queries, competitors, brand products/offers, and prompt-program notes. Use reads for topic ids and duplicate prevention.

## Procedure

1. Produce a bounded baseline tracked prompts program balanced across brand-mentioned, non-brand category, competitor comparison, alternatives, local/geography, use-case, and buying-decision prompts.
2. Attach each prompt to a known topic when possible; include intent, funnel stage, brand classification, priority, and competitor references.
3. Use generic answer-engine scan terminology only.
4. Persist only prompts grounded in known brand/category/competitor evidence.
5. Reconcile candidate, created, reused, skipped-duplicate, and skipped-insufficient-evidence counts.
6. If evidence is partial, create the supported subset and report the missing category/competitor inputs without failing the run.

## Do Not

- Do not name provider-specific internal analysis services.
- Do not submit scans, wait for results, or analyze observations.
- Do not independently browse or search to invent prompt themes.
- Do not create near-duplicate prompts just to increase counts.

## Required Output Fields

Return the common JSON envelope plus:

- `prompt_program_status`
- `tracked_prompt_queries_created_count`
- `brand_mention_prompts_count`
- `non_brand_prompts_count`
- `competitor_comparison_prompts_count`
- `prompt_program_receipts`
- `prompt_program_notes`

## Handoff

Include prompt groups, topic ids/names, counts by prompt type, primary competitor references, skipped categories and reasons, receipts, and scan-ready subset guidance.
