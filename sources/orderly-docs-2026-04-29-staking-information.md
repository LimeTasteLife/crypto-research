---
type: source
id: orderly-docs-2026-04-29-staking-information
title: Staking Information
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/tokenomics/order-staking/staking-information
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/staking-information.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Staking Information

## TL;DR
$ORDER staking earns VALOR (non-transferable, deflationary measure of staking position) representing share of protocol treasury. VALOR hard cap: 1B, 100% linearly emitted over 200 epochs (5M per epoch). Treasury pool receives 30% of Orderly's net fees daily, settled via ORDER buyback at end of each epoch. New system effective 4 November 2025. VALOR redeemable for esORDER (7-day wait, auto-staked). 7-day unstaking period with no VALOR accrual. Omnichain staking. Staking not allowed for locked team/investor tokens.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | VALOR: non-transferable, non-tradable measure of staking position; permanently burned when redeemed for treasury assets | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c2 | VALOR hard cap: 1 billion; 100% linearly emitted to stakers over 200 epochs (5M VALOR per epoch) | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c3 | Treasury pool receives 30% of Orderly's net fees daily, settled via ORDER buyback at end of each epoch | [[concepts/tokenomics/buyback]] | A2-PI |
| #c4 | New VALOR/staking system effective 4 November 2025 | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c5 | ~4.13 VALOR distributed every second, proportional to staked share | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c6 | VALOR redeemable for esORDER; esORDER claimed after 7-day waiting period, auto-staked | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c7 | 7-day unstaking period; no VALOR accrual during unstaking; one active unstaking request at a time; new request merges and resets timer | [[parameters/orderly/tokenomics]] | A2-PII |
| #c8 | Cancel unstaking restakes the full amount | [[parameters/orderly/tokenomics]] | A2-PII |
| #c9 | Omnichain: stake on one chain, claim on another | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c10 | APR calculation: trailing 7-day average daily returns, annualized; daily returns = 30% of protocol daily net revenue / USD equivalent of total staked $ORDER and esORDER | [[parameters/orderly/tokenomics]] | A2-PI |
| #c11 | Staking not allowed for locked team or investor tokens | [[parameters/orderly/tokenomics]] | A2-PIV |
| #c12 | TreasuryShare = (AvailableValorBalance / ValorCirculatingSupply) * TotalProtocolTreasuryValue | [[parameters/orderly/tokenomics]] | A2-PIV |

## Conflicts raised
None.
