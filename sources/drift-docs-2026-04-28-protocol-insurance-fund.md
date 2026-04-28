---
type: source
id: drift-docs-2026-04-28-protocol-insurance-fund
title: What is the Insurance Fund?
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/insurance-fund
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-insurance-fund.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# What is the Insurance Fund?

## TL;DR
Drift's Insurance Fund is the first solvency backstop. It is multi-asset (USDC, BTC, ETH, SOL) — with each pool only covering same-denomination liabilities. The USDC pool collects exchange fees from spot+perp trading and supports liquidations from perp trading; SOL/BTC/ETH pools backstop borrow-lend losses for those assets. Funded jointly by stakers and protocol via premiums collected from liquidation, trading, and borrow fees. Excess losses (beyond allotted limits) trigger socialized loss pro-rata: by base amount for perp traders, by token amount for lenders. Markets deemed highly volatile receive Isolated Insurance Funds — separate from the standard fund and funded ONLY by premiums collected for that specific market.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift's Insurance Fund is the first backstop to maintain protocol solvency in the event of bankruptcies. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c2 | There are separate Insurance Funds for each asset depositable on the platform: USDC, BTC, ETH, and SOL. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c3 | The USDC pool collects exchange fees from spot+perp trading and supports liquidations from perpetual trading. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c4 | SOL, BTC, ETH pools backstop respective asset-denominated liquidations from borrow-lend. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c5 | Anyone can stake the corresponding asset into the Insurance Fund to collateralize it in return for a portion of liquidation and trading fees. | [[parameters/drift/insurance-fund]] | A5-PI |
| #c6 | When account balance falls below zero (more unrealised loss than collateral), the exchange is left with bad debt that the Insurance Fund resolves. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c7 | The Insurance Fund pays out bankruptcy losses in full for spot market balances and up to the perp market's set max insurance limit for perpetual markets. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c8 | USDC balances in the Insurance Fund only cover USDC-denominated liabilities. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c9 | The Insurance Fund is funded by stakers and protocol — funds increase via premiums collected from liquidation, trading, and borrow fees. | [[parameters/drift/insurance-fund]] | A2-PI, A5-PI |
| #c10 | All excess losses beyond the Insurance Fund's allotted limits will be covered by the socialized loss mechanism. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c11 | Socialized loss for Perpetual Traders: paid pro-rata by base amount across all open positions. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c12 | Socialized loss for Lenders: paid pro-rata by token amount across all lenders. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c13 | Isolated Insurance Funds are assigned to markets deemed highly volatile, isolated from the standard Insurance Fund. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c14 | An Isolated Insurance Fund is funded exclusively via a portion of premiums collected for that specific market. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c15 | Users in a market with an Isolated Insurance Fund will not have access to the standard Insurance Fund for losses beyond the limited fund. | [[parameters/drift/insurance-fund]] | A6-PI |
