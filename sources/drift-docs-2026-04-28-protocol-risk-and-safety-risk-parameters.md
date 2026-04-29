---
type: source
id: drift-docs-2026-04-28-protocol-risk-and-safety-risk-parameters
title: Risk Parameters
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/risk-and-safety/risk-parameters
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-risk-and-safety-risk-parameters.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Risk Parameters

## TL;DR
Price-band guard: Drift v3 blocks orders if the oracle-mark divergence breaches a 10% band relative to the oracle's 5-minute TWAP. Collateral weight scales down for large concentrated positions: `Size Weightage = 1.1 / (weight * sqrt(size) * imf_factor)`. Liabilities can have premiums applied: `max(0.8 * wgt + sqrt(size) * imf_factor, wgt)`. The Clearinghouse pauses risk-increasing trades that further enlarge oracle-mark divergence. Order limits: max 32 outstanding orders per sub-account; market orders default to 30s active time limit and 2% max price-impact (`max_slippage_ratio`); within a single tx, AMM fills are bounded by `max_base_asset_amount` per market. Maker post-only orders are auto-cancelled when oracle is 2.5% above their ask or 2.5% below their bid (out-of-favor divergence). Taker orders that would push free collateral negative are also cancelled; cancellers earn a small filler reward. Unbounded unrealized P&L from AMM exits is acknowledged — gains require offsetting loss to settle/withdraw, otherwise the market may be eligible for the Delisting Process.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift v3 prevents users from sending orders if the oracle-mark price breaches a 10% band of the oracle's 5-minute TWAP. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c2 | Oracle-mark divergence formula: `(mark − oracle) * max_spread`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c3 | Oracle-TWAP-mark band: within 10% of `mark − oracle_twap_5min`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c4 | Concentration risk control: when assets exceed a certain size, asset weights are discounted via `Size Weightage = 1.1 / (weight * sqrt(size) * imf_factor)`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c5 | Liability premium formula for large positions: `max(0.8 * wgt + sqrt(size) * imf_factor, wgt)`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c6 | The Clearinghouse pauses risk-increasing trades that further enlarge oracle-mark divergence. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c7 | Closing or reducing a position that further breaches oracle-mark divergence is also disallowed unless divergence has already been breached. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c8 | An individual user sub-account can have up to 32 outstanding orders at any time. | [[parameters/drift/risk-parameters]] | - |
| #c9 | Market orders have a Clearinghouse-set active time limit of 30 seconds. | [[parameters/drift/risk-parameters]] | - |
| #c10 | Market orders cap price impact at 2% via the market's `max_slippage_ratio`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c11 | Within a single transaction, orders against the AMM are bounded by `max_base_asset_amount` (per market); larger orders require multiple instruction calls. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c12 | Maker post-only ask is cancelled if the oracle's price is 2.5% above the maker's ask limit price. | [[parameters/drift/risk-parameters]] | A4-PIII, A6-PI |
| #c13 | Maker post-only bid is cancelled if the oracle's price is 2.5% below the maker's bid limit price. | [[parameters/drift/risk-parameters]] | A4-PIII, A6-PI |
| #c14 | Taker orders are cancelled if the fill would reduce free collateral below 0. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c15 | Fillers receive a small reward for cancelling orders if they did not receive payment otherwise. | [[parameters/drift/fee-schedule]] | A4-PV |
| #c16 | Users can technically achieve unbounded unrealised P&L by entering and exiting against the AMM (asynchronous trading allows this). | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c17 | Unbounded unrealised gains cannot be settled and withdrawn until offsetting loss exists in the system. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c18 | A market with majority extreme positive unrealised P&L that cannot be settled may be eligible for settlement through the Delisting Process. | [[concepts/listing/delisting-policy]] | A6-PII |
