---
type: concept
domain: tokenomics
name: Buyback
last_reviewed: 2026-04-29
disputed: false
---

# Buyback

## Definition
A buyback is a programmatic conversion of venue revenue (typically trading fees) into the venue's native token, used to reduce circulating supply (burn) or to redistribute (treasury / staker yield). Buybacks anchor token value to platform usage. Key axes: cadence (TWAP / discretionary / automatic), gross-vs-net denominator, sink (burn / treasury / yield).

## Mechanism on Hyperliquid

**Automatic L1-execution-time buyback.** The Assistance Fund (on-chain system address `0xfefefefefefefefefefefefefefefefefefefefe`) automatically converts trading fees into [[entities/token/hype|HYPE]] on-chain as part of L1 execution[^hl-docs-2026-04-27-trading-fees].

**Permanent burn sink.** HYPE accumulated in the Assistance Fund is burned, permanently removing tokens from circulating and total supply[^hl-docs-2026-04-27-trading-fees]. There is no treasury accumulation or redistribution path.

**Cadence.** Continuous (event-driven via L1 execution), not TWAP-windowed.

## Variants in the wild

| venue | cadence | sink | denominator | onchain-verifiable? |
|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | continuous (L1 execution)[^hl-docs-2026-04-27-trading-fees] | burn (permanent supply reduction)[^hl-docs-2026-04-27-trading-fees] | gross trading fees flowing to AF | yes (system address `0xfefe…fefe`)[^hl-docs-2026-04-27-trading-fees] |
| [[entities/perpdex/aster]] | not specified[^aster-docs-2026-04-28-usdaster-tokenomics] | $ASTER buybacks + governance rewards (Aster Foundation discretionary)[^aster-docs-2026-04-28-usdaster-tokenomics] | not specified (gross-vs-net unstated)[^aster-docs-2026-04-28-usdaster-tokenomics] | not surfaced |
| [[entities/perpdex/dydx]] | not specified (cadence per Buyback Program implementation)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | market acquisition of DYDX (75% of net protocol revenue allocated Nov 13, 2025)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | net protocol revenue (post rev-share split)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | governance-approved allocation on-chain[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] |
| [[entities/perpdex/orderly]] | end of each epoch (14-day cycle)[^orderly-docs-2026-04-29-staking-information] | treasury (VALOR staking redemption for esORDER)[^orderly-docs-2026-04-29-staking-information] | 30% of net protocol fees daily[^orderly-docs-2026-04-29-staking-information] | not surfaced (buyback execution mechanism not detailed) |
| [[entities/dex/uniswap-v4]] | permissionless (anyone calls Firepit.release() when TokenJar value > UNI threshold)[^uniswap-v4-protocol-fee-2026-04-29-overview] | burn (UNI sent to 0xdead)[^uniswap-v4-protocol-fee-2026-04-29-guides-getting-started] | protocol fees from v2+v3 pools (v4 adapter TBD)[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] | yes (TokenJar + Firepit on Ethereum mainnet)[^uniswap-v4-protocol-fee-2026-04-29-deployments] |

(Other venues to be added in subsequent ingest passes.)

## Disputed claims
None.

## Related
[[entities/token/hype]] · [[entities/dex/uniswap-v4]] · [[concepts/tokenomics/fee-distribution]] · [[parameters/hyperliquid/revenue-distribution]] · [[parameters/uniswap-v4/protocol-fee-config]]

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]: [[sources/dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]]
[^orderly-docs-2026-04-29-staking-information]: [[sources/orderly-docs-2026-04-29-staking-information]]
[^uniswap-v4-protocol-fee-2026-04-29-overview]: [[sources/uniswap-v4-protocol-fee-2026-04-29-overview]]
[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]: [[sources/uniswap-v4-protocol-fee-2026-04-29-concepts-fees]]
[^uniswap-v4-protocol-fee-2026-04-29-deployments]: [[sources/uniswap-v4-protocol-fee-2026-04-29-deployments]]
[^uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]: [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]]
