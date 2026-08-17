---
name: enrichment-answer-scan-submit
description: Use only for enrichment answer-scan submission: submit existing tracked prompts to answer-engine scan surfaces and return a batch id.
---

## When To Use

Use after the prompt universe exists. Do not wait for long-running results or analyze observations here; Ingest owns the wait step.

## Inputs

Expect prompt universe handoff, tracked prompt ids, priority guidance, brand id, scan surfaces/policy supplied by backend, and any existing scan batch receipts.

## WorkPods Reads

Read tracked prompt queries, topics, competitors, existing scan batches, and recent scan status to avoid duplicate submission.

## Procedure

1. Select a bounded scan-ready set of tracked prompts, favoring high-priority prompts and primary competitor comparisons.
2. Submit the scan through the generic answer-engine scan capability.
3. Return the scan batch id, submitted prompt count, surfaces count, and any skipped prompt reasons.
4. Do not mention provider-specific names. Do not block waiting for completion.
5. Reconcile available, selected, submitted, skipped, duplicate-batch, and receipt counts.
6. If submission capability is unavailable, return `BLOCKED` for submission while preserving the selected prompt set in the handoff.

## Do Not

- Do not browse, search, or create new tracked prompts.
- Do not wait for scan completion or analyze observations.
- Do not name provider-specific internal analysis services.

## Required Output Fields

Return the common JSON envelope plus:

- `answer_scan_submit_status`
- `scan_batch_id`
- `tracked_prompt_queries_submitted_count`
- `scan_surfaces_count`
- `answer_scan_submit_receipts`
- `answer_scan_submit_notes`

## Handoff

Include scan batch id, submitted prompt count, surfaces, selected/skipped prompt ids and reasons, duplicate-batch caveats, receipts, and downstream wait/analysis conditions.
