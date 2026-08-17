---
name: baseline-search-market
description: Use only for the baseline search-market step: create an initial keyword/topic program and save first-pass market metrics when available.
---

## When To Use

Use only for `baseline-search-market` after brand evidence is available. This creates the initial topic and tracked keyword query program; prompt generation remains separate.

## Inputs

Expect brand/category/offering context, geography, audience, offering hints, competitor tier summary if available, and compact search/category evidence supplied by Ingest. Use assigned Semrush data where available.

## WorkPods Reads

Read existing tracked topics, tracked keyword queries, brand products/offers, competitors, market metrics, search performance rows, and prior baseline notes. Use reads to avoid duplicate topics and queries.

## Procedure

1. Translate brand/category/offering evidence into customer-search language, not internal jargon.
2. Create a bounded set of tracked topics covering primary category, high-intent offerings, local/geographic modifiers, problems/use cases, and comparison alternatives when supported.
3. Create tracked keyword queries with intent, funnel stage, brand/non-brand classification, geography, priority, and topic linkage.
4. Persist available market/search facts from WorkPods or Semrush: volume, rankings, SERP features, authority, overlap, or visibility only when evidenced.
5. Reconcile topic/query candidates against existing records; count created, reused, skipped-duplicate, and skipped-insufficient-evidence items.
6. Return `INSUFFICIENT_DATA` for unavailable metrics while still completing the topic/query program when evidence supports it.

## Do Not

- Do not duplicate competitor discovery or tracked prompt creation.
- Do not independently search or crawl websites.
- Do not invent volumes, rankings, or metrics.
- Do not overproduce broad speculative queries.

## Required Output Fields

- `query_program_status`
- `topics_created_count`
- `tracked_keyword_queries_created_count`
- `market_metrics_status`
- `market_metrics_receipts`
- `search_market_notes`

If metric data is unavailable, use `INSUFFICIENT_DATA` with a clear note.

## Handoff

Include tracked topic ids/names, keyword themes, created/reused query counts, market/category assumptions, geography, metric availability/caveats, receipts, and prompt-program implications.
