---
name: enrichment-final-synthesis
description: Use only for final enrichment synthesis: reconcile enrichment outputs into a final context packet, findings, and next-step priorities.
---

## When To Use

Use after enrichment specialist steps finish or are explicitly skipped. Do not rerun specialist work except for a small read needed to resolve a contradiction.

## Inputs

Use direct handoffs from site inventory, offering catalog, PageSpeed audit, technical audit, competitor expansion, prompt universe, answer analysis, content strategy, and lifecycle gaps.

## Procedure

1. Reconcile all enrichment findings into a final brand context packet.
2. Identify the highest-impact opportunities across GEO visibility, content, technical health, and lifecycle conversion.
3. Persist final synthesis/context and findings/recommendations when available.
4. Be explicit about missing connected data, incomplete scans, unreachable pages, or low-confidence assumptions.
5. Keep the summary client-facing and operational.

## Required Output Fields

Return the common JSON envelope plus:

- `final_synthesis_status`
- `context_packet_status`
- `findings_created_count`
- `final_synthesis_receipts`
- `final_synthesis_notes`

## Handoff

Include final priorities, durable record ids, unresolved blockers, and recommended follow-up workflows.
