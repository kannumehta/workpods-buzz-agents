---
name: baseline-brand-evidence
description: Use only for the baseline brand-evidence step: identify the brand from a submitted domain, save first-party brand facts, owned pages, and obvious products/offers.
---

## When To Use

Use for `baseline-brand-evidence` after preflight has resolved the submitted domain and canonical URL. Do not do full site inventory, competitor research, technical audit, or lifecycle analysis.

## Inputs

Use `brand_id`, `domain`, `canonical_url`, and the `baseline-preflight` handoff. If canonical URL is unavailable, try the submitted domain directly and report the limitation.

## Source Priority

1. Brand homepage and linked about/contact/product/service/category pages.
2. Structured page metadata, visible navigation, footer, and schema data.
3. Search/web research only to resolve brand identity ambiguity.

Do not invent facts that are not visible or strongly evidenced.

## Procedure

1. Confirm the brand name, aliases, homepage URL, one-line description, industry/category, product type, primary country/market, and geography.
2. Inspect only the homepage and a bounded set of obvious high-value pages linked from navigation.
3. Identify owned pages worth registering: homepage, category/service/product pages, about/contact, pricing, key landing pages.
4. Identify obvious products/offers with names, category, short description, page URL, and price text when visible.
5. Persist only brand profile, owned pages, products/offers, and a compact brand evidence note/document if available.
6. Keep receipts compact. If a write tool is unavailable, mark the affected status as `BLOCKED` and explain.

## Required Output Fields

Return the common JSON envelope plus:

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

Include compact brand name, aliases, canonical URL, primary categories, products/offers, geography, and evidence URLs.
