---
name: enrichment-lifecycle-gaps
description: Use only for enrichment lifecycle gaps: analyze conversion, audience, funnel, and channel gaps from visible and connected data.
---

## When To Use

Use after baseline conversion path and enrichment site inventory. Do not run paid/CRM metric analysis unless connected data is available.

## Inputs

Use baseline conversion path, site inventory, offering catalog when available, connected source status, and scoped lifecycle reads.

## Source Priority

1. Visible website funnel and CTA evidence.
2. Connected analytics/CRM/ads data when available.
3. Existing funnel/audience/channel records from WorkPods.

## Procedure

1. Identify gaps in funnel clarity, conversion steps, trust proof, lead capture, retention, audience segmentation, and channel attribution.
2. Persist lifecycle facts and findings only when supported by visible or connected data.
3. Do not invent conversion volumes, revenue, LTV, or attribution metrics without connected data.
4. Produce practical recommendations tied to funnel/audience stages.

## Required Output Fields

Return the common JSON envelope plus:

- `lifecycle_gaps_status`
- `lifecycle_gaps_found_count`
- `lifecycle_findings_persisted_count`
- `lifecycle_gaps_receipts`
- `lifecycle_gaps_notes`

## Handoff

Include lifecycle gaps, affected funnel stages, recommended fixes, evidence URLs, and data availability caveats.
