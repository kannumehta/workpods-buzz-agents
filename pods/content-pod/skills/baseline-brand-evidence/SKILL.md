---
name: baseline-brand-evidence
description: Use only for the baseline brand-evidence step: identify the brand from a submitted domain, save first-party brand facts, owned pages, and obvious products/offers.
---

## When To Use

Use only for `baseline-brand-evidence` after Ingest preflight has resolved the submitted domain and canonical URL and supplied compact `site_evidence`.

## Inputs

Expect these direct predecessor categories in `inputs`:

- `preflight`: submitted domain, canonical URL, redirect notes, reachability status.
- `site_evidence`: compact homepage/about/navigation/contact/product/service evidence with source URLs, titles, snippets, schema hints, and extraction limits.
- Optional existing baseline context from WorkPods.

If `site_evidence` is absent or too thin, read existing scoped WorkPods brand/page/product records and return partial status. Do not fetch pages yourself.

## WorkPods Reads

Read the brand, existing brand documents/facts, brand pages, products/offers, and prior onboarding notes when available. Use reads to avoid duplicates and preserve existing facts that are better supported than the new packet.

## Procedure

1. Establish evidenced brand identity: display name, aliases, canonical URL, category, audience, geography, value proposition, core offering hints, and owned identity pages.
2. Separate durable facts from weak hints. Persist only facts supported by `site_evidence` or existing WorkPods records.
3. Register a bounded owned identity page set: homepage, about/contact, core category/service/product entry pages, pricing if supplied, and key conversion pages when evidenced.
4. Persist initial offering facts only when names/categories are directly evidenced. This is not the complete catalog.
5. Reconcile duplicates against existing pages/products by canonical URL, normalized name, and source URL.
6. Count discovered, selected, persisted, skipped-duplicate, and skipped-insufficient-evidence records.
7. Return `INSUFFICIENT_DATA` for thin evidence, `PARTIAL`/equivalent notes for partial persistence, and `BLOCKED` only when required writes cannot be attempted.

## Do Not

- Do not browse, crawl, map the full site, independently search the web, or call Browse directly.
- Do not overwrite established brand facts with weaker snippets.
- Do not produce a complete product/service catalog; leave that to `enrichment-offering-catalog`.
- Do not create competitor, technical, prompt, or lifecycle records.

## Required Output Fields

- `brand_profile_status`
- `brand_profile_receipts`
- `owned_pages_status`
- `owned_pages_found_count`
- `owned_pages_persisted_count`
- `owned_pages_receipts`
- `products_status`
- `products_found_count`
- `products_persisted_count`
- `products_receipts`
- `brand_evidence_notes`

If persisted count is lower than found count, include `owned_pages_not_persisted_reason` or `products_not_persisted_reason`.

## Handoff

Include compact brand name, aliases, canonical URL, category, audience, geography, core offering hints, selected identity page URLs, product/service hints, evidence URLs, count reconciliation, persistence receipts, and open gaps for competitor/search/prompt downstream steps.
