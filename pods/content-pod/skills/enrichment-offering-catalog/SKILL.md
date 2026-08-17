---
name: enrichment-offering-catalog
description: Use only for enrichment offering catalog: expand product, SKU, service, and offer records from owned pages.
---

## When To Use

Use only for `enrichment-offering-catalog` after Ingest supplies deterministic offering candidates and source evidence.

## Inputs

Expect these direct predecessor categories:

- `site_inventory`: relevant owned page ids/URLs/classifications and sampling limits.
- `offering_candidates`: deterministic product/service/category/family/variant candidates with names, source URLs, snippets, price text, schema hints, and confidence.
- `brand_evidence` or baseline synthesis for category and audience.

## WorkPods Reads

Read existing brand products/offers, product pages, brand pages, brand documents, and prior catalog receipts. Use reads for duplicate merging and idempotent updates.

## Procedure

1. Classify candidates as product, service, plan, category/family, bundle, variant, or reject.
2. Merge semantic duplicates by normalized name, source URL, parent family, and customer choice. Preserve variants only when they matter to buyers.
3. Persist a bounded catalog with name, type, category/family, description, page URL, price/price text, evidence URL, and confidence.
4. Preserve large-catalog sampling, truncation, and skipped-candidate notes.
5. Reconcile candidate, selected, persisted, merged, duplicate, rejected, and truncated counts.
6. Return partial status if only a representative catalog can be persisted from a large or thin packet.

## Do Not

- Do not browse product pages, call Browse directly, or invent SKUs/services.
- Do not discover competitors or run technical/content/lifecycle analysis.
- Do not overwrite existing catalog records with less complete candidates.

## Required Output Fields

Return the common JSON envelope plus:

- `offering_catalog_status`
- `products_found_count`
- `products_persisted_count`
- `offering_catalog_receipts`
- `offering_catalog_notes`

If persisted count is lower than found count, include `products_not_persisted_reason`.

## Handoff

Include persisted product/offer ids, category/family structure, representative variants, source URLs, price notes, large-catalog sampling/truncation notes, count reconciliation, receipts, and catalog gaps for content/lifecycle downstream steps.
