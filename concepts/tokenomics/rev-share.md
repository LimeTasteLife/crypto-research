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
| [[entities/perpdex/aster]] | five auto-NAV streams to ALP — Simple Mode MM P&L, perp trading fees, funding fees, liquidation captures, platform-level fee collection — plus a portion of protocol revenue routed to $ASTER buybacks and governance rewards via the Aster Foundation[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-usdaster-tokenomics] (per-stream basis-points disputed; see [[entities/perpdex/aster#dispute-alp-tax-basis-points]]) | [[parameters/aster/alp]] depositors (NAV accrual) + $ASTER buyback recipients (Foundation route) + governance-rewards beneficiaries[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-usdaster-tokenomics] | Perpetuals fee rates contested across primary docs; see [[entities/perpdex/aster#dispute-fee-rates]] for documented variants. Split percentages between ALP / Foundation buyback / governance rewards not surfaced (primary docs); funding take is 0% (peer-to-peer between longs and shorts)[^aster-docs-2026-04-28-trading-perpetuals-funding-rate] |
## Related
[[parameters/hyperliquid/hlp]] · [[concepts/lp/venue-owned-lp]] · [[concepts/risk/liquidation]]

## Sources
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]: [[sources/aster-docs-2026-04-28-trading-perpetuals-funding-rate]]
