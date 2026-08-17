---
name: enrichment-technical-audit
description: Use only for enrichment technical audit: persist deeper site issues, site health, tech signals, and technical recommendations.
---

## When To Use

Use after site inventory and PageSpeed audit. Consume compact site inventory and PageSpeed evidence; do not perform broad discovery.

## Inputs

Expect site inventory page groups/attributes, PageSpeed audit handoff, canonical URL, PageSpeed/site issue evidence, and optional compact crawler/search technical facts supplied by Ingest.

## WorkPods Reads

Read brand pages, page attributes, page quality rows, site issues, site health, tech signals, search performance rows, and prior technical receipts.

## Procedure

1. Consolidate duplicate technical issues across inventory and PageSpeed evidence while preserving URL/page scope.
2. Persist site issues, site health counts, page attributes, and tech signals only when directly evidenced.
3. Prioritize issues affecting indexing, crawlability, Core Web Vitals, structured data, citation eligibility, or conversion.
4. Separate measured evidence from inferred recommendations.
5. Reconcile issue-found, issue-persisted, duplicate, skipped, tech-signal, and receipt counts.
6. Return partial status for missing PageSpeed or compact crawler evidence while still persisting supported findings.

## Do Not

- Do not reopen broad website browsing, run a local browser, crawl the site, or fetch raw pages.
- Do not create content strategy or lifecycle recommendations unless they are direct consequences of technical blockers.
- Do not overstate issues that were not directly observed.

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

Include top issues, affected URLs/page ids, severity rationale, site health caveats, tech-stack signals, count reconciliation, receipts, and recommendations for final/content/lifecycle synthesis.
