---
type: concept
domain: market-microstructure
name: Mark price formula
last_reviewed: 2026-04-28
disputed: false
---

# Mark price formula

## Definition
The mark price is the venue's robust reference price used for margining, liquidation triggering, take-profit / stop-loss execution, and unrealized PnL accounting[^hl-docs-2026-04-27-trading-robust-price-indices]. Unlike the [[concepts/market-microstructure/oracle-spec|oracle price]] (which is purely external), the mark price typically combines external CEX inputs with the venue's own book state, producing a value that cannot be moved freely by manipulating either side alone.

## Mechanism on Hyperliquid

**Median of three components.** Mark price is the median of:

1. **Oracle plus EMA of book deviation:** `oracle + EMA_150s(HL_mid − oracle)` — anchors to external truth but absorbs persistent local book deviation[^hl-docs-2026-04-27-trading-robust-price-indices].
2. **HL book median:** median of HL best bid, best ask, last trade — represents instantaneous on-venue state[^hl-docs-2026-04-27-trading-robust-price-indices].
3. **External perp median:** weighted median of Binance / OKX / Bybit / Gate / MEXC perp mids with weights 3 / 2 / 2 / 1 / 1[^hl-docs-2026-04-27-trading-robust-price-indices].

**Fallback when input missing.** If exactly two of the three above exist, a 30-second EMA of (median of HL best bid / best ask / last) is appended to the median inputs as a fourth value[^hl-docs-2026-04-27-trading-robust-price-indices].

**Update cadence.** Mark price updates whenever validators publish new oracle prices — approximately every 3 seconds[^hl-docs-2026-04-27-trading-robust-price-indices].

**Use in liquidation.** Liquidations use mark price (not book price) to trigger; this is what makes liquidations robust to single-instantaneous-book-price manipulation[^hl-docs-2026-04-27-trading-liquidations].

**EMA update formula** (used in component 1's `EMA_150s` and the fallback's `30s`):

```
numerator   ← numerator * exp(−t / τ) + sample * t
denominator ← denominator * exp(−t / τ) + t
ema         ← numerator / denominator

τ = 2.5 minutes (= 150 seconds) for component 1
τ = 30 seconds for the fallback
t = elapsed time since last update
sample = current observation
```

[^hl-docs-2026-04-27-trading-robust-price-indices]

## Variants in the wild

| venue | components | aggregation | use sites |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | oracle+EMA, HL book median, external perp median[^hl-docs-2026-04-27-trading-robust-price-indices] | median (with fallback EMA when one missing)[^hl-docs-2026-04-27-trading-robust-price-indices] | margining, liquidations, TP/SL trigger, unrealized PnL[^hl-docs-2026-04-27-trading-robust-price-indices] |
| [[entities/perpdex/aster]] | Price1 = Index×(1 + Funding × time-to-next/8); Price2 = Index + 5min MA of (Bid1+Ask1)/2 − Index; Contract price[^aster-docs-2026-04-28-trading-perpetuals-mark-price] | median(Price1, Price2, Contract)[^aster-docs-2026-04-28-trading-perpetuals-mark-price] | margining, liquidations, unrealized PnL[^aster-docs-2026-04-28-trading-perpetuals-mark-price] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Edge cases
- Component 1's EMA absorbs persistent on-venue divergence — slow enough (150s) that brief manipulation attempts fade, fast enough that legitimate price movement isn't lagged.
- During global outage where external CEX feeds are unavailable, only components 1 (with stale oracle) and 2 (HL book) remain; the system falls into the "two of three" fallback, which can amplify on-venue movement.

## Disputed claims
None at first ingest.

## Related
[[concepts/market-microstructure/oracle-spec]] · [[concepts/risk/liquidation]] · [[concepts/fee-model/funding-rate]] · [[parameters/hyperliquid/oracle-config]]

## Sources
[^hl-docs-2026-04-27-trading-robust-price-indices]: [[sources/hl-docs-2026-04-27-trading-robust-price-indices]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-trading-perpetuals-mark-price]: [[sources/aster-docs-2026-04-28-trading-perpetuals-mark-price]]
