---
name: baseline-synthesis
description: Use only for the baseline synthesis step: summarize baseline findings, persist a context packet, and create prioritized findings.
---

## When To Use

Use after all required baseline specialist steps finish or are explicitly skipped. Do not redo specialist research unless a small verification is needed to avoid an incorrect synthesis.

## Inputs

Use direct handoffs from preflight, brand evidence, competitor map, search market, technical discoverability, conversion path, and prompt program.

## Procedure

1. Reconcile the baseline into a compact brand context packet: positioning, offers, audience, geography, primary competitors, prompt themes, technical blockers, conversion blockers, and known limitations.
2. Create findings only for evidenced opportunities/problems. Separate facts from recommendations.
3. Prioritize findings by severity, confidence, business impact, and whether they affect answer visibility or onboarding readiness.
4. Persist the context packet/document and findings/recommendations when tools are available.

## Required Output Fields

Return the common JSON envelope plus:

- `baseline_synthesis_status`
- `context_packet_status`
- `findings_created_count`
- `synthesis_receipts`
- `synthesis_notes`

## Handoff

Include baseline decision summary, unresolved blockers, next enrichment priorities, and durable reference ids where available.
