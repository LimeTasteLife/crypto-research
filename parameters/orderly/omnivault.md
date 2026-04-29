---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: omnivault
unit: mixed
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly OmniVault

## Current (as of 2026-04-29)
- Flagship omnichain strategy vault; permissionless deposits[^orderly-docs-2026-04-29-omnivault-overview]
- Strategy Provider (SP): Kronos Research (first SP)[^orderly-docs-2026-04-29-omnivault-overview]
- SPs execute market-making strategies primarily on Orderly orderbook + act as primary liquidator for selected symbols[^orderly-docs-2026-04-29-omnivault-mechanics]
- Shares: non-tokenized, non-tradable, non-transferable; Share price = Vault NAV / Total Issued Shares[^orderly-docs-2026-04-29-omnivault-mechanics]
- Vault period: 3 hours (8 periods/day starting 0200H UTC); deposits/withdrawals batched at period boundaries[^orderly-docs-2026-04-29-omnivault-mechanics]
- Deposit chains: Arbitrum, Base, Optimism, Sei[^orderly-docs-2026-04-29-omnivault-overview]
- Omnichain: deposit from chain A, withdraw on chain B[^orderly-docs-2026-04-29-omnivault-mechanics]
- Revenue allocation: up to 40% of net protocol revenue + portion of IF liquidation fees to OmniVault; percentage periodically adjusted[^orderly-docs-2026-04-29-omnivault-mechanics]
- OmniVault does NOT replace the insurance fund[^orderly-docs-2026-04-29-omnivault-mechanics]
- APY: daily TWRR across 30-day rolling window, compounded and annualized[^orderly-docs-2026-04-29-omnivault-mechanics]
- Smart contract: 0x70fe7d65ac7c1a1732f64d2e6fc0e33622d0c991[^orderly-docs-2026-04-29-omnivault-overview]
- Two independent audits on vault contracts; reports on GitHub[^orderly-docs-2026-04-29-omnivault-overview]

## Planned
- Permissionless Vault: open vault creation to any strategist (roadmap 2026 H1)[^orderly-docs-2026-04-29-roadmap]
- Non-USDC Vault: ETH, BTC, LST deposits (roadmap 2026 H1)[^orderly-docs-2026-04-29-roadmap]

## Time series

| effective | parameter | value | source |
|-----------|-----------|-------|--------|
| 2026-04-29 | Strategy Provider | Kronos Research | [^orderly-docs-2026-04-29-omnivault-overview] |
| 2026-04-29 | Vault period | 3 hours | [^orderly-docs-2026-04-29-omnivault-mechanics] |
| 2026-04-29 | Max revenue allocation | up to 40% net protocol revenue | [^orderly-docs-2026-04-29-omnivault-mechanics] |
| 2026-04-29 | Deposit collateral | USDC only | [^orderly-docs-2026-04-29-omnivault-overview] |
| 2026-04-29 | Deposit chains | Arbitrum, Base, Optimism, Sei | [^orderly-docs-2026-04-29-omnivault-overview] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-omnivault-overview]: [[sources/orderly-docs-2026-04-29-omnivault-overview]]
[^orderly-docs-2026-04-29-omnivault-mechanics]: [[sources/orderly-docs-2026-04-29-omnivault-mechanics]]
[^orderly-docs-2026-04-29-roadmap]: [[sources/orderly-docs-2026-04-29-roadmap]]
