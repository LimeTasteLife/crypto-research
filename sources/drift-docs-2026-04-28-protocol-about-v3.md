---
type: source
id: drift-docs-2026-04-28-protocol-about-v3
title: Understanding Drift
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/about-v3
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-about-v3.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Understanding Drift

## TL;DR
Drift's "About v3" page positions the venue as a decentralized exchange offering four primary products: Spot Trading, Perpetuals, Borrow & Lend, and Passive Liquidity Provision via Backstop AMM Liquidity (BAL). The architectural innovation is a three-layer liquidity stack — Just-in-Time (JIT) auctions (default ~5s Dutch auction), a Constant Liquidity virtual AMM (x*y=k with inbuilt inventory-adjusting bid-ask spread, supporting LP via lpShares), and a Decentralized Limit Orderbook (DLOB) maintained off-chain by a permissionless network of Keeper Bots. The AMM allows Drift to bootstrap new markets without external market makers (with caveat that unsettled PnL availability adds risk). Pyth is the current default oracle, with the protocol able to support other sources per market.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol offers four primary products: Spot Trading, Perpetuals Trading, Borrow & Lend, and Passive Liquidity Provision (Backstop AMM Liquidity / BAL). | [[entities/perpdex/drift]] | A1-PI, A5-PI |
| #c2 | All deposits, withdraws, and trades on Drift are executed on-chain and transparent. | [[entities/perpdex/drift]] | A1-PI |
| #c3 | Trading on Drift requires connection to a self-custodial Solana wallet. | [[entities/perpdex/drift]] | A1-PI |
| #c4 | Drift's matching has three liquidity sources: JIT auction liquidity, virtual AMM (constant liquidity), and decentralized orderbook (DLOB). | [[concepts/operations/matching-engine]], [[entities/perpdex/drift]] | A1-PI |
| #c5 | All market trades (spot and perpetual) are routed through a short-term JIT auction with default duration approximately 5 seconds. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c6 | JIT auctions are run via a Dutch Auction where price starts at the better price and linearly moves toward the worse end price. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c7 | Drift's virtual AMM (vAMM) is the backstop designated liquidity provider when JIT does not fill or when resting orders trigger. | [[concepts/market-structure/vamm]] | A1-PI, A4-PI |
| #c8 | The vAMM uses a constant product formula `x*y=k` to balance reserves. | [[concepts/market-structure/vamm]] | A1-PI |
| #c9 | Drift's vAMM has an inbuilt bid-ask spread that adjusts based on inventory held. | [[concepts/market-structure/vamm]] | A4-PI |
| #c10 | Users can LP into the vAMM to provide additional collateral. | [[parameters/drift/lp-shares]] | A5-PI |
| #c11 | Drift Protocol can support new markets without dependence on external market makers, since the AMM bootstraps liquidity. | [[entities/perpdex/drift]] | A1-PII |
| #c12 | The vAMM mechanism comes with risks on immediate availability of unsettled PnL. | [[concepts/market-structure/vamm]] | A6-PI |
| #c13 | Drift uses Pyth for oracles by default and can arbitrarily support other sources per market. | [[parameters/drift/oracle-config]] | A6-PI |
| #c14 | Drift's decentralized orderbook (DLOB) is its third source of liquidity. | [[entities/perpdex/drift]] | A1-PI |
| #c15 | A network of Keeper Bots sorts on-chain limit orders into an off-chain orderbook and matches them when conditions are met. | [[concepts/operations/matching-engine]] | A4-PI |
| #c16 | Each Keeper maintains its own independent view of the orderbook (decentralized aspect). | [[entities/perpdex/drift]] | A1-PI |
| #c17 | Keepers are paid a portion of the taker fee to their Drift User Account when they fill orders. | [[parameters/drift/fee-schedule]] | A2-PI, A4-PI |
| #c18 | Keepers are incentivized to fill the oldest and largest order first. | [[concepts/operations/matching-engine]] | A4-PI |
