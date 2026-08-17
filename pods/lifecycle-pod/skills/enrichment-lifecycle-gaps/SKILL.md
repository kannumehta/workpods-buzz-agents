---
name: enrichment-lifecycle-gaps
description: Use only for enrichment lifecycle gaps: analyze conversion, audience, funnel, and channel gaps from visible and connected data.
---

## When To Use

Use after enrichment site inventory and offering catalog evidence are available. Baseline conversion-path may be absent in the Browse-backed public DAG.

## Inputs

Expect compact site inventory, offering catalog evidence, key conversion/identity pages, baseline synthesis, connected source status, and optional existing lifecycle records.

## WorkPods Reads

Read brand pages, products/offers, audience segments, funnel metrics, channel attribution, findings, recommendations, and existing lifecycle documents. Use reads for duplicate prevention and data availability.

## Procedure

1. Infer funnel stages from supplied page roles, CTAs, forms/contact pages, pricing/offering pages, trust proof, and conversion page evidence.
2. Identify gaps in funnel clarity, lead capture, offer-to-CTA alignment, trust proof, retention/nurture, audience segmentation, and channel attribution.
3. Persist lifecycle facts, findings, audience/funnel records, and recommendations only when supported by supplied or connected evidence.
4. Record connected-data availability separately from visible-site observations.
5. Reconcile gaps found, lifecycle records persisted, findings persisted, recommendation receipts, skipped duplicates, and insufficient-data reasons.
6. Complete with partial status when connected analytics/CRM/ads data is unavailable.

## Do Not

- Do not browse or inspect pages outside the compact inventory.
- Do not invent conversion volumes, revenue, LTV, or attribution metrics without connected data.
- Do not write competitor, answer analysis, technical audit, or content strategy records except for directly supporting findings.

## Required Output Fields

Return the common JSON envelope plus:

- `lifecycle_gaps_status`
- `lifecycle_gaps_found_count`
- `lifecycle_findings_persisted_count`
- `lifecycle_gaps_receipts`
- `lifecycle_gaps_notes`

## Handoff

Include lifecycle gaps, affected funnel stages, evidence page ids/URLs, recommended fixes, data availability caveats, count reconciliation, receipts, and final-synthesis priorities.
