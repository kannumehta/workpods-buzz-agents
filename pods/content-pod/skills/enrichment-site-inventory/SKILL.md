---
name: enrichment-site-inventory
description: Use only for enrichment site inventory: expand owned page discovery, page attributes, and crawl coverage from the canonical site.
---

## When To Use

Use for `enrichment-site-inventory` at the start of enrichment. Do not run product catalog, PageSpeed audit, or content strategy here except for page-level facts needed by downstream steps.

## Inputs

Use `brand_id`, `domain`, `canonical_url`, baseline context, sitemap/robots if available, and existing brand page reads.

## Source Priority

1. Sitemap, robots, canonical homepage links, and top navigation.
2. Bounded crawl/render of important page templates.
3. Existing scoped WorkPods pages to avoid duplicates.

## Procedure

1. Discover a bounded but useful page set: homepage, core category/service pages, product pages, blog/resources, comparison/landing pages, contact/conversion pages.
2. Save owned pages with URL, title, content type, and lifecycle status.
3. Record page attributes such as title/meta presence, schema hints, canonical/indexability, readability, and content type when available.
4. Do not create content recommendations here; content strategy runs later.

## Required Output Fields

Return the common JSON envelope plus:

- `site_inventory_status`
- `owned_pages_found_count`
- `owned_pages_persisted_count`
- `page_attributes_persisted_count`
- `site_inventory_receipts`
- `site_inventory_notes`

If persisted count is lower than found count, include `owned_pages_not_persisted_reason`.

## Handoff

Include key page URLs grouped by type, page ids/receipts, crawl limits, and notable inventory gaps.
