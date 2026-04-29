---
type: concept
domain: lp
name: Concentrated liquidity
last_reviewed: 2026-04-29
disputed: false
---

# Concentrated liquidity

## Definition
Concentrated liquidity allows LPs to allocate capital within specific price ranges rather than across the full [0, infinity) curve, increasing capital efficiency for in-range positions. Introduced by Uniswap v3 and inherited by Uniswap v4[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]. Positions are defined by a lower and upper tick; fees accrue only when the current price is within the position's range.

## Variants in the wild

| venue | CL model | position standard | fee accounting | staking/mining | notes |
|---|---|---|---|---|---|
| [[entities/dex/uniswap-v4]] | same CL math as v3; hooks can eject entirely for custom curves[^uniswap-v4-contracts-2026-04-29-concepts-architecture] | ERC-6909 (gas-efficient multi-token, replaces v3 ERC-721)[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909] | accrued fees act as credit: increase converts to liquidity, decrease auto-withdraws; salt parameter for position disambiguation[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3] | subscribers (notification-based, no position transfer)[^uniswap-v4-contracts-2026-04-29-concepts-subscribers] | singleton design, flash accounting, native ETH support |

(Other venues to be added in subsequent ingest passes.)

## Edge cases
- In v3, positions of the same range share state; v4 adds salt-based disambiguation[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]
- v4 hooks can completely bypass CL via custom curves (return deltas + native pricing bypass)[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]
- v4 subscribers eliminate the v3 requirement to transfer ERC-721 positions for staking/mining[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]

## Disputed claims
None.

## Related
[[concepts/market-structure/amm]] · [[entities/dex/uniswap-v4]] · [[concepts/lp/vault]]

## Sources
[^uniswap-v4-contracts-2026-04-29-concepts-architecture]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-architecture]]
[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]]
[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-erc-6909]]
[^uniswap-v4-contracts-2026-04-29-concepts-subscribers]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-subscribers]]
[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]: [[sources/uniswap-v4-contracts-2026-04-29-guides-custom-accounting]]
