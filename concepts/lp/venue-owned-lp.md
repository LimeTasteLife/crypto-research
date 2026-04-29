---
type: concept
domain: lp
name: Venue-owned LP
last_reviewed: 2026-04-28
disputed: false
---

# Venue-owned LP

## Definition
A venue-owned LP is a liquidity vault deployed and operated by the venue itself (rather than a third-party MM firm), in which depositor capital is pooled to provide quotes and to backstop liquidations. The vault's PnL flows to depositors, with the venue as strategy operator. Distinct from "mm-firm-as-LP" (external counterparty) and from "AMM LP" (passive curve provision).

## Mechanism on Hyperliquid

**HLP as the canonical case.** [[parameters/hyperliquid/hlp]] is Hyperliquid's protocol-owned vault. The Liquidator Vault — a component strategy of HLP — takes over backstop liquidations[^hl-docs-2026-04-27-trading-liquidations]. PnL flows entirely to the community (HLP depositors) rather than to the exchange operator or privileged market makers[^hl-docs-2026-04-27-trading-liquidations].

## Variants in the wild

| venue | vault | sub-strategies | beneficiaries |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | HLP[^hl-docs-2026-04-27-trading-liquidations] | market-making + liquidator vault[^hl-docs-2026-04-27-trading-liquidations] | community depositors[^hl-docs-2026-04-27-trading-liquidations] |
| [[entities/perpdex/aster]] | ALP (BNB Chain + Arbitrum)[^aster-docs-2026-04-28-earn-aster-alp] | market-making PnL (Simple Mode), trading fees, funding fees, liquidation captures, platform fees; mint/burn dynamic toward target[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-earn-aster-alp-fees] | ALP depositors[^aster-docs-2026-04-28-earn-aster-alp] |
## Edge cases
- Venue-owned LPs raise a protocol-MM conflict of interest: the same operator setting risk parameters runs the largest MM. Mitigations include public PnL stream and open deposit access (anyone can be the "house").

## Related
[[parameters/hyperliquid/hlp]] · [[concepts/tokenomics/rev-share]] · [[concepts/risk/liquidation]]

## Sources
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^aster-docs-2026-04-28-earn-aster-alp-fees]: [[sources/aster-docs-2026-04-28-earn-aster-alp-fees]]
