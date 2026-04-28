---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: multi-asset-collateral
unit: percent / USDC
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: true
---

# Lighter multi-asset collateral

## Current (as of 2026-04-28)

**Overview.** Multi-Asset Margin (MAM) enables users to use non-USDC assets as margin for trading; deposited supported assets count toward Total Account Value (TAV) discounted by an LTV haircut[^lighter-docs-2026-04-28-trading-multi-asset-margin]. ETH is the first non-USDC asset; additional assets will be rolled out with conservative user and global supply limits[^lighter-docs-2026-04-28-trading-multi-asset-margin].

**Account gating.** MAM is available exclusively to accounts with Unified Trading Accounts (UTA) enabled[^lighter-docs-2026-04-28-trading-multi-asset-margin]. At launch, MAM supports perpetual futures only; USDC spot trading with non-USDC collateral is "coming soon"[^lighter-docs-2026-04-28-trading-multi-asset-margin].

**Per-asset parameters.**
- **LTV** (Loan-to-Value ratio): determines how much of a margin asset's value counts toward TAV[^lighter-docs-2026-04-28-trading-multi-asset-margin].
- **LT** (Liquidation Threshold): determines how much counts toward TALT; always `LT ≥ LTV`[^lighter-docs-2026-04-28-trading-multi-asset-margin].
- **LF** (Liquidation Factor): determines the minimum value the user receives per unit of collateral during liquidation; always `LF ≥ LT`[^lighter-docs-2026-04-28-trading-multi-asset-margin].
- **Liquidation Fee**: maximum fee paid when spot collateral is seized during liquidation; capped so the user always receives at least the LF-discounted value[^lighter-docs-2026-04-28-trading-multi-asset-margin].
- **User Supply Cap**: max amount one user can hold as margin (in asset units)[^lighter-docs-2026-04-28-trading-multi-asset-margin].
- **Global Supply Cap**: max total amount across all users; as of 2026-04-28 the cap for ETH is shown as "ETH as collateral is coming soon" — no concrete numeric cap published[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits].

**Health formulas.**
- `TAV(USDC) = PortfolioBalance(USDC) + Σ_j LTV_j · MarginBalance_j · IndexPrice_j`[^lighter-docs-2026-04-28-trading-multi-asset-margin]
- `TALT(USDC) = PortfolioBalance(USDC) + Σ_j LT_j · MarginBalance_j · IndexPrice_j` (by construction TALT ≥ TAV)[^lighter-docs-2026-04-28-trading-multi-asset-margin]
- Healthy: `TAV ≥ IMR`[^lighter-docs-2026-04-28-trading-multi-asset-margin]
- Pre-Liquidation: `TALT ≥ MMR` and `TAV < IMR`[^lighter-docs-2026-04-28-trading-multi-asset-margin]
- Partial Liquidation: `TALT < MMR` and `TALT ≥ CMR`[^lighter-docs-2026-04-28-trading-multi-asset-margin]
- Full Liquidation: `TALT < CMR`[^lighter-docs-2026-04-28-trading-multi-asset-margin]

**Modified zero price (MAM accounts).**
- Long: `markPrice_i · (1 − M_i · TALT / MMR)`[^lighter-docs-2026-04-28-trading-multi-asset-margin]
- Short: `markPrice_i · (1 + M_i · TALT / MMR)`[^lighter-docs-2026-04-28-trading-multi-asset-margin]

**Spot liquidation.** Spot zero price for asset j = `IndexPrice_j · LF_j`; spot liquidation guarantees the user receives at least LF-discounted value in USDC per unit of collateral sold[^lighter-docs-2026-04-28-trading-multi-asset-margin]. Spot partial liquidation sends an IoC order to the spot order book on behalf of the user[^lighter-docs-2026-04-28-trading-multi-asset-margin].

**Rollout policy.** Lighter is implementing a measured approach to collateral supply with conservative limits as ETH becomes the first non-USDC collateral asset; users can choose how much of their available collateral to allocate as margin on a per-asset basis[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits].

## Time series

| effective | first asset | LTV | LT | LF | global cap | user cap | source |
|---|---|---|---|---|---|---|---|
| 2026-04-28 | ETH (coming soon per limits page) | TBD | TBD | TBD | coming soon | TBD | [^lighter-docs-2026-04-28-trading-multi-asset-margin][^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits] |

## Tiering rules / formulae
Per-asset LTV/LT/LF/Liq Fee values not yet published as numeric values in the 2026-04-28 mirror snapshot.

## Disputed values

**Claim A** · confidence: high · recency: 2026-04 · authority: high
  Multi-Asset Margin page describes ETH as "the first non-USDC asset added" implying it is live[^lighter-docs-2026-04-28-trading-multi-asset-margin].

**Claim B** · confidence: high · recency: 2026-04 · authority: high
  Collateral supply-limits page shows ETH global cap as "ETH as collateral is coming soon" — implying not yet live[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits].

→ Open question: Is ETH multi-asset margin live or still pending? Likely staleness between two docs pages at the 2026-04-28 snapshot. Suggested verification: check live app UI or re-crawl supply-limits page.

## Sources
[^lighter-docs-2026-04-28-trading-multi-asset-margin]: [[sources/lighter-docs-2026-04-28-trading-multi-asset-margin]]
[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits]: [[sources/lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits]]
