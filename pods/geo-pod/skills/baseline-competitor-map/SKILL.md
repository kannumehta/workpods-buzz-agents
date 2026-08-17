---
name: baseline-competitor-map
description: Use only for the baseline competitor-map step: discover competitors, persist them, and assign primary/secondary tiers before tracked prompt generation.
---

## When To Use

Use for `baseline-competitor-map` after preflight and preferably with brand-evidence context. This step exists so prompt generation can depend on tiered competitors.

## Inputs

Use `brand_id`, `domain`, `canonical_url`, preflight handoff, and brand-evidence handoff when available.

## Source Priority

1. Competitors visible on search results for the brand's core category/geography.
2. Alternatives/comparison pages and marketplace/category lists.
3. Semrush or other SEO suite data when available.
4. Brand-provided or already saved competitors from scoped WorkPods reads.

## Procedure

1. Find direct competitors with overlapping offerings, geography, and customer intent.
2. Persist all useful competitors with name, domain, website URL, country, and short positioning summary.
3. Assign up to 4 primary competitors: closest substitutes or most important rivals for answer visibility.
4. Assign secondary competitors for adjacent or less direct competitors.
5. Persist competitor intelligence when evidence supports it: target customer, pricing model, distribution model, strengths, weaknesses, gaps, differentiators.
6. Do not include directories, media sites, generic marketplaces, or unrelated brands unless they genuinely compete for the customer decision.

## Required Output Fields

Return the common JSON envelope plus:

- `competitor_map_status`
- `competitors_found_count`
- `competitors_persisted_count`
- `primary_competitors_count`
- `secondary_competitors_count`
- `competitor_map_receipts`
- `competitor_map_notes`

If persisted count is lower than found count, include `competitors_not_persisted_reason`.

## Handoff

Include primary and secondary competitor names/domains, tier rationale, and evidence URLs.
