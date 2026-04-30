---
type: audit
date: 2026-04-30
author: LLM (Claude), in dialogue with project owner
scope: Proposal-only audit. Argues that A4 (Market Making) in `schema/frame.md` is currently calibrated for external MM relationships, while six perpdex venues operate protocol-owned vaults whose claims either get force-fitted into A4 patterns (latency tier, MM HHI, hedge venue, MM SLA) that don't apply or land as A4/PIII gaps that aren't real gaps. Proposes two carve-out options (sub-tag vs new angle) without implementing either.
---

# Frame A4 Carve-out Proposal — Protocol-Owned Vault Sub-slot

> Status: PROPOSAL ONLY. Implementation requires a user-acknowledged schema-patch session per `schema/schema.md` §"Layers" item 6. This audit is append-only; no schema files are touched.

## Context

`schema/frame.md` defines a 9×5 investigation matrix for `perpdex` entities. Angle **A4 (Market Making)** is currently written around external MM relationships:

> "Latency tier. Toxic-flow / markout-adjusted rebate. MM concentration HHI + single-exit simulation. Counterparty / inventory limits. Quote-obligation measurement methodology … Hedge venue dependency. Protocol-MM conflict of interest. Orderly offboarding."

Most of these probes presuppose a third-party counterparty with an MM agreement (PV), an onboarding/offboarding template (PII), and a measurable rebate-vs-markout relationship per cohort (PIII).

Empirically, **all 6 actively-investigated perpdex venues operate protocol-owned vaults** that simultaneously perform protocol-as-MM and (for 4 of 6) the insurance-fund role. These vaults are:

- a) MM-shaped (they quote, they capture toxic flow, they earn rebate)
- b) NOT external (no MM agreement, no MM HHI, no offboarding playbook, no hedge-venue dependency in the standard sense)
- c) Often dual-purpose with the IF (so A6 IF-coverage probes also touch them)

Two consequences observed during ingest:

1. **A5 is `not-applicable` for all 6 venues** (perp-only; no spot AMM lifecycle to investigate). A5/PII, A5/PIII, A5/PIV are dead cells.
2. Vault claims filed into A4 either over-stretch the external-MM patterns (e.g. `A4-PIII` interpreted as "markout vs LLP NAV" when the pattern was written for "markout-adjusted maker rebate per MM cohort"), or get filed as `A4/PIII gap — requires on-chain markout-PnL analysis per MM cohort` when there is no per-MM cohort to analyze, only one vault. Both outcomes are ontology-noise, not signal.

## Evidence

Six venues, six vault objects. Source IDs verified against `sources/`.

| venue | vault | role | A4 patterns that DO fit | A4 patterns that DON'T fit |
|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | HLP[^hl-liq] | hybrid (protocol-MM + Liquidator Vault backstop; PnL flows to community depositors) | PIII (toxic flow into vault), PIV (vault PnL × backstop role × HYPE buyback stack) | PI (no latency tier — vault is the maker), PII (no MM onboarding; depositor onboarding instead), PV (no MM agreement; vault terms instead) |
| [[entities/perpdex/aster]] | ALP[^aster-alp] | hybrid (protocol-MM counterparty for Simple Mode + liquidation captures + multi-source NAV) | PIII (toxic flow into ALP NAV), PIV (5-source yield stack: MM PnL × trading fees × funding × liquidation captures × platform fees) | PI, PII, PV (same — no external counterparty) |
| [[entities/perpdex/orderly]] | OmniVault[^omni-mech] | protocol-MM-only (Strategy Provider Kronos; OmniVault explicitly does NOT replace IF; up to 40% net protocol revenue + portion of IF liquidation fees routed in) | PI (vault-period 3h cadence is a quality signal), PIII (SP markout), PIV (SP fee × IF rev-share × OmniVault rev-share stack), PV (SP relationship has elements of an agreement) | PII (no MM offboarding playbook documented for vault; depositor batch-period instead), PI partial (no per-MM latency since SP is the vault) |
| [[entities/perpdex/lighter]] | LLP[^llp-if] | hybrid+ (protocol-MM, primary backstop, AND insurance fund of last resort before ADL; LIT-staked deposit gating) | PIII (LLP NAV erosion = markout), PIV (LLP × LIT staking × liquidation-fee inflow stack) | PI, PII, PV — and PIII partial (vault-level NAV markout is a different KPI than per-MM-cohort markout) |
| [[entities/perpdex/dydx]] | MegaVault[^mv] | protocol-MM-only (Greave-operated; 50% trading-fee revenue share; no documented IF role on this page) | PIII (vault PnL × funding × fee share), PIV (vault × fee-share × governance authority stack), PV partial (operator agreement w/ Greave) | PI (no latency tier), PII (no MM onboarding; depositor flow instead) |
| [[entities/perpdex/drift]] | DSM[^dsm] (+ BAL[^drift-about] as separate protocol-MM) | DSM is **IF-only** (DRIFT-staked safety module backstopping Insurance Fund); BAL is **protocol-MM-only** (backstop virtual AMM). Drift uniquely splits the two roles into two distinct vault-shaped objects. | DSM: PIV (DRIFT staking × IF backstop × revenue-pool incentive stack). BAL: PI partial, PIII partial. | DSM: PI/PII/PIII/PV (no MM patterns apply — it's an IF). BAL: PII/PV (no agreement). |

Cross-cutting observation: **A5 is `not-applicable` for all 6** — none has a spot AMM LP layer with the lifecycle A5 was designed to investigate. A5's full-row of 5 patterns produces 30 dead cells across the 6 venues.

[^hl-liq]: `sources/hl-docs-2026-04-27-trading-liquidations.md` (HLP role + Liquidator Vault component)
[^aster-alp]: `sources/aster-docs-2026-04-28-earn-aster-alp.md`, `sources/aster-docs-2026-04-28-earn-aster-alp-fees.md`
[^omni-mech]: `sources/orderly-docs-2026-04-29-omnivault-mechanics.md`, `sources/orderly-docs-2026-04-29-omnivault-overview.md`
[^llp-if]: `sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund.md`, `sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies.md`, `sources/lighter-docs-2026-04-28-about-lighter-lit-utility.md`
[^mv]: `sources/dydx-community-2026-04-28-dydx-features-megavault.md`, `sources/dydx-docs-2026-04-28-concepts-trading-megavault.md`
[^dsm]: `sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module.md`, `sources/drift-docs-2026-04-28-protocol-insurance-fund-staking.md`
[^drift-about]: `sources/drift-docs-2026-04-28-protocol-about-v3.md` (BAL = backstop virtual AMM)

## Proposal

Two options for the user to pick. Recommendation: **Option 1**.

### Option 1 (Recommended) — A4 sub-tag `{ext, pov}`

Keep angle = A4. Introduce a sub-tag immediately after the angle number:

- **`A4-ext-P<X>`** — external MM. Current pattern definitions remain calibrated for this (latency tier, MM HHI, MM agreement, hedge venue dependency, orderly offboarding).
- **`A4-pov-P<X>`** — protocol-owned vault. Pattern definitions are reinterpreted (see mapping table below).

`schema/frame.md` A4 prose updated to enumerate which probes are `ext`-specific vs `pov`-specific vs shared. The angle ↔ domain table row stays the same (`mm-agreement` for ext, `lp` + `mm-agreement` for pov-hybrid, `lp` + `risk` for pov-IF-overlap).

**Pro:**
- Minimal schema disturbance — frame still has 9 angles.
- Migration is opportunistic, not bulk: existing `A4-PIII` tags interpret as `A4-ext-PIII` by default; `A4-pov-*` is opt-in for new claims and back-filled when a Phase-2 pass touches the source.
- Mirrors the precedent set by the 2026-04-29 A7/A8/A9 promotion — additive, not destructive.

**Con:**
- The `frame_tag` regex in `schema/frame.md` lint rule and `schema/schema.md` source template must accept the sub-tag form. Current regex: `^(A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*|-)$`. New regex: `^(A[1-9](-(ext|pov))?-P(I|II|III|IV|V)(, A[1-9](-(ext|pov))?-P(I|II|III|IV|V))*|-)$`.
- Sets a precedent: future angles may want their own sub-tags (e.g. A6 IF-self-insured vs A6 IF-token-backed). Pro or con depending on view.

### Option 2 — Promote pov to its own angle (A10, or split A4 → A4a/A4b)

Frame becomes 10 angles or "9-angle with A4 split". The matrix becomes 10×5 = 50 cells per perpdex (or 9.5×5 with split). A4-pov gets its own pattern definitions in `schema/frame.md`; A4-ext keeps the current ones.

**Pro:**
- Cleanest pattern definitions — no shared probes that mean different things in two contexts.
- The angle ↔ domain mapping row for the new angle can land cleanly on `lp` (or a new `vault` domain if promoted later).
- Coverage matrix per entity becomes more honest: 6 venues that have a pov get `filled` cells in the new angle row instead of awkward `A4-pov-*` tags.

**Con:**
- Bigger schema surface change. Requires renumbering or re-lettering scheme that lint, audits, and existing entity `## Frame coverage` blocks must all migrate.
- Bulk migration of all current A4 claims into either A4 (ext-only) or the new angle. Estimated reach: every entity page's `## Frame coverage` block + every source page's `frame_tag` column for every A4-tagged claim across the 6 venues — roughly 50–100 claim rows.
- Sets a heavier precedent for splitting other ambiguous angles.

## Migration cost

| step | Option 1 | Option 2 |
|---|---|---|
| `schema/frame.md` edit | A4 prose expanded; lint regex updated | New angle inserted; A4 prose narrowed; matrix dimension changed; lint regex updated |
| `schema/schema.md` source-template edit | regex-string update only | regex-string update + frame_tag examples updated |
| Existing `A4-*` claims (sources/) | reinterpret as `A4-ext-*` by default; opt-in `A4-pov-*` for new claims; opportunistic backfill | bulk re-tag every existing A4 claim into `A4-ext-*` or `A10-*` (or `A4a/A4b`); ~50–100 claim rows |
| Existing `## Frame coverage` blocks (6 entity pages) | unchanged unless re-reviewed; new pov rows added on next refresh | each entity gains 5 new cells (pov × P I–V); existing A4 cells re-stated as A4-ext |
| Lint impact | one regex change + one accept rule for sub-tag | regex change + matrix-arithmetic update (`<filled>/<NA>/<gap>` summed against 50 instead of 45) |
| Total disturbance | low — additive | medium-to-high — structural |

## Patterns under each interpretation

A4-ext keeps the current `schema/frame.md` definitions verbatim. A4-pov reinterprets them:

| pattern | A4-ext interpretation (current) | A4-pov interpretation (proposed) |
|---|---|---|
| **PI Quality** | latency p99, depth-time, cancel-ack, MM uptime SLA | NAV smoothness (drawdown frequency / depth), depositor-batch-period cadence, vault-NAV transparency interval, withdrawal-queue length |
| **PII Onboard/Offboard** | MM application, SLA, orderly wind-down with announce-window | depositor onboarding UX, deposit eligibility gating (e.g. LIT-staked LLP cap), withdrawal queue / batch-period, vault sunset playbook |
| **PIII Toxic flow** | markout-adjusted maker rebate per MM cohort, latency-arb-vs-retail routing | toxic-flow-vs-NAV-erosion accounting, per-strategy NAV markout (e.g. LLP per-strategy bucket), backstop-PnL vs ordinary-PnL split |
| **PIV Stack** | MM rebate × incentive × LP program stack | vault PnL × IF role × buyback / rev-share × deposit-token incentive stack (HLP × HYPE buyback; ALP × 5-source yield; OmniVault × 40%-rev-share × IF-fee-portion) |
| **PV SLA / contracting** | MM agreement template (uptime / depth / downtime comp / offboarding) | depositor-facing terms (smart-contract risk disclosure, withdrawal-queue rules, operator-discretion clauses, e.g. Greave's MegaVault sub-vault tuning authority) |

## Decision

Defer to user. The two questions are:

1. **Which option** — sub-tag (Option 1) or new angle (Option 2)?
2. **When** to schedule the schema-patch session that implements the choice (per `schema/schema.md` §"Layers" item 6, this audit is proposal-only).

Recommendation: **Option 1**, in the same session that the `venue-owned-lp` ↔ `vault` overlap question (now in `open-questions.md`) gets resolved — they are the same surface seen from two angles (concept side vs frame side) and benefit from being decided together.

## Open questions raised

None new. This audit consolidates observations already implicit in:

- `concepts/lp/venue-owned-lp.md` (note on protocol-MM conflict of interest)
- the existing `open-questions.md` entry on vault / venue-owned-lp overlap (relocated 2026-04-30 from `index.md`)
- the 6 entities' Frame coverage blocks where `A4/PIII gap — requires on-chain markout-PnL analysis per MM cohort` shows up despite there being no per-MM cohort (only one vault)

## Predictions if implemented

Falsifiable predictions for the next ingest pass, used to validate carve-out value:

1. **P1 — gap-collapse.** After Option 1 is implemented, the count of `A4/PIII gap — requires on-chain markout-PnL analysis per MM cohort` entries across the 6 entity pages drops by ≥ 4 (because the protocol-MM-only / hybrid venues no longer need a per-MM-cohort gap; their `A4-pov-PIII` becomes a NAV-erosion gap, which is more tractable from doc text alone).
2. **P2 — pattern fit.** ≥ 80% of new A4-pov claims ingested in the next 2 ingest sessions cite at least one of the 5 pov-reinterpreted patterns (PI NAV-smoothness, PII deposit-gating, PIII NAV-erosion, PIV multi-source stack, PV depositor terms) without needing prose adaptation in the source page TL;DR.
3. **P3 — Drift split.** Drift's `DSM` claims migrate to A4-pov + A6 (IF), and `BAL` claims migrate to A4-pov standalone — predicting that splitting Drift's two vault objects will produce zero `A4-ext-*` tags for Drift after migration.
4. **P4 — A5 stays NA.** The A5 `not-applicable` row remains for all 6 venues; the carve-out does NOT relieve A5 deadness (which is a separate question — possibly a future "A5 not-applicable for perp-only venues" optimization, but out of scope here).
5. **P5 — no new gaps.** No new venue-page `gap` entries are introduced by the carve-out itself (i.e. the carve-out reorganizes existing claims; it does not surface fresh gap demands). If new gaps appear, the carve-out's pattern definitions are too permissive and need tightening in a follow-up.
