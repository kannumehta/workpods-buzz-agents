---
name: baseline-brand-foundation
description: Use only for the public baseline brand-foundation write step: persist brand identity, important owned pages, and primary offerings from compact evidence.
---

## When To Use

Use only for `baseline-brand-foundation` after Ingest has supplied compact brand packet, homepage evidence, offering evidence, and light site inventory. This is a baseline write step, not a discovery step.

## Inputs

Expect direct predecessor handoffs for:

- `baseline-prepare-brand-packet`: typed brand facts, confidence, evidence URLs, aliases, category, audience, geography, value proposition, and gaps.
- `baseline-homepage-extract`: compact homepage/title/meta/navigation/schema/CTA/evidence snippets.
- `baseline-offering-extract`: source-grounded product/service/offering candidates and retrieval counts.
- `baseline-light-site-inventory`: bounded important owned pages and page-family counts.

If one branch is thin or failed, use the remaining evidence and mark the affected field status as `INSUFFICIENT_DATA`. Do not block the whole step unless WorkPods writes cannot be attempted.

## WorkPods Reads

Read the current brand, existing brand facts/context, owned pages, products/offers, and prior onboarding notes when available. Use reads only to deduplicate and preserve better existing facts.

## Procedure

1. Normalize evidenced brand identity: display name, aliases, canonical URL, category, business model, audience, geography, value proposition, and positioning.
2. Separate durable facts from weak hints. Persist only facts supported by supplied evidence or stronger existing WorkPods records.
3. Register a bounded owned-page set where supported: homepage, about/contact, core product/service/category pages, pricing/plans, docs/resources, and conversion pages when evidenced.
4. Normalize and persist up to 8-10 primary offerings/products/services. Prefer named offers with source URLs and descriptions; avoid generic navigation labels.
5. Reconcile duplicates by canonical URL, normalized name, and existing record ids.
6. Inspect write receipts. If a write tool returns a warning or partial result, include it in receipts or notes and continue with the rest of the batch.
7. Reconcile found, reviewed, selected, persisted, excluded, failed, and truncated counts. Explain any gap between found/reviewed/selected/persisted counts.

## Do Not

- Do not browse, crawl, scrape, search the web, or call Browse directly.
- Do not create competitor, market/search, answer visibility, technical, lifecycle, or prompt records.
- Do not invent products, locations, audience, or positioning that are not supported by the evidence.
- Do not overwrite established brand facts with weaker snippets.

## Required Output Fields

Return the common JSON envelope plus every field requested in the output contract, including:

- `brand_profile_status`
- `brand_profile_receipts`
- `owned_pages_status`
- `owned_pages_found_count`
- `owned_pages_reviewed_count`
- `owned_pages_persisted_count`
- `owned_pages_receipts`
- `products_status`
- `products_found_count`
- `products_reviewed_count`
- `products_persisted_count`
- `products_receipts`
- `found_count`
- `reviewed_count`
- `selected_count`
- `persisted_count`
- `excluded_count`
- `failed_count`
- `truncated_count`
- `brand_foundation_notes`

If a status is not `PERSISTED` or `NOT_APPLICABLE`, include the matching notes field. Counts must be integers and receipt fields must be arrays.

## Handoff

Include compact persisted brand facts, primary offering names/ids/URLs, important page ids/URLs, evidence URLs, count reconciliation, receipts, and open gaps for market-position and synthesis steps.
