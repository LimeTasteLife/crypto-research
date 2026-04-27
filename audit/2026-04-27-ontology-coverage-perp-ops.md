# Audit: Ontology Coverage vs Perp Operations Lead Responsibilities

**Date:** 2026-04-27
**Author:** LLM (Claude), in dialogue with project owner
**Scope:** Re-evaluate the Crypto Research Wiki ontology against the responsibilities of a hypothetical "Perp Operations Lead" role, after the introduction of the per-platform investigation frame (perpdex) on 2026-04-27 16:55 and its critic-driven fix on 2026-04-27 17:10.
**Method:** Map each Op Lead responsibility to specific ontology slots (entity subtypes, concept domains, parameter conventions, frame angles A1–A9, cross-cutting patterns PI–PV). Verdict per area: ✓✓ (full), ✓ (sufficient), ◐ (partial), ⚠ (gap).
**State assessed:** AGENTS.md as of 2026-04-27 17:10 (perpdex-frame-fix).
**Linked log entries:** `ontology-expand` (15:25), `perpdex-frame` (16:55), `perpdex-frame-fix` (17:10).
**Companion run:** Hyperliquid sample ingest is presumed to be in progress at the time of this audit. The audit's predicted manifestations (per gap, below) double as falsifiable hypotheses that the sample run will validate or refute.

---

## Verdict summary

The ontology is **sufficient to start substantive ingest for Hyperliquid** (and for any other perpdex within frame scope). Three minor structural gaps remain; all are likely to surface during a Hyperliquid sample run and can be closed reactively or pre-emptively. Two new operational risks introduced by the frame are tracked.

---

## Op Lead responsibilities × ontology coverage

| # | Responsibility | Verdict | Mapped slots | Frame coverage |
|---|---|---|---|---|
| 1 | Perp Market Design / Launch | ✓✓ | `concepts/listing/*` · `concepts/market-microstructure/{oracle-spec, mark-price-formula}` · `concepts/risk/{leverage-cap, margin-tier, oi-cap}` · `parameters/<venue>/markets/<symbol>.md` | A1 covers listing modality (auction / deposit-gated / depth-gated / governance / prelaunch-tier), pre-launch oracle (EMA / TWAP / external), risk-param calibration at launch, oracle-MCPR, position-limit ramp, info-asymmetry controls, portfolio cannibalization, settlement-edge mechanics. |
| 2 | Fee Structure | ✓✓ | `concepts/fee-model/*` · `concepts/tokenomics/{buyback, rev-share, fee-distribution, holder-discount}` · `parameters/<venue>/{fee-schedule, revenue-distribution, mm-rebate-tiers}` | A2 covers funding integrated into fee accounting, stake → discount/rebate/latency mapping, buyback cadence (TWAP / discretionary / automatic; gross-vs-net), maker-rebate funding source, network/gas passthrough, cross-/portfolio-margin effective fee, liquidation fee distribution. |
| 3 | Referral / Incentive | ✓✓ | `concepts/incentives/*` · `entities/programme/<slug>` · (programme outcomes — see Gap 2) | A3 covers termination conditions, multi-level depth (1L/2L/15L/permissionless), attribution window (last-vs-first touch), cohort LTV/CAC and retention curves, sybil/wash detection threshold + clawback, incentive-cliff sunset plan, KYC/sanctions/tax reporting, cross-program stack double-counting. PIII forces toxic-flow markout discipline. PV forces SLA-template discipline. |
| 4 | Market Making | ✓✓ | `concepts/mm-agreement/*` · `entities/mm-firm/<slug>` · `concepts/metrics/{mm-uptime, depth-*, concentration-ratio}` · `concepts/market-microstructure/{tick-size, funding-interval}` | A4 covers protocol-as-MM model (HLP / MegaVault / BAL etc.), latency tier, toxic-flow / markout-adjusted rebate, MM concentration HHI + single-exit simulation, counterparty / inventory limits, quote-obligation measurement methodology (notional ladder × polling cadence), hedge-venue dependency, protocol-MM conflict of interest, orderly offboarding. |
| 5 | Spot DEX LP | ◐ | `concepts/lp/{lp-token, vault, jit-liquidity, impermanent-loss, concentrated-liquidity, full-range, basket-lp, venue-owned-lp}` · (per-pool data — see Gap 1) | A5 covers fee-tier matrix per pair, LVR/IL visibility, CL vs FR default guidance, JIT/sandwich defense, emissions sunset plan, pair retirement playbook, onboarding/exit UX, AMM-LP × orderbook-MM economic overlap, TVL sticky-vs-mercenary cohort. Individual pool data slot is unspecified. |
| 6 | MC / Liquidity Forecasting / Risk | ✓ | `concepts/risk/{oi-cap, adl-waterfall, insurance-fund-sizing, circuit-breaker, exposure-cap}` · `concepts/metrics/{depth-1bp/10bp/100bp, fill-rate, slippage, taker-flow, fdv}` · (token asset profile — see Gap 3) | A6 covers OI scaling function (OIMF / nominal / size), Insurance Fund topology (single / per-asset / per-market / per-builder), funding period & clamp, liquidity quality (depth-time-persistence, cancel/fill ratio), token unlock → forward OI drift, MCPR ≥ 3x screen, organic-volume share ≥ 25% screen, cross-asset correlation stress, IF coverage ratio = IF / (max-OI × slippage × gap%) ≥ 1.0 @ p99, ADL probability, pre-launch FDV sanity bound (comparable [0.3, 3.0]×), delisting symmetry. Forecasting formulae go in concept body of `risk` / `metrics`. |

---

## What the frame closed (vs. pre-frame audit)

| Pre-frame gap | How the frame closed it |
|---|---|
| Launch case-study slot ambiguity ("FDV $X via path Y → OI cap hit in T hours") | A1 + 1-hop transitive scope → per-launch evidence accumulates inside the perpdex entity's `## Frame coverage` section and the relevant `parameters/<venue>/markets/<symbol>.md` lifecycle log |
| Forecasting formula location (FDV bound, OI cap function) | A6 captures formulae explicitly (MCPR, IF coverage ratio, FDV bound [0.3, 3.0]×). Concept body of `risk` / `metrics` is the canonical home — no new tier required |
| Anti-abuse case discipline | A3 + PIII (markout) + PV (SLA template) force per-program clawback rules and dispute-escalation surfaces to be extracted from sources |
| MM offboarding / negotiation public surface | A4 + PII (onboarding↔offboarding pair) + PV (SLA template) define what MM-related claims to extract from public sources |
| Tokenomics ↔ fee linkage | A2's "buyback cadence" + `concepts/tokenomics` provide explicit slot for fee → token flow analysis |
| Investigation breadth discipline | The 9 × 5 matrix with tri-state (filled / not-applicable / gap) cells and explicit rationale requirement is itself a forcing function — gaps are visible, not hidden |

---

## Remaining structural gaps

### Gap 1: Per-pool data location

**What is missing.** A5 covers LP mechanism but the canonical location for individual pool time-series (HLP, GLP, GMv2, JLP, etc.) — TVL, APY, composition, fee take, deposit/withdraw caps, strategy params over time — is not formally defined.

**Predicted manifestation in Hyperliquid sample.** HLP claims will arrive (it is the canonical case for `protocol-as-MM` under A4 and `venue-owned-lp` under A5). Without a `parameters/<venue>/pools/<pool-id>.md` convention, HLP data will land in one of:

1. A venue-wide param slot (e.g. `parameters/hyperliquid/hlp.md`). Works for single-pool venues. Awkward for multi-pool venues.
2. The body of `entities/perpdex/hyperliquid.md`. Works short-term; becomes spreadsheet-ish at scale.
3. The body of `concepts/lp/venue-owned-lp.md` (variants table). Loses per-snapshot time-series fidelity.

**Severity.** Low for Hyperliquid (single pool). Medium-high for multi-pool venues (GMX with multiple GM pools, Jupiter Perps with JLP variants). Should be resolved before ingesting GMX-class venues.

**Proposed fix.** Add `parameters/<venue>/pools/<pool-id>.md` convention parallel to `markets/<symbol>.md`. Frontmatter:

```yaml
---
type: parameter
entity: [[hyperliquid]]
parameter: pool-spec
pool_id: HLP
pool_class: venue-owned-lp     # basket-lp | concentrated | full-range | venue-owned-lp
status: live
deposit_tokens: [USDC]
strategy_summary: market-making + liquidation backstop
last_change: YYYY-MM-DD
last_reviewed: YYYY-MM-DD
---
```

Body: `## Current pool spec` · `## Time series` (effective | tvl_usd | apy | composition | fee_take | source) · `## Lifecycle events` · `## Disputed values` · `## Sources`.

### Gap 2: Programme outcome KPI time-series

**What is missing.** A3 demands cohort LTV/CAC and retention curves as investigation targets. Programme is an entity, so per-instance metadata fits the entity page. But longitudinal KPI data (volume_delta_pct, unique_traders, est_cost_usd, est_roi over time) is parameter-shaped and has no defined slot.

**Predicted manifestation in Hyperliquid sample.** HL points S1/S2 will arrive as programme entities. Their measurable outcomes (claimable HYPE per cohort, post-airdrop retention, cost-per-active-user) are time-series. Without a slot, they bloat the programme entity body or scatter across ad hoc concept pages.

**Severity.** Medium. Programme entities will accumulate quickly across venues; entity-body bloat is a real risk.

**Proposed fix.** Add `parameters/programmes/<slug>.md` convention. Frontmatter:

```yaml
---
type: parameter
programme: [[aevo-surge-s1]]
parameter: outcomes
last_change: YYYY-MM-DD
last_reviewed: YYYY-MM-DD
---
```

Body: `## KPI time series` (snapshot | volume_delta_pct | unique_traders | est_cost_usd | est_roi | source) · `## Anti-abuse incidents` · `## Cohort retention` · `## Sources`. The programme entity page links to it.

### Gap 3: Token asset profile

**What is missing.** A6 demands "token unlock → forward OI drift" and "pre-launch FDV sanity bound" as forecasting inputs. The token entity template currently has no slot for unlock schedule, holder distribution, narrative class, volatility class, parent ecosystem.

**Predicted manifestation in Hyperliquid sample.** The HYPE token entity will accumulate (a) buyback claims from A2, (b) emission schedule claims from `tokenomics`, (c) potential holder-distribution claims from third-party analyses. Without a profile section, these arrive as ad hoc body sections.

**Severity.** Low-medium. Token data on the perpdex's native token is core to A2 / A6 reasoning.

**Proposed fix.** Add an optional `## Asset profile` section to the token entity template. Suggested fields:

```markdown
## Asset profile (token entities only, optional)
- volatility class: high | medium | low
- holder distribution: concentrated | distributed | unknown
- narrative class: meme | infra | DeFi | RWA | gaming | ...
- supply unlock: <prose summary, plus link to parameters/<token>/unlock-schedule.md if time-series>
- parent ecosystem: [[network]]
```

For full unlock time-series, add `parameters/<token>/unlock-schedule.md` (tier-based, parameter convention).

---

## New risks introduced by the frame

| Risk | Severity | Mitigation |
|---|---|---|
| Coverage matrix bookkeeping cost (45 cells × N perpdex). 7 venues = 315 cells to populate or rationalize | Medium | Lint enforces per-entity progress reports. Treat `not-applicable` aggressively rather than chasing 45/45 |
| Entity page becomes a spreadsheet via the `## Frame coverage` section | Low-medium | If section exceeds ~50 lines, split into `entities/perpdex/<slug>/coverage.md` and link from main page |
| Frame is perpdex-only; non-perpdex investigations (spot-only DEX, MM-firm-as-subject, token-as-subject) have no parallel discipline | Low (Op Lead scope is perpdex-centric) | Build analogous frames as scope expands. Spot-DEX frame and MM-firm frame are plausible v2 additions |
| A7 / A8 / A9 land under `operations` until ≥10 claims × ≥2 entities trigger split into `governance` / `security` / `regulatory` | Low | Lint surfaces accumulated claims with their `frame_tag`; manual review at trigger point |
| `not-applicable` rationalization can become a rubber-stamp ("not-applicable: not relevant") | Medium | Periodic lint sample of NA rationales for one-line quality. Reject empty / circular rationales |
| 1-hop transitive scope can balloon into spurious in-frame claims (e.g., a network-level claim getting tagged because the network hosts a perpdex) | Low-medium | The schema's scope rule clarifies "claim about the venue's behavior, not the network's" — but enforcement is interpretive. Spot-check ingest output |

---

## Validation plan: what the Hyperliquid sample run should test

The first Hyperliquid ingest doubles as an empirical validation of this audit. After the sample run completes, check:

1. **Did HLP data find a clean home?** If it landed in a single `parameters/hyperliquid/hlp.md` and reads naturally, Gap 1 may not need pre-emptive fix. If it splattered across entity body + concept body + parameters with no clear canonical, fix Gap 1 before the next ingest.

2. **Did HL points data overflow programme entity body?** If the entity page exceeded ~400 lines or the time-series became hard to scan, fix Gap 2.

3. **Did the HYPE token entity accumulate ad hoc sections** for unlock schedule, holder distribution, narrative? If 3+ such sections appear without a unifying template, fix Gap 3.

4. **Frame coverage actually populated?** Read `entities/perpdex/hyperliquid.md` `## Frame coverage` section. If most cells are `gap` with the same boilerplate rationale, the frame is being box-checked rather than absorbed — process issue, not schema issue.

5. **Did A7 / A8 / A9 claims accumulate under operations?** Count claims tagged `A7-*`, `A8-*`, `A9-*` on Hyperliquid. If ≥10 in any of the three for a single entity, the trigger to split into `governance` / `security` / `regulatory` has fired earlier than the heuristic anticipated (which expects ≥2 entities).

6. **Per-claim citation density.** Sample 20 claims at random; count footnoted vs unfootnoted. <90% footnoted → lint defect rate too high; tune the Phase 1 ingest contract.

7. **Frame-tag malformation rate.** Count `frame: malformed` and `frame: untagged` lint warnings per 100 claims. >5% → tighten Phase 1 agent prompt.

8. **Conflict detection actually fired.** Hyperliquid has had multiple fee schedule revisions and listing-policy changes (e.g., HIP-3). Expect at least one auto-flagged dispute. Zero disputes after a thorough docs+blog ingest is suspicious — re-check the conflict scan.

---

## Notes for next audit

- Re-run this audit (`audit/<later-date>-ontology-coverage-perp-ops.md`) after the Hyperliquid sample completes. Compare predicted manifestations with observed manifestations. Update gap severities accordingly.
- If gaps 1–3 are closed pre-emptively before the sample run, this audit becomes the baseline for assessing closure quality.
- If new gaps emerge during the sample run, append to a separate followup audit (`audit/<date>-hyperliquid-sample-postmortem.md`). Do not edit this file — audits are append-only by convention.
- The frame itself is not yet audited against operational use ("does it actually help the user reason about a venue?"). That requires querying the wiki post-ingest with operational questions ("If we were launching ETH-PERP today on a new venue, what risk-params would we set?") and grading the answer quality. Schedule this after the sample run.
