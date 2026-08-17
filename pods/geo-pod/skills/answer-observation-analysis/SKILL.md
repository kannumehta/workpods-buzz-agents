---
name: answer-observation-analysis
description: Use when turning raw answer-engine or prompt-analysis observations into structured GEO findings, AI Discovery Score, AI Brand Equity Score, visibility gaps, sentiment, citation quality, and recommendations for a WorkPods brand.
---

## CRITICAL: When To Use This Skill

Use this skill after answer-engine scan results exist and the task asks for interpretation, scoring, rollups, visibility findings, citation quality, sentiment, or recommendations.

Examples: "analyze these answer observations", "calculate AI discovery and brand equity", "summarize prompt visibility results".

Do not use this skill to submit prompts or fetch raw answers; use `answer-engine-scan-execution`.


Use this skill to turn answer-engine observations into structured findings.

Process:

1. Group observations by prompt intent, model/source, geography, buyer stage, and competitor set.
2. Measure visibility, mention quality, citation quality, accuracy, sentiment, and competitive displacement.
3. Roll up non-brand prompts into AI Discovery Score: how often the brand appears for targeted services/products in the relevant market without being named.
4. Roll up brand prompts into AI Brand Equity Score: trust, sentiment, strengths, weaknesses, factual accuracy, and cited proof when the brand is named.
5. Identify the highest-leverage gaps: missing source, weak entity clarity, no comparison page, thin proof, bad reviews, technical blockers.
6. Save findings, scores, and evidence-backed recommendations through WorkPods MCP when brand/org context is explicit.

Separate raw observation from interpretation.
