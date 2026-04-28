---
type: source
id: lighter-docs-2026-04-28-trading-multi-asset-margin
title: Multi-Asset Margin
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/multi-asset-margin
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-multi-asset-margin.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Multi-Asset Margin

## TL;DR
Multi-Asset Margin lets users post non-USDC assets (ETH first) as margin; the asset's value × LTV (loan-to-value haircut) is added to the account's Total Account Value (TAV). The feature is gated to Unified Trading Accounts. At launch it covers perpetual futures only (USDC spot trading with non-USDC collateral is "coming soon"). Per-asset config: LTV, LT (Liquidation Threshold, ≥ LTV), LF (Liquidation Factor, ≥ LT), Liquidation Fee, plus User and Global Supply Caps. Total Account Liquidation Threshold (TALT) uses LT (less conservative) and equals TAV when only USDC is held. Health checks: Healthy iff TAV ≥ IMR; Pre-Liquidation iff TALT ≥ MMR and TAV < IMR; Partial iff CMR ≤ TALT < MMR; Full iff TALT < CMR. Spot zero price = IndexPrice · LF; spot liquidation guarantees the user receives at least the LF-discounted value per unit of collateral.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Multi-Asset Margin enables users to use non-USDC assets as margin for trading; deposited supported assets count toward total margin discounted by a haircut. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c2 | ETH is the first non-USDC asset added to Multi-Asset Margin; additional assets will be rolled out with conservative user and global supply limits. | [[parameters/lighter/multi-asset-collateral]] | A6-PII |
| #c3 | Multi-Asset Margin is available exclusively to accounts with Unified Trading Accounts enabled. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c4 | At launch, Multi-Asset Margin supports perpetual futures only; USDC spot trading with non-USDC collateral is not included at launch and is "coming soon". | [[parameters/lighter/multi-asset-collateral]] | A6-PI, A6-PII |
| #c5 | When no non-USDC margin assets are held, Multi-Asset Margin accounts behave identically to standard cross-margin accounts and existing margin calculations are unchanged. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c6 | LTV (Loan-to-Value ratio) determines how much of a margin asset's value counts toward Total Account Value. | [[concepts/risk/margin-tier]], [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c7 | LT (Liquidation Threshold) determines how much of a margin asset's value counts toward Total Account Liquidation Threshold; LT is always ≥ LTV. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c8 | LF (Liquidation Factor) determines the minimum value the user receives per unit of collateral during liquidation; LF is always ≥ LT. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c9 | The per-asset Liquidation Fee is the maximum fee paid when spot collateral is seized during liquidation, capped so the user always receives at least the LF-discounted value. | [[parameters/lighter/multi-asset-collateral]], [[parameters/lighter/fee-schedule]] | A2-PI, A6-PI |
| #c10 | Each margin-enabled asset has a User Supply Cap (max amount one user can hold as margin, in asset units) and a Global Supply Cap (max total amount across all users). | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c11 | TAV(USDC) = PortfolioBalance(USDC) + Σ_j LTV_j · MarginBalance_j · IndexPrice_j; TAV is used for all risk checks when opening positions or placing orders. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c12 | TALT(USDC) = PortfolioBalance(USDC) + Σ_j LT_j · MarginBalance_j · IndexPrice_j; by construction TALT ≥ TAV. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c13 | Multi-Asset Margin uses a single unified health check covering both perpetual positions and spot margin assets; IMR/MMR/CMR remain unchanged from the existing contract specifications. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c14 | Healthy state: TAV ≥ IMR. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c15 | Pre-Liquidation state: TALT ≥ MMR and TAV < IMR; only operations that improve the health ratio and reduce position size are permitted. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c16 | Partial Liquidation state: TALT < MMR and TALT ≥ CMR. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c17 | Full Liquidation state: TALT < CMR. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c18 | Liquidation eligibility: when TALT falls below MMR, both perpetual positions and spot margin assets become eligible for liquidation in a unified flow. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c19 | Modified perp zero price (long) = markPrice_i · (1 − M_i · TALT / MMR); (short) = markPrice_i · (1 + M_i · TALT / MMR). | [[concepts/risk/liquidation]] | A6-PI |
| #c20 | Executing a perp trade at the modified zero price preserves the account's health ratio invariant. | [[concepts/risk/liquidation]] | A6-PI |
| #c21 | When no non-USDC margin assets are held, the modified zero price reduces to the standard zero price (TALT collapses to PortfolioBalance). | [[concepts/risk/liquidation]] | A6-PI |
| #c22 | Spot partial liquidation sends an Immediate-or-Cancel (IoC) order to the spot order book on behalf of the user. | [[concepts/risk/liquidation]] | A6-PI |
| #c23 | Spot zero price for asset j: SpotZeroPrice_j = IndexPrice_j · LF_j. | [[concepts/risk/liquidation]] | A6-PI |
| #c24 | Spot liquidation collects the configured liquidation fee but always guarantees the user receives at least LF-discounted value in USDC per unit of collateral sold. | [[parameters/lighter/multi-asset-collateral]], [[concepts/risk/liquidation]] | A6-PI |

## Conflicts raised
- (none within group)
