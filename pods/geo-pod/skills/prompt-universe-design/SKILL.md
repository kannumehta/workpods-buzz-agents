---
name: prompt-universe-design
description: Use when designing brand, non-brand, competitor comparison, competitor-only, local/geographic, buyer-intent, pricing, alternative, and lifecycle prompts for answer-engine analysis of a WorkPods brand.
---

## CRITICAL: When To Use This Skill

Use this skill when the task asks to create prompts, build a prompt universe, define brand/non-brand prompts, create competitor comparison prompts, or prepare prompts for the configured prompt analysis tool.

Examples: "build onboarding prompts", "create non-brand local prompts", "design competitor comparison prompts".

Do not use this skill to run scans; use `answer-engine-scan-execution` after prompts are approved or ready.


Use this skill to build the prompt set for answer-engine analysis.

Process:

1. Build prompts from audience, use case, category, problem, comparison, alternative, pricing, implementation, local/geographic, and lifecycle intent.
2. Treat this as prompt design, not topic submission. Each top topic should usually contribute one clear prompt before expanding.
3. Include brand-mentioned prompts, non-brand category prompts, competitor comparison prompts, and competitor-only prompts.
4. Mark every prompt as `brand` when it names the client brand or `non_brand` when it measures discovery without naming the brand.
5. Use verified operating cities/service areas in non-brand local prompts, for example "best {category} in {city}".
6. For a lightweight onboarding run, prefer 5-7 non-brand prompts and 2-3 brand prompts unless the task asks for a larger paid-account set.
7. Prioritize prompts by buyer relevance and expected impact.
8. Save prompt definitions through WorkPods MCP and submit them to the configured prompt analysis tool when brand/org context is explicit.

Never mention vendor-internal implementation names in outputs or skill text.
