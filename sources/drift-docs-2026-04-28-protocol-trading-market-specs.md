---
type: source
id: drift-docs-2026-04-28-protocol-trading-market-specs
title: Market Specs
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/trading/market-specs
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-trading-market-specs.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Specs

## TL;DR
Drift defines five Contract Tiers (A, B, C, Speculative, Highly Speculative, Isolated — note the docs list six labels but call them "five unique tiers") used to rank perpetual market risk and govern access to insurance funds, oracle divergence tolerance, and TWAP/funding sanitization. As of the snapshot, BTC-PERP is Tier A; SOL-PERP and ETH-PERP are Tier B; 1MBONK-PERP, 1MPEPE-PERP, WIF-PERP are Speculative; W-PERP is Highly Speculative; most others are Tier C. Speculative tier has NO access to external insurance — only the per-market fee pool. Highly Speculative sits one tranche below Speculative. Isolated tier requires the user to disable cross-margin. Spot Asset Tiers parallel: Collateral, Protected, Cross, Isolated, Unlisted. Each market additionally exposes Oracle Source (Pyth | Switchboard | Prelaunch), Max OI cap, and IMF Factor for size-based margin scaling.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Contract Tiers are A, B, C, Speculative, Highly Speculative, and Isolated. | [[concepts/risk/margin-tier]], [[parameters/drift/risk-parameters]] | A6-PI |
| #c2 | Contract tiers govern priority access to collateral in liquidations, max insurance limits, acceptable oracle price divergence, and TWAP/funding rate sanitization rules. | [[concepts/risk/margin-tier]] | A6-PI |
| #c3 | A market in Contract Tier B is in a 'safer' tranche than Tier C, Speculative, or Isolated. | [[concepts/risk/margin-tier]] | A6-PI |
| #c4 | As of this snapshot: BTC-PERP is Tier A; SOL-PERP and ETH-PERP are Tier B; 1MBONK-PERP, 1MPEPE-PERP, WIF-PERP are Speculative; W-PERP is Highly Speculative; most other markets are Tier C. | [[parameters/drift/listed-markets-roster]] | A1-PI |
| #c5 | Speculative tier markets have NO access to external insurance funds — they have access only to the perpetual market's own fee pool. | [[parameters/drift/insurance-fund]], [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c6 | Highly Speculative tier has the same restrictions as Speculative but sits a tranche below. | [[concepts/risk/margin-tier]] | A6-PI |
| #c7 | Isolated tier requires the user account to refrain from / disable cross-margin trading on both perpetual and spot markets. | [[concepts/risk/margin-tier]] | A6-PI |
| #c8 | Users with Margin Trading enabled, a non-USDC borrow, or another perpetual position cannot enter an Isolated Tier market. | [[concepts/risk/margin-tier]] | A6-PI |
| #c9 | An account with liabilities beyond the perpetual market's quote asset and the isolated perpetual market is forced into Reduce Only mode. | [[concepts/risk/margin-tier]] | A6-PI |
| #c10 | Drift supports oracle sources Pyth, Switchboard, and a custom internal "Prelaunch" oracle. | [[parameters/drift/oracle-config]] | A6-PI |
| #c11 | The Prelaunch oracle uses mark TWAP as the oracle price for markets without an external spot reference. | [[parameters/drift/oracle-config]] | A1-PI, A6-PI |
| #c12 | Each Prelaunch oracle has both an initial price and a max price; the oracle value cannot exceed the max price. | [[parameters/drift/oracle-config]] | A1-PI, A6-PI |
| #c13 | Each perpetual market has a Max Open Interest parameter; orders that would breach this limit are blocked. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c14 | The IMF Factor (Initial Margin Fraction factor) is used to increase liability weight and decrease asset weight for large positions. | [[concepts/risk/margin-tier]] | A6-PI |
| #c15 | Drift Asset Tiers (spot) are: Collateral (full privilege), Protected (collateral, no borrow), Cross (not collateral, allow multi-borrow), Isolated (not collateral, single borrow), Unlisted (no privilege). | [[concepts/risk/margin-tier]] | A6-PI |
| #c16 | Spot markets define a Scale Initial Asset Weight Start parameter — the notional total user deposits at which the initial asset weight starts scaling down. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c17 | Spot markets define a Max Token Deposits cap on tokens addable to the collateral vault. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c18 | Spot orders must have base lots that are multiples of step size and price lots that are multiples of tick size. | [[concepts/market-microstructure/tick-size]] | - |
