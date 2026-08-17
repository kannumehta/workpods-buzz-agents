---
name: enrichment-answer-scan-submit
description: Use only for enrichment answer-scan submission: submit existing tracked prompts to answer-engine scan surfaces and return a batch id.
---

## When To Use

Use after the prompt universe exists. Do not wait for long-running results or analyze observations here; Ingest owns the wait step.

## Inputs

Use prompt universe handoff, scoped tracked prompt reads, brand id, and desired answer surfaces.

## Source Priority

1. Persisted tracked prompts from WorkPods.
2. Prompt universe handoff when persisted ids are not available.
3. Existing scan batch reads to avoid duplicate submissions.

## Procedure

1. Select a bounded scan-ready set of tracked prompts, favoring high-priority prompts and primary competitor comparisons.
2. Submit the scan through the generic answer-engine scan capability.
3. Return the scan batch id, submitted prompt count, surfaces count, and any skipped prompt reasons.
4. Do not mention provider-specific names. Do not block waiting for completion.

## Required Output Fields

Return the common JSON envelope plus:

- `answer_scan_submit_status`
- `scan_batch_id`
- `tracked_prompt_queries_submitted_count`
- `scan_surfaces_count`
- `answer_scan_submit_receipts`
- `answer_scan_submit_notes`

## Handoff

Include scan batch id, submitted prompt count, surfaces, expected downstream analysis conditions, and skipped prompts.
