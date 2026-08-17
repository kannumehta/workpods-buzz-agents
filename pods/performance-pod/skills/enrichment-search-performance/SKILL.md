---
name: enrichment-search-performance
description: Use only for enrichment search performance: persist connected search/ranking/SERP metrics when available.
---

## When To Use

Use for `enrichment-search-performance` only when connected search or SEO-suite data is available. If unavailable, return `INSUFFICIENT_DATA` with a clear client-facing explanation.

## Inputs

Expect tracked topics/queries, owned pages, connected source status, Semrush/search evidence packets when available, date ranges, and source limits.

## WorkPods Reads

Read tracked topics, tracked keyword queries, brand pages, existing search performance rows, rankings, SERP features, authority metrics, and source connection status.

## Procedure

1. Match metrics to existing tracked queries/topics and landing pages.
2. Persist search performance rows, ranking rows, SERP feature facts, and authority/visibility metrics only when values are supplied by connected or assigned sources.
3. Record source/date-range coverage and unavailable provider status.
4. Reconcile requested query/page coverage, matched records, persisted metric rows, skipped duplicates, and unavailable metrics.
5. Complete with `INSUFFICIENT_DATA` when no connected or Semrush evidence exists; include what would be needed later.

## Do Not

- Do not browse search results or scrape SERPs.
- Do not invent volume, click, impression, rank, or SERP feature values.
- Do not create new tracked prompt queries; use existing query/topic records.

## Required Output Fields

Return the common JSON envelope plus:

- `search_performance_status`
- `search_performance_rows_persisted_count`
- `rankings_rows_persisted_count`
- `serp_feature_rows_persisted_count`
- `search_performance_receipts`
- `search_performance_notes`

## Handoff

Include source availability, date ranges, query/page coverage, persisted metric counts, ranking/SERP caveats, count reconciliation, receipts, and gaps for final synthesis.
