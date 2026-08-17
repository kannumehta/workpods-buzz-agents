---
name: enrichment-offering-catalog
description: Use only for enrichment offering catalog: expand product, SKU, service, and offer records from owned pages.
---

## When To Use

Use for `enrichment-offering-catalog` after site inventory. Do not discover competitors or run technical audits.

## Inputs

Use site inventory handoff, owned page reads, baseline brand evidence, and visible product/service/category pages.

## Source Priority

1. Product/service/category pages and structured product data.
2. Pricing, collections, navigation labels, and page copy.
3. Search snippets only to clarify product naming.

## Procedure

1. Extract the most important products, SKUs, services, plans, or offer categories.
2. Save each item with name, category, description, page URL, price/price text when visible, and evidence URL.
3. Avoid duplicate variants unless they represent distinct customer choices.
4. Record a compact offer-catalog note or context packet when useful.

## Required Output Fields

Return the common JSON envelope plus:

- `offering_catalog_status`
- `products_found_count`
- `products_persisted_count`
- `offering_catalog_receipts`
- `offering_catalog_notes`

If persisted count is lower than found count, include `products_not_persisted_reason`.

## Handoff

Include primary offers, categories, product URLs, price notes, and unresolved catalog gaps.
