---
name: enrichment-pagespeed-audit
description: Use only for enrichment PageSpeed audit: record page quality scores and PageSpeed-derived issues for important URLs.
---

## When To Use

Use for `enrichment-pagespeed-audit` after canonical URL is known and preferably after site inventory identifies important pages.

## Inputs

Use canonical URL, site inventory handoff, owned page reads, and PageSpeed MCP results when available.

## Source Priority

1. PageSpeed/Page quality MCP for mobile and desktop.
2. Direct page fetch/render for obvious fallback checks.
3. Existing page quality/site issue reads to avoid duplicate issues.

## Procedure

1. Audit homepage first, then a small set of important pages if budget allows.
2. Record mobile and desktop quality rows when available.
3. Record actionable site issues tied to URL/page when possible.
4. Separate measured PageSpeed data from inferred technical observations.

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

Include audited URLs, score summary, Core Web Vitals caveats, and top issues.
