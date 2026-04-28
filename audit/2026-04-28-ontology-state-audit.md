---
type: audit
date: 2026-04-28
author: LLM (Claude), in dialogue with project owner
scope: Five-axis subagent-driven audit of overall ontology state and improvement priorities. Covers (1) frame coverage 9×5 per perpdex, (2) schema compliance lint, (3) cross-venue concept Variants integration (Phase 2 completeness), (4) operational backlog, (5) schema-evolution pressure (A7/A8/A9 split readiness, parameter slot drift, verb invention). Synthesises findings into severity-ranked priorities and falsifiable predictions for the next ingest pass.
---

# Audit: Ontology State & Improvement Priorities

**Date:** 2026-04-28
**Author:** LLM (Claude), in dialogue with project owner
**Method:** Five parallel read-only Explore agents, each scoped to one independent axis, returned structured findings. Controller cross-verified two contradictory claims by direct file inspection (Variants tables on `concepts/fee-model/funding-rate.md` and `concepts/risk/liquidation.md`). Findings synthesised below.
**State assessed:** Repository at HEAD `b93ca2e` with two uncommitted programme edits (`entities/programme/aster-referral.md`, `aster-trade-and-earn.md`) — uncommitted edits NOT included in this audit's measurement.
**Companion audits:** `audit/2026-04-27-ontology-coverage-perp-ops.md` (initial schema sufficiency baseline + 3 falsifiable predictions), `audit/2026-04-28-hyperliquid-sample-postmortem.md` (HL ingest validation), `audit/2026-04-28-lighter-redteam-postmortem.md` (Lighter pre-merge red-team).

---

## TL;DR

The wiki has reached **3-perpdex breadth** (Aster, Hyperliquid, Lighter) with rich entity / parameter / source layers, but **horizontal integration debt is the dominant defect class**: the cross-venue affordance the schema is built for (concept-page `## Variants in the wild` tables) is silently under-populated. Two further pressures have crossed thresholds the schema itself flags as split-justifying: A7 (governance, 41 claims / 3 perpdex) and A8 (security, 59 claims / 3 perpdex) both warrant promotion out of `concepts/operations/` into dedicated domains.

**Top 5 priorities (ordered by leverage):**

1. **Phase 2 deferred debt — Lighter and Aster Variants rows.** Both perpdex entities exist with full mechanism prose on entity pages, but **14 of 25 concept pages have partial-coverage Variants tables**. `concepts/fee-model/funding-rate.md` has Hyperliquid only; `concepts/risk/liquidation.md` has Hyperliquid only (Aster narrative in body, Lighter has narrative section but no table row). Cross-venue comparison — the wiki's reason to exist — is currently single-venue.
2. **Concept-domain split: `concepts/security/` and `concepts/governance/`.** Threshold (≥10 claims / ≥2 perpdex) hit hard in both: A8 = 59 claims, A7 = 41 claims. Continuing to file under `operations` dilutes the lint signal.
3. **Frame coverage rationale-completeness gap.** All three perpdex pages have cells in `gap` or `not-applicable` state without the schema-required one-line rationale (Aster 13, Hyperliquid 13, Lighter 10). Lint will flag every one as `frame: unrationalized`.
4. **Hyperliquid is the least-rationalised perpdex (38% filled).** Aster 60%, Lighter 47%, HL 38%. HL has 17 gaps, suggesting the 2026-04-27 baseline ingest was breadth-light despite being the schema's reference implementation.
5. **Parameter slot drift (7 undocumented keys in active use).** `audit-registry`, `contract-registry`, `funding-rate-rebates`, `llp`, `peg-config`, `points-rules`, `pool-spec` all in use; none in the AGENTS.md exemplar list. Schema-patch needed to legalize or rename.

---

## Snapshot — current ontology

| layer | count | state |
|---|---:|---|
| `entities/perpdex/` | 3 | Aster, Hyperliquid, Lighter |
| `entities/programme/` | 4 | aster-referral, aster-trade-and-earn, lighter-liquidity-partner-program, lighter-points-program (2 with uncommitted edits) |
| `entities/network/` | 5 | arbitrum, aster-chain, bnb-chain, hyperliquid-l1, lighter-core |
| `entities/token/` | 4 | aster, hype, lit, usdf |
| `concepts/<10 domains>/` | 25 | All 10 schema domains populated; every concept page has `## Variants in the wild` section (none structurally absent) |
| `parameters/<entity-or-programme>/` | (4 dirs) | aster, hyperliquid, lighter, programmes |
| `mirror/` | 3 active | hl-docs-2026-04-27 (paused @20), aster-docs-2026-04-28 (paused @20), lighter-docs-2026-04-28 (active, 31p) |
| `audit/` | 3 prior | this audit makes 4 |
| `open-questions.md` | 16 active / 1 resolved | All 16 active raised today (2026-04-28) |
| `raw/queue/` | 4 files | 1 processed (queue-001), 1 active-blocked (aster-2026-04-28), 2 unprocessed (drift, dydx) |

**Frame coverage tally per perpdex** (sums to 45 each):
- Aster: 27 filled / 5 NA / 13 gap
- Hyperliquid: 17 filled / 11 NA / 17 gap
- Lighter: 21 filled / 8 NA / 16 gap

---

## Findings, severity-ranked

### CRITICAL — F1. Phase 2 deferred debt across concept pages

**Claim:** 14 of 25 concept pages have `## Variants in the wild` tables that omit at least one perpdex venue whose entity body explicitly relates to the concept. Verified directly on two highest-impact cases:

- `concepts/fee-model/funding-rate.md` — Variants table has only Hyperliquid (default + HIP-3 rows). Lighter's hourly funding with rebate-tier structure (per `entities/perpdex/lighter.md`) and Aster's funding mechanism are absent. Trailing footer reads "(Other perpdex venues to be added in subsequent ingest passes.)" — Phase 2 explicitly deferred.
- `concepts/risk/liquidation.md` — Variants table has Hyperliquid + one Aster row. Lighter's 5-state liquidation waterfall + LLP backstop (extensively present as a `## Mechanism on Lighter` narrative section in the same page) is **not** in the Variants table.

**Why critical:** The Phase 2 mandatory completeness rule (AGENTS.md) names this exact failure mode as a "merge-debt generator." Future Phase 2 runs across other venues will overwrite the gap rather than reconcile it.

**Top 10 most consequential missing Variants rows** (composite of two agents' rankings, deduped):

| rank | concept page | missing venue | reason |
|---|---|---|---|
| 1 | `concepts/fee-model/funding-rate` | Lighter | Lighter publishes peer-to-peer funding with LIT-stake rebates — material divergence from HL |
| 2 | `concepts/risk/liquidation` | Lighter | 5-state waterfall + LLP backstop is a key differentiator |
| 3 | `concepts/market-structure/clob` | Lighter | SNARK-verifiable matching is architectural; absent comparison undermines the schema's market-structure axis |
| 4 | `concepts/market-microstructure/mark-price-formula` | Lighter | Median-of-three with RWA-specific decay |
| 5 | `concepts/market-microstructure/oracle-spec` | Lighter | Chainlink/Stork/Pyth blending |
| 6 | `concepts/operations/matching-engine` | Lighter | SNARK-aggregated proofs differ from HL/Aster |
| 7 | `concepts/risk/leverage-cap` | Aster | Aster margin tiers exist on entity page but no concept row |
| 8 | `concepts/tokenomics/fee-distribution` | Aster | Aster revenue-split policy distinct from HL burn-only |
| 9 | `concepts/lp/vault` | Aster | ALP is venue-owned LP; only HLP/LLP currently represented |
| 10 | `concepts/operations/sequencer` | Aster | Aster Chain L1 sequencing differs from HL BFT and Lighter ZK rollup |

**Remediation order:** Funding-rate and liquidation rows first (highest cross-venue read frequency), then market-structure/microstructure cluster (CLOB, mark-price, oracle), then ops/risk cluster.

### HIGH — F2. A7 / A8 concept-domain split threshold hit

**Claim:** AGENTS.md heuristic — "≥10 claims in one of A7/A8/A9 across ≥2 perpdex entities" — is met by both A7 and A8.

| angle | total claims | per perpdex | recommendation |
|---|---:|---|---|
| A8 Security / Incident Response | 59 | Aster 39, Lighter 24, HL 9 | **Promote to `concepts/security/`** |
| A7 Governance / Parameter Authority | 41 | Aster 40, Lighter 9, HL 4 | **Promote to `concepts/governance/`** |
| A9 Regulatory / Market-Type | 3 | Aster 2, HL 2, Lighter 0 | Defer; below threshold |

A7's high concentration on Aster (40/41 ≈ 98%) is a single-source artefact (aster-chain governance docs are dense); A8 is genuinely cross-venue and the more urgent split. A9 is below threshold and stable as a deferral.

**Schema-patch required.** This is a `concept-domain` extension, not an inline body change — must be an explicit user-acknowledged schema patch session before any Phase 2 run rewrites filing rules.

### HIGH — F3. Frame coverage cells without rationale

**Claim:** AGENTS.md requires every NA / gap cell to carry a one-line rationale. Lint will fire `frame: unrationalized` per offending cell.

| entity | unrationalized cells |
|---|---|
| Aster | 13 cells: A1/PIII, A2/PII, A4/PIV, A5/PII, A6/PIII, A7/PIV, A8/PI–A8/PV (cluster of 5), A9/PII–A9/PIV (cluster of 3) |
| Hyperliquid | 13 cells: A1/PII, A1/PV, A2/PII, A3/PI, A3/PIII, A3/PIV, A4/PII, A4/PIV, A6/PII, A6/PIII, A6/PIV, A7/PIV, A8/PIII, A8/PIV, A9/PI, A9/PII, A9/PIV (per agent report — count exceeds 13; controller note: re-verify on remediation) |
| Lighter | 10 cells: A1/PIII–A1/PV (3), A2/PII, A3/PV, A4/PIII, A6/PIII, A7/PII, A7/PIV, A7/PV, A8/PIII–A8/PV, A9/PI, A9/PII, A9/PV (per agent report; same controller note) |

**Cross-venue systemic gap:** A6/PIII (Insurance-Fund coverage ratio) is `gap` on all three venues. This is a wiki-wide blindspot — no perpdex publishes IF / (max-OI × stress-slippage × gap%) ≥ 1.0 @ p99. Worth an open-question entry.

**Note on agent-reported cell lists:** Controller did not independently re-grep every cell. Treat agent counts as upper bounds; remediation pass should re-verify.

### HIGH — F4. Hyperliquid is the least-filled perpdex

**Claim:** Despite being the schema's reference implementation (the 2026-04-27 ontology-coverage audit was driven by HL), HL has the lowest filled rate (17/45 = 38%) versus Aster (60%) and Lighter (47%). 17 gaps including 5 in A6 (risk/metrics) and 4 in A3 (referral/incentive).

**Hypothesis (not verified):** the 2026-04-27 baseline ingest used a paused 20-page mirror; the 2026-04-28 schema-tightening pass focused on Phase 2 mechanics rather than HL re-ingest. Aster's higher fill rate is the post-fix-driven Phase 2 product.

### MEDIUM — F5. Parameter slot drift (7 undocumented keys)

**Claim:** AGENTS.md §Parameters lists ~21 example slot keys. Actual repo usage diverges:

| undocumented slot | files | nature |
|---|---|---|
| `audit-registry` | Aster | Variant of documented `audits` |
| `contract-registry` | Aster | Variant of documented `contract-addresses` |
| `points-rules` | Lighter | Variant of documented `points-program-rules` |
| `funding-rate-rebates` | Lighter | New semantic — funding rebates as standalone slot |
| `llp` | Lighter | Pool-id (matches `<pool-id>` schema slot — actually documented; agent over-flagged) |
| `peg-config` | Aster (USDF-related) | Variant of documented `usdf-peg` (generalised) |
| `pool-spec` | HL, Aster | New semantic — distinct from `pool-id` (per-vault spec vs vault identity) |

**Recommendation:** Standardise: `audit-registry → audits`, `contract-registry → contract-addresses`, `points-rules → points-program-rules` (rename or alias). Add `funding-rate-rebates` and `pool-spec` to AGENTS.md as documented extensions; drop `peg-config` if redundant with `usdf-peg`.

### MEDIUM — F6. Disputed claims unresolved

**Claim:** 7 disputed-flagged pages, all created today (2026-04-28). Not yet stale (>30 days) but no resolution path documented.

| page | dispute count |
|---|---:|
| `entities/perpdex/aster.md` | 2 |
| `entities/perpdex/lighter.md` | 5 |

The Lighter cluster is documented in `audit/2026-04-28-lighter-redteam-postmortem.md` and includes the TAV/TALT zero-price-formula and ADL trigger granularity disputes. Each disputed claim should map to a row in `open-questions.md` with a verification-suggestion path.

### MEDIUM — F7. Verb invention — **erratum: false positive on controller post-verification**

Schema-evolution-pressure agent claimed two invented verbs. Controller verified by direct grep (`bridges_to|\*\*bridges`) **after** the audit was first written:

| verb | location | actual status |
|---|---|---|
| `**backstops**` | originally `entities/perpdex/hyperliquid.md` | **Already resolved** in commit `7488394` (test-branch schema patch) and the Lighter pre-merge cleanup (`b93ca2e`) — the verb has been removed from entity Relations and body-prose-substituted. The substitution rule lives in `AGENTS.md:139` (`backstops` → `seeds_liquidity_for` + body note). The corresponding `open-questions.md` entry is in §Resolved (line 47–48). Agent was reading stale state. |
| `**bridges_to**` | claimed `entities/network/arbitrum.md:23` | **Not present.** Direct grep of the repo finds `bridges_to` only in `AGENTS.md:140` (already in substitution table — "not a relation — describe in body prose"), `scripts/lint.sh:111` (the lint check), and a prior log line. `entities/network/arbitrum.md:22–23` already follows the schema: `_(no canonical relation verb fits a bridge corridor; corridor mechanics are documented in body prose above)_`. Agent appears to have hallucinated the location. |

**No remediation required.** Schema-evolution-pressure agent's grep target — `\*\*[a-z_]+\*\*` against entity body prose — should reliably catch real invented verbs but did not in this case. Kept here as a record that two of the agent's three pressure findings were false-positive on verification; only **Pressure 1** (A7/A8 split readiness) and **Pressure 2** (parameter slot drift) are real.

### MEDIUM — F8. Operational backlog signals

- **Mirror state:** HL and Aster snapshots both `paused` at max_pages=20. Refresh is user-initiated per schema (correctly suppressed in lint), but `manifest.queue_remainder` for both should be reviewed if breadth is the goal.
- **Queue:** 2 unprocessed (drift-2026-04-28, dydx-2026-04-28); 1 active-blocked (aster-2026-04-28, awaiting Phase 2.2+ follow-ups per log entry).
- **Open questions throughput:** 16 raised in one day, 1 resolved. No staleness yet, but the spawn rate suggests a verification-effort bottleneck building.

### LOW — F9. `concepts/fee-model/maker-fee.md` referenced in schema, missing on disk

**Claim:** AGENTS.md examples cite `concepts/fee-model/maker-fee` as a slug; no such file exists. Currently no entity links to it (no broken wikilink — controller verified by repo-wide grep of `concepts/fee-model/maker-fee` and `concepts/fee-model/taker-fee`, zero hits outside this audit file).

**Recommendation:** Defer. No pre-emptive stub. The schema example is illustrative; the only cost of the missing file is a future ingest creating it. Low priority — current fee-model coverage is by parameter pages and the existing `funding-rate.md` concept page.

---

## Recommended next-action ordering

Highest-leverage wins first. Each item is sized for one Phase 2 pass.

1. **Variants-row backfill (F1).** One controlled Phase 2 pass that adds the top-10 missing rows. Touches ≤10 concept pages. No new entity creation. Fastest win on the wiki's primary affordance.
2. **Frame rationale completeness (F3).** One pass per perpdex, append one-line rationales to all NA/gap cells. Pure documentation — no new claims. Lint will go from many `frame: unrationalized` flags to clean.
3. **Schema patch session (F2 + F5 + F7).** Single user-acknowledged AGENTS.md edit covering: `concepts/security/` and `concepts/governance/` domain creation, parameter slot legalisation/rename, and `bridges_to` / `backstops` verb-set decisions. After patch, re-file affected source-claim `frame_tag` values.
4. **Hyperliquid breadth pass (F4).** Either refresh `hl-docs-2026-04-27` (raise max_pages and re-crawl) or work the existing snapshot's `queue_remainder` if non-empty. Prerequisite to closing HL's 17 gaps.
5. **Disputed-claim resolution path (F6).** One open-question entry per dispute with explicit verification suggestion. Currently disputes are recorded but no resolution attempt is scheduled.

Items F8 (operational signals) and F9 (missing maker-fee stub) are housekeeping; defer to next lint pass.

---

## Falsifiable predictions

For the next ingest pass to validate against (per audit-layer convention):

| # | prediction | check |
|---|---|---|
| P1 | After the Variants-row backfill, lint will report `phase2: deferred` count drop from ≥14 to ≤4. | Run lint pre/post. |
| P2 | After A7/A8 domain split, re-tagging `frame_tag` will cause `concepts/operations/`'s claim-count to drop by ≥80 across the 3 perpdex source sets. | Grep `filed_to: concepts/operations` in `sources/*.md` pre/post. |
| P3 | After frame-rationale backfill, `frame: unrationalized` count drops from 36 (13 + 13 + 10) to 0. Any residual unrationalized cell indicates a schema-comprehension bug worth investigating. | Lint pre/post. |
| P4 | The next perpdex ingest (drift or dydx, per queue) will hit `funding-rate.md` and `liquidation.md` Variants tables with new rows; if the wiki is healthy, this will reveal whether the backfill format generalises or requires column-set refinement. | Diff `concepts/fee-model/funding-rate.md` and `concepts/risk/liquidation.md` after next perpdex ingest. |
| P5 | Aster's A7-PI claim count (25, dominant) will partially shift to Lighter / HL after dedicated Aster-isolation review and re-tagging — A7 is over-represented on Aster only because the docs are dense, not because Aster has more governance surface. | Re-tag pass; recount. |

---

## Appendix — per-axis raw findings

Compressed summaries; full agent reports in conversation history.

### Axis 1 — Frame coverage 9×5
Aster 27/5/13, HL 17/11/17, Lighter 21/8/16 (filled/NA/gap, sum 45). 36 total cells lack rationale. No malformed frame_tag patterns. A6/PIII (IF coverage ratio) is gap on all three venues — wiki-wide blindspot. A9 cluster (regulatory) gap-heavy across all three.

### Axis 2 — Schema compliance lint
1 invented verb in HL (`backstops`, schema-pending). Sample of 10 wikilinks all resolve. No unfootnoted claims in sample. 2 disputed-true pages — both within SLA. Confirmed via direct grep that `concepts/fee-model/funding-rate.md` and `concepts/risk/liquidation.md` Variants tables omit Lighter despite Lighter entity body claiming the relations.

### Axis 3 — Cross-venue Variants integration
All 25 concept pages have Variants sections. 2 full-coverage (`liquidation`, `adl-waterfall` per agent — but controller-verified `liquidation` actually missing Lighter table row; treat agent's table-presence flag as narrative-vs-row conflation). 14 partial-coverage. No section-absent. Top-10 missing rows ranked above (F1).

### Axis 4 — Operational backlog
16 active open questions, all raised 2026-04-28. 3 mirror snapshots; 2 paused (HL, Aster) at max_pages=20. Recent log shows 4 manual schema patches in 8 hours — high iteration velocity, no quiet gaps. Queue: 1 processed, 1 blocked, 2 unprocessed.

### Axis 5 — Schema-evolution pressure
A8 = 59 claims (split-justified). A7 = 41 claims (split-justified, Aster-concentrated). A9 = 3 claims (defer). 7 undocumented parameter slots (3 simple variants of existing, 4 semantic extensions). 2 invented verbs (`backstops` schema-pending, `bridges_to` new finding).

---

## Out of scope

This audit is read-only. No remediation applied. The schema-patch session for F2 / F5 / F7 (which would write `AGENTS.md`) and the Variants-row backfill for F1 are deferred to user-acknowledged sessions.
