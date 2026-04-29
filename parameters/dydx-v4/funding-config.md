---
type: parameter
entity: [[dydx]]
parameter: funding-config
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 funding-config

## Current (as of 2026-04-28)
- Funding-sample epoch: 60s (default); min_num_votes_per_sample = 15[^dydx-community-2026-04-28-modules-governance-perpetual][^dydx-docs-2026-04-28-concepts-trading-funding]
- Funding-tick epoch: 3,600s (averages 60 samples)[^dydx-community-2026-04-28-modules-governance-perpetual][^dydx-docs-2026-04-28-concepts-trading-funding]
- Premium = (max(0, ImpactBid - Index) - max(0, Index - ImpactAsk)) / Index[^dydx-docs-2026-04-28-concepts-trading-funding]
- Impact Notional = 500 USDC / IMF[^dydx-docs-2026-04-28-concepts-trading-funding]
- Final funding rate = (Premium / 8) + Interest Rate Component[^dydx-docs-2026-04-28-concepts-trading-funding]
- Cross markets IRC = 0% (default); isolated markets IRC = 0.125 bps/h (1 bps/8h) per governance vote 220[^dydx-docs-2026-04-28-concepts-trading-funding]
- 8-hour rate cap = 600% x (IMF - MMF), e.g. 12%/8h for Large-Cap (IMF=5%, MMF=3%)[^dydx-docs-2026-04-28-concepts-trading-funding]
- funding_rate_clamp_factor_ppm = 6,000,000 (6%); premium_vote_clamp_factor_ppm = 60,000,000 (60%)[^dydx-community-2026-04-28-modules-governance-perpetual]
- Funding payments exchanged directly between traders (peer-to-peer, no exchange take)[^dydx-community-2026-04-28-modules-governance-perpetual]

## Time series

| effective | funding_sample_s | funding_tick_s | irc_cross | irc_isolated | rate_clamp | source |
|---|---|---|---|---|---|---|
| 2026-04-28 (snapshot) | 60 | 3,600 | 0% | 0.125 bps/h | 600% x (IMF-MMF) | [^dydx-docs-2026-04-28-concepts-trading-funding][^dydx-community-2026-04-28-modules-governance-perpetual] |

## Tiering rules / formulae
- Premium sampled via median FundingPremiumVote from validators each funding-sample epoch[^dydx-community-2026-04-28-modules-governance-perpetual]
- 8h cap formula: `cap_8h = 600% * (IMF - MMF)` — Tier 0 (Large-Cap, IMF=5%, MMF=3%) = 12%/8h[^dydx-docs-2026-04-28-concepts-trading-funding]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-funding]: [[sources/dydx-docs-2026-04-28-concepts-trading-funding]]
[^dydx-community-2026-04-28-modules-governance-perpetual]: [[sources/dydx-community-2026-04-28-modules-governance-perpetual]]
