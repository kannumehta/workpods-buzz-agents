---
name: enrichment-answer-analysis
description: Use only for enrichment answer analysis: analyze completed answer observations and persist mention, citation, competitor, and visibility facts.
---

## When To Use

Use after `enrichment-answer-scan-wait` indicates observations are available or a partial timeout still has analyzable observations. Do not submit new scans unless explicitly required by the blueprint context.

## Inputs

Expect scan batch id, available observations, timeout/partial status, tracked prompts, brand pages, competitor map, prompt universe, and relevant visibility reads or handoffs.

## WorkPods Reads

Read scan batch, observations, tracked prompts, brand pages, competitors, answer analyses, cited pages, page citations, visibility summaries, and existing findings.

## Procedure

1. Analyze each available observation for answer shown, brand named, brand domain cited, brand page cited, answer format, mentions, rank/order, sentiment, recommendation strength, themes, and factual errors.
2. Persist answer analysis rows in batch when available, or one-by-one if necessary.
3. Persist aggregate AI visibility metrics and evidenced findings.
4. Separate observed answer behavior from recommendations.
5. Promote untracked brand mentions only when they are real competitors and evidence supports it.
6. Reconcile observations available, analyzed, persisted, skipped, visibility rows persisted, competitor promotions, and receipts.
7. If the scan timed out or returned partial observations, analyze the available subset and mark the status as partial/insufficient rather than failing the whole run.

## Do Not

- Do not submit new scans, browse, search, or call provider-specific systems directly.
- Do not infer mentions/citations that are not present in observations.
- Do not promote directories/publishers as competitors without evidence.
- Do not mention provider-specific internal analysis services.

## Required Output Fields

Return the common JSON envelope plus:

- `answer_analysis_status`
- `observations_analyzed_count`
- `answer_analyses_persisted_count`
- `ai_visibility_rows_persisted_count`
- `answer_analysis_receipts`
- `answer_analysis_notes`

If persisted count is lower than analyzed count, include `answer_analyses_not_persisted_reason`.

## Handoff

Include mention/citation patterns, competitor promotion decisions, prompt groups with weak visibility, factual error themes, partial-scan caveats, count reconciliation, receipts, and prioritized findings for content/final synthesis.
