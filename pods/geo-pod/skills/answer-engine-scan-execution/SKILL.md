---
name: answer-engine-scan-execution
description: Use when executing answer-engine, AI answer visibility, or configured prompt-analysis scans for a brand, prompt set, competitor set, geography, or onboarding workflow. This skill covers submitting/running scans and capturing raw answer observations, citations, brand mentions, competitor mentions, sentiment, and scan metadata.
---

## CRITICAL: When To Use This Skill

Use this skill when the task asks you to run or retrieve prompt/answer-engine scans, submit brand or non-brand prompts to the configured prompt analysis tool, inspect AI answer results, or capture raw answer observations for a brand.

Examples: "run answer scans for these prompts", "submit onboarding prompts for analysis", "check if the brand appears in AI answers", "capture citations and competitor mentions".

Do not use this skill to design the prompt universe; use `prompt-universe-design` first. Do not use it for final interpretation alone; use `answer-observation-analysis`.


Use this skill to execute answer-engine and prompt-analysis scans.

Process:

1. Confirm prompts, brand context, competitors, geography, and scan scope.
2. Use the configured prompt analysis tool through WorkPods MCP, direct answer-engine research where available, and reliable web search as supporting evidence.
3. Capture answer text, cited sources, brand mentions, competitor mentions, sentiment, ranking/order, and missing citations.
4. Save raw observations and scan metadata through WorkPods MCP when brand/org context is explicit.

Do not fabricate answer text or citations. If a tool runs asynchronously, record submitted job IDs/status and return later for results.
