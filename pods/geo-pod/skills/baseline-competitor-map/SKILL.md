---
name: baseline-competitor-map
description: Use only for the baseline competitor-map step: discover competitors, persist them, and assign primary/secondary tiers before tracked prompt generation.
---

## When To Use

Use only for `baseline-competitor-map` after brand evidence is available and Ingest has supplied Browse-generated competitor candidates.

## Inputs

Expect these direct predecessor categories:

- `brand_evidence`: brand name, category, offering hints, audience, geography, canonical URL.
- `competitor_candidates`: compact candidate list from Browse/Ingest with names, domains, evidence URLs, snippets, source type, rank/confidence, and retrieval limits.
- Existing WorkPods competitor records and baseline map when present.

## WorkPods Reads

Read existing competitors, competitor intelligence, brand facts, tracked topics if present, and prior competitor map documents. Use reads for dedupe, tier preservation, and idempotent updates.

## Procedure

1. Normalize candidate names/domains and merge duplicates with existing competitors.
2. Decide whether each candidate is direct, adjacent, citation/domain-of-interest, or reject. Direct competitors share category, audience, geography, and buyer intent.
3. Assign up to 4 primary competitors and a bounded secondary set. Preserve existing valid primary tiers unless new evidence is stronger.
4. Persist competitors and tier rationale with evidence URLs and short positioning notes.
5. Persist competitor intelligence only when evidence supports it: target customer, pricing/distribution hints, strengths, weaknesses, gaps, differentiators.
6. Reconcile found, selected, persisted, primary, secondary, duplicate, and rejected counts.
7. Report insufficient or partial evidence without failing the whole run; a small high-confidence competitor set is acceptable.

## Do Not

- Do not independently search the web, browse competitor sites, or widen the candidate set beyond supplied evidence and assigned Semrush reads.
- Do not include directories, publishers, marketplaces, or review sites as competitors unless the evidence shows they compete for the same decision.
- Do not replace baseline tiers with weaker evidence or invent positioning.

## Required Output Fields

- `competitor_map_status`
- `competitors_found_count`
- `competitors_persisted_count`
- `primary_competitors_count`
- `secondary_competitors_count`
- `competitor_map_receipts`
- `competitor_map_notes`

If persisted count is lower than found count, include `competitors_not_persisted_reason`.

## Handoff

Include primary and secondary competitor names/domains/ids, direct versus adjacent rationale, rejected-candidate caveats, evidence URLs, count reconciliation, receipts, and prompt/search implications.
