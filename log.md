# Log

Append-only chronological record. Entry format:

```
## [YYYY-MM-DD HH:MM] {ingest|query|lint|file-back|manual} | <subject> | <one-line summary>
```

Tip: `grep "^## \[" log.md | tail -10` shows recent activity.

---

## [2026-04-27 14:44] manual | bootstrap | Wiki initialized with AGENTS.md schema (entities/concepts/parameters tiers, per-claim citations, time-series parameters, dispute preservation). Empty directory skeleton created.

## [2026-04-27 14:55] manual | mirror-layer | Added mirror/ as second persistence layer. Layout: mirror/<snap-id>/{manifest.yaml, pages/}. Crawl boundary: same host + same path prefix. Refresh: versioned (old snapshot kept, status=superseded). Ingest is now three-phase (recon → parallel mirror crawl → parallel claim extract → sequential merge). All ontology work reads from mirror/, not live URLs.

## [2026-04-27 15:05] manual | crawler-default | Crawler order set: exa MCP primary, WebFetch fallback. Per-page actual-crawler recorded in manifest.

## [2026-04-27 15:10] manual | refresh-policy | Refresh is user-initiated only. Ingest reuses any existing active snapshot regardless of age (no 30-day window). Lint reports mirror ages but never suggests refresh. Added mirror/_index.md as snapshot rollup for "when was X last refreshed?" queries.

## [2026-04-27 15:25] manual | ontology-expand | Expanded ontology for Perp Operations Lead context. Added entity subtype: mm-firm. Added 6 concept domains: market-microstructure, tokenomics, listing, incentives, mm-agreement, metrics. Extended risk/operations/lp domains. Added per-market parameter convention (parameters/<venue>/markets/<symbol>.md with contract-spec time-series + lifecycle events). Added 5 relation verbs: quotes_on, partners_with, distributes_to, subsidizes, seeds_liquidity_for. Index.md updated with new sections.

## [2026-04-27 16:55] manual | perpdex-frame | Added "Per-platform investigation frame (perpdex)" section to AGENTS.md. 9 angles (6 mechanism: launch / fee / referral / MM / spot-LP / risk + 3 governance: governance-authority / security-incident / regulatory-classification) × 5 cross-cutting patterns (quality≠quantity / onboarding↔offboarding / toxic-flow / stack-accounting / SLA-contracting) = 45-cell coverage matrix. Applies to perpdex subtype only; other subtypes untouched. Inline tag convention `[frame: A<n>-P<X>]` in source Claims-extracted table. Lint workflow extended with per-entity frame-coverage report (`<filled>/45` + lowest-coverage cells + `frame: untagged` flag). Page templates unchanged. Frame derived from light exa recon across 7 platforms (HL/Aster/Orderly/Drift/Lighter/dYdX-v4/Uniswap-v4) + 7 parallel red-team subagents probing each angle for table-stakes operator considerations.

## [2026-04-27 17:10] manual | perpdex-frame-fix | Applied 3 critic-driven fixes to perpdex frame after adversarial verification (verdict: PARTIAL→MEANINGFUL). (1) Source template Claims-extracted table gained `frame_tag` column with regex `^A[1-9]-P(I|II|III|IV|V)(, ...)*$` — replaces inline free-text tag for parseability. (2) Subtype gating moved from "perpdex only" to "1-hop transitive" — claims on token/actor/programme/parameter/network entities are in scope when their 1-hop neighborhood includes a perpdex; fixes HYPE-buyback-style spillover. (3) Coverage matrix replaced "empty is valid" with tri-state (`filled` / `not-applicable` with rationale / `gap` with reason) recorded in entity page `## Frame coverage` section — restores diagnostic signal. Added Angle↔domain mapping table (A1↔listing, A2↔fee-model+tokenomics, ..., A7-9↔operations partial with new-domain proposal trigger ≥10 claims × ≥2 entities). Filing rule: domain wins over frame_tag on disagreement. Lint extended with `frame: malformed` and `frame: unrationalized` checks.
