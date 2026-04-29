---
type: parameter
entity: [[dydx-v4]]
parameter: megavault
unit: mixed
last_change: 2024-11-21
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 megavault

## Current (as of 2026-04-28)
- Protocol-as-MM construct: USDC depositors fund automated AMM strategies across per-market sub-vaults[^dydx-docs-2026-04-28-concepts-trading-megavault][^dydx-community-2026-04-28-dydx-features-megavault]
- Deposits represent fractional ownership of vault's net equity (USDC + active positions)[^dydx-docs-2026-04-28-concepts-trading-megavault]
- Yield sources: PnL on vault positions, funding payments, 50% trading-fee revenue share (community-approved Nov 15, 2024; governance-adjustable)[^dydx-community-2026-04-28-dydx-features-megavault]
- Operator: [[entities/actor/greave]] (elected Nov 21, 2024); authority to tune sub-vault parameters and reallocate capital[^dydx-community-2026-04-28-dydx-features-megavault]
- APR formula: `(30d PnL / current TVL) * (365/30)` -- APR will likely decrease as TVL grows[^dydx-community-2026-04-28-dydx-features-megavault]
- Uses cross-margined funds, no general lock-up except IML (~30d lock at 1s avg block time)[^dydx-community-2026-04-28-dydx-features-megavault]
- Worst-case withdrawal slippage: 100% (full loss) at 8x leverage[^dydx-community-2026-04-28-dydx-features-megavault]
- US/Canada/prohibited-jurisdiction users excluded[^dydx-community-2026-04-28-dydx-features-megavault]

## Time series

| effective | event | fee_share | operator | source |
|---|---|---|---|---|
| 2024-11-15 | Community-approved 50% fee share | 50% | — | [^dydx-community-2026-04-28-dydx-features-megavault] |
| 2024-11-21 | Greave elected MegaVault operator | 50% | Greave | [^dydx-community-2026-04-28-dydx-features-megavault] |

## Tiering rules / formulae
- Per-market sub-vault topology; operator can reallocate between sub-vaults[^dydx-community-2026-04-28-dydx-features-megavault]
- IML 10k USDC deposit creates a new sub-vault with ~30d lock[^dydx-community-2026-04-28-dydx-features-instant-market-listings]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-megavault]: [[sources/dydx-docs-2026-04-28-concepts-trading-megavault]]
[^dydx-community-2026-04-28-dydx-features-megavault]: [[sources/dydx-community-2026-04-28-dydx-features-megavault]]
[^dydx-community-2026-04-28-dydx-features-instant-market-listings]: [[sources/dydx-community-2026-04-28-dydx-features-instant-market-listings]]
