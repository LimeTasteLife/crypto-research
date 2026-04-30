---
type: source
id: dydx-docs-2026-04-28-concepts-trading-governance
title: Governance Functionalities
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/governance
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-governance.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Governance Functionalities

## TL;DR
Comprehensive enumeration of every protocol parameter that x/gov can update directly. Trading: Stats Module (look-back window, currently 30d), FeeTiers Module. Trading core: Insurance Fund (governance can send funds out of IF; anyone can send funds in), Liquidations Config (max IF quantums for deleveraging, max liquidation fee in ppm with 100% to IF, position/subaccount per-block liquidation caps, fillable price config), Funding Rate (clamp factors, epoch info, Liquidity Tier impact notional). Trading rewards: Vest Module, Rewards Module (incl. constant C). Markets: Oracles, Liquidity Tiers (with full table — 8 tiers from Large-Cap to IML 5x). Updating live markets via Msg* methods. Adding new markets requires 4 ordered messages. Safety: spam mitigation via equity-tier order limits and rate limits. Bridge: bridge module enable/disable. Community Assets: Community Pool (from Community Tax) and Community Treasury (governance-controlled).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Stats Module tracks user maker and taker volumes over a 30-day look-back window. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c2 | Governance can update the Stats Module look-back window (measured in seconds). | [[parameters/dydx-v4/fee-schedule]] | A7-PI |
| #c3 | Governance has the ability to update fee tiers via the FeeTiers Module. | [[parameters/dydx-v4/fee-schedule]] | A7-PI |
| #c4 | Governance can send funds from the Protocol's Insurance Fund to individual accounts or other modules. | [[parameters/dydx-v4/insurance-fund]] | A7-PI |
| #c5 | Any account has the ability to send assets to the Insurance Fund. | [[parameters/dydx-v4/insurance-fund]] | A6-PI |
| #c6 | Governance can adjust the maximum liquidation fee, in parts-per-million; 100% of this fee goes to the Insurance Fund. | [[parameters/dydx-v4/liquidation-params]] | A6-PI, A2-PI |
| #c7 | Governance can adjust the max insurance-fund quantums for deleveraging (the maximum quote quantums, exclusive, that the IF can have for deleveraging to be enabled). | [[parameters/dydx-v4/liquidation-params]] | A6-PI |
| #c8 | Governance can adjust the maximum amount a single position or single subaccount can be liquidated within one block. | [[parameters/dydx-v4/liquidation-params]] | A6-PI |
| #c9 | Governance can adjust the fillable price config (how the fillable-price spread from the oracle increases based on the adjusted bankruptcy rating of the subaccount). | [[parameters/dydx-v4/liquidation-params]] | A6-PI |
| #c10 | Governance can adjust funding rate clamp factor, premium vote clamp factor, min number of votes per premium sample, epoch information, and Liquidity Tier impact notional. | [[parameters/dydx-v4/funding-config]] | A7-PI |
| #c11 | The Vest Module determines the rate of tokens vested from Vester Accounts to other accounts (Community Treasury, Rewards Treasury); governance can create/update/delete VestEntries. | [[parameters/dydx-v4/tokenomics]] | A7-PI |
| #c12 | The Rewards Module distributes trading rewards; governance can adjust the funding account, the funding token, the oracle market for the funding token, and protocol constant `C`. | [[parameters/dydx-v4/trading-rewards-config]] | A7-PI |
| #c13 | Governance can adjust the list of oracles used per market (does not include adding/removing exchange-source supported by the protocol — that requires a binary upgrade). | [[parameters/dydx-v4/oracle-config]] | A7-PI |
| #c14 | Liquidity Tier 0 (Large-Cap) — IMF 0.02, maintenance fraction 0.6 (MMF 0.012), impact notional 25,000 USDC, no caps. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c15 | Liquidity Tier 1 (Small-Cap) — IMF 0.1, MMF 0.05, lower cap 20M USDC, upper cap 50M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c16 | Liquidity Tier 2 (Long-Tail) — IMF 0.2, MMF 0.1, lower cap 5M USDC, upper cap 10M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c17 | Liquidity Tier 3 (Safety) — IMF 1.0, MMF 0.2, lower cap 2M USDC, upper cap 5M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c18 | Liquidity Tier 4 (Isolated) — IMF 0.05, MMF 0.03, lower cap 0.5M USDC, upper cap 1M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c19 | Liquidity Tier 5 (Mid-Cap) — IMF 0.05, MMF 0.03, lower cap 40M USDC, upper cap 100M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c20 | Liquidity Tier 6 (FX) — IMF 0.01, MMF 0.0005, lower cap 0.5M USDC, upper cap 1M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c21 | Liquidity Tier 7 (IML 5x) — IMF 0.2, MMF 0.1, lower cap 0.5M USDC, upper cap 1M USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c22 | The Open-Interest-scaled IMF formula: Open Notional = Open Interest × Oracle Price; Scaling Factor = (Open Notional − Lower Cap) / (Upper Cap − Lower Cap); IMF Increase = Scaling Factor × (1 − Base IMF). | [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c23 | At Open Notional ≥ Upper Cap, the effective IMF is 1.0 (1:1 collateral required). | [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c24 | Adding a new market requires 4 messages in order: MsgCreateOracle, MsgCreatePerpetual, MsgCreatePerpetualClobPair, MsgDelayMessage (to schedule MsgSetClobPairStatus to enable trading). | [[parameters/dydx-v4/listing-policy]] | A1-PI, A7-PV |
| #c25 | Governance can adjust how many open orders a subaccount can have based on its equity tier and order placement rate limits. | [[parameters/dydx-v4/rate-limits]] | A7-PI |
| #c26 | The Bridge Module receives bridged tokens from Ethereum; governance can update Event Parameters, Proposal Parameters, and Safety Parameters (including bridging enable/disable). | [[entities/perpdex/dydx]] | A8-PI, A7-PI |
| #c27 | The Community Pool receives any Community Tax via the Distribution Module and is governance-controlled. | [[parameters/dydx-v4/tokenomics]] | A7-PI |
| #c28 | The Community Treasury is a governance-controlled account funded by any account/module sending tokens to it. | [[parameters/dydx-v4/tokenomics]] | A7-PI |
