---
type: concept
domain: tokenomics
name: Fee distribution
last_reviewed: 2026-04-28
disputed: false
---

# Fee distribution

## Definition
Fee distribution is the venue's published policy for where trading fees flow once collected. Recipient categories typically include: protocol treasury, team, liquidity providers, native-token stakers, market makers (rebates), referrers, and asset deployers.

## Mechanism on Hyperliquid

**Community-only direction.** All trading fees are directed to the community: HLP, the Assistance Fund, and HIP-3 / spot deployers — the team takes nothing[^hl-docs-2026-04-27-trading-fees]. See [[parameters/hyperliquid/revenue-distribution]] for the time-series.

## Variants in the wild

| venue | team take | LP take | token-holder benefit | deployer take |
|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | 0%[^hl-docs-2026-04-27-trading-fees] | yes (HLP)[^hl-docs-2026-04-27-trading-fees] | indirect via burn[^hl-docs-2026-04-27-trading-fees] | up to 50% (HIP-3 / spot deployers)[^hl-docs-2026-04-27-trading-fees] |
| [[entities/perpdex/dydx]] | 5% to Treasury SubDAO[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | 5% to MegaVault[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | 75% to Buyback Program (DYDX market acquisition)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | 15% to Distribution module (validators/stakers/community pool)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] |

## Related
[[concepts/tokenomics/buyback]] · [[concepts/tokenomics/rev-share]] · [[parameters/hyperliquid/revenue-distribution]]

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]: [[sources/dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]]
