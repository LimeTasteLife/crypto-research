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

## [2026-04-27 17:30] manual | audit-layer | Added audit/ as 6th meta-layer (append-only schema/ontology audits, not part of content graph). First audit committed: audit/2026-04-27-ontology-coverage-perp-ops.md — verdict that ontology is sufficient to start substantive HL ingest, with 3 remaining structural gaps (per-pool data location, programme outcome KPI time-series, token asset profile) flagged as falsifiable predictions for the in-progress Hyperliquid sample run to validate. Audit also tracks 6 new risks introduced by the perpdex frame and lists 8 validation checks for the post-sample re-audit.

## [2026-04-28 00:00] manual | schema-patch-g1-g4-g11 | Patched 5 confirmed gaps from HL sample run (mirror G1-G4 + source G11). (1) manifest.yaml schema: added optional `queue_remainder` (in-scope URLs not crawled this run, e.g. paused at max_pages or llms.txt-discovered overflow) and `notes` (free-form crawl-anomaly log) fields. (2) Phase 0.5 contract: added step 4a "sparse-link fallback" — if seed yields <3 in-scope outbound links AND host serves /llms.txt or /sitemap.xml, seed BFS from canonical doc index (handles GitBook/Docusaurus/Mintlify JS-rendered nav). (3) Phase 0.5 contract: 404-with-redirect-hint follows redirect once, recorded in notes, not charged against retry budget. (4) Lint: definitional claims filed to generic concepts/ pages may carry `frame_tag: -` (legitimate-empty) — distinct from blank (untagged defect). Untagged threshold raised from 5% to 10%; `-`-marked rate up to 30% acceptable for definition-heavy primary doc sources. frame_tag regex extended to `^(A[1-9]-P(I|II|III|IV|V)(, ...)*|-)$`. Predicted-but-unconfirmed gaps (audit Gap 1-3: per-pool slot, programme KPI, token asset profile) deferred until Phase 2 produces evidence.
