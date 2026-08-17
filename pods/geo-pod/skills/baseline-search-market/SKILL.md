---
name: baseline-search-market
description: Use only for the baseline search-market step: create an initial keyword/topic program and save first-pass market metrics when available.
---

## When To Use

Use for `baseline-search-market` after preflight. Do not create tracked prompts here except when a keyword naturally doubles as a query seed; prompt generation belongs to `baseline-prompt-program`.

## Inputs

Use `brand_id`, `domain`, `canonical_url`, preflight context, and any brand-evidence handoff if provided.

## Source Priority

1. Brand homepage/category language.
2. Search result snippets and visible SERP/category language.
3. Semrush or search-console data when connected and available.

## Procedure

1. Identify the market/category the brand competes in using customer language, not internal jargon.
2. Create a small set of tracked topics for the primary market and geography.
3. Create baseline keyword queries with intent, funnel stage, priority, and brand/non-brand classification.
4. Save available baseline market metrics such as rankings, search volume, authority, overlap, or visibility only when supported by evidence.
5. Do not overproduce: prefer a high-quality seed set over a large speculative list.

## Required Output Fields

Return the common JSON envelope plus:

- `query_program_status`
- `topics_created_count`
- `tracked_keyword_queries_created_count`
- `market_metrics_status`
- `market_metrics_receipts`
- `search_market_notes`

If metric data is unavailable, use `INSUFFICIENT_DATA` with a clear note.

## Handoff

Include tracked topic names, keyword themes, market/category assumptions, geography, and metric caveats.
