---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: listed-markets-roster
unit: count
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter listed markets roster

## Current (as of 2026-04-28)

**Coverage.** Lighter Test Network supports perpetual futures across crypto, FX, commodities (RWAs), and pre-launch markets[^lighter-docs-2026-04-28-trading-contract-specifications]. New markets are added by Lighter Governance as the network grows[^lighter-docs-2026-04-28-trading-contract-specifications]. RWA market specifications may be updated at the discretion of the Lighter team[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications].

**Crypto perpetuals (selected).**

| Symbol | Max leverage | IMR | MMR | CMR | Price step | Amount step |
|---|---|---|---|---|---|---|
| BTC | 50x | 2% | 1.2% | 0.8% | 0.1 | 0.00001 |
| ETH | 50x | 2% | 1.2% | 0.8% | 0.01 | 0.0001 |
| SOL | 25x | 4% | 2.4% | 1.6% | 0.001 | 0.001 |
| XRP, HYPE, BNB | 20x | 5% | 3% | 2% | — | — |
| ARB, OP | 15x | 6.66% | 3.99% | 2.66% | — | — |
| TON, BCH, ADA, DOGE, JUP, XMR, TRUMP, LDO, SEI, LTC, FARTCOIN, KSHIB, KBONK, IP, WIF, DOT, SUI, TIA, UNI, XPL, ENA, CRV, NEAR, KPEPE, WLD, APT, POPCAT, ONDO, AVAX, TRX, AAVE, LINK | 10x | 10% | 6% | 4% | — | — |
| POL, PUMP, ZK, PAXG, PENGU | 8x | 12.5% | 7.5% | 5% | — | — |
| PENDLE, TAO, PYTH, SPX, STRK, SYRUP, VIRTUAL, ICP, MNT, KAITO, APEX, GRASS, CC, BERA, ASTER, GMX, HBAR, ETHFI, MORPHO, EIGEN, MET, ZRO, DYDX, FIL, ZEC, S, YZY | 5x | 20% | 12% | 8% | — | — |
| VVV, DOLO, MYX, kTOSHI, ZORA, AERO, NMR, 2Z, AVNT, LINEA, USELESS, RESOLV, CRO, 0G, PROVE, EDEN, FF, KTOSHI, STBL | 3x | 33.33% | 20% | 13.33% | — | — |

[^lighter-docs-2026-04-28-trading-contract-specifications]

**FX perpetuals.**

| Symbol | Max leverage | IMR | MMR | CMR |
|---|---|---|---|---|
| USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD | 25x | 5% | 2.4% | 1.6% |

[^lighter-docs-2026-04-28-trading-contract-specifications]

**Commodity / RWA perpetuals (selected).**

| Symbol | Max leverage | IMR | MMR | CMR | Price step | Amount step |
|---|---|---|---|---|---|---|
| XAU (gold) | 15x | 6.66% | 3.99% | 2.66% | 0.01 | 0.0001 |
| XAG (silver) | 10x | 10% | 6% | 4% | 0.0001 | 0.01 |

[^lighter-docs-2026-04-28-trading-contract-specifications]

Full RWA market specifications (tick, lot, leverage, IMR/MMR/CMR per symbol) are rendered via a live widget not captured in the 2026-04-28 mirror snapshot — values above are from the contract-specifications page[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications].

**Pre-launch markets.** Operate in isolated margin mode only; XLP (Experimental Liquidity Provider) provides liquidity; no liquidation fee[^lighter-docs-2026-04-28-trading-prelaunch-markets]. See [[concepts/listing/pre-launch-perp]].

**Per-market pages.** [[parameters/lighter/markets/BTC]] · [[parameters/lighter/markets/ETH]] · [[parameters/lighter/markets/SOL]] · [[parameters/lighter/markets/XAU]] · [[parameters/lighter/markets/XAG]].

## Time series

| effective | crypto perps | FX pairs | RWA/commodity | pre-launch | source |
|---|---|---|---|---|---|
| 2026-04-28 | 50x→3x tiers, 50+ symbols | USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD | XAU, XAG + unlisted equities/commodities | yes (isolated only, XLP) | [^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications] |

## Tiering rules / formulae

Margin tiers: `MMR ≈ 0.6·IMR`, `CMR ≈ 0.4·IMR` across all leverage tiers[^lighter-docs-2026-04-28-trading-contract-specifications]. Per-leverage-tier details in [[parameters/lighter/margin-tiers]].

## Disputed values
None. Numeric RWA per-market specs not captured (live-widget gap)[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications].

## Sources
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications]: [[sources/lighter-docs-2026-04-28-trading-real-world-assets-rwas-market-specifications]]
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
