---
type: concept
domain: tokenomics
name: Emission schedule
last_reviewed: 2026-04-28
disputed: false
---

# Emission schedule

## Definition
The emission schedule is the rule by which a venue's native token is minted (or unlocked from a reserve) over time, typically governing staking rewards, programme incentives, and validator pay.

## Mechanism on Hyperliquid

**Reward formula.** Staking reward rate is **inversely proportional to sqrt(total HYPE staked)** — Ethereum-inspired[^hl-docs-2026-04-27-hypercore-staking]. At 400M total HYPE staked, the yearly reward rate is approximately 2.37%[^hl-docs-2026-04-27-hypercore-staking].

**Source.** Staking rewards come from the **future emissions reserve** (a pre-allocated unlock pool, not new mint at the moment of payment)[^hl-docs-2026-04-27-hypercore-staking].

(Full unlock schedule, total cap, and per-cohort vesting curves are not surfaced in primary docs at this snapshot.)

## Variants in the wild

| venue | reward formula | source | yield @ benchmark stake |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | sqrt(stake) inverse, ETH-style[^hl-docs-2026-04-27-hypercore-staking] | future emissions reserve[^hl-docs-2026-04-27-hypercore-staking] | ~2.37%/yr at 400M staked[^hl-docs-2026-04-27-hypercore-staking] |
| [[entities/perpdex/aster]] | 450K $ASTER per weekly Epoch (150K Base + 300K Loyalty); replaces Ecosystem & Community linear vesting active Oct 2025–Jan 2026 (4 months)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works][^aster-docs-2026-04-28-usdaster-tokenomics] | staking emissions (post-vesting regime change)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works] | not surfaced |
| [[entities/perpdex/orderly]] | 200 epochs (~7yr, 14d/epoch); 5M VALOR/epoch linear emission; Community 55% over full schedule, Investors 6mo lock + 3.5yr, Team 1yr cliff + 3yr[^orderly-docs-2026-04-29-distribution-and-emission-schedule] | Community allocation (55% of 1B supply)[^orderly-docs-2026-04-29-distribution-and-emission-schedule] | not surfaced |
## Related
[[entities/token/hype]] · [[parameters/hyperliquid/staking-rewards]] · [[concepts/tokenomics/buyback]]

## Sources
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]: [[sources/aster-docs-2026-04-28-aster-chain-staking-how-staking-works]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^orderly-docs-2026-04-29-distribution-and-emission-schedule]: [[sources/orderly-docs-2026-04-29-distribution-and-emission-schedule]]
