---
name: enrichment-technical-audit
description: Use only for enrichment technical audit: persist deeper site issues, site health, tech signals, and technical recommendations.
---

## When To Use

Use after site inventory and PageSpeed audit. Do not create content strategy or lifecycle recommendations here unless they are direct consequences of technical blockers.

## Inputs

Use site inventory, PageSpeed audit handoff, canonical URL, owned page reads, and available crawler/search data.

## Source Priority

1. PageSpeed/page quality results and direct rendered-page inspection.
2. Sitemap/robots/canonical/indexation evidence.
3. Tech-stack evidence from headers, scripts, structured data, and page markup.

## Procedure

1. Consolidate duplicate technical issues and preserve page/url scope.
2. Record site issues, site health counts when measurable, page attributes, and tech signals.
3. Prioritize issues that affect indexing, crawling, Core Web Vitals, citation eligibility, or conversion.
4. Do not overstate issues that were not directly observed.

## Required Output Fields

Return the common JSON envelope plus:

- `technical_audit_status`
- `site_issues_found_count`
- `site_issues_persisted_count`
- `tech_signals_persisted_count`
- `technical_audit_receipts`
- `technical_audit_notes`

If persisted count is lower than found count, include `site_issues_not_persisted_reason`.

## Handoff

Include top issues, affected URLs, severity rationale, site health caveats, and tech-stack signals.
