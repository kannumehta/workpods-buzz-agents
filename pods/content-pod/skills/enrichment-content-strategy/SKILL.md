---
name: enrichment-content-strategy
description: Use only for enrichment content strategy: map clusters, page coverage, content gaps, and content recommendations.
---

## When To Use

Use after site inventory, offering catalog, and prompt universe are available. Do not run technical audits or answer observation analysis here.

## Inputs

Use site inventory, offering catalog, prompt universe, tracked topics/queries, owned pages, and baseline synthesis.

## Source Priority

1. Owned pages and product/category pages.
2. Tracked prompts and keyword/query topics.
3. Competitor/content gap evidence from search results or available SEO data.

## Procedure

1. Create or update content clusters that match the brand's real offers and customer intents.
2. Link relevant terms/prompts to clusters and assign pages to clusters where ids/URLs are known.
3. Identify content gaps that block answer visibility, citations, or conversion.
4. Persist content recommendations and findings with evidence.
5. Do not invent future pages without clearly marking them as recommendations.

## Required Output Fields

Return the common JSON envelope plus:

- `content_strategy_status`
- `content_clusters_persisted_count`
- `content_gaps_found_count`
- `content_recommendations_persisted_count`
- `content_strategy_receipts`
- `content_strategy_notes`

## Handoff

Include clusters, page coverage gaps, recommended content briefs, and evidence references.
