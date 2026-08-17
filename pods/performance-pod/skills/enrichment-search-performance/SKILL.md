---
name: enrichment-search-performance
description: Use only for enrichment search performance: persist connected search/ranking/SERP metrics when available.
---

## When To Use

Use for `enrichment-search-performance` only when connected search or SEO-suite data is available. If unavailable, return `INSUFFICIENT_DATA` with a clear client-facing explanation.

## Inputs

Use tracked topics/queries, owned pages, connected source status, and available search/SEO metrics.

## Source Priority

1. Connected Google Search Console or equivalent first-party source.
2. SEO suite keyword/ranking/SERP data when available.
3. Existing WorkPods query/page records for ids and dedupe.

## Procedure

1. Record search performance rows for known tracked queries and landing pages.
2. Record ranking and SERP feature facts when available.
3. Record source status for connected/unavailable providers.
4. Do not invent volume, click, impression, or ranking values.

## Required Output Fields

Return the common JSON envelope plus:

- `search_performance_status`
- `search_performance_rows_persisted_count`
- `rankings_rows_persisted_count`
- `serp_feature_rows_persisted_count`
- `search_performance_receipts`
- `search_performance_notes`

## Handoff

Include source availability, date range, query/page coverage, and metric gaps.
