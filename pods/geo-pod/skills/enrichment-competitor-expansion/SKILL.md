---
name: enrichment-competitor-expansion
description: Use only for enrichment competitor expansion: deepen competitors, intelligence, and market metrics beyond the baseline set.
---

## When To Use

Use after baseline competitor map and after Ingest supplies enrichment competitor candidates or assigned Semrush overlap evidence.

## Inputs

Expect baseline competitor handoff, enrichment competitor candidates, tracked topics/queries, search market context, Semrush/SEO overlap data when available, and candidate retrieval limits.

## WorkPods Reads

Read existing competitors, competitor intelligence, competitor overlap, authority/visibility metrics, tracked topics/queries, and baseline map receipts.

## Procedure

1. Normalize enrichment candidates and merge against the baseline map.
2. Add only evidence-supported direct or adjacent competitors; record important non-competitor domains as visibility/citation context only when the write surface supports it.
3. Refine intelligence and metrics: authority, overlap, visibility, strengths, weaknesses, gaps, differentiators, and evidence source.
4. Preserve baseline primary tiers unless stronger evidence clearly justifies an update.
5. Reconcile candidate, added, updated, reused, rejected, metric-row, and receipt counts.
6. Treat missing Semrush or thin candidate evidence as `INSUFFICIENT_DATA` for metrics, not a whole-step failure.

## Do Not

- Do not independently search or browse competitor websites.
- Do not replace valid baseline tiers with weaker enrichment data.
- Do not turn publishers/directories/marketplaces into competitors unless they compete directly.

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

Include added/updated/reused competitor ids/domains, preserved or changed tier rationale, metric caveats, opportunity gaps, count reconciliation, and receipts for prompt universe and answer analysis.
