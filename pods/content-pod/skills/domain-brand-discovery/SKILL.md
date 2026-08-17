---
name: domain-brand-discovery
description: Use when a WorkPods workflow starts from only a domain or URL and needs canonical brand identity, business model, market, audience, geography, cities/service areas, social links, and evidence sources before other analysis starts.
---

## CRITICAL: When To Use This Skill

Use this skill when the task starts with a domain, URL, sparse brand record, or missing brand identity and asks you to infer the brand, market, location, operating areas, audience, or reliable source set.

Examples: "onboard this domain", "identify the brand for example.com", "find the operating cities/service areas".

Do not use this skill for full website page inventory; use `website-inventory` after identity is clear.


Use this skill when a workflow starts from only a domain name.

Goal: identify the canonical brand, organization context, primary market, business model, target customers, geography, operating cities/service areas, and reliable evidence sources.

Process:

1. Normalize the domain and resolve the live canonical website.
2. Inspect homepage, about, product, pricing, contact, legal, schema, title/meta, social links, and footer evidence.
3. Cross-check with search results, knowledge panels, business directories, LinkedIn/company pages, and trusted third-party sources.
4. Extract country plus city/service-area signals from address pages, branch/location pages, schema, directories, local SERPs, and footer/contact evidence.
5. Separate observed facts from inferred facts, especially geography and market scope.
6. Save brand identity fields through WorkPods MCP only when an explicit brand/org context is present.

Do not invent company size, revenue, funding, or location. Mark uncertain facts as hypotheses. City-level geography matters because non-brand prompts should use the real market where the brand operates.
