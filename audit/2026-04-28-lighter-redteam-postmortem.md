---
type: audit
date: 2026-04-28
author: LLM (Claude), in dialogue with project owner
scope: Postmortem of the 6-agent red-team review pass on the Phase 2.1 + 2.2 Lighter ingest, prior to commit. Catalogues the 10 high-severity remediations applied, the medium-severity items deferred, and the schema implications surfaced.
---

# Audit: Lighter Ingest Red-Team Postmortem

**Date:** 2026-04-28
**Author:** LLM (Claude), in dialogue with project owner
**Scope:** Six adversarial subagent passes audited the Phase 2.1 + 2.2 Lighter ingest before commit. The agents probed (1) frame-coverage rationale, (2) framing drift / borrowed structure, (3) dispute completeness, (4) source-cite plumbing, (5) cross-platform consistency vs HL, and (6) orphan / parse-broken artefacts. This postmortem records the high-severity items remediated in this branch, the medium-severity items intentionally deferred, and the schema-level implications.
**Method:** Each red-team agent surfaced findings with severity. The 10 high-severity items below were applied as point-edits in this commit; medium-severity items are filed for the next ingest pass.
**State assessed:** Lighter ingest immediately before commit on 2026-04-28.
**Linked log entries:** `lighter-phase-2.2` (01:36), `lighter-redteam-fix` (this entry).
**Companion audit:** `audit/2026-04-27-ontology-coverage-perp-ops.md` — the Hyperliquid-sample-driven baseline whose validation predictions this Lighter ingest also implicitly tests.

---

## High-severity items (fixed)

All 10 items below were applied in the same commit as this audit. See `log.md` `lighter-redteam-fix` entry for the cross-referenced summary.

| # | Item | Files touched |
|---|---|---|
| 1 | **Frame coverage re-rate.** Five `filled` cells flipped to `gap` with new rationales: A1/PIV (portfolio-cannibalization stack accounting absent; integrator-fee stacking belongs at A2/PIV), A2/PII (no announce-window protocol; only an ad-hoc 2026-04-15 RWA Premium-fee resume timestamp), A3/PV (no affiliate/referrer SLA template — partner-attribution is a per-user signature mechanic), A4/PIII (no markout-window or toxicity-class segregation in maker rebates), A8/PV (bug-bounty page is "Coming soon" stub; no externally signed disclosure-policy / safe-harbor template). Coverage summary line updated `26 / 8 / 11 = 45` → `21 / 8 / 16 = 45`. | `entities/perpdex/lighter.md` |
| 2 | **Two new Disputed blocks.** Disputed #4 (zero-price formula base: TAV per trading-liquidations vs TALT per multi-asset-margin; status `likely_superseded` because TALT collapses to TAV when collateral is USDC-only); Disputed #5 (ADL trigger granularity: LLP-wide exhaustion per trading-liquidations vs per-strategy depletion per LLP-strategies; status `active` because the per-strategy trigger fires earlier and the boundary is operationally material). Two corresponding rows appended to `open-questions.md`. | `entities/perpdex/lighter.md`, `open-questions.md` |
| 3 | **Leverage-ladder citation.** Added `[^lighter-docs-2026-04-28-trading-contract-specifications]` to the margin-tiers Parameters bullet on the lighter entity page and to the leverage-range sentence on `concepts/risk/liquidation.md`; the source defines #c5–#c16 covering all leverage tiers. Cite definition added to the liquidation page's `## Sources`. | `entities/perpdex/lighter.md`, `concepts/risk/liquidation.md` |
| 4 | **Removed orphan footnote definitions.** The lighter entity page defined `[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications]` but never cited it; deleted, and `sources_count` bumped `31 → 30`. The LLP parameter page defined `[^lighter-docs-2026-04-28-trading-public-pools]` but never cited it; deleted. | `entities/perpdex/lighter.md`, `parameters/lighter/llp.md` |
| 5 | **Pipe-broken table row in source file.** Source-claim row #c4 used `\|pos_i\|` (literal absolute-value bars) which broke markdown table-cell parsing. Replaced every `\|pos_i\|` occurrence in that row with `abs(pos_i)`; the row now parses as exactly 4 cells (id, claim, filed_to, frame_tag). | `sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund.md` |
| 6 | **Verb-set conformance fixes.** `runs` (non-canonical) → `runs_on` (canonical) on `entities/network/lighter-core.md` line ~42, with subject and object flipped to match canonical direction. `gates` (non-canonical) → `applies_to` (canonical) on `entities/token/lit.md` line ~48. `backstops` retained on `entities/perpdex/lighter.md` line ~65 because HL's `entities/perpdex/hyperliquid.md` uses the same verb (precedent established). A verb-set proposal filed in `open-questions.md` to add `backstops` (and possibly `gates`) to the AGENTS.md canonical relation set. | `entities/network/lighter-core.md`, `entities/token/lit.md`, `open-questions.md` |
| 7 | **New `## Risks` section.** Inserted between `## Snapshot` and `## Mechanism` on the lighter entity page. Three risk clusters: (i) high regulatory surface with no published per-product legal opinion (FX / commodities / Korean equities / RWA / prelaunch all stacked); (ii) ZK-rollup operational scaffolding only partially documented (sequencer-failure recovery, prover-stall fallback, Escape-Hatch trigger deadline not surfaced); (iii) explicit callout of the five red-team-driven `gap` re-rates with a pointer to `## Frame coverage`. | `entities/perpdex/lighter.md` |
| 8 | **fee-schedule frontmatter `last_change` bump.** `2026-04-15 → 2026-04-28` to match the snapshot row in the time-series table; the previous value implied no entry beyond 2026-04-15. | `parameters/lighter/fee-schedule.md` |
| 9 | **Audit postmortem file (this file).** Mirrors `audit/2026-04-27-ontology-coverage-perp-ops.md` structure for tone/sections; documents fixes, deferrals, and schema implications. | `audit/2026-04-28-lighter-redteam-postmortem.md` (new) |
| 10 | **log.md remediation entry.** Single `manual` entry at `2026-04-28 HH:MM` summarizing all 10 fixes. | `log.md` |

---

## Medium-severity items (deferred)

These items surfaced in the red-team passes but are not blocking for the current commit. Filed here so they can be addressed in the next ingest pass without losing context.

### From red-team-2 (framing-shifts and borrowed structure)

- **Operator Snapshot field.** The "Operator: Lighter team / Lighter Governance" Snapshot bullet is inferred from parameter-mutation evidence (contract-specs page references team-set parameters; points-program references Lighter Governance for market additions); no single docs page explicitly names an "Operator" entity. Acceptable for now — the inference is conservative and the constituent claims are all individually footnoted — but the Snapshot bullet itself does not carry an inline cite.
- **"Community-aligned tokenomics" header.** The phrase "community-aligned tokenomics" is borrowed verbatim from the HL phrasing pattern; Lighter docs do not use that exact framing. Defensible because the underlying claim (Standard Account zero-fee for retail + LIT buyback funded by trading-fee revenue) is directly cited, but the borrowed phrasing should be revisited if HL wording diverges.

### From red-team-5 (cross-platform consistency vs HL)

- **Variants table column-header rename.** The `concepts/risk/liquidation.md` `## Variants in the wild` table uses a column header (`partial-liq threshold`) inherited from the HL-only first ingest; the column for Lighter holds "none documented (full-size IoC each step)" because Lighter's partial-liquidation flow is unconditional rather than threshold-gated. Renaming the column to e.g. `partial-liq trigger` would more honestly accommodate both venues. Deferred to the next concept-tidying pass to avoid touching the locked HL artefacts.
- **HLP / LLP rigor asymmetry.** `parameters/hyperliquid/hlp.md` and `parameters/lighter/llp.md` are not strictly parallel: HLP has historical TVL time-series, LLP does not (per-strategy collateral sizes are not in primary docs — A6/PIII gap). Acceptable asymmetry for now (the gap is documented), but on the next refresh the LLP page should adopt the same time-series schema as HLP even when most rows are `unknown / not-published`.
- **Network-entity granularity drift.** `entities/network/lighter-core.md` is much shorter than `entities/network/hyperliquid-l1.md` — partly because Lighter Core is a single-app rollup (less surface) and partly because the Lighter ingest extracted less from the technical-architecture page than the HL ingest did from the L1 docs. The asymmetry is defensible but should be re-tested on the next Lighter docs refresh.
- **fee-schedule sources_count.** `parameters/lighter/fee-schedule.md` has no `sources_count` field in its frontmatter (parameter pages are not strictly required to expose this), whereas the HL fee-schedule equivalent does. Cosmetic schema drift; file as a lint enhancement rather than a content fix.

### Five unbuilt high-density parameter pages (Phase 2.2 deferral)

The following parameter pages are linked from `entities/perpdex/lighter.md` `## Parameters` but are not yet fleshed out beyond the entity-page summary bullet. All carry enough source-claim density to warrant their own page on the next ingest pass:

1. `parameters/lighter/funding-rate-rebates.md` — 6% automatic Premium + 9% LIT-stake-scaled (capped at 50k LIT); 10% annualized cap; daily 00:00 UTC L2 transfer; $1 minimum; rebate fund address.
2. `parameters/lighter/margin-tiers.md` — leverage tiers 50x / 25x / 20x / 15x / 10x / 8x / 5x / 3x with `M_i ≈ 0.6·I_i`, `C_i ≈ 0.4·I_i`; per-asset/tier table from `lighter-docs-2026-04-28-trading-contract-specifications` #c5–#c16.
3. `parameters/lighter/oracle-config.md` — Chainlink + Stork + Pyth index aggregation, mark = median of three components, 8-min EMA, ±0.5% premium clamp, Impact Notional 500 USDC / IMF; per-source decay τ for RWA stale-oracle handling.
4. `parameters/lighter/multi-asset-collateral.md` — ETH-first roll-out; per-asset LTV / LT / LF / Liquidation Fee / User Cap / Global Cap; UTA-gated; supply-limits page reconciliation.
5. `parameters/lighter/liquidation-params.md` — partial-liquidation IoC at zero price; up to 1% liquidation fee on overshoot routed to LLP; prelaunch carve-out (zero fee); LLP IMR self-protection rule; ADL counterparty selection rules.

---

## Schema implications

Two schema-level questions surfaced in the red-team passes that should be raised against `AGENTS.md` rather than fixed in-place:

1. **Should `backstops` be added to the canonical relation set in AGENTS.md §"Relations"?** It is now in use on `entities/perpdex/{hyperliquid,lighter}` describing the LP-vault → liquidation-flow relationship. The semantic distinction from `seeds_liquidity_for` is real (an LP that seeds liquidity does not necessarily backstop liquidations), and the verb is intuitive enough that two independent ingest passes converged on it. Filed as an open-questions entry; suggested verification: schema patch on next user-initiated refresh.
2. **Should `gates` be added to the canonical relation set?** This pass replaced one `gates` use (on `entities/token/lit.md`) with `applies_to` plus prose ("LLP capacity is gated by LIT stake at a 1-LIT-per-10-USDC ratio"). The substitution is clean but slightly less precise than a dedicated `gates` verb. If a future ingest adds a third or fourth `gates` use that resists `applies_to` substitution, the verb should be promoted to canonical.

Both questions are tracked in `open-questions.md` (the `backstops` entry as a verb-set proposal; `gates` is implicitly captured by the same entry).

---

## Notes for next audit

- Re-run a similar 6-agent red-team pass after the next perpdex ingest (Aster / Orderly / Drift / dYdX-v4) to validate whether the tightened frame-coverage rationale rules survive contact with a different venue. If most cells still come back `filled` with weak rationale, the frame-coverage rubric needs further tightening, not just per-agent vigilance.
- Re-evaluate the deferred medium-severity items list on the next refresh; if any item has become high-severity (e.g. variants-table column-header is actively misleading users), promote it.
- Audits remain append-only by convention. Do not edit this file once committed; surface follow-ups in subsequent audits.
