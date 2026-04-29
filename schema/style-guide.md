# Style Guide — Citations, Naming & Conventions

> Split from `AGENTS.md`. Rules for citation format, style, and index/log/open-questions conventions.

## Citation rule — per-claim inline

Every numeric value, mechanism description, definition, and asserted relation MUST carry an inline footnote `[^source-id]`. Treat any unfootnoted claim as a defect to be fixed by lint.

```markdown
Hyperliquid pays −0.001% rebate to tier-4+ makers[^hl-fees-2026-03].
50% of the liquidation fee is allocated to the insurance fund[^hl-liq-2026].
```

The footnote `id` matches the `id` field in the corresponding `sources/<id>.md` frontmatter.

## Style rules

- All wiki content in **English** for cross-LLM compatibility, regardless of conversation language.
- One concept per page. If a page exceeds ~400 lines, propose splitting it.
- Use lowercase-hyphen slugs for filenames (`maker-fee.md`, `dydx-v4.md`).
- Wikilinks always relative: `[[entities/perpdex/hyperliquid]]` from elsewhere, or `[[hyperliquid]]` if unambiguous and the wiki tooling resolves it.
- Frontmatter `last_reviewed` updated whenever an LLM touches the page.
- Never guess. If a claim's source is unknown, either find one or omit the claim.
- Prefer "X says Y" framing over bare assertions for any non-mainstream claim.

## Index conventions

`index.md` is grouped by tier and subtype/domain. Each entry: `- [[path]] — one-line summary (sources: N, last_reviewed: date)`.

## Log conventions

`log.md` is append-only. Every entry begins with `## [YYYY-MM-DD HH:MM] {ingest|query|lint|file-back|manual} | ...`. Parseable with `grep "^## \[" log.md`.

## Open questions conventions

`open-questions.md` is a flat list. Each entry: `- [page-link] {question}. Suggested verification: {action}. Raised: YYYY-MM-DD.`

When a question is resolved, move the line to a `## Resolved` section at the bottom with `→ resolved YYYY-MM-DD by [[source-id]]`.

## Audit severity taxonomy (effective from next audit)

Adopted 2026-04-29 to unify severity scales across audit documents. Prior audits (2026-04-27, 2026-04-28) retain their original scales; this taxonomy applies from the next audit onward.

| Level | Criteria |
|---|---|
| CRITICAL | Data integrity violation, schema breach, silent data loss |
| HIGH | Cross-venue comparison broken, coverage gap blocking investigation |
| MEDIUM | Style violation, incomplete rationalization, non-blocking gap |
| LOW | Cosmetic, notation inconsistency, non-functional |
