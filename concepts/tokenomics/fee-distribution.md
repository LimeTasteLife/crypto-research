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

(Other perpdex venues to be added in subsequent ingest passes.)

## Related
[[concepts/tokenomics/buyback]] · [[concepts/tokenomics/rev-share]] · [[parameters/hyperliquid/revenue-distribution]]

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
