# Per-platform Investigation Frame (perpdex)

> Split from `AGENTS.md`. The 9×5 coverage matrix for perpdex entity investigation.

When ingesting a `perpdex` entity (or refreshing one), use this frame to identify what is worth filing. The frame is a coverage checklist, not a fixed page section — claims still surface as wikilinks/footnotes inside the standard entity/concept/parameter pages. The frame ensures investigation breadth.

Two parts:
- **9 angles** — what to investigate (6 mechanism + 3 operational governance).
- **5 cross-cutting patterns** — how to probe each angle (every angle should be checked against every pattern when applicable).

Frame applies to any claim that reaches a `perpdex` entity within 1 hop via the source page's `filed_to` wikilinks. A claim filed directly on a non-perpdex entity (e.g. a `token` like HYPE, an `actor` like Hyperliquid Foundation, a `programme` operated by the venue, or a `parameter` whose `entity` frontmatter is a perpdex) IS within frame scope when its 1-hop neighborhood includes a perpdex entity. Claims with no perpdex within 1 hop are out of frame and leave `frame_tag` empty.

The angles and patterns are an investigation **lens**, not a parallel page taxonomy. Pages always live at `entities/<subtype>/...`, `concepts/<domain>/...`, or `parameters/<entity>/...` per existing rules. The `frame_tag` is metadata for coverage tracking, never a filing location.

## Mechanism angles (1–6) — what the platform built

**A1. Perp Market Design & Launch.** Listing modality (auction / deposit-gated / depth-gated / governance / prelaunch-tier). Pre-launch oracle (EMA / TWAP / external). Risk-param calibration at launch (initial leverage, IM/MM, funding bound, ADL ladder). Oracle composition & manipulation-cost-to-profit ratio (MCPR). Position-limit ramp schedule. Information-asymmetry controls during the listing window. Portfolio cannibalization. Settlement-edge mechanics for pre-launch perps.

**A2. Fee Structure.** Maker / taker / funding / liquidation fees, with funding integrated into fee accounting. Stake → discount / rebate / latency mapping. Buyback cadence (TWAP / discretionary / automatic; gross-vs-net denominator). Maker rebate funding source. Network/gas passthrough policy. Cross- / portfolio-margin effect on effective fee. Liquidation fee distribution.

**A3. Referral / Incentive.** Termination conditions (volume cap / tier cutoff / time decay). Multi-level depth (1L / 2L / 15L / permissionless integrator). Attribution window (last- vs first-touch). Cohort LTV/CAC and retention curves. Sybil / wash detection threshold + clawback. Incentive-cliff sunset plan. KYC / sanctions / tax reporting. Cross-program stack double-counting.

**A4. Market Making.** Protocol-as-MM model (HLP / MegaVault / BAL etc.). Latency tier. Toxic-flow / markout-adjusted rebate. MM concentration HHI + single-exit simulation. Counterparty / inventory limits. Quote-obligation measurement methodology (notional ladder × polling cadence). Hedge venue dependency. Protocol-MM conflict of interest. Orderly offboarding.

**A5. Spot DEX LP.** Fee-tier matrix per pair. LVR / IL visibility. Concentrated vs full-range default guidance. JIT / sandwich defense. Emissions sunset plan. Pair retirement playbook. Onboarding / exit UX + stressed-state slippage. AMM-LP × orderbook-MM economic overlap. TVL sticky-vs-mercenary cohort.

**A6. MC / Liquidity Forecasting / Risk.** OI scaling function (OIMF / nominal / size). Insurance Fund topology (single / per-asset / per-market / per-builder). Funding period & clamp. Liquidity quality (depth-time-persistence, cancel/fill ratio). Token unlock → forward OI drift. MCPR ≥ 3x screen. Organic-volume share ≥ 25% screen. Cross-asset correlation stress. IF coverage ratio = IF / (max-OI × slippage × gap%) ≥ 1.0 @ p99. ADL probability. Pre-launch FDV sanity bound (comparable [0.3, 3.0]). Delisting symmetry.

## Operational governance angles (7–9) — how the platform is run

**A7. Governance / Parameter Authority.** Parameter-change lead-time (announce → effective). Veto holders. Emergency-pause SLA. Mutation cadence (quarterly / monthly / instant).

**A8. Security / Incident Response.** Audit cadence + scope. Oracle attack history. Bug bounty max payout & scope. Validator MEV policy. Outage refund / rebate policy. Downtime fee-credit threshold. Status page MTTA. Liquidation rollback window.

**A9. Regulatory / Market-Type Classification.** Blocked jurisdictions. OFAC / sanctions screen coverage. Per-product legal opinion (prediction market / RWA / equity perp). MiCA / SFC / MAS classification. Affiliate eligibility per jurisdiction. User KYC tier. Frontend sovereignty (canonical vs builder-forkable).

## Cross-cutting patterns (I–V) — applied across every angle

**PI. Quality ≠ Quantity.** Every headline KPI must be paired with a quality / persistence / authenticity KPI. Examples: depth-time-persistence (A1, A6); p99 cancel-ack latency (A4); sticky-vs-mercenary cohort (A5); organic-volume share (A6).

**PII. Onboarding ↔ Offboarding pair.** Every onboarding decision is committed alongside its wind-down playbook. Examples: delisting trigger committed in launch doc (A1); incentive-cliff taper (A3); MM orderly exit with announce-window + wind-down spread schedule (A4); pair retirement (A5); incident retro (A8).

**PIII. Toxic flow / adverse selection accounting.** Wherever rebates / incentives flow, score by markout (e.g. +5s / +30s) and segregate by flow class. Examples: maker-rebate markout-adjustment (A2); latency-arb-vs-retail routing (A4); JIT-bot vs passive-LP fee share (A5).

**PIV. Stack / overlap accounting (Goodhart resistance).** When multiple incentive layers compose, monitor combined per-trade effective economics. Examples: tier-boundary wash (A2); per-trade total incentive ratio (A3); AMM-LP × orderbook-MM cannibalization (A5); governance-vs-ops authority overlap (A7).

**PV. SLA / contracting template.** External counterparty relationships are codified in agreement clauses, not just dashboards. Examples: affiliate agreement (A3 — clawback / attribution / dispute escalation); MM agreement (A4 — uptime / depth / downtime compensation / offboarding); LP onboarding terms (A5 — smart-contract risk disclosure); bug bounty terms (A8); legal opinion (A9).

## Angle ↔ existing concept domain mapping

Each angle composes with one or more existing `concepts/<domain>/` locations (defined in `schema/schema.md` §"Entity model — three tiers"). The `frame_tag` is a navigation hint over those domains; it never replaces the domain.

| angle | primary domain(s) | adjacent / overlapping |
|---|---|---|
| A1 Launch | `listing` | `market-microstructure` (oracle-spec, mark-price-formula at launch); `risk` (initial-leverage, IM/MM at launch) |
| A2 Fee | `fee-model`, `tokenomics` | `incentives` (rebate that doubles as incentive) |
| A3 Referral / Incentive | `incentives` | `tokenomics` (when emission-funded) |
| A4 Market Making | `mm-agreement` | `market-microstructure` (latency, quote-obligation), `metrics` (mm-uptime, depth, concentration) |
| A5 Spot LP | `lp` | `metrics` (LP-specific KPIs) |
| A6 Risk forecasting | `risk`, `metrics` | `market-microstructure` (oracle integrity at risk-param time) |
| A7 Governance / Parameter Authority | `governance` | `operations` (partial — sequencer-failover, settlement-finality remain ops-mechanism); `mm-agreement` (when MM authority overlaps) |
| A8 Security / Incident Response | `security` | `operations` (partial — oracle, settlement-finality remain ops-mechanism); `risk` (when incident triggers liq cascade) |
| A9 Regulatory / Market-Type Classification | `regulatory` | `listing` (per-product legal opinion at listing time); `incentives` (affiliate eligibility per jurisdiction) |

**Filing rule:** when a claim's `filed_to` page resolves to a domain in the angle's row, the placement is canonical. If `frame_tag` and resolved `filed_to` domain disagree, the **domain wins** — correct the `frame_tag`, never the page location. The angle ↔ domain mapping is one-to-many; the page tier (entity / concept / parameter) is unchanged by the frame.

The A7/A8/A9 dedicated domains were promoted on 2026-04-29 after thresholds were crossed wiki-wide (A7: 161 claims / 6 venues; A8: 182 claims / 6 venues; A9: 33 claims / 3 venues — see `audit/2026-04-28-ontology-state-audit.md` F2 finding and 2026-04-29 rebaseline). Going forward, file A7 claims under `concepts/governance/`, A8 under `concepts/security/`, and A9 under `concepts/regulatory/`. Pre-promotion claims filed under `operations` may carry forward without re-tagging unless a Phase 2 pass touches their source page; the migration is opportunistic, not bulk.

## Coverage matrix

The 9 × 5 matrix has 45 cells per perpdex entity. Each cell carries one of three explicit states (no silent emptiness):

| state | meaning |
|---|---|
| `filled` | at least one cited claim on the entity's wiki pages carries this `frame_tag` |
| `not-applicable` | platform does NOT have distinctive behavior in this cell. Requires a one-line rationale (e.g. `A5/PII not-applicable: perp-only venue, no spot LP lifecycle`) |
| `gap` | platform LIKELY has distinctive behavior here but data not yet sourced — or it requires on-chain analysis the LLM cannot perform from doc text. Requires a one-line `gap reason` (e.g. `A4/PIII gap: requires on-chain markout-PnL analysis per MM cohort`) |

`not-applicable` and `gap` are **explicit judgments**, recorded on the entity page in a `## Frame coverage` section formatted as:

```markdown
## Frame coverage
- A1/PI: filled
- A1/PII: filled
- A4/PIII: gap — requires on-chain markout-PnL analysis per MM cohort
- A5/PII: not-applicable — perp-only venue, no spot LP lifecycle
...
```

Lint treats `filled` / `not-applicable` / `gap` differently: NA cells are stable (rare to revisit on refresh); gap cells are a backlog (review on every refresh and on every ingest). Do NOT fabricate claims to fill cells. The forcing function is rationalization, not optimism.

## How to apply during ingest

1. **Scope test.** A source page is in perpdex-frame scope if any of its `filed_to` wikilinks reaches a perpdex entity within 1 hop. Within-1-hop includes: claim filed directly on a perpdex entity; claim on the perpdex's native token entity; claim on a parameter page whose `entity` frontmatter is a perpdex; claim on a programme operated by a perpdex; claim on a network where the perpdex runs natively (only when the claim is about the venue's behavior, not the network's).

2. **Tagging.** Fill the `frame_tag` column of the source page's `Claims extracted` table with `A<n>-P<X>`. Comma-separate when one claim spans multiple cells (e.g. `A4-PIII, A2-PIV`). Empty `frame_tag` = claim is out of perpdex frame scope.

3. **Page filing is unchanged.** Resolve `filed_to` per the existing entity / concept / parameter rules. Use the §"Angle ↔ existing concept domain mapping" table to choose the canonical concept domain when the angle has multiple options.

4. **Frame coverage update.** After all claims from a source are filed, update each touched perpdex entity's `## Frame coverage` section: any newly filled cell flips `gap`/`not-applicable`/missing → `filled`. New `gap`/`not-applicable` entries require their one-line rationale.

5. **Lint enforcement** (executed on `lint` command):
   - Source claim with non-empty `filed_to` reaching a perpdex within 1 hop AND empty `frame_tag` → `frame: untagged`. **Exception:** claims with type `definition` whose `filed_to` resolves to a generic `concepts/<domain>/<slug>` page (definition is venue-agnostic — e.g. "what is a maker fee", "what is a clob") may have empty `frame_tag` without lint complaint. Mark such rows with `frame_tag: -` (single hyphen) to distinguish from genuinely-untagged claims. Lint counts `-` as legitimate-empty, blank as untagged. Threshold heuristic: if untagged rate exceeds 10% of in-scope claims, the Phase 1 agent prompt needs tightening; if `-`-marked rate exceeds 30%, the source set is definition-heavy (expected for primary docs) and not a defect.
   - `frame_tag` not matching `^(A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*|-)$` → `frame: malformed`.
   - Coverage state with no rationale or rationale absent → `frame: unrationalized`.
   - Per-entity coverage report `<filled>/<NA>/<gap>` summed against 45.

## Out of frame scope

- Specific per-platform keyword lists are NOT pre-defined here. Keywords are emergent from the (angle × pattern) grid plus the platform's documented surface.
- Quantitative thresholds (e.g. `MCPR ≥ 3x`, `organic-volume share ≥ 25%`) are recommended starting points for analysis. Per-entity adjustments live on the entity page, not in this schema.
- Frame applies only at ingest / lint time. It does NOT alter the entity / concept / parameter page templates.
