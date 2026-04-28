---
type: source
id: drift-sdk-docs-2026-04-28-concepts-markets
title: Markets
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/markets
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-markets.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Markets

## TL;DR
Drift supports two market types: SPOT and PERP. Perpetuals support three contract types: PERPETUAL (standard, no expiry), FUTURE (expiring), PREDICTION (binary outcome 0 or 1). vAMM mechanism: constant product `k = baseReserves × quoteReserves`; price = `(quoteReserves / baseReserves) × pegMultiplier`. PegMultiplier adjusted periodically (using protocol fees) to keep AMM price near oracle. Funding: positive when mark > oracle (longs pay shorts); typical interval = hourly. Margin formulas with size scaling: Initial Margin Ratio = `marginRatioInitial + imfFactor × sqrt(size × 10)`; Maintenance Margin Ratio = `marginRatioMaintenance + imfFactor × sqrt(size × 10)`. Spot: AssetTier = COLLATERAL | PROTECTED | CROSS | ISOLATED | UNLISTED. Interest rate model is utilization-based: borrowRate scales linearly to optimalUtilization, then accelerates above. Deposit rate = `borrowRate × utilization × (1 − protocolFee)`. Scaled balance system: `tokenAmount = scaledBalance × cumulativeInterest / 10^9`. Asset/liability weights: COLLATERAL ~1.0, volatile assets more conservative. Per-operation pause flags (UPDATE_FUNDING, AMM_FILL, FILL, SETTLE_PNL, etc.) allow granular admin control.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift supports two market types: SPOT and PERP. | [[entities/perpdex/drift]] | A1-PI |
| #c2 | Perpetual contracts have three subtypes: PERPETUAL (no expiration), FUTURE (expiring), PREDICTION (binary outcome 0 or 1). | [[entities/perpdex/drift]] | A1-PI |
| #c3 | vAMM constant product invariant: `k = baseAssetReserve × quoteAssetReserve`. | [[concepts/market-structure/vamm]] | A1-PI |
| #c4 | vAMM price formula: `price = (quoteReserves / baseReserves) × pegMultiplier`. | [[concepts/market-structure/vamm]] | - |
| #c5 | The pegMultiplier is adjusted periodically using protocol fees to keep AMM price close to oracle price. | [[concepts/market-structure/vamm]] | A6-PI |
| #c6 | Funding rate signs: positive funding (longs pay shorts) when mark > oracle; negative funding (shorts pay longs) when mark < oracle. | [[concepts/fee-model/funding-rate]] | A6-PI |
| #c7 | Funding payment interval is typically every hour. | [[parameters/drift/funding-config]] | A6-PI |
| #c8 | Initial Margin Ratio formula: `marginRatioInitial + imfFactor × sqrt(size × 10)`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c9 | Maintenance Margin Ratio formula: `marginRatioMaintenance + imfFactor × sqrt(size × 10)`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c10 | Spot AssetTier values: COLLATERAL (full collateral weight), PROTECTED (protected from borrows), CROSS (cross-margin only), ISOLATED (isolated only), UNLISTED (not tradeable). | [[concepts/risk/margin-tier]] | A6-PI |
| #c11 | Spot interest rate model: utilization = totalBorrows / totalDeposits; borrowRate scales linearly to optimalUtilization then accelerates above. | [[concepts/operations/insurance-fund]] | A6-PI |
| #c12 | Spot deposit rate = `borrowRate × utilization × (1 − protocolFee)`. | [[entities/perpdex/drift]] | - |
| #c13 | Spot positions use a scaled balance system: `tokenAmount = scaledBalance × cumulativeInterest / 10^9`, allowing all balances to accrue interest without per-user updates. | [[entities/perpdex/drift]] | - |
| #c14 | Asset weights examples: initial 0.8 (80% collateral value for opening positions), maintenance 0.9 (90% for maintaining); higher quality assets like USDC closer to 1.0. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c15 | Liability weights examples: initial 1.2 (120% borrow weight for opening), maintenance 1.1 (110% for maintaining). | [[parameters/drift/risk-parameters]] | A6-PI |
| #c16 | Per-operation pause flags allow granular admin control: PerpOperation (UPDATE_FUNDING, AMM_FILL, FILL, SETTLE_PNL, SETTLE_PNL_WITH_POSITION, LIQUIDATION, SETTLE_REV_POOL); SpotOperation (UPDATE_CUMULATIVE_INTEREST, FILL, DEPOSIT, WITHDRAW, LIQUIDATION). | [[entities/perpdex/drift]] | A7-PI |
| #c17 | Markets track historical oracle data including 1-hour and 5-minute TWAPs used for funding rate calculations and as manipulation-resistant price source. | [[parameters/drift/oracle-config]] | A6-PI |
