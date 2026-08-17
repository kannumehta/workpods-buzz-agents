---
name: baseline-conversion-path
description: Use only for the baseline conversion-path step: map the visible customer journey and persist first-pass funnel vocabulary.
---

## When To Use

Use for `baseline-conversion-path` after preflight and brand evidence. Do not run analytics attribution or paid-media analysis here.

## Inputs

Use `brand_id`, `canonical_url`, preflight context, and brand-evidence handoff when available.

## Source Priority

1. Homepage navigation, calls to action, product/service pages, forms, carts, booking flows, pricing, and contact pages.
2. Visible conversion copy and page paths.
3. Connected analytics/CRM/ads data only when explicitly available.

## Procedure

1. Identify the primary conversion action: buy, book, call, demo, form, signup, visit store, or contact.
2. Map the visible funnel stages using the brand's own terminology.
3. Persist funnel steps and audience segments if there is enough evidence.
4. Note missing conversion paths, broken CTAs, trust gaps, and unclear next steps.
5. Do not invent lifecycle metrics without connected data.

## Required Output Fields

Return the common JSON envelope plus:

- `conversion_path_status`
- `funnel_steps_found_count`
- `funnel_steps_persisted_count`
- `conversion_path_receipts`
- `conversion_path_notes`

If persisted count is lower than found count, include `funnel_steps_not_persisted_reason`.

## Handoff

Include funnel stages, primary CTA, audience hints, conversion blockers, and URLs inspected.
