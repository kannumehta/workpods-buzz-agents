---
name: baseline-market-position
description: Use only for the public baseline market-position write step: persist search-market context and competitor tiers from compact evidence.
---

## When To Use

Use only for `baseline-market-position` after Ingest has supplied a typed brand packet, market search evidence, competitor search evidence, and competitor page evidence. This is a baseline write step, not a discovery step.

## Inputs

Expect direct predecessor handoffs for:

- `baseline-prepare-brand-packet`: brand/category/audience/geography/offer context.
- `baseline-market-search`: compact market/category terms, intent clusters, source queries, and result counts.
- `baseline-competitor-search`: bounded competitor candidate evidence and exclusions.
- `baseline-competitor-extract`: compact selected competitor homepage/page evidence.

If competitor evidence is thin, persist the high-confidence subset and mark the rest as `INSUFFICIENT_DATA` or excluded with rationale.

## WorkPods Reads

Read existing competitors, competitor intelligence, tracked topics, tracked keyword queries, market metrics, and prior baseline notes. Use reads for dedupe, tier preservation, and idempotent updates.

## Procedure

1. Normalize market/category terminology into customer-search language, not internal jargon.
2. Persist a bounded initial topic/query program covering category, primary offerings, buyer problems/use cases, geography, and comparison intent when supported.
3. Normalize competitor candidates by domain/name and merge duplicates with existing competitors.
4. Classify competitors as primary, secondary, adjacent, or excluded/noise. Primary competitors should share category, audience, geography, and buyer intent.
5. Persist up to 3-6 high-confidence competitors with tier rationale, source URLs, and concise positioning evidence.
6. Persist market/search facts or metrics only when supplied by evidence or available WorkPods records. Do not invent volume, rankings, or authority.
7. Inspect write receipts and reconcile candidate, reviewed, selected, persisted, excluded, failed, and truncated counts.

## Do Not

- Do not browse, crawl, scrape, search the web, or call Browse directly.
- Do not create tracked prompts or submit answer-engine scans in baseline.
- Do not include directories, publishers, marketplaces, or review sites as competitors unless evidence shows they compete for the same buyer decision.
- Do not replace existing valid tiers with weaker baseline evidence.

## Required Output Fields

Return the common JSON envelope plus every field requested in the output contract, including:

- `market_position_status`
- `market_terms_status`
- `topics_created_count`
- `tracked_keyword_queries_created_count`
- `competitors_status`
- `candidate_count`
- `reviewed_count`
- `selected_count`
- `persisted_count`
- `excluded_count`
- `failed_count`
- `truncated_count`
- `primary_competitors_count`
- `secondary_competitors_count`
- `adjacent_competitors_count`
- `market_position_receipts`
- `market_position_notes`

If a status is not `PERSISTED` or `NOT_APPLICABLE`, include the matching notes field. Counts must be integers and receipt fields must be arrays.

## Handoff

Include persisted topic/query ids, market/category assumptions, competitor names/domains/ids/tiers, direct versus adjacent rationale, rejected-candidate caveats, evidence URLs, count reconciliation, receipts, and open gaps for enrichment.
