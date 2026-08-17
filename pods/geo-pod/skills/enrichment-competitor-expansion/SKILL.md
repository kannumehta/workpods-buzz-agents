---
name: enrichment-competitor-expansion
description: Use only for enrichment competitor expansion: deepen competitors, intelligence, and market metrics beyond the baseline set.
---

## When To Use

Use after baseline competitor map. Do not change primary competitor tiers unless stronger evidence clearly warrants it and the write surface supports idempotent updates.

## Inputs

Use baseline competitor handoff, tracked topics/queries, search market context, Semrush/SEO data when available, and scoped competitor reads.

## Source Priority

1. Existing primary/secondary competitors from WorkPods.
2. Search/SERP/category overlap and SEO-suite overlap data.
3. Competitor websites and comparison pages.

## Procedure

1. Expand or refine competitor list with direct and adjacent competitors.
2. Persist competitor intelligence and metrics: authority, overlap, visibility, strengths, weaknesses, gaps, differentiators.
3. Keep tier changes conservative and evidence-backed.
4. Exclude publishers/directories unless they are important citation or visibility domains rather than competitors.

## Required Output Fields

Return the common JSON envelope plus:

- `competitor_expansion_status`
- `competitors_found_count`
- `competitors_persisted_count`
- `market_metrics_rows_persisted_count`
- `competitor_expansion_receipts`
- `competitor_expansion_notes`

If persisted count is lower than found count, include `competitors_not_persisted_reason`.

## Handoff

Include expanded competitor ids/domains, metric caveats, and opportunity gaps.
