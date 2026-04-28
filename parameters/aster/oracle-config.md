---
type: parameter
entity: [[aster]]
parameter: oracle-config
unit: weight
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster oracle config

## Current (as of 2026-04-28)

**Mark price construction.** Aster's mark price is the **median of three components**: Price 1, Price 2, and the Contract Price[^aster-docs-2026-04-28-trading-perpetuals-mark-price].

- **Price 1** = `Index × (1 + FundingRate × TimeToNextFunding(h) / 8)` — the funding-adjusted forward index[^aster-docs-2026-04-28-trading-perpetuals-mark-price].
- **Price 2** = `Index + 5min-MA((Bid1 + Ask1)/2 − Index)` — the index plus a five-minute moving average of the local-book mid deviation, sampled every minute over a 5-minute window[^aster-docs-2026-04-28-trading-perpetuals-mark-price].
- **Contract Price** = the latest contract trade price[^aster-docs-2026-04-28-trading-perpetuals-mark-price].

**Price index source set.** The Price Index is a volume-weighted average from major external spot exchanges including **Binance, HTX, Kraken, and Huobi**[^aster-docs-2026-04-28-trading-perpetuals-mark-price]. Higher-volume exchanges carry greater weight[^aster-docs-2026-04-28-trading-perpetuals-mark-price].

**Defensive measures.** Four documented guards harden the index against single-source manipulation and stale feeds[^aster-docs-2026-04-28-trading-perpetuals-mark-price]:

1. Any exchange deviating **>5%** from the median has its weight set to **zero**.
2. If multiple exchanges show large deviations, the **median** of all sources replaces the weighted average for that calculation.
3. An exchange failing to update within **3 seconds** is **excluded** from the index.
4. If the latest contract trade strays **>5%** from mark for **>5 seconds**, the contract price is replaced by mark in calculations.

**Pre-launch mode.** For pre-launch contracts, both Price 1 and Price 2 are anchored to the local pre-market book's `(Bid1 + Ask1)/2` since no external Price Index exists yet; standard methodology resumes after conversion to perp[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]. See [[parameters/aster/listing-policy]].

**Dependent uses.** Mark price drives unrealized PnL, liquidation triggers, and funding payments[^aster-docs-2026-04-28-trading-perpetuals-mark-price].

## Time series

| effective | aggregation | sources | guards | source |
|---|---|---|---|---|
| 2026-04-28 | median(Price1, Price2, Contract); Index = volume-weighted spot VWAP | Binance, HTX, Kraken, Huobi (and other major spot venues) | 5% deviation → weight 0; multi-deviation → median replaces VWAP; ≥3s lag excluded; 5%/5s contract-vs-mark replaces contract | [^aster-docs-2026-04-28-trading-perpetuals-mark-price] |

## Tiering rules / formulae

- `MarkPrice = median(Price1, Price2, ContractPrice)`[^aster-docs-2026-04-28-trading-perpetuals-mark-price]
- `Price1 = Index × (1 + FundingRate × Δt_next/8)`[^aster-docs-2026-04-28-trading-perpetuals-mark-price]
- `Price2 = Index + MA_5min((Bid1+Ask1)/2 − Index)` (sampled every minute)[^aster-docs-2026-04-28-trading-perpetuals-mark-price]
- Median selection example: if `Price1 < Price2 < Contract`, then `MarkPrice = Price2`[^aster-docs-2026-04-28-trading-perpetuals-mark-price]

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-mark-price]: [[sources/aster-docs-2026-04-28-trading-perpetuals-mark-price]]
[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]: [[sources/aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]]
