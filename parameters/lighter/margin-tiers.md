---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: margin-tiers
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter margin tiers

## Current (as of 2026-04-28)

**Three-level system.** Each market defines three margin requirement levels: IMR (Initial Margin Requirement), MMR (Maintenance Margin Requirement), and CMR (Close-Out Margin Requirement), with the strict ordering `C_i < M_i < I_i`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Across all tiers, `MMR ≈ 0.6·IMR` and `CMR ≈ 0.4·IMR`[^lighter-docs-2026-04-28-trading-contract-specifications].

**User leverage.** When a user changes leverage, the effective initial margin fraction is `min(user-set fraction, minimum fraction allowed for the market)`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Leverage-tier table.**

| Max leverage | IMR | MMR | CMR | Example markets |
|---|---|---|---|---|
| 50x | 2% | 1.2% | 0.8% | BTC, ETH[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 25x | 4% | 2.4% | 1.6% | SOL; also FX (5% IMR, see note)[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 20x | 5% | 3% | 2% | XRP, HYPE, BNB[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 15x | 6.66% | 3.99% | 2.66% | ARB, OP, XAU[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 10x | 10% | 6% | 4% | TON, BCH, ADA, DOGE, JUP, XMR, TRUMP, LDO, SEI, LTC, FARTCOIN, KSHIB, KBONK, IP, WIF, DOT, SUI, TIA, UNI, XPL, ENA, CRV, NEAR, KPEPE, WLD, APT, POPCAT, ONDO, AVAX, TRX, AAVE, LINK, XAG[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 8x | 12.5% | 7.5% | 5% | POL, PUMP, ZK, PAXG, PENGU[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 5x | 20% | 12% | 8% | PENDLE, TAO, PYTH, SPX, STRK, SYRUP, VIRTUAL, ICP, MNT, KAITO, APEX, GRASS, CC, BERA, ASTER, GMX, HBAR, ETHFI, MORPHO, EIGEN, MET, ZRO, DYDX, FIL, ZEC, S, YZY[^lighter-docs-2026-04-28-trading-contract-specifications] |
| 3x | 33.33% | 20% | 13.33% | VVV, DOLO, MYX, kTOSHI, ZORA, AERO, NMR, 2Z, AVNT, LINEA, USELESS, RESOLV, CRO, 0G, PROVE, EDEN, FF, KTOSHI, STBL[^lighter-docs-2026-04-28-trading-contract-specifications] |

**Note.** FX pairs (USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD) are listed at 25x max leverage with IMR=5%, MMR=2.4%, CMR=1.6% — a different IMR than crypto 25x markets[^lighter-docs-2026-04-28-trading-contract-specifications].

**Multi-asset margin extension.** When non-USDC margin assets are used (Multi-Asset Margin), health checks reuse IMR/MMR/CMR but evaluate TALT (Total Account Liquidation Threshold) instead of TAV for liquidation triggers[^lighter-docs-2026-04-28-trading-multi-asset-margin]. See [[parameters/lighter/multi-asset-collateral]].

## Time series

| effective | max leverage tiers | IMR/MMR/CMR ratio | FX exception | source |
|---|---|---|---|---|
| 2026-04-28 | 50x / 25x / 20x / 15x / 10x / 8x / 5x / 3x | MMR≈0.6·IMR, CMR≈0.4·IMR | 25x FX at IMR=5% | [^lighter-docs-2026-04-28-trading-contract-specifications] |

## Tiering rules / formulae

**Margin requirement calculations.**
- `IMR = Σ_i abs(pos_i) · mark_i · I_i`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]
- `MMR = Σ_i abs(pos_i) · mark_i · M_i`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]
- `CMR = Σ_i abs(pos_i) · mark_i · C_i`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]

**Effective leverage.**
`effective_IMF = min(user_set_fraction, min_fraction_for_market)`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-multi-asset-margin]: [[sources/lighter-docs-2026-04-28-trading-multi-asset-margin]]
