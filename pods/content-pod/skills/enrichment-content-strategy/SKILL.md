---
name: enrichment-content-strategy
description: Use only for enrichment content strategy: map clusters, page coverage, content gaps, and content recommendations.
---

## When To Use

Use after site inventory, offering catalog, and prompt universe are available. Do not run technical audits or answer observation analysis here.

## Inputs

Expect compact site inventory, normalized offering catalog, prompt universe handoff, tracked topics/queries, owned page ids, baseline synthesis, and optional answer-analysis gaps if available.

## WorkPods Reads

Read brand pages, page attributes, products/offers, content clusters, content cluster terms, tracked topics/queries, tracked prompt queries, competitors, findings, and prior recommendations.

## Procedure

1. Create or update content clusters that match real offers, customer intents, tracked topics, and prompt themes.
2. Link relevant terms/prompts to clusters and assign existing pages to clusters where ids/URLs are known.
3. Identify content gaps blocking answer visibility, citations, category coverage, comparison coverage, or conversion.
4. Persist content recommendations and findings with evidence from supplied inventory/offering/prompt handoffs.
5. Reconcile clusters, linked terms, page assignments, gaps found, recommendations persisted, skipped duplicates, and receipts.
6. If prompt universe or catalog evidence is partial, produce a supported subset and call out missing inputs.

## Do Not

- Do not browse or search for extra content ideas.
- Do not run technical audits or answer observation analysis.
- Do not invent future pages as facts; mark them as recommendations.

## Required Output Fields

Return the common JSON envelope plus:

- `content_strategy_status`
- `content_clusters_persisted_count`
- `content_gaps_found_count`
- `content_recommendations_persisted_count`
- `content_strategy_receipts`
- `content_strategy_notes`

## Handoff

Include clusters, assigned pages, linked terms/prompts, content gaps, recommended briefs, evidence references, count reconciliation, receipts, and final-synthesis priorities.
