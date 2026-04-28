---
type: parameter
entity: [[aster]]
parameter: revenue-distribution
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster revenue distribution

## Current (as of 2026-04-28)

**Revenue inflow.** Protocol revenue flows from perp trading fees (USDT-perp 0% / 0.04% taker, USD1-perp 0% / 0.005% taker) computed on nominal value[^aster-docs-2026-04-28-trading-perpetuals-fees]. Funding does **not** flow to the protocol — Aster does not collect or pay funding; funding is peer-to-peer between longs and shorts[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Buybacks.** A portion of protocol revenue is redirected to **$ASTER buybacks** routed via the Aster Foundation, funding a Foundation allocation for long-term price stabilization[^aster-docs-2026-04-28-usdaster-tokenomics].

**Governance rewards.** Buybacks also fund **governance rewards distribution** to incentivize participation in Aster's decentralized governance[^aster-docs-2026-04-28-usdaster-tokenomics].

**APX swap residual.** Eligible $APX holders/stakers can swap APX for $ASTER at a conversion rate that decreases over time; unclaimed tokens redirect back to the Airdrop & Community Rewards allocation[^aster-docs-2026-04-28-usdaster-tokenomics].

**ALP yield routing.** A portion of platform-level fee collection accrues to ALP NAV as one of five yield streams (alongside Simple Mode market-making P&L, trading fees, funding fees, and liquidation captures) — see [[parameters/aster/alp]][^aster-docs-2026-04-28-earn-aster-alp].

**Open: cadence and quantification.** Buyback cadence, source-percentage split between ALP yield / Foundation buyback / governance rewards, and the buyback execution venue are not specified in primary docs.

## Time series

| effective | revenue inflows | buyback routing | governance rewards | funding take | source |
|---|---|---|---|---|---|
| 2026-04-28 | perp trading fees (USDT/USD1 rate cards) | Foundation buybacks (cadence undisclosed) | funded by buybacks | 0% (peer-to-peer) | [^aster-docs-2026-04-28-trading-perpetuals-fees][^aster-docs-2026-04-28-usdaster-tokenomics][^aster-docs-2026-04-28-trading-perpetuals-funding-rate] |

## Tiering rules / formulae

Not applicable — parameter aggregates the revenue surface (rate card → buyback → governance rewards) but specific split percentages are undisclosed. Trading-fee rate is `nominal_value × rate`, where `rate` is the published quote-asset card; see [[parameters/aster/fee-schedule]].

## Disputed values
None at first ingest. (The fee-rate dispute lives on [[parameters/aster/fee-schedule]].)

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-fees]: [[sources/aster-docs-2026-04-28-trading-perpetuals-fees]]
[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]: [[sources/aster-docs-2026-04-28-trading-perpetuals-funding-rate]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
