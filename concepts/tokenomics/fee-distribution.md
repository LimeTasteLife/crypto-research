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
| [[entities/perpdex/aster]] | 0% direct (Treasury 7% allocation fully locked at TGE and gated on governance approval; specific protocol-revenue → team take not surfaced in primary docs)[^aster-docs-2026-04-28-usdaster-tokenomics] (disputed; see [[entities/perpdex/aster#dispute-fee-rates]]) | yes — ALP NAV accrues a share of platform-level fee collection plus trading fees, funding fees, liquidation captures, and Simple Mode MM P&L[^aster-docs-2026-04-28-earn-aster-alp] (disputed; see [[entities/perpdex/aster#dispute-alp-tax-basis-points]]) | direct: 5% flat fee discount when $ASTER is deposited into the perp wallet; indirect: portion of protocol revenue redirected to $ASTER buybacks via the Aster Foundation and to governance rewards[^aster-docs-2026-04-28-trading-perpetuals-fees][^aster-docs-2026-04-28-usdaster-tokenomics] (disputed; see [[entities/perpdex/aster#dispute-fee-rates]]) | not surfaced (primary docs) — no documented HIP-3-style asset-deployer fee share on Aster[^aster-docs-2026-04-28-usdaster-tokenomics] |
| [[entities/perpdex/lighter]] | not surfaced | LLP earns liquidation clearance fees (up to 1%)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | trading revenue → daily LIT buybacks; 100% LIT Fee Credits → staker yield[^lighter-docs-2026-04-28-about-lighter-lit-utility][^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits] | not surfaced |

(Other perpdex venues to be added in subsequent ingest passes.)
| [[entities/perpdex/dydx]] | 5% to Treasury SubDAO[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | 5% to MegaVault[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | 75% to Buyback Program (DYDX market acquisition)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] | 15% to Distribution module (validators/stakers/community pool)[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing] |

## Related
[[concepts/tokenomics/buyback]] · [[concepts/tokenomics/rev-share]] · [[parameters/hyperliquid/revenue-distribution]]

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^aster-docs-2026-04-28-trading-perpetuals-fees]: [[sources/aster-docs-2026-04-28-trading-perpetuals-fees]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-about-lighter-lit-utility]: [[sources/lighter-docs-2026-04-28-about-lighter-lit-utility]]
[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]: [[sources/lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]]
[^dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]: [[sources/dydx-community-2026-04-28-modules-distribution-protocol-revenue-sharing]]
