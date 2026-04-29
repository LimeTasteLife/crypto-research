---
type: parameter
entity: [[drift]]
parameter: risk-parameters
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift risk parameters

## Current (as of 2026-04-28)

**10% oracle-mark price band.** Drift v3 prevents orders if oracle-mark divergence breaches a 10% band relative to the oracle's 5-minute TWAP[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

**Clearinghouse pause.** Pauses risk-increasing trades that further enlarge oracle-mark divergence; closing or reducing a position that further breaches divergence is also disallowed unless divergence has already been breached[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

**Post-only auto-cancel.** Maker post-only ask auto-cancelled if oracle's price is 2.5% above the maker's ask limit price; symmetric for bid 2.5% below[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

**Order limits.** Each user sub-account can have up to 32 outstanding orders[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters]. Market orders default to a 30s active time limit and a 2% max price-impact (`max_slippage_ratio`)[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters]. Within a single transaction, AMM fills are bounded by `max_base_asset_amount` per market[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

**Size-based IMF scaling.** `marginRatio = baseMarginRatio + imfFactor * sqrt(size * 10)`[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters][^drift-sdk-docs-2026-04-28-concepts-margin].

**Spot asset-weight discount.** `assetWeight_eff = (1.1 * assetWeight) / (1 + imfFactor * sqrt(size * 10))`[^drift-sdk-docs-2026-04-28-concepts-margin].

**Liability premium.** `max(0.8 * wgt + sqrt(size) * imf_factor, wgt)`[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

**HighLeverageMode.** `maxUsers` cap; may be reduce-only; doubles bottom-tier taker fee[^drift-docs-2026-04-28-protocol-trading-trading-fees][^drift-sdk-docs-2026-04-28-concepts-margin].

**Free-collateral guard.** Taker orders that would push free collateral negative are cancelled; fillers receive a small reward for the cancellation[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

**Unbounded unrealized PnL risk.** Traders can technically achieve unbounded unrealized PnL by entering/exiting against the AMM; gains cannot be settled until offsetting loss exists; a market with majority extreme positive unsettled PnL may be eligible for the Delisting Process[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters].

## Time series

| effective | price band | post-only cancel band | max orders/sub | market order TTL | source |
|---|---|---|---|---|---|
| 2026-04-28 | 10% vs 5min oracle TWAP | 2.5% | 32 | 30s | [^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters] |

## Tiering rules / formulae

IMF scaling: `marginRatio = baseMarginRatio + imfFactor * sqrt(size * 10)`[^drift-sdk-docs-2026-04-28-concepts-margin].

Asset weight discount: `assetWeight_eff = (1.1 * assetWeight) / (1 + imfFactor * sqrt(size * 10))`[^drift-sdk-docs-2026-04-28-concepts-margin].

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters]]
[^drift-sdk-docs-2026-04-28-concepts-margin]: [[sources/drift-sdk-docs-2026-04-28-concepts-margin]]
[^drift-docs-2026-04-28-protocol-trading-trading-fees]: [[sources/drift-docs-2026-04-28-protocol-trading-trading-fees]]
