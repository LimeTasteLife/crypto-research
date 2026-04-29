---
type: concept
domain: tokenomics
name: Buyback
last_reviewed: 2026-04-28
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

## Disputed claims
None.

## Related
[[entities/token/hype]] · [[concepts/tokenomics/fee-distribution]] · [[parameters/hyperliquid/revenue-distribution]]

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]: [[sources/dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]]
