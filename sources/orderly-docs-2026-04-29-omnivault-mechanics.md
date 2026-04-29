---
type: source
id: orderly-docs-2026-04-29-omnivault-mechanics
title: OmniVault Mechanics
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/orderly-omniVault/mechanics
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/omnivault-mechanics.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# OmniVault Mechanics

## TL;DR
OmniVault deploys strategies with vault assets. PnL is proportionally split across LPs by share ownership. Shares are non-tokenized, non-tradable, non-transferable. Each vault period is 3 hours (8 periods/day starting 0200H UTC). Deposits and withdrawals batched at period boundaries. Omnichain capability: deposit from chain A, withdraw on chain B. SPs (1) execute market-making on Orderly orderbook and (2) act as primary liquidator for selected symbols. Orderly allocates up to 40% of net protocol revenue and a portion of IF liquidation fees to OmniVault.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | OmniVault lifecycle: deposit USDC → SPs execute strategies → withdrawal request → claim redeemed USDC | [[parameters/orderly/omnivault]] | A4-PI |
| #c2 | Shares are non-tokenized, non-tradable, non-transferable; Share price = Vault NAV / Total Issued Shares | [[parameters/orderly/omnivault]] | A4-PI |
| #c3 | Each vault period lasts 3 hours (8 periods/day); start times 0200H-2300H UTC; deposits and withdrawals batched at common settlement share price | [[parameters/orderly/omnivault]] | A4-PI |
| #c4 | Omnichain: LP can deposit from any supported network (Arbitrum, Base, Optimism) and withdraw on a different chain | [[parameters/orderly/omnivault]] | A4-PI |
| #c5 | Strategy Providers execute market-making strategies primarily on Orderly orderbook | [[parameters/orderly/omnivault]] | A4-PI |
| #c6 | SPs also act as primary liquidator for selected symbols, taking on liquidated positions | [[parameters/orderly/omnivault]] | A4-PI, A6-PI |
| #c7 | OmniVault does NOT replace the Orderly insurance fund; not all liquidated positions handled by OmniVault | [[parameters/orderly/omnivault]] | A6-PI |
| #c8 | Orderly allocates up to 40% of net protocol revenue and a portion of IF liquidation fees to OmniVault; percentage periodically adjusted based on market conditions and TVL | [[parameters/orderly/omnivault]] | A4-PI, A2-PIV |
| #c9 | All returns compounded and distributed to LPs proportionally | [[parameters/orderly/omnivault]] | A4-PI |
| #c10 | APY calculated using daily time-weighted rate of return (TWRR) across 30-day rolling window, compounded and annualized | [[parameters/orderly/omnivault]] | A4-PI |

## Conflicts raised
None.
