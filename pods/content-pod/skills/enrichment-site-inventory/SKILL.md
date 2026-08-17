---
name: enrichment-site-inventory
description: Use only for enrichment site inventory: expand owned page discovery, page attributes, and crawl coverage from the canonical site.
---

## When To Use

Use only for `enrichment-site-inventory` after Ingest supplies a compact normalized site inventory packet from Browse.

## Inputs

Expect these direct predecessor categories:

- `baseline_synthesis` or brand evidence context.
- `site_inventory`: compact normalized page records with selected URL count, crawled/scraped/returned counts, canonical URL, page type/classification, titles, snippets, status/indexability hints, source URLs, and truncation notes.
- Optional existing page ids/receipts from baseline brand evidence.

## WorkPods Reads

Read existing brand pages, page attributes, products/offers, brand documents, and prior inventory receipts. Use reads to avoid duplicate pages and preserve stronger classifications.

## Procedure

1. Review the supplied normalized inventory; do not request raw pages or raw crawl dumps.
2. Validate and, where necessary, correct semantic page classifications using supplied titles/snippets/path evidence.
3. Persist bounded owned pages with URL, title, page type, lifecycle/conversion role when evidenced, source, and status.
4. Persist page attributes such as title/meta/schema/canonical/indexability/readability/content type only when present in the packet.
5. Reconcile discovered, selected, scraped, returned, persisted, duplicate, skipped, and truncated counts. Preserve Browse truncation and sampling notes.
6. If returned pages are fewer than selected/scraped pages, explain the limitation and continue with the returned subset.

## Do Not

- Do not browse, crawl, fetch raw URLs, parse sitemaps, or expand beyond the normalized packet.
- Do not create the offering catalog, content strategy, technical audit, or lifecycle recommendations here.
- Do not overwrite a stronger existing page classification with weaker packet evidence.

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

Include page ids/receipts, URLs grouped by type, page attribute counts, discovered/selected/scraped/returned/persisted count reconciliation, sampling/truncation notes, and notable inventory gaps for offering, technical, content, and lifecycle steps.
