---
name: baseline-prompt-program
description: Use only for the baseline prompt-program step: create and persist a small tracked prompts seed set from brand, market, and tiered competitor context.
---

## When To Use

Use for `baseline-prompt-program` after brand evidence, search market, and baseline competitor map are complete. Do not run answer scans or analyze observations here.

## Inputs

Use brand facts, primary/secondary competitors, market topics, keyword themes, geography, and funnel context.

## Source Priority

1. Current workflow handoffs from brand evidence, search market, and competitor map.
2. Scoped WorkPods reads for existing topics/queries to avoid duplicates.
3. Light web/search evidence only to resolve missing category language.

## Procedure

1. Create a compact balanced tracked prompts program.
2. Include brand-mentioned prompts, non-brand category prompts, competitor-comparison prompts, alternatives prompts, geography/local prompts when relevant, and lifecycle/buying-decision prompts.
3. Attach each prompt to the most relevant tracked topic and set intent, funnel stage, brand classification, and priority.
4. Persist only prompts that are grounded in known brand/category/competitor evidence.
5. Do not name any provider-specific prompt analysis system. Use generic answer-engine scan language.

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

Include prompt themes, topic names, counts by prompt type, and primary competitor references.
