---
type: parameter
entity: [[dydx]]
parameter: margin-tiers
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: true
---

# dYdX v4 margin-tiers

## Current (as of 2026-04-28)
- 8 Liquidity Tiers: Large-Cap 0, Small-Cap 1, Long-Tail 2, Safety 3, Isolated 4, Mid-Cap 5, FX 6, IML 5x 7[^dydx-community-2026-04-28-modules-governance-markets][^dydx-docs-2026-04-28-concepts-trading-governance]
- Per-tier: IMF (initial margin fraction, may scale with OI) + MMF (maintenance margin fraction, fixed)[^dydx-docs-2026-04-28-concepts-trading-margin]
- OI-scaling IMF formula: `effective_IMF = min(base_IMF + max(scaling_factor * (1 - base_IMF), 0), 1.0)` where `scaling_factor = (open_notional - lower_cap) / (upper_cap - lower_cap)` -- at upper_cap or above, IMF reaches 100%[^dydx-docs-2026-04-28-concepts-trading-margin][^dydx-docs-2026-04-28-concepts-trading-governance]
- MMF does NOT scale with OI[^dydx-docs-2026-04-28-concepts-trading-margin]
- Free collateral = TAV - Total IMR; account liquidatable when TAV < Total MMR[^dydx-docs-2026-04-28-concepts-trading-margin]
- Schema disputed: community docs use `base_position_notional` + `impact_notional`; docs.dydx.xyz uses `lower_cap` / `upper_cap` with different numeric values for impact_notional (Tier 0: 10,000 USDC vs 25,000 USDC)[^dydx-community-2026-04-28-modules-governance-markets][^dydx-docs-2026-04-28-concepts-trading-governance]

## Time series

| effective | tier | IMF | MMF | impact_notional | capacity_schema | source |
|---|---|---|---|---|---|---|
| 2026-04-28 (snapshot, community-docs schema) | 0 Large-Cap | 0.02 (2%) | 0.012 (MF=0.6) | 10,000 USDC | base_position_notional 1,000,000 USDC | [^dydx-community-2026-04-28-modules-governance-markets] |
| 2026-04-28 (snapshot, community-docs schema) | 1 Small-Cap | 0.10 (10%) | 0.05 (MF=0.5) | 5,000 USDC | base_position_notional 250,000 USDC | [^dydx-community-2026-04-28-modules-governance-markets] |
| 2026-04-28 (snapshot, community-docs schema) | 5 Mid-Cap | 0.05 (5%) | 0.03 (MF=0.6) | 5,000 USDC | base_position_notional 500,000 USDC | [^dydx-community-2026-04-28-modules-governance-markets] |
| 2026-04-28 (snapshot, community-docs schema) | 6 FX | 0.01 (1%) | 0.005 (MF=0.5) | 2,500 USDC | base_position_notional 500,000 USDC | [^dydx-community-2026-04-28-modules-governance-markets] |
| 2026-04-28 (snapshot, docs.dydx.xyz schema) | 0 Large-Cap | 0.02 (2%) | 0.012 (MF=0.6) | 25,000 USDC | lower_cap none, upper_cap none | [^dydx-docs-2026-04-28-concepts-trading-governance] |
| 2026-04-28 (snapshot, docs.dydx.xyz schema) | 1 Small-Cap | 0.10 (10%) | 0.05 (MF=0.5) | not listed | lower_cap 20M, upper_cap 50M | [^dydx-docs-2026-04-28-concepts-trading-governance] |
| 2026-04-28 (snapshot, docs.dydx.xyz schema) | 6 FX | 0.01 (1%) | 0.0005 | not listed | lower_cap 0.5M, upper_cap 1M | [^dydx-docs-2026-04-28-concepts-trading-governance] |

## Tiering rules / formulae
- OI-scaling: `effective_IMF = min(base_IMF + max((open_notional - lower_cap)/(upper_cap - lower_cap) * (1 - base_IMF), 0), 1.0)`[^dydx-docs-2026-04-28-concepts-trading-margin]
- IMF reaches 100% at upper_cap (1:1 collateral required)[^dydx-docs-2026-04-28-concepts-trading-margin]
- Isolated Markets (v5.0.0): `PerpetualParams.market_type = PERPETUAL_MARKET_TYPE_ISOLATED`[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]

## Disputed values

### #dispute-liquidity-tier-schema -- Liquidity Tier schema (base_position_notional + impact_notional vs lower_cap/upper_cap)

**Claim A** . confidence: high . recency: 2026-04 . authority: high
  Per-tier on-chain values use `base_position_notional` + `impact_notional` schema. Tier 0 (Large-Cap) impact_notional = 10,000 USDC[^dydx-community-2026-04-28-modules-governance-markets].

**Claim B** . confidence: high . recency: 2026-04 . authority: high
  Per-tier values use `lower_cap` / `upper_cap` schema. Tier 0 (Large-Cap) impact_notional = 25,000 USDC[^dydx-docs-2026-04-28-concepts-trading-governance].
  status: active

-> Open question: What is the current on-chain Liquidity Tier table schema and per-tier numeric values?
  Suggested verification: query `dydxprotocold query perpetuals liquidity-tiers` and cross-reference with v4_chain proto definitions.

## Sources
[^dydx-community-2026-04-28-modules-governance-markets]: [[sources/dydx-community-2026-04-28-modules-governance-markets]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-docs-2026-04-28-concepts-trading-margin]: [[sources/dydx-docs-2026-04-28-concepts-trading-margin]]
[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]: [[sources/dydx-docs-2026-04-28-concepts-trading-isolated-markets]]
