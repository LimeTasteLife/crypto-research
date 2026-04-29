---
type: concept
domain: market-microstructure
name: Oracle spec
last_reviewed: 2026-04-28
disputed: false
---

# Oracle spec

## Definition
An oracle spec is the venue's policy for constructing a robust external reference price feed for each listed perp[^hl-docs-2026-04-27-trading-robust-price-indices]. The oracle price is the input to funding-rate computation and is used as one component of the [[concepts/market-microstructure/mark-price-formula|mark price]][^hl-docs-2026-04-27-trading-robust-price-indices][^hl-docs-2026-04-27-hypercore-oracle].

The oracle spec governs source selection (which CEXs/AMMs feed the price), aggregation method (median, weighted median, mean), update cadence (sample frequency), and validator / signer set (who can publish a valid update).

## Mechanism on Hyperliquid

**Validator-published feed.** Validators publish per-perp spot oracle prices every 3 seconds[^hl-docs-2026-04-27-hypercore-oracle][^hl-docs-2026-04-27-trading-robust-price-indices].

**Aggregation across validators.** The clearinghouse uses the **stake-weighted median** of validator-submitted prices as the final oracle price[^hl-docs-2026-04-27-hypercore-oracle].

**Source weights** (stored in [[parameters/hyperliquid/oracle-config]]):

| source | weight |
|---|---|
| Binance | 3 |
| OKX | 2 |
| Bybit | 2 |
| Kraken | 1 |
| Kucoin | 1 |
| Gate | 1 |
| MEXC | 1 |
| Hyperliquid spot | 1 |

[^hl-docs-2026-04-27-hypercore-oracle]

**Adaptive source exclusion.**
- Assets whose primary spot liquidity is on Hyperliquid (e.g. HYPE) **exclude external CEX sources** until external liquidity reaches a threshold[^hl-docs-2026-04-27-hypercore-oracle].
- Assets with primary spot liquidity off-Hyperliquid (e.g. BTC) **exclude Hyperliquid spot** from the oracle[^hl-docs-2026-04-27-hypercore-oracle].

**Independence from on-chain market state.** Oracle price is independent of Hyperliquid market data (it is a CEX-spot-weighted figure) and is used to compute funding rates separately from mark price[^hl-docs-2026-04-27-trading-robust-price-indices].

## Variants in the wild

| venue | aggregation | source mix | cadence | adaptive exclusion |
|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | stake-weighted median across validators; weighted median across CEX sources[^hl-docs-2026-04-27-hypercore-oracle] | 7 CEX + HL spot[^hl-docs-2026-04-27-hypercore-oracle] | 3s validator cadence[^hl-docs-2026-04-27-hypercore-oracle] | yes — venue-specific (HYPE excludes external; BTC excludes HL spot)[^hl-docs-2026-04-27-hypercore-oracle] |
| [[entities/perpdex/aster]] | VWAP across CEX spot sources; ≥5% deviation → weight 0; multi-deviation → median replaces VWAP[^aster-docs-2026-04-28-trading-perpetuals-mark-price] | Binance / HTX / Kraken / Huobi spot[^aster-docs-2026-04-28-trading-perpetuals-mark-price] | not surfaced; ≥3s lag → source excluded[^aster-docs-2026-04-28-trading-perpetuals-mark-price] | deviation/lag based exclusion + 5s/5% guard on contract-vs-mark[^aster-docs-2026-04-28-trading-perpetuals-mark-price] |
| [[entities/perpdex/lighter]] | index = weighted blend of external oracles[^lighter-docs-2026-04-28-trading-fair-price-marking] | Chainlink, Stork, Pyth; RWAs blend external + internal (EMA-smoothed impact)[^lighter-docs-2026-04-28-trading-fair-price-marking][^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism] | τ = 1h index, τ = 8min mark[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism] | stale-oracle weight decays exponentially per-source; clamps ±(1/L·0.75 − 0.5%) index, ±(1/L·0.75) mark[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism] |

(Other perpdex venues to be added in subsequent ingest passes.)
| [[entities/perpdex/dydx]] | Slinky validator-sidecar vote extensions; proposer aggregates and network accepts in-consensus[^dydx-docs-2026-04-28-concepts-trading-oracle] | 7 source exchanges (Binance, Bitfinex, Bitstamp, Bybit, Coinbase, crypto.com, GateIO)[^dydx-docs-2026-04-28-concepts-trading-oracle] | rate-limited by max-markets-per-block + min_price_change_ppm per market[^dydx-docs-2026-04-28-concepts-trading-oracle] | per-market `min_exchanges` + `min_price_change_ppm`; adding/removing sources requires binary upgrade[^dydx-docs-2026-04-28-concepts-trading-oracle] |

## Edge cases
- Manipulation cost depends on which sources are weighted; high-weight CEXs (Binance) require deeper external liquidity to manipulate than low-weight ones.
- For permissionlessly-listed spot markets (HIP-1) where the asset's CEX presence is thin, the adaptive exclusion rule can leave the oracle dominated by Hyperliquid's own spot — increasing self-referential manipulation risk until liquidity breadth grows.

## Disputed claims
None at first ingest.

## Related
[[concepts/market-microstructure/mark-price-formula]] · [[concepts/fee-model/funding-rate]] · [[parameters/hyperliquid/oracle-config]]

## Sources
[^hl-docs-2026-04-27-hypercore-oracle]: [[sources/hl-docs-2026-04-27-hypercore-oracle]]
[^hl-docs-2026-04-27-trading-robust-price-indices]: [[sources/hl-docs-2026-04-27-trading-robust-price-indices]]
[^aster-docs-2026-04-28-trading-perpetuals-mark-price]: [[sources/aster-docs-2026-04-28-trading-perpetuals-mark-price]]
[^lighter-docs-2026-04-28-trading-fair-price-marking]: [[sources/lighter-docs-2026-04-28-trading-fair-price-marking]]
[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]: [[sources/lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]]
[^dydx-docs-2026-04-28-concepts-trading-oracle]: [[sources/dydx-docs-2026-04-28-concepts-trading-oracle]]
