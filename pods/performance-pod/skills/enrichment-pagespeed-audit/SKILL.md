---
name: enrichment-pagespeed-audit
description: Use only for enrichment PageSpeed audit: record page quality scores and PageSpeed-derived issues for important URLs.
---

## When To Use

Use for `enrichment-pagespeed-audit` after site inventory identifies important pages and Ingest or PageSpeed MCP provides measurable page-quality evidence.

## Inputs

Expect canonical URL, compact site inventory handoff, selected audit URLs/page ids, and PageSpeed evidence or permission to use the private PageSpeed MCP assigned to `performance-pod`.

## WorkPods Reads

Read brand pages, existing page quality rows, site issues, site health, and technical audit receipts. Use reads for URL ids and duplicate avoidance.

## Procedure

1. Use supplied PageSpeed evidence first; call the private PageSpeed MCP only when the step context expects fresh measurements and credentials are available.
2. Audit homepage first, then a bounded set of high-value pages from site inventory.
3. Persist mobile and desktop page quality rows when available.
4. Persist actionable site issues tied to URL/page and measured evidence.
5. Separate measured PageSpeed data from semantic/inferred observations.
6. Reconcile selected, measured, persisted, skipped, failed-URL, issue-found, and issue-persisted counts.
7. If PageSpeed is unavailable, return `INSUFFICIENT_DATA` with selected URLs and do not fail unrelated workflow branches.

## Do Not

- Do not install or invoke a local browser, run Playwright, or browse pages yourself.
- Do not crawl extra URLs beyond the selected audit list.
- Do not invent Core Web Vitals or scores.

## Required Output Fields

Return the common JSON envelope plus:

- `pagespeed_audit_status`
- `page_quality_rows_persisted_count`
- `site_issues_found_count`
- `site_issues_persisted_count`
- `pagespeed_receipts`
- `pagespeed_notes`

If persisted count is lower than found count, include `site_issues_not_persisted_reason`.

## Handoff

Include audited URL/page ids, score summary, Core Web Vitals caveats, top issues, selected/measured/persisted count reconciliation, receipts, and technical-audit follow-up priorities.
