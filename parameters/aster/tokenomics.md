---
type: parameter
entity: [[aster]]
parameter: tokenomics
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster tokenomics

## Current (as of 2026-04-28)

**Total supply.** $ASTER total supply is **8,000,000,000** (8 billion); the 53.5% Airdrop allocation implies the headline figure (53.5% = 4.28B)[^aster-docs-2026-04-28-usdaster-tokenomics].

**Allocation table.**

| Bucket | Allocation | Tokens |
|---|---|---|
| Airdrop | 53.5% | 4,280,000,000 |
| Ecosystem & Community | 30% | 2,400,000,000 |
| Treasury | 7% | 560,000,000 |
| Team | 5% | 400,000,000 |
| Liquidity & Listings | 4.5% | 360,000,000 |

[^aster-docs-2026-04-28-usdaster-tokenomics]

**TGE unlock.** **8.8% (704,000,000 $ASTER)** unlocked immediately at TGE for Aster Spectra and Aster Gems participants[^aster-docs-2026-04-28-usdaster-tokenomics]. Aster Spectra and Aster Gems are named reward programs whose participants received the immediate-TGE allocation[^aster-docs-2026-04-28-usdaster-tokenomics].

**Airdrop release.** Remaining airdrop tokens release gradually over **~80 months (~7 years)** post-TGE; release schedule is subject to future adjustments by protocol governance[^aster-docs-2026-04-28-usdaster-tokenomics]. Unclaimed tokens redirect back to the Airdrop & Community Rewards allocation for future distribution[^aster-docs-2026-04-28-usdaster-tokenomics].

**Team vesting.** Team allocation has a **12-month cliff** from TGE, then **40 months of linear vesting** at **10,000,000 $ASTER per month**[^aster-docs-2026-04-28-usdaster-tokenomics].

**Liquidity & Listings.** Fully unlocked at TGE[^aster-docs-2026-04-28-usdaster-tokenomics].

**Treasury (7%).** Fully locked at TGE; does not enter circulating supply and only unlocks via governance-approved mechanisms[^aster-docs-2026-04-28-usdaster-tokenomics].

**Ecosystem & Community regime change.** The Ecosystem & Community allocation was originally vested over 20 months on a linear distribution model[^aster-docs-2026-04-28-usdaster-tokenomics]. Linear vesting was active for only **4 months (October 2025 – January 2026)** before being replaced by a **staking emission model** — staking rewards are now the sole active use of that bucket[^aster-docs-2026-04-28-usdaster-tokenomics]. See [[parameters/aster/staking-rewards]].

**APX swap.** Eligible $APX holders/stakers can exchange APX for $ASTER during a designated swap period at a **conversion rate that decreases over time**; unclaimed tokens redirect back to the Airdrop pool[^aster-docs-2026-04-28-usdaster-tokenomics].

**Buyback / governance flow.** Protocol revenue partially redirects to $ASTER buybacks via the Aster Foundation, plus governance rewards distribution — see [[parameters/aster/revenue-distribution]][^aster-docs-2026-04-28-usdaster-tokenomics].

## Time series

| effective | regime | Ecosystem & Community distribution | source |
|---|---|---|---|
| 2025-10 (TGE) | linear vesting (planned 20 months) | linear release begins | [^aster-docs-2026-04-28-usdaster-tokenomics] |
| 2026-01 | regime change | linear replaced by staking-emission model after 4 months | [^aster-docs-2026-04-28-usdaster-tokenomics] |
| 2026-04-28 | staking-emission only | staking rewards = sole active use | [^aster-docs-2026-04-28-usdaster-tokenomics][^aster-docs-2026-04-28-aster-chain-staking-how-staking-works] |

## Tiering rules / formulae

- TGE unlock = `total_supply × 0.088` = 704M.
- Team monthly unlock = `10,000,000` for 40 months following 12-month cliff.
- Airdrop release ≈ `(remaining_after_TGE) / 80 months` (subject to governance adjustment).

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]: [[sources/aster-docs-2026-04-28-aster-chain-staking-how-staking-works]]
