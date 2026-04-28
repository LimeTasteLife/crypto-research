---
type: source
id: lighter-docs-2026-04-28-trading-contract-specifications
title: Contract Specifications
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/contract-specifications
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-contract-specifications.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Contract Specifications

## TL;DR
Lighter Test Network supports perpetual futures across crypto, FX (USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD), and commodities (XAU, XAG). Each market exposes Price Step, Amount Step, Leverage, and three margin fractions: IMR (Initial), MMR (Maintenance), CMR (Close-Out). Crypto leverage tiers are 50x / 25x / 20x / 15x / 10x / 8x / 5x / 3x with corresponding IMR/MMR/CMR triplets that follow MMR ≈ 0.6·IMR and CMR ≈ 0.4·IMR. The default funding period is 1 hour per market; new market deployments may configure a different period. Lighter Governance continually adds markets as the testnet grows. Per-market detail (each symbol's tick/lot/leverage/IMR/MMR/CMR) is filed downstream into per-market parameter pages.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Lighter Test Network supports perpetual futures markets; new markets are added by Lighter Governance as the test network grows. | [[entities/perpdex/lighter]], [[parameters/lighter/listed-markets-roster]] | A1-PI, A7-PI |
| #c2 | Each market specifies IMR (Initial Margin Requirement), MMR (Maintenance Margin Requirement), and CMR (Close-Out Margin Requirement) fractions. | [[concepts/risk/margin-tier]] | - |
| #c3 | Each deployed market has a default funding period of 1 hour. | [[parameters/lighter/funding-config]] | A6-PI |
| #c4 | Funding period is per-market configuration and may differ for new market deployments. | [[parameters/lighter/funding-config]] | A6-PI, A7-PI |
| #c5 | BTC and ETH are listed at 50x max leverage with IMR=2%, MMR=1.2%, CMR=0.8% (Price Step BTC=0.1 / ETH=0.01; Amount Step BTC=0.00001 / ETH=0.0001). | [[parameters/lighter/markets/BTC]], [[parameters/lighter/markets/ETH]], [[parameters/lighter/margin-tiers]] | A6-PI |
| #c6 | SOL is listed at 25x max leverage with IMR=4%, MMR=2.4%, CMR=1.6% (Price Step 0.001, Amount Step 0.001). | [[parameters/lighter/markets/SOL]], [[parameters/lighter/margin-tiers]] | A6-PI |
| #c7 | XRP, HYPE, BNB are listed at 20x max leverage with IMR=5%, MMR=3%, CMR=2%. | [[parameters/lighter/margin-tiers]] | A6-PI |
| #c8 | ARB, OP are listed at 15x max leverage with IMR=6.66%, MMR=3.99%, CMR=2.66%. | [[parameters/lighter/margin-tiers]] | A6-PI |
| #c9 | A 10x-leverage tier exists with IMR=10%, MMR=6%, CMR=4% (members include TON, BCH, ADA, DOGE, JUP, XMR, TRUMP, LDO, SEI, LTC, FARTCOIN, KSHIB, KBONK, IP, WIF, DOT, SUI, TIA, UNI, XPL, ENA, CRV, NEAR, KPEPE, WLD, APT, POPCAT, ONDO, AVAX, TRX, AAVE, LINK). | [[parameters/lighter/margin-tiers]], [[parameters/lighter/listed-markets-roster]] | A6-PI |
| #c10 | An 8x-leverage tier exists with IMR=12.5%, MMR=7.5%, CMR=5% (members POL, PUMP, ZK, PAXG, PENGU). | [[parameters/lighter/margin-tiers]] | A6-PI |
| #c11 | A 5x-leverage tier exists with IMR=20%, MMR=12%, CMR=8% (members PENDLE, TAO, PYTH, SPX, STRK, SYRUP, VIRTUAL, ICP, MNT, KAITO, APEX, GRASS, CC, BERA, ASTER, GMX, HBAR, ETHFI, MORPHO, EIGEN, MET, ZRO, DYDX, FIL, ZEC, S, YZY). | [[parameters/lighter/margin-tiers]] | A6-PI |
| #c12 | A 3x-leverage tier exists with IMR=33.33%, MMR=20%, CMR=13.33% (members VVV, DOLO, MYX, kTOSHI, ZORA, AERO, NMR, 2Z, AVNT, LINEA, USELESS, RESOLV, CRO, 0G, PROVE, EDEN, FF, KTOSHI, STBL). | [[parameters/lighter/margin-tiers]] | A6-PI |
| #c13 | Forex pairs USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD are listed at 25x max leverage with IMR=5%, MMR=2.4%, CMR=1.6%. | [[parameters/lighter/listed-markets-roster]], [[parameters/lighter/margin-tiers]] | A6-PI, A1-PI |
| #c14 | XAG (silver) is listed at 10x max leverage with IMR=10%, MMR=6%, CMR=4% (Price Step 0.0001, Amount Step 0.01). | [[parameters/lighter/markets/XAG]], [[parameters/lighter/margin-tiers]] | A6-PI |
| #c15 | XAU (gold) is listed at 15x max leverage with IMR=6.66%, MMR=3.99%, CMR=2.66% (Price Step 0.01, Amount Step 0.0001). | [[parameters/lighter/markets/XAU]], [[parameters/lighter/margin-tiers]] | A6-PI |
| #c16 | Across the Lighter margin schedule, MMR is approximately 0.6·IMR and CMR is approximately 0.4·IMR for each leverage tier. | [[parameters/lighter/margin-tiers]] | A6-PI |
| #c17 | Lighter perp price tick varies per market (e.g. BTC=0.1, ETH=0.01, SOL=0.001, XRP=0.000001, USDJPY=0.001, XAU=0.01); amount step also varies per market. | [[parameters/lighter/listed-markets-roster]] | - |

## Conflicts raised
- (none within group; CMR appears here as a third margin level — verify against the liquidations page where CMR is referenced as the "close-out" margin in the waterfall. The two pages are consistent on `C_i < M_i < I_i`.)
