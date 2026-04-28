# Crypto Research Wiki — Agent Instructions

You are the maintainer of an LLM-built crypto research wiki. The user curates sources and asks questions. You read sources, file knowledge into a structured graph of markdown pages, keep cross-references current, and surface contradictions instead of hiding them. You write almost every page in this repo; the user reads them.

This document is the schema. Read it fully at the start of every session before performing any operation.

## Layers

1. **`raw/`** — manually-dropped source artifacts (PDFs, screenshots, transcripts, off-web material). User-owned, immutable.
2. **`mirror/<snapshot-id>/`** — LLM-crawled snapshots of remote URLs. Versioned. **All ontology work reads from here, not from live URLs.** See §"Mirror data".
3. **`sources/<id>.md`** — one metadata page per source. Each references either a `raw/` artifact or a `mirror/<snapshot>/pages/<slug>.md`. Contains TL;DR + extracted claims with file-back targets.
4. **Wiki pages** — `entities/`, `concepts/`, `parameters/`. LLM-owned.
5. **Indices** — `index.md` (catalog), `log.md` (chronological), `open-questions.md` (unresolved disputes & verification queue).
6. **`audit/<YYYY-MM-DD>-<topic>.md`** — schema/ontology audits. Meta-layer: assessments of the wiki/schema itself, not part of the content graph. **Append-only**: one file per audit pass; never edit prior audits. New audit on the same topic gets a new dated filename. Used to track ontology evolution decisions and to record predictions that ingest runs validate.

## Entity model — three tiers

The single most important rule: **a fact's tier determines where it lives.**

### Entities — `entities/<subtype>/<slug>.md`
Real-world identifiable actors/systems. Stable identity across time.

| subtype | examples |
|---|---|
| `perpdex` | Hyperliquid, dYdX v4, Vertex, Drift, Aevo, Paradex |
| `network` | Arbitrum, Base, Solana, Hyperliquid L1 |
| `token` | USDC, ETH, HYPE, dYdX |
| `actor` | Hyperliquid Foundation, GMX DAO, dYdX Trading Inc, key individuals (founders, leads) |
| `mm-firm` | Wintermute, Amber Group, GSR, Flow Traders, Auros, Selini Capital, Jane Street, Cumberland — first-class because they have their own agreements, history, and metrics across venues |
| `programme` | named, time-bounded campaigns (HL points S2, dYdX MM rewards epoch 47, Aevo Surge, Blast Big Bang) |

### Concepts — `concepts/<domain>/<slug>.md`
Domain abstractions. The definition does not change; only its variants in the wild change.

| domain | examples |
|---|---|
| `market-structure` | clob, amm, vamm, rfq, hybrid, jit-auction |
| `market-microstructure` | tick-size, lot-size, contract-size, settlement-type, funding-interval, oracle-spec, mark-price-formula |
| `fee-model` | maker-fee, taker-fee, liquidation-fee, funding-rate, rebate, referral-fee |
| `tokenomics` | buyback, rev-share, fee-distribution, holder-discount, fee-burn, governance-utility, emission-schedule |
| `operations` | matching-engine, sequencer, oracle, settlement, adl, insurance-fund, matching-tick, batching, sequencer-failover, settlement-finality |
| `risk` | liquidation, margin-tier, leverage-cap, position-limit, oi-cap, adl-waterfall, insurance-fund-sizing, circuit-breaker, exposure-cap |
| `lp` | lp-token, vault, jit-liquidity, impermanent-loss, concentrated-liquidity, full-range, basket-lp, venue-owned-lp |
| `listing` | listing-criteria, listing-playbook, pre-launch-perp, launch-sequencing, liquidity-bootstrap, delisting-policy, market-selection |
| `incentives` | referral-design, points-program, trading-competition, affiliate-structure, anti-abuse, sybil-resistance, campaign-roi |
| `mm-agreement` | quote-obligation, mm-tier, rebate-ladder, uptime-sla, exclusivity, spread-requirement, depth-commitment |
| `metrics` | depth-1bp, depth-10bp, depth-100bp, volume, oi, fill-rate, slippage, mm-uptime, concentration-ratio, taker-flow, fdv |

### Parameters — `parameters/<entity>/<slug>.md` or `parameters/<entity>/markets/<symbol>.md`

Numeric/rule facts that change over time. Two keying schemes:

- **Venue-wide**: `parameters/<entity>/<slug>.md` — keyed by `(entity, parameter-name)`.
  Examples: `fee-schedule`, `rebate-programme`, `margin-tiers`, `liquidation-params`, `listed-markets-roster`, `oracle-config`, `insurance-fund-balance`, `revenue-distribution`, `mm-rebate-tiers`, `points-program-rules`, `funding-config`, `validator-requirements`, `staking-rewards`, `tokenomics`, `audits`, `contract-addresses`, `usdf-peg`, `listing-policy`, `<pool-id>` (for venue-owned LP vaults — see HLP, ALP, GLP, JLP).

- **Per-market**: `parameters/<entity>/markets/<symbol>.md` — keyed by `(entity, market-symbol)`. Each listed market gets its own page tracking contract-spec time-series and lifecycle. Frontmatter:
  ```yaml
  ---
  type: parameter
  entity: [[hyperliquid]]
  parameter: market-spec
  market_symbol: ETH-PERP-USD     # canonical symbol for this venue
  status: live                    # live | delisted | paused | pre-launch
  listed_at: 2023-Q2
  delisted_at: null
  last_change: 2026-03-01
  last_reviewed: 2026-04-27
  disputed: false
  ---
  ```
  Body sections: `## Current contract specs` · `## Time series` (columns: effective | tick_size | lot_size | max_leverage | oi_cap | mark_price_formula | initial_margin | maint_margin | source) · `## Lifecycle events` (listed/paused/delisted with reasons + source) · `## Disputed values` · `## Sources`.

**Filing rule:** per-market changes (OI cap raise on ETH-PERP, BTC-PERP listing, SOL-PERP delisting) → market-specific page. Venue-wide changes (fee schedule update, MM tier overhaul, oracle migration) → venue-wide parameter page.

- **Per-programme**: `parameters/programmes/<slug>.md` — keyed by `(programme-slug, "outcomes")`. For named, time-bounded campaigns (HL points S2, dYdX MM rewards epoch 47, Aevo Surge, Aster Trade & Earn). The programme entity at `entities/programme/<slug>.md` carries the programme's identity and rules; the parameters page carries longitudinal KPI data. Frontmatter:
  ```yaml
  ---
  type: parameter
  programme: [[<slug>]]
  parameter: outcomes
  last_change: YYYY-MM-DD
  last_reviewed: YYYY-MM-DD
  disputed: false
  ---
  ```
  Body sections: `## KPI time series` (snapshot | volume_delta_pct | unique_traders | est_cost_usd | est_roi | source) · `## Anti-abuse incidents` · `## Cohort retention` · `## Sources`. The programme entity page links to it.

**Rule:** if a fact has an effective date or is expected to change, it is a parameter, not body text on an entity page.

## Relations

Express relations as wikilinks with verbs in body text: `[[hyperliquid]] **implements** [[clob]]`.

Canonical verb set:

| relation | direction | example |
|---|---|---|
| `implements` | entity → concept | Hyperliquid implements CLOB |
| `runs_on` | entity → network | dYdX v4 runs_on Cosmos appchain |
| `uses` | entity → concept/entity | Aevo uses off-chain matching |
| `competes_with` | entity ↔ entity | symmetric |
| `forks` / `derives_from` | entity → entity | Vertex derives_from Serum |
| `charges` / `rebates` | entity → fee-component | tier 4+ rebates maker |
| `governs` / `operates` | actor → entity | HL Foundation governs Hyperliquid |
| `lists` | entity → token | dYdX v4 lists ETH-USD perp |
| `applies_to` | parameter/programme → concept | rebate-programme applies_to maker_volume |
| `depends_on` | concept → concept | liquidation depends_on oracle |
| `succeeds` | parameter row → row | implicit via time-series ordering |
| `cites` | claim → source | inline footnote `[^source-id]` |
| `contradicts` | claim ↔ claim | auto-flagged at ingest |
| `quotes_on` | mm-firm → entity | Wintermute quotes_on Hyperliquid |
| `partners_with` | entity ↔ mm-firm | dYdX v4 partners_with Wintermute (formal MM agreement) |
| `distributes_to` | entity → token/actor | Hyperliquid distributes_to HYPE buyback (revenue flow) |
| `subsidizes` | programme → concept/market | mm-rewards subsidizes maker-volume on ETH-PERP |
| `seeds_liquidity_for` | entity/programme → market | HLP seeds_liquidity_for ETH-PERP-USD |
| `is_collateral_for` | token → entity/market | USDF is_collateral_for Aster Perps via Multi-Asset Mode |

**Do not invent verbs.** If a relation does not fit, propose a new one in `open-questions.md` and continue with the closest existing verb. Common substitutions when tempted to invent:

| Tempting invented verb | Use instead |
|---|---|
| `provides_liquidity_for` | `seeds_liquidity_for` |
| `discounts_fees` | `applies_to` (token → fee-schedule) |
| `bears_pnl_for` / `bears` | not a relation — describe in body prose, not in Relations |
| `backstops` | `seeds_liquidity_for` (with body note clarifying backstop role) |

Verb invention is a Phase 2 schema violation that lint will flag. If you reach for a verb not in the table, stop and either substitute from the table or open a schema-extension question; do not commit.

## Citation rule — per-claim inline

Every numeric value, mechanism description, definition, and asserted relation MUST carry an inline footnote `[^source-id]`. Treat any unfootnoted claim as a defect to be fixed by lint.

```markdown
Hyperliquid pays −0.001% rebate to tier-4+ makers[^hl-fees-2026-03].
50% of the liquidation fee is allocated to the insurance fund[^hl-liq-2026].
```

The footnote `id` matches the `id` field in the corresponding `sources/<id>.md` frontmatter.

## Parameter versioning — time-series tables

Parameter pages contain a time-series table. Every change is a row. Never overwrite.

```markdown
## Time series

| effective  | maker            | taker  | liquidation | source              |
|------------|------------------|--------|-------------|---------------------|
| 2025-01-15 | 0.020%           | 0.050% | 0.5%        | [^hl-docs-2025-01]  |
| 2026-03-01 | −0.001% .. 0.015%| 0.045% | 0.5%        | [^hl-docs-2026-03]  |
```

Frontmatter `last_change` matches the latest row's `effective` date.

## Page templates

### Entity

```yaml
---
type: entity
subtype: perpdex
name: Hyperliquid
network: [[hyperliquid-l1]]
status: live           # live | testnet | deprecated | proposed
launched: 2023-Q2
sources_count: 0
last_reviewed: YYYY-MM-DD
disputed: false
---

# {Name}

> One-line tagline.

## Snapshot
- Market structure: [[...]]
- Operator: [[...]]
- Native token: [[...]]

## Mechanism
- Bulleted facts, each [^cited].

## Parameters
- [[parameters/{slug}/fee-schedule]]
- [[parameters/{slug}/rebate-programme]]

## Open questions

## Disputed claims

## Related
[[...]] · [[...]]

## Sources
[^id]: ...
```

### Concept

```yaml
---
type: concept
domain: fee-model
name: Maker fee
last_reviewed: YYYY-MM-DD
disputed: false
---

# {Name}

## Definition
1–2 lines, [^cited].

## Variants in the wild
| venue | model | current value | notes |
|---|---|---|---|
| [[...]] | tiered + rebate | ... | ... |

## Edge cases
## Disputed claims
## Related
## Sources
```

### Parameter

```yaml
---
type: parameter
entity: [[hyperliquid]]
parameter: fee-schedule
unit: percent
last_change: YYYY-MM-DD
last_reviewed: YYYY-MM-DD
disputed: false
---

# {Entity} {parameter-name}

## Current (as of {last_change})
- key facts in plain language

## Time series
| effective | ... | source |
|---|---|---|

## Tiering rules / formulae
## Disputed values
## Sources
```

### Source

```yaml
---
type: source
id: hl-docs-trading-fees-2026-04-27   # <snapshot-id>-<page-slug> (or <raw-id> for raw artifacts)
title: Hyperliquid Trading Fees
publisher: Hyperliquid Docs
author: Hyperliquid team
date: 2026-03-01                      # source's own publication date (if known); else mirror crawl date
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees
mirror_snapshot: hl-docs-2026-04-27   # null if backed by raw/ artifact instead
mirror_page: pages/trading-fees.md    # path inside snapshot dir; null if raw/-backed
raw_path: null                        # set instead of mirror_* when source is a raw/ artifact
kind: docs           # docs | whitepaper | blog | tweet | paper | interview | onchain
authority: high      # high | medium | low
ingested: 2026-04-27 # when sources/<id>.md was created
---

# {Title}

## TL;DR
4–6 lines.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | ... | [[...]] | A4-PIII |

`frame_tag` is empty for claims out of perpdex frame scope. For in-scope claims (see §"Per-platform investigation frame (perpdex)"), use `A<n>-P<X>` matching `^A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*$`. Use `-` (single hyphen) for in-scope claims that are venue-agnostic definitions filed to generic `concepts/` pages — these legitimately have no (angle, pattern) mapping. Full regex including the hyphen escape: `^(A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*|-)$`.

## Conflicts raised
- #c1 vs other-source#cN → see [[target-page]]#disputed
```

## Per-platform investigation frame (perpdex)

When ingesting a `perpdex` entity (or refreshing one), use this frame to identify what is worth filing. The frame is a coverage checklist, not a fixed page section — claims still surface as wikilinks/footnotes inside the standard entity/concept/parameter pages. The frame ensures investigation breadth.

Two parts:
- **9 angles** — what to investigate (6 mechanism + 3 operational governance).
- **5 cross-cutting patterns** — how to probe each angle (every angle should be checked against every pattern when applicable).

Frame applies to any claim that reaches a `perpdex` entity within 1 hop via the source page's `filed_to` wikilinks. A claim filed directly on a non-perpdex entity (e.g. a `token` like HYPE, an `actor` like Hyperliquid Foundation, a `programme` operated by the venue, or a `parameter` whose `entity` frontmatter is a perpdex) IS within frame scope when its 1-hop neighborhood includes a perpdex entity. Claims with no perpdex within 1 hop are out of frame and leave `frame_tag` empty.

The angles and patterns are an investigation **lens**, not a parallel page taxonomy. Pages always live at `entities/<subtype>/...`, `concepts/<domain>/...`, or `parameters/<entity>/...` per existing rules. The `frame_tag` is metadata for coverage tracking, never a filing location.

### Mechanism angles (1–6) — what the platform built

**A1. Perp Market Design & Launch.** Listing modality (auction / deposit-gated / depth-gated / governance / prelaunch-tier). Pre-launch oracle (EMA / TWAP / external). Risk-param calibration at launch (initial leverage, IM/MM, funding bound, ADL ladder). Oracle composition & manipulation-cost-to-profit ratio (MCPR). Position-limit ramp schedule. Information-asymmetry controls during the listing window. Portfolio cannibalization. Settlement-edge mechanics for pre-launch perps.

**A2. Fee Structure.** Maker / taker / funding / liquidation fees, with funding integrated into fee accounting. Stake → discount / rebate / latency mapping. Buyback cadence (TWAP / discretionary / automatic; gross-vs-net denominator). Maker rebate funding source. Network/gas passthrough policy. Cross- / portfolio-margin effect on effective fee. Liquidation fee distribution.

**A3. Referral / Incentive.** Termination conditions (volume cap / tier cutoff / time decay). Multi-level depth (1L / 2L / 15L / permissionless integrator). Attribution window (last- vs first-touch). Cohort LTV/CAC and retention curves. Sybil / wash detection threshold + clawback. Incentive-cliff sunset plan. KYC / sanctions / tax reporting. Cross-program stack double-counting.

**A4. Market Making.** Protocol-as-MM model (HLP / MegaVault / BAL etc.). Latency tier. Toxic-flow / markout-adjusted rebate. MM concentration HHI + single-exit simulation. Counterparty / inventory limits. Quote-obligation measurement methodology (notional ladder × polling cadence). Hedge venue dependency. Protocol-MM conflict of interest. Orderly offboarding.

**A5. Spot DEX LP.** Fee-tier matrix per pair. LVR / IL visibility. Concentrated vs full-range default guidance. JIT / sandwich defense. Emissions sunset plan. Pair retirement playbook. Onboarding / exit UX + stressed-state slippage. AMM-LP × orderbook-MM economic overlap. TVL sticky-vs-mercenary cohort.

**A6. MC / Liquidity Forecasting / Risk.** OI scaling function (OIMF / nominal / size). Insurance Fund topology (single / per-asset / per-market / per-builder). Funding period & clamp. Liquidity quality (depth-time-persistence, cancel/fill ratio). Token unlock → forward OI drift. MCPR ≥ 3x screen. Organic-volume share ≥ 25% screen. Cross-asset correlation stress. IF coverage ratio = IF / (max-OI × slippage × gap%) ≥ 1.0 @ p99. ADL probability. Pre-launch FDV sanity bound (comparable [0.3, 3.0]). Delisting symmetry.

### Operational governance angles (7–9) — how the platform is run

**A7. Governance / Parameter Authority.** Parameter-change lead-time (announce → effective). Veto holders. Emergency-pause SLA. Mutation cadence (quarterly / monthly / instant).

**A8. Security / Incident Response.** Audit cadence + scope. Oracle attack history. Bug bounty max payout & scope. Validator MEV policy. Outage refund / rebate policy. Downtime fee-credit threshold. Status page MTTA. Liquidation rollback window.

**A9. Regulatory / Market-Type Classification.** Blocked jurisdictions. OFAC / sanctions screen coverage. Per-product legal opinion (prediction market / RWA / equity perp). MiCA / SFC / MAS classification. Affiliate eligibility per jurisdiction. User KYC tier. Frontend sovereignty (canonical vs builder-forkable).

### Cross-cutting patterns (I–V) — applied across every angle

**PI. Quality ≠ Quantity.** Every headline KPI must be paired with a quality / persistence / authenticity KPI. Examples: depth-time-persistence (A1, A6); p99 cancel-ack latency (A4); sticky-vs-mercenary cohort (A5); organic-volume share (A6).

**PII. Onboarding ↔ Offboarding pair.** Every onboarding decision is committed alongside its wind-down playbook. Examples: delisting trigger committed in launch doc (A1); incentive-cliff taper (A3); MM orderly exit with announce-window + wind-down spread schedule (A4); pair retirement (A5); incident retro (A8).

**PIII. Toxic flow / adverse selection accounting.** Wherever rebates / incentives flow, score by markout (e.g. +5s / +30s) and segregate by flow class. Examples: maker-rebate markout-adjustment (A2); latency-arb-vs-retail routing (A4); JIT-bot vs passive-LP fee share (A5).

**PIV. Stack / overlap accounting (Goodhart resistance).** When multiple incentive layers compose, monitor combined per-trade effective economics. Examples: tier-boundary wash (A2); per-trade total incentive ratio (A3); AMM-LP × orderbook-MM cannibalization (A5); governance-vs-ops authority overlap (A7).

**PV. SLA / contracting template.** External counterparty relationships are codified in agreement clauses, not just dashboards. Examples: affiliate agreement (A3 — clawback / attribution / dispute escalation); MM agreement (A4 — uptime / depth / downtime compensation / offboarding); LP onboarding terms (A5 — smart-contract risk disclosure); bug bounty terms (A8); legal opinion (A9).

### Angle ↔ existing concept domain mapping

Each angle composes with one or more existing `concepts/<domain>/` locations (defined in §"Entity model — three tiers"). The `frame_tag` is a navigation hint over those domains; it never replaces the domain.

| angle | primary domain(s) | adjacent / overlapping |
|---|---|---|
| A1 Launch | `listing` | `market-microstructure` (oracle-spec, mark-price-formula at launch); `risk` (initial-leverage, IM/MM at launch) |
| A2 Fee | `fee-model`, `tokenomics` | `incentives` (rebate that doubles as incentive) |
| A3 Referral / Incentive | `incentives` | `tokenomics` (when emission-funded) |
| A4 Market Making | `mm-agreement` | `market-microstructure` (latency, quote-obligation), `metrics` (mm-uptime, depth, concentration) |
| A5 Spot LP | `lp` | `metrics` (LP-specific KPIs) |
| A6 Risk forecasting | `risk`, `metrics` | `market-microstructure` (oracle integrity at risk-param time) |
| A7 Governance / Parameter Authority | `operations` (partial — sequencer-failover, settlement-finality cover infra; param-mutation cadence is the gap) | propose new domain `governance` on first-need |
| A8 Security / Incident Response | `operations` (partial — oracle, settlement-finality) | propose new domain `security` on first-need |
| A9 Regulatory / Market-Type Classification | none direct | propose new domain `regulatory` on first-need |

**Filing rule:** when a claim's `filed_to` page resolves to a domain in the angle's row, the placement is canonical. If `frame_tag` and resolved `filed_to` domain disagree, the **domain wins** — correct the `frame_tag`, never the page location. The angle ↔ domain mapping is one-to-many; the page tier (entity / concept / parameter) is unchanged by the frame.

For A7/A8/A9, until a dedicated concept domain is created, file claims under `operations` with the appropriate `frame_tag`. Lint will surface accumulated A7/A8/A9 claims under `operations` to signal when a domain split is justified (heuristic: ≥10 claims in one of A7/A8/A9 across ≥2 perpdex entities).

### Coverage matrix

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

### How to apply during ingest

1. **Scope test.** A source page is in perpdex-frame scope if any of its `filed_to` wikilinks reaches a perpdex entity within 1 hop. Within-1-hop includes: claim filed directly on a perpdex entity; claim on the perpdex's native token entity; claim on a parameter page whose `entity` frontmatter is a perpdex; claim on a programme operated by a perpdex; claim on a network where the perpdex runs natively (only when the claim is about the venue's behavior, not the network's).

2. **Tagging.** Fill the `frame_tag` column of the source page's `Claims extracted` table with `A<n>-P<X>`. Comma-separate when one claim spans multiple cells (e.g. `A4-PIII, A2-PIV`). Empty `frame_tag` = claim is out of perpdex frame scope.

3. **Page filing is unchanged.** Resolve `filed_to` per the existing entity / concept / parameter rules. Use the §"Angle ↔ existing concept domain mapping" table to choose the canonical concept domain when the angle has multiple options.

4. **Frame coverage update.** After all claims from a source are filed, update each touched perpdex entity's `## Frame coverage` section: any newly filled cell flips `gap`/`not-applicable`/missing → `filled`. New `gap`/`not-applicable` entries require their one-line rationale.

5. **Lint enforcement** (executed on `lint` command):
   - Source claim with non-empty `filed_to` reaching a perpdex within 1 hop AND empty `frame_tag` → `frame: untagged`. **Exception:** claims with type `definition` whose `filed_to` resolves to a generic `concepts/<domain>/<slug>` page (definition is venue-agnostic — e.g. "what is a maker fee", "what is a clob") may have empty `frame_tag` without lint complaint. Mark such rows with `frame_tag: -` (single hyphen) to distinguish from genuinely-untagged claims. Lint counts `-` as legitimate-empty, blank as untagged. Threshold heuristic: if untagged rate exceeds 10% of in-scope claims, the Phase 1 agent prompt needs tightening; if `-`-marked rate exceeds 30%, the source set is definition-heavy (expected for primary docs) and not a defect.
   - `frame_tag` not matching `^(A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*|-)$` → `frame: malformed`.
   - Coverage state with no rationale or rationale absent → `frame: unrationalized`.
   - Per-entity coverage report `<filled>/<NA>/<gap>` summed against 45.

### Out of frame scope

- Specific per-platform keyword lists are NOT pre-defined here. Keywords are emergent from the (angle × pattern) grid plus the platform's documented surface.
- Quantitative thresholds (e.g. `MCPR ≥ 3x`, `organic-volume share ≥ 25%`) are recommended starting points for analysis. Per-entity adjustments live on the entity page, not in this schema.
- Frame applies only at ingest / lint time. It does NOT alter the entity / concept / parameter page templates.

## Confidence model

Each source carries `authority`. Each claim inherits `recency` from `source.date` and `confidence` from a heuristic:

- `high` — official primary docs, on-chain verifiable, audited code, whitepaper.
- `medium` — team blog post, reputable secondhand reporting, well-reasoned independent analysis.
- `low` — tweet/social, anonymous, dated > 1 year with no reconfirmation, rumor.

Promote/demote confidence only with stated reason in the source page.

## Conflict detection (ingest-time)

A new claim *X* conflicts with an existing claim *Y* on the same target page when any of:

1. Same `(entity, parameter)` with overlapping effective windows but different values.
2. Same concept definition phrased non-equivalently.
3. Same mechanism described with different components or ordering.
4. Same relation asserted with reversed polarity (A forks B vs B forks A).

When detected:

1. Set `disputed: true` in the affected page's frontmatter.
2. Append both claims into a `## Disputed claims` block in the canonical layout below.
3. Append one line to `open-questions.md` with a verification suggestion.
4. **Never silently overwrite.** Prior claims stay, with a `status:` flag if appropriate.

### Disputed claims block format

```markdown
## Disputed claims — {topic}

**Claim A** · confidence: high · recency: 2026-03 · authority: high
  {claim text} [^source-a]

**Claim B** · confidence: medium · recency: 2026-01 · authority: medium
  {claim text} [^source-b]
  status: likely_superseded   # one of: active | likely_superseded | refuted | unverified

→ Open question: {what would resolve this?}
  Suggested verification: {on-chain query, secondary source, primary doc lookup}
```

## Ingest workflow

Trigger: user says `ingest <path>` or drops a file in `raw/` and asks you to process it.

Steps:

1. Read source. Detect `kind` and `authority` from publisher heuristics.
2. Create `sources/<id>.md` with frontmatter, TL;DR (4–6 lines), and an empty `Claims extracted` table.
3. Extract claims. For each claim:
   - Classify: `definition` | `parameter-value` | `mechanism` | `relation` | `event`.
   - Resolve target page (entity / concept / parameter). Create stub if missing.
   - `parameter-value` → append a row to the time-series table with `[^id]`.
   - `definition` / `mechanism` → add inline-cited sentence to body.
   - `relation` → add wikilink + verb on both endpoints' pages.
   - Record the file-back target in the source page's `Claims extracted` table.
4. Conflict scan: for each new claim, compare against existing claims on the same target. If conflict → apply Disputed claims block protocol.
5. Cross-reference pass: link every newly mentioned entity/concept noun via `[[wikilink]]`.
6. Update `index.md` under correct subtype/domain.
7. Append to `log.md`:
   ```
   ## [YYYY-MM-DD HH:MM] ingest | <source-id> | touched: N pages | claims: N | conflicts: N | new pages: N
   ```
8. Show user a diff summary and any newly raised open questions.

## Mirror data

Web sources are mirrored locally at first ingest and reused for all downstream ontology work. Live URL fetches happen only at (a) initial mirror crawl, (b) explicit `refresh <snapshot-id>`, or (c) one-off user-requested live check (does not auto-mirror).

### Layout

```
mirror/
  <snapshot-id>/
    manifest.yaml
    pages/
      <slug>.md
      ...
```

`<snapshot-id>` = `<root-slug>-<YYYY-MM-DD>`. Examples: `hl-docs-2026-04-27`, `dydx-v4-docs-2026-04-27`, `aevo-blog-clob-2026-05-01`.

### manifest.yaml schema

```yaml
snapshot_id: hl-docs-2026-04-27
root_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees
host: hyperliquid.gitbook.io
path_prefix: /hyperliquid-docs/trading/
crawled_at: 2026-04-27T14:50:00Z
crawler: exa                           # exa | webfetch  (default: exa, fallback: webfetch)
page_count: 17
status: active                         # active | superseded | paused
supersedes: null                       # snapshot_id of older crawl, if this is a refresh
superseded_by: null                    # snapshot_id of newer crawl, if any
allow: []                              # extra path-prefix regexes (per-URL queue override)
deny: []                               # path-prefix regexes to skip
max_pages: 100                         # soft cap; if exceeded, status=paused
pages:
  - slug: trading-fees
    url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees
    fetched_at: 2026-04-27T14:50:03Z
    status: ok                         # ok | fetch_failed | non_html_skipped
    crawler: exa                       # actual crawler used (may differ from manifest default if fallback fired)
    bytes: 24561
    title: Trading Fees
  - slug: trading-liquidations
    ...
queue_remainder: []                    # optional. URLs known to be in scope but NOT crawled in this run (e.g. status=paused at max_pages, or discovered via llms.txt but truncated). Documentation only; does NOT auto-resume — user must explicitly refresh or queue them.
notes: []                              # optional. Free-form anomaly log for this crawl run. One-liners. Examples: "GitBook nav is JS-rendered; seeded BFS from /llms.txt"; "404 on /old-path → redirect hint to /new-path; followed (no retry charged)"; "exa CRAWL_LIVECRAWL_TIMEOUT on /x; succeeded on second exa attempt".
```

### Crawler selection

**Default: exa MCP** (`mcp__exa-web-search__web_fetch_exa`).
**Fallback: WebFetch** (built-in).

Order, per page fetch:
1. Try `exa.web_fetch_exa(url)`.
2. On exa failure (timeout, tool error, empty/garbage content, blocked) → retry once with `WebFetch(url)`.
3. On WebFetch failure → `status: fetch_failed`, max 2 total retries across both crawlers.
4. Record actual crawler used in `pages[].crawler`.

Per-URL override in queue:
```
https://example.com/x   +crawler=webfetch       # force WebFetch (e.g., exa known-bad for this domain)
https://example.com/y   +crawler=exa            # force exa (skip fallback)
```

For deep-link discovery (BFS through children), use the crawler that succeeded on the seed page — don't mix per page unless one fails.

### Crawl boundary (default)

Same host AND path startswith `path_prefix`. `path_prefix` derived from seed URL by taking the path up to and including the seed's parent directory:

| seed URL path | derived prefix |
|---|---|
| `/hyperliquid-docs/trading/fees` | `/hyperliquid-docs/trading/` |
| `/hyperliquid-docs/` | `/hyperliquid-docs/` |
| `/` | `/` (whole host — soft cap kicks in) |

Soft cap: 100 pages per snapshot. On overflow, save partial manifest with `status: paused` and ask user before continuing.

### Per-URL queue overrides

```
https://hl.gitbook.io/.../trading/fees   +allow=/risk/        # widen prefix
https://hl.gitbook.io/                   +deny=/api/v1/       # exclude subpath
https://docs.dydx.exchange/v4/           +max-pages=200       # raise cap
https://medium.com/@x/post               +nochildren          # single page only
https://hl.gitbook.io/.../fees           +refresh             # force re-crawl even if recent snapshot exists
```

### Page extraction

Each crawled URL → `pages/<slug>.md`.
Slug rule: URL path with `/` replaced by `-`, leading slash stripped, trailing `.html`/`.md` stripped, query strings dropped.
Examples:
- `/hyperliquid-docs/trading/fees` → `trading-fees`
  *(if path-prefix-stripped slug collides, fall back to full-path slug)*
- `/v4/whitepaper.pdf` → `v4-whitepaper` (with `status: non_html_skipped` if not extractable)

Content: cleaned markdown (strip nav/footer/ads). Preserve headings, tables, code blocks, outbound links as `[text](url)`.

### Refresh — user-initiated only

**Refresh is NEVER triggered automatically.** Not by ingest reuse, not by lint, not by any agent action. The user — and only the user — decides when to re-crawl an existing root. Lint may report mirror ages but must not suggest refresh.

Trigger: user says `refresh <snapshot-id>` or `refresh <root-slug>` (most recent active snapshot of that root). Or `+refresh` flag in a queue line for that URL.

Steps:
1. Re-crawl using same `root_url`, `path_prefix`, `allow`, `deny`, `max_pages` from old manifest unless user overrides.
2. Write new snapshot dir `<root-slug>-<today>`.
3. Old manifest: set `status: superseded`, `superseded_by: <new-id>`.
4. New manifest: set `supersedes: <old-id>`.
5. Run claim re-extraction against the new snapshot — produces NEW `sources/<new-id>-<page>.md` files. **Do NOT modify old source pages or wiki pages directly.**
6. Phase 2 merge runs as normal: contradictions between old-snapshot claims and new-snapshot claims surface naturally via the Disputed claims block protocol.
7. Update `mirror/_index.md` with new active row + moved superseded row.

Old snapshots are NEVER deleted. They remain queryable.

### Querying mirror status

When the user asks "when was X last refreshed?", "how old is the X mirror?", "what mirrors do we have?", etc.:

1. Read `mirror/_index.md` first (rollup, fastest).
2. For specifics, read `mirror/<snapshot-id>/manifest.yaml`.
3. Answer with `crawled_at`, `status`, `page_count`, and (if superseded) `superseded_by`.
4. **Do NOT** fetch live URLs to compare. Mirror status is purely a local-file question.

### `mirror/_index.md` — snapshots rollup

Maintained by Phase 2 merge. Three sections (active / superseded / paused), table format:

```
## Active
| snapshot_id | root_url | path_prefix | crawled_at | pages | crawler |
| hl-docs-2026-04-27 | https://hl.gitbook.io/.../trading/ | /hyperliquid-docs/trading/ | 2026-04-27 | 17 | exa |

## Superseded
| snapshot_id | superseded_by | crawled_at | pages |

## Paused
| snapshot_id | root_url | crawled_at | pages | max_pages |
```

### Use rule (load-bearing)

> All claim extraction, lint, and query operations read from `mirror/<snapshot-id>/pages/...`, NOT from live URLs.
> `original_url` in `sources/*.md` is for human reference and refresh, not for runtime fetching.

## Batch ingest workflow (parallel, three-phase)

Trigger: user provides a markdown file containing a flat list of URLs (one per line, blank lines and `#`-comments ignored), e.g. `ingest @raw/queue/queue-001.md` or just hands you the file.

**Hard rule:** parallel agents NEVER touch wiki pages (`entities/`, `concepts/`, `parameters/`, `index.md`, `log.md`, `open-questions.md`). Phase 0.5 agents write only inside `mirror/<snap>/`. Phase 1 agents write only inside `sources/`. Wiki integration happens in a single sequential merge phase.

### Subagent isolation + extended shared-file boundaries [LOAD-BEARING]

This section codifies post-incident lessons from the 2026-04-28 parallel HL/Aster/Lighter/Drift session, where multiple parallel branches independently wrote to shared registry files and produced merge-conflict surfaces.

**Extended forbidden-write list for parallel agents** (in addition to the Hard rule above): `mirror/_index.md`, `AGENTS.md`, `audit/<existing-files>`, `raw/queue/<existing-files>`. These are shared registries / schema documents and may only be modified by:

- The Phase 2 sequential merge controller (for `mirror/_index.md`, `index.md`, `log.md`, `open-questions.md`).
- An explicit user-acknowledged schema-patch session (for `AGENTS.md`).
- An explicit user-acknowledged audit session (for `audit/`).

Parallel platform-ingest agents that need to register a new mirror snapshot, append to `log.md`, or extend `index.md` MUST defer those writes to Phase 2 — never make the writes inside the parallel agent's branch. If a parallel branch contains writes to any extended-forbidden file at merge time, the controller MUST reject the merge and ask the user before proceeding.

**Subagent isolation — controller-managed worktree pattern (REQUIRED).**

Empirically, the Agent tool's `isolation: "worktree"` parameter does NOT reliably create an isolated worktree in this environment — observed failure mode (2026-04-28): subagent committed directly to the parent branch's HEAD with no separate branch created. Do not rely on the parameter alone.

Standard pattern for any subagent that will write to the repository:

1. Controller creates the worktree explicitly BEFORE dispatch:
   `git worktree add .outline/agent-<task-slug> HEAD`
2. Controller dispatches the subagent with the `cwd` (or first-step `cd`) pinned to the worktree path.
3. Subagent commits inside the worktree on its own branch.
4. Controller verifies the worktree branch via `git -C .outline/agent-<task-slug> log` after subagent returns.
5. Controller merges the branch into the target with explicit `git merge --no-ff` (or rebase + push), resolving conflicts as needed.
6. Controller removes the worktree: `git worktree remove .outline/agent-<task-slug>`.

The subagent must NEVER be trusted to self-isolate; isolation is a controller responsibility.

**Subagent prompt verifier clause (REQUIRED preamble).**

Every dispatched subagent prompt that grants write access to the repository MUST include this verification preamble verbatim, BEFORE any task-specific instructions:

```
PRE-WORK SELF-CHECK (run first, return BLOCKED if any check fails):
1. Print `pwd`. Confirm the path is under `.outline/agent-*` or
   `.claude/worktrees/*`. If under the parent repo (no `.outline/` or
   `.claude/worktrees/` segment), STOP and return BLOCKED with the
   message "Not in isolated worktree — controller setup error".
2. Print `git rev-parse --abbrev-ref HEAD`. Confirm the branch is NOT
   `test`, `main`, or any branch matching `worktree-*` already in use.
   If the branch is shared, STOP and return BLOCKED.
3. Confirm the listed forbidden directories from the task prompt are
   present (sanity check that the worktree is a real checkout).
```

A subagent that proceeds with writes without passing the self-check is a critical incident; the controller MUST roll back any commits made and re-dispatch with corrected isolation.

### Phase 0 — reconnaissance (controller, sequential, fast)

1. Parse the queue file into a list of seed URLs with optional flags (`+allow`, `+deny`, `+max-pages`, `+nochildren`, `+refresh`, `+scope`).
2. For each seed: derive `snapshot_id = <root-slug>-<today>` and `path_prefix` (per Mirror crawl boundary rules).
3. Check for existing snapshots of the same `root_url` (consult `mirror/_index.md`):
   - If any **active** snapshot exists AND `+refresh` not set → **reuse** it; skip Phase 0.5 for this seed. **Reuse regardless of age** — refresh is user-initiated only. Ingest never re-crawls automatically.
   - If `+refresh` flag set → schedule re-crawl in Phase 0.5; Phase 2 marks the prior snapshot `status: superseded`.
   - If no snapshot exists → fresh crawl in Phase 0.5.
4. Show user a one-screen dispatch plan: per seed → `snapshot_id | path_prefix | reuse-or-crawl(-or-refresh) | guessed_kind | guessed_target_entity`. Wait for confirmation only if any row is ambiguous (e.g., personal blog, ambiguous publisher).

### Phase 0.5 — mirror crawl (parallel, one agent per seed)

Dispatch all crawl agents in a single tool call. Each agent contract:

```
INPUT: seed_url, snapshot_id, host, path_prefix, allow[], deny[], max_pages, nochildren?
ALLOWED OUTPUT: write mirror/<snapshot_id>/manifest.yaml AND mirror/<snapshot_id>/pages/<slug>.md.
FORBIDDEN: any write outside mirror/<snapshot_id>/. Any read of sources/, entities/, concepts/, parameters/.

STEPS:
  1. mkdir mirror/<snapshot_id>/pages/.
  2. Fetch seed_url using crawler-selection order (exa → webfetch fallback). Extract cleaned markdown → pages/<seed-slug>.md.
  3. If nochildren: skip to step 6.
  4. Find outbound links matching: same host AND path startswith path_prefix AND not in deny[] AND (allow[] empty OR matches allow[]).
  4a. Sparse-link fallback. If step 4 yields fewer than 3 in-scope outbound links AND the host serves a canonical doc index (probe `<host>/llms.txt`, `<path_prefix>/llms.txt`, or `<host>/sitemap.xml`), seed the BFS queue from that index. Common cause: client-side-rendered nav (GitBook, Docusaurus, Mintlify) — the seed page's HTML lacks the sidebar links. Record the fallback in `manifest.notes`.
  5. BFS through matching links until queue exhausted or max_pages reached.
     - Each fetch: use crawler-selection order, extract markdown, save to pages/<slug>.md, record entry in manifest (including pages[].crawler used).
     - Skip non-HTML (PDF/img) but record with status: non_html_skipped.
     - On 404 with explicit redirect hint in response body (e.g. GitBook's "page moved to /new-path"): follow the redirect once. Record in `manifest.notes`. Do not count the 404 against retry budget.
     - On both-crawler failure (no redirect available): status: fetch_failed.
     - At max_pages: stop, manifest.status = paused. Append unprocessed in-scope URLs to `manifest.queue_remainder`.
  6. Write manifest.yaml with full schema (root_url, host, path_prefix, crawled_at, page_count, all pages list, queue_remainder, notes).
  7. Return snapshot_id, page_count, status.
```

### Phase 1 — claim extraction (parallel, one agent per snapshot)

Dispatch one extraction agent per Phase 0.5 snapshot in a single tool call.

```
INPUT: snapshot_id, schema (this AGENTS.md)
ALLOWED OUTPUT: write one sources/<snapshot_id>-<page-slug>.md per page in mirror/<snapshot_id>/pages/.
FORBIDDEN: write outside sources/. Write to mirror/. Write to wiki pages or indices.
ALLOWED READ: own snapshot's pages and manifest. Other sources/*.md (cross-reference). Schema.
                NOT wiki pages.

STEPS:
  1. Read mirror/<snapshot_id>/manifest.yaml.
  2. For each page entry with status: ok:
     a. Read mirror/<snapshot_id>/pages/<slug>.md.
     b. Detect kind/authority (inherit from snapshot host heuristic if no page-level signal).
     c. Write sources/<snapshot_id>-<slug>.md per Source template (frontmatter references mirror_snapshot + mirror_page).
     d. Write 4-6 line TL;DR.
     e. Extract every concrete claim into the Claims extracted table. For each claim:
          - target tier (entity | concept | parameter)
          - target slug (existing-if-known or proposed-new)
          - claim type (definition | parameter-value | mechanism | relation | event)
          - confidence (high | medium | low)
     f. If a within-snapshot conflict is visible (page A vs page B in same snapshot), record under Conflicts raised.
  3. Skip pages with status: fetch_failed or non_html_skipped (no source page produced).
  4. Return the list of created source ids.
```

### Phase 2 — sequential merge (controller, single-threaded)

After all Phase 1 agents complete:

1. Read every newly created `sources/*.md`. Flat-list all claims with their `filed_to` proposals.
2. Group claims by `filed_to` target page.
3. For each target page (entity / concept / parameter), deterministic order:
   - Create from template if it does not exist.
   - Integrate claims by type:
     - `parameter-value` → append row(s) to time-series, sort by `effective` date.
     - `definition` / `mechanism` → add inline-cited sentence(s) to appropriate section.
     - `relation` → add wikilink + verb to both endpoints.
   - Conflict scan across all claims targeting this page (across ALL sources, including pre-existing). Apply Disputed claims block protocol.
   - Update `last_reviewed` and `sources_count` in frontmatter.
4. Update `index.md` (new pages, modified pages, source counts).
5. Update `mirror/_index.md`: insert new active rows for snapshots created in Phase 0.5; if any `+refresh` was used, move the prior snapshot's row from Active to Superseded with its `superseded_by` set; insert paused-snapshot rows if any.
6. Append `log.md` entry:
   ```
   ## [YYYY-MM-DD HH:MM] batch-ingest | queue=<queue-file> | snapshots: N (new=K, reused=R, refreshed=F) | sources: M | pages touched: P | new pages: J | conflicts: C
   ```
7. Append every conflict to `open-questions.md`.
8. Print structured summary: per-snapshot crawl result (new/reused/refreshed), per-page touch list, all newly raised open questions.

#### Phase 2 mandatory completeness rule [LOAD-BEARING]

**Phase 2 is atomic.** A Phase 2 run that creates an entity page WITHOUT (a) integrating that entity's claims into existing concept pages' `## Variants in the wild` tables and (b) creating the parameter pages the entity body references is **incomplete** and breaks the wiki's cross-venue comparison affordance.

Specific obligations every Phase 2 run MUST satisfy before declaring done:

1. **Concept-page Variants integration.** For every claim with type `definition` / `mechanism` filed to a `concepts/<domain>/<slug>` page that **already exists**, append a row to that concept page's `## Variants in the wild` table representing the new venue. Do NOT skip on the basis of "concepts already populated by another venue" — that is precisely the case where the row is needed.
2. **Parameter-page creation.** Every wikilink of the form `[[parameters/<entity>/<slug>]]` written into the new entity page's `## Parameters` section MUST resolve to an existing file by end of Phase 2. Either create the parameter page (preferred) or remove the wikilink (acceptable if the parameter is unsourced from this snapshot).
3. **Index update.** `index.md` lists every page created or modified in this run.
4. **Schema verb discipline.** Every relation written in `**verb**` form MUST appear in §"Relations" canonical verb table. If a needed relation does not fit, add it to `open-questions.md` and use the closest existing verb — DO NOT invent verbs inline.
5. **Schema slot discipline.** Every parameter slot key (the `parameter:` field in parameter-page frontmatter) MUST be either a documented example in §"Parameters" or a justified extension recorded in this Phase 2's log entry. Do NOT silently adopt audit-predicted slots without schema patch.

**Forbidden shortcuts.** No "lightweight Phase 2", no "concepts deferred", no "parameters TBD as forward refs". An entity ingest that defers concept-table integration is a merge-debt generator: future Phase 2 runs across other venues will silently overwrite the gap rather than reconcile it. If time pressure forces deferral, **defer the entity page itself** — file claims on existing concept pages as a one-row-per-claim addition, and create the entity later when there is time to do it correctly.

**Verification before commit.** Before the Phase 2 commit, run:
- Grep every `[[<dir>/<...>]]` wikilink in newly-touched pages; confirm target file exists OR is in this commit.
- Grep every `**<verb>**` pattern; confirm the verb is in the §"Relations" table.
- Diff `concepts/**/*.md` for added Variants rows; confirm at least one row was added per concept page the new entity touches.

### Failure handling

- A single Phase 0.5 or Phase 1 agent failure does NOT abort the batch. Survivors proceed.
- If two agents propose colliding `snapshot_id`s for different `root_url`s: append `-2`, `-3` suffix.
- If a Phase 1 agent wrote outside `sources/`: abort Phase 2, report the violation, ask user.
- If Phase 0.5 hit `max_pages` (status: paused): list affected snapshots in summary; user decides whether to raise cap and resume.

## Lint workflow

Trigger: user says `lint`.

Checks:

- All `disputed: true` pages — has new evidence arrived since `last_reviewed`?
- Disputed pages older than 30 days with no movement — flag for user attention.
- Orphan parameters (no parent entity page exists).
- Orphan concepts (no implementing entity points to it).
- Parameters with `last_change > 90 days` — flag "still current?"
- Unfootnoted claims (any sentence asserting a fact without `[^...]`).
- **Broken wikilinks** — every fully-qualified `[[<dir>/<...>]]` must resolve to an existing file. Group separately by tier (entity / concept / parameter / source / audit).
- **Invented relation verbs** — every `**<verb>**` pattern in body prose must match a verb in §"Relations" canonical table. Flag any non-matching verb as `verb: invented` with the page and verb. Common offenders are listed in the substitutions table; treat each as a Phase 2 schema violation, not a stylistic note.
- **Phase 2 incompleteness markers** — when an entity page exists for a perpdex but its claims are absent from existing concept pages' `## Variants in the wild` tables, flag as `phase2: deferred` with the entity name and the list of concept pages missing a row.
- Sources cited nowhere (file-back failed).
- **Mirror age report**: list active snapshots with their `crawled_at` age in days. **Do NOT suggest refresh** — refresh is user-initiated only. Just report ages so the user can decide.
- **Superseded mirrors not yet reconciled**: snapshots with `status: superseded` whose newer counterpart's claims have not been cross-checked → propose contradictions to verify.
- **Paused crawls** (`status: paused`): list snapshots that hit `max_pages` and never resumed.
- **Frame coverage** (perpdex 1-hop): for each perpdex entity, report `frame coverage: <filled>/<NA>/<gap>` (sums to 45). List ALL `gap` cells per entity (this is the backlog). NA cells reported only on entity creation / first-pass review (rarely revisited). Flag `frame: untagged`, `frame: malformed`, `frame: unrationalized` claims/cells. Surface accumulated A7/A8/A9 claims under `operations` once heuristic threshold reached (≥10 claims in one angle across ≥2 perpdex entities) → propose new concept domain split.
- Suggest 3–5 new questions worth investigating, given current gaps.

Output: a structured report. Do not auto-edit pages during lint — propose, let user approve.

## Query workflow

Trigger: user asks a question.

1. Read `index.md` to identify candidate pages.
2. Read those pages.
3. Synthesize answer with inline citations to wiki pages and (transitively) to sources.
4. **File the answer back** into the wiki when it represents a non-trivial synthesis (a comparison, a new derived insight, a connection). Create a new concept page or augment an existing one. Append to `log.md`.

## File-back rule

Valuable conversational outputs — comparisons, analyses, derivations — are knowledge. Do not let them disappear into chat history. Either:
- Add a new section to an existing page, or
- Create a new concept/entity page.

Mark the file-back in `log.md` as `query | <topic> | filed: <pages>`.

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

## First-session checklist

When the user asks you to bootstrap an entity (e.g. "start a page for Hyperliquid"):

1. Create the entity page using the template, even if mostly empty.
2. Create stubs for any concepts mentioned but missing.
3. Create a parameter page skeleton for `fee-schedule` and other expected parameters.
4. Add to `index.md`.
5. Log the bootstrap.

## Out of scope

- Price predictions, alpha generation, trade signals.
- Personal opinions about which venue is "best" — replace with structured comparison tables.
- Marketing language. Use neutral, source-cited prose.
