---
name: website-inventory
description: Use when mapping a brand website's pages, sitemap, robots.txt, navigation, footer, top pages, content types, page purposes, indexability notes, stale/thin content, and website structure for WorkPods analysis.
---

## CRITICAL: When To Use This Skill

Use this skill when the task asks to crawl or inspect a website, map pages, classify content types, inspect sitemap/robots/navigation/footer, identify top pages, or create a structured page inventory.

Examples: "map the website", "inventory the domain pages", "classify product, pricing, blog, FAQ, and contact pages".

Do not use this skill to extract the detailed product catalog alone; use `product-service-catalog`.


Use this skill to map a brand website into useful pages and content types.

Process:

1. Crawl or inspect the domain, sitemap, robots.txt, navigation, footer, and high-value internal links.
2. Prefer top pages from Google Search Console clicks when connected; use Semrush Organic Pages as the fallback estimate.
3. Classify pages by purpose: homepage, product/service, pricing, comparison, blog, resource, case study, FAQ, contact, legal, conversion.
4. For v1 technical scoring, score the homepage first and only expand to other top pages when explicitly requested.
5. Identify indexability, canonical issues, duplicate patterns, stale pages, thin pages, and missing key pages.
6. Save page inventory, source period, top-page source, and content observations through WorkPods MCP when brand/org context is explicit.

Prefer structured crawl data and sitemap data over guesses from search snippets.
