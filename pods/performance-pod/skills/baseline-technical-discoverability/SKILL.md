---
name: baseline-technical-discoverability
description: Use only for the baseline technical-discoverability step: perform a fast homepage-level technical and discoverability check.
---

## When To Use

Use for `baseline-technical-discoverability` after preflight. Do not run a deep crawl or full PageSpeed audit here; those belong to enrichment.

## Inputs

Use `brand_id`, `domain`, `canonical_url`, and preflight reachability/TLS notes.

## Source Priority

1. Direct homepage fetch/render.
2. Page metadata, canonical tags, robots/meta directives, schema, title/meta description, hreflang, and basic mobile/render evidence.
3. PageSpeed/Page quality tools only if readily available and bounded.

## Procedure

1. Check homepage reachability, canonical consistency, title/meta, indexability hints, schema presence, viewport/mobile basics, and visible navigation.
2. Identify obvious technical issues that block search or answer citation.
3. Record page attributes, site issues, and tech signals when available.
4. Keep findings baseline-level: do not create long audit inventories.

## Required Output Fields

Return the common JSON envelope plus:

- `technical_discoverability_status`
- `technical_checks_count`
- `site_issues_found_count`
- `site_issues_persisted_count`
- `technical_receipts`
- `technical_notes`

If persisted count is lower than found count, include `site_issues_not_persisted_reason`.

## Handoff

Include canonical/indexability notes, key site issues, and technical blockers for later enrichment.
