---
type: concept
domain: lp
name: Venue-owned LP
last_reviewed: 2026-04-30
disputed: false
---

# Venue-owned LP

## Definition

A **venue-owned LP** is a liquidity vault **deployed and operated by the venue itself** (rather than by a third-party MM firm under bilateral agreement, and distinct from a passive AMM curve), into which depositor capital is pooled to provide quotes and/or backstop liquidations. PnL flows pro-rata to depositors with the venue acting as strategy operator[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp]. The defining trait is **ownership and operational control**: the venue (or a venue-elected operator) authors the strategy, holds the keys, and bears reputational accountability for the vault's behaviour — even though depositors bear the financial risk.

## Lens

This page covers **vault-as-ownership**: who deployed the vault, who operates it, and how venue-capture differs from external-firm-capture of the same capital structure. It answers *"who owns it?"* — not the structural mechanism and not the counterparty role.

The same vault construct is covered by two sibling pages under different lenses:

- **Aggregation lens** — what a vault *is* as a capital-pooling mechanism (multi-role taxonomy, lockup, strategy isolation, loss-socialization): see [[concepts/lp/vault]].
- **Counterparty-role lens** — what role the vault plays in the matching engine (counterparty for trades, IF backstop, both): see [[concepts/lp/protocol-owned-liquidity]].

A single vault appears on all three pages under different lenses — this is by design, not duplication.

## Mechanism

The ownership distinction shows up at three points:

1. **Deployment authority.** A venue-owned LP is deployed by the venue itself or by an operator whom the venue elected (sometimes via governance). Contrast: an mm-firm-as-LP is deployed by the firm under a bilateral agreement governed by [[concepts/mm-agreement/quote-obligation]] (uptime SLA, depth, spread, exclusivity).
2. **Operational control.** The venue authors the strategy parameters and can pause/reallocate at will (subject to governance). MM firms run their own infrastructure and books; the venue can only ratchet incentives, not direct quotes.
3. **PnL flow.** Venue-owned LP PnL flows entirely to depositors (with optional fee-skim into the vault NAV — see [[concepts/lp/protocol-owned-liquidity]] §"Funding sources"). MM-firm-as-LP PnL accrues to the firm (net of rebates the venue pays out).

For the structural mechanics of how a vault aggregates capital, allocates collateral, and socializes loss, see [[concepts/lp/vault]] §"Mechanism" and §"Edge cases" — those concerns are lens-agnostic.

## Variants in the wild

The ownership-lens table focuses on **operator identity, deployment authority, and venue capture**. For counterparty-role columns (MM vs IF vs hybrid) see [[concepts/lp/protocol-owned-liquidity]] §"Variants in the wild". For aggregation-lens columns (lockup, strategy isolation, loss-socialization) see [[concepts/lp/vault]] §"Variants in the wild".

| venue | vault | deployment authority | operator | sole vs multi-operator | venue capture |
|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | [[parameters/hyperliquid/hlp]] | venue-deployed | Hyperliquid (protocol-direct)[^hl-docs-2026-04-27-trading-liquidations] | sole-operator (single account, two component strategies)[^hl-docs-2026-04-27-trading-liquidations] | none — PnL flows entirely to community depositors[^hl-docs-2026-04-27-trading-liquidations] |
| [[entities/perpdex/aster]] | [[parameters/aster/alp]] | venue-deployed (BNB Chain + Arbitrum)[^aster-docs-2026-04-28-earn-aster-alp] | Aster (protocol-direct, Simple Mode)[^aster-docs-2026-04-28-earn-aster-alp] | sole-operator | NAV captures five fee streams (MM PnL, trading fees, funding fees, liquidation captures, platform fees) — depositors receive net NAV growth[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-earn-aster-alp-fees] |
| [[entities/perpdex/orderly]] | [[parameters/orderly/omnivault]] | venue-deployed | external-firm-as-operator: Kronos Research as Strategy Provider[^orderly-docs-2026-04-29-omnivault-mechanics] | sole-SP today; Permissionless Vault (any strategist) on roadmap 2026 H1[^orderly-docs-2026-04-29-omnivault-overview][^orderly-docs-2026-04-29-roadmap] | up to 40% net protocol revenue + portion of IF liquidation fees allocated to vault NAV[^orderly-docs-2026-04-29-omnivault-mechanics] |
| [[entities/perpdex/lighter]] | Public Pools | venue-platform / external-operator | whitelisted external operators (one pool per operator strategy)[^lighter-docs-2026-04-28-trading-public-pools] | multi-operator marketplace — many independent pools, each operator-controlled | Operator Fee = % of profits realized at participant withdrawal; Minimum Operator Share keeps operator skin-in-the-game[^lighter-docs-2026-04-28-trading-public-pools] |
| [[entities/perpdex/dydx]] | [[parameters/dydx-v4/megavault]] | venue-deployed (governance-approved) | Greave (governance-elected operator, tunes per-market sub-vault parameters)[^dydx-community-2026-04-28-dydx-features-megavault] | sole-operator across per-market sub-vault topology[^dydx-community-2026-04-28-dydx-features-megavault] | 50% trading-fee share routed to vault by governance (2024-11-15)[^dydx-community-2026-04-28-dydx-features-megavault] |

## Edge cases

- **Conflict-of-interest at the protocol-MM layer.** A venue-owned LP raises a structural conflict: the same operator that sets risk parameters (margin tiers, liquidation cascades, oracle bands) also runs the largest MM. Mitigations observed in the wild: public PnL stream (HLP, ALP)[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp]; open deposit access so any external party can be "the house" pari-passu (HLP, ALP, MegaVault)[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp][^dydx-community-2026-04-28-dydx-features-megavault]; governance approval of fee-share to vault (MegaVault 50% trading-fee allocation)[^dydx-community-2026-04-28-dydx-features-megavault].
- **External-operator-on-venue-vault.** OmniVault is venue-deployed but operator is Kronos Research (an external firm) under a Strategy Provider arrangement[^orderly-docs-2026-04-29-omnivault-mechanics]. This is a hybrid ownership pattern: the venue retains deployment authority and the share-token issuance, but operational discretion is delegated. The roadmap toward Permissionless Vaults pushes this further toward "any strategist can launch on the venue"[^orderly-docs-2026-04-29-roadmap].
- **Multi-operator marketplaces (Public Pools).** Lighter's Public Pools invert the default: the venue provides the *platform* (deposit accounting, withdrawal mechanics, operator whitelisting) but each pool is operator-deployed[^lighter-docs-2026-04-28-trading-public-pools]. Strategy-isolation at the operator boundary; depositors choose which operator's pool to fund. This bridges venue-owned-LP and mm-firm-as-LP structurally — closer to a vault marketplace than a single house pool.
- **Governance-elected vs protocol-direct.** Hyperliquid HLP and Aster ALP are protocol-direct (the venue runs the strategy). dYdX MegaVault is governance-elected (Greave operator + 50% fee-share approved by governance vote 2024-11-15)[^dydx-community-2026-04-28-dydx-features-megavault]. Both are venue-owned, but the legitimacy chain differs — protocol-direct is fast but concentrates risk-parameter conflict; governance-elected is slower but ratifies operator choice and fee allocation through token-holder vote.

## Related

[[concepts/lp/vault]] · [[concepts/lp/protocol-owned-liquidity]] · [[concepts/mm-agreement/quote-obligation]] · [[concepts/tokenomics/rev-share]] · [[concepts/risk/liquidation]] · [[parameters/hyperliquid/hlp]] · [[parameters/aster/alp]] · [[parameters/orderly/omnivault]] · [[parameters/dydx-v4/megavault]]

## Sources

[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^aster-docs-2026-04-28-earn-aster-alp-fees]: [[sources/aster-docs-2026-04-28-earn-aster-alp-fees]]
[^orderly-docs-2026-04-29-omnivault-overview]: [[sources/orderly-docs-2026-04-29-omnivault-overview]]
[^orderly-docs-2026-04-29-omnivault-mechanics]: [[sources/orderly-docs-2026-04-29-omnivault-mechanics]]
[^orderly-docs-2026-04-29-roadmap]: [[sources/orderly-docs-2026-04-29-roadmap]]
[^lighter-docs-2026-04-28-trading-public-pools]: [[sources/lighter-docs-2026-04-28-trading-public-pools]]
[^dydx-community-2026-04-28-dydx-features-megavault]: [[sources/dydx-community-2026-04-28-dydx-features-megavault]]
