---
type: concept
domain: tokenomics
name: Rev share
last_reviewed: 2026-04-28
disputed: false
---

# Rev share

## Definition
Rev share is a recurring, formula-defined transfer of venue revenue (typically a percentage of trading fees or PnL streams) to a defined beneficiary class — protocol vault, deployer, tier of stakers, etc. Distinct from one-time buyback: rev share keeps revenue legible per recipient, while buyback collapses revenue into supply effects.

## Mechanism on Hyperliquid

**Liquidator-vault PnL → community via HLP.** All backstop-liquidation PnL flows entirely to the community via [[parameters/hyperliquid/hlp|HLP]] — explicitly contrasted with CEX exchange-operator or privileged-MM internalization[^hl-docs-2026-04-27-trading-liquidations]. HLP holders are the rev-share beneficiaries of liquidation flow.

## Variants in the wild

| venue | source | recipient | denominator |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | backstop-liquidation PnL[^hl-docs-2026-04-27-trading-liquidations] | HLP depositors (community)[^hl-docs-2026-04-27-trading-liquidations] | net of MM buffer (maintenance margin retained)[^hl-docs-2026-04-27-trading-liquidations] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Related
[[parameters/hyperliquid/hlp]] · [[concepts/lp/venue-owned-lp]] · [[concepts/risk/liquidation]]

## Sources
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
