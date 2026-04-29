# Schema — Entity Model, Relations & Templates

> Split from `AGENTS.md`. Canonical reference for the wiki's data model.

## Layers

1. **`raw/`** — manually-dropped source artifacts (PDFs, screenshots, transcripts, off-web material). User-owned, immutable.
2. **`mirror/<snapshot-id>/`** — LLM-crawled snapshots of remote URLs. Versioned. **All ontology work reads from here, not from live URLs.** See `schema/workflows.md` §"Mirror data".
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
| `dex` | Uniswap (v2/v3/v4), Curve, Balancer, PancakeSwap — non-perp DEX protocols providing AMM/pool primitives. Perpdex hooks (3rd-party) may build on these as a substrate. |
| `network` | Arbitrum, Base, Solana, Hyperliquid L1 |
| `token` | USDC, ETH, HYPE, dYdX |
| `actor` | Hyperliquid Foundation, GMX DAO, dYdX Trading Inc, key individuals (founders, leads) |
| `mm-firm` | Wintermute, Amber Group, GSR, Flow Traders, Auros, Selini Capital, Jane Street, Cumberland — first-class because they have their own agreements, history, and metrics across venues |
| `programme` | named, time-bounded campaigns (HL points S2, dYdX MM rewards epoch 47, Aevo Surge, Blast Big Bang) |

**Dominant-function rule (venue spanning multiple subtypes):** A venue that primarily operates as a perpdex but offers secondary surfaces (e.g., Drift's 5x spot, Aster's spot pairs) is filed under `perpdex` — its dominant trader-facing identity. Same logic in reverse: a primarily-spot DEX hosting a permissionless perp hook is filed under `dex` — the perp hook becomes a separate `perpdex` entity that `runs_on` the underlying `dex`. Secondary surfaces of an entity are captured in that entity's mechanism prose, not by creating duplicate entities.

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

_Slugs in the `examples` column are illustrative; create concept pages as ingest demands — not every listed slug has a page on disk yet._

### Parameters — `parameters/<entity>/<slug>.md` or `parameters/<entity>/markets/<symbol>.md`

Numeric/rule facts that change over time. Two keying schemes:

- **Venue-wide**: `parameters/<entity>/<slug>.md` — keyed by `(entity, parameter-name)`.
  Examples: `fee-schedule`, `rebate-programme`, `margin-tiers`, `liquidation-params`, `listed-markets-roster`, `oracle-config`, `insurance-fund-balance`, `revenue-distribution`, `mm-rebate-tiers`, `points-program-rules`, `funding-config`, `validator-requirements`, `staking-rewards`, `tokenomics`, `audits`, `contract-addresses`, `usdf-peg`, `listing-policy`, `audit-history` (longitudinal audit pass log, distinct from venue's audit registry/contract list), `bug-bounty` (bounty program scope, max payout, exclusions), `multi-asset-collateral` (non-USD collateral admission rules and haircuts), `lp-program-tiers` (tiered LP rewards/eligibility schedule), `funding-rate-rebates` (rebate component tied specifically to funding payments, distinct from fee-schedule), `<pool-id>` (for venue-owned LP vaults — see HLP, ALP, GLP, JLP).

**Slot-key normalization deferred (next schema pass).** Several existing parameter pages use frontmatter slot keys that diverge from the exemplar list above or from their filenames. Renames are deferred — listed here so a future cleanup pass can normalize:

- `parameters/aster/audits.md` — slot key `audit-registry`; filename says `audits`.
- `parameters/aster/contract-addresses.md` — slot key `contract-registry`; filename says `contract-addresses`.
- `parameters/aster/usdf-peg.md` — slot key `peg-config`; filename says `usdf-peg`.
- `parameters/lighter/points-rules.md` — slot key `points-rules`; exemplar list uses `points-program-rules`.
- `parameters/lighter/insurance-fund.md` — slot key `insurance-fund`; exemplar list uses `insurance-fund-balance`.
- `parameters/aster/alp.md`, `parameters/hyperliquid/hlp.md` — slot key `pool-spec`; exemplar pattern is `<pool-id>` matching filename (e.g. slot key `alp`, `hlp`).

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
| `bridges_to` | not a relation — describe the bridge/corridor in body prose, not in Relations |

Verb invention is a Phase 2 schema violation that lint will flag. If you reach for a verb not in the table, stop and either substitute from the table or open a schema-extension question; do not commit.

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

`frame_tag` is empty for claims out of perpdex frame scope. For in-scope claims (see `schema/frame.md`), use `A<n>-P<X>` matching `^A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*$`. Use `-` (single hyphen) for in-scope claims that are venue-agnostic definitions filed to generic `concepts/` pages — these legitimately have no (angle, pattern) mapping. Full regex including the hyphen escape: `^(A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*|-)$`.

## Conflicts raised
- #c1 vs other-source#cN → see [[target-page]]#disputed
```
