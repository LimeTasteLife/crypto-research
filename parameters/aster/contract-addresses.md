---
type: parameter
entity: [[aster]]
parameter: contract-registry
unit: address
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster contract addresses

## Current (as of 2026-04-28)

**Treasury — multi-chain footprint.** Aster Treasury is deployed across four networks; Treasury (7% allocation) is fully locked at TGE and only unlocks via governance approval[^aster-docs-2026-04-28-overview-smart-contracts][^aster-docs-2026-04-28-usdaster-tokenomics]:

| Network | Treasury address |
|---|---|
| BNB Chain | `0x128463A60784c4D3f46c23Af3f65Ed859Ba87974`[^aster-docs-2026-04-28-overview-smart-contracts] |
| Ethereum | `0x604DD02d620633Ae427888d41bfd15e38483736E`[^aster-docs-2026-04-28-overview-smart-contracts] |
| Solana | `EhUtRgu9iEbZXXRpEvDj6n1wnQRjMi2SERDo3c6bmN2c`[^aster-docs-2026-04-28-overview-smart-contracts] |
| Arbitrum | `0x9E36CB86a159d479cEd94Fa05036f235Ac40E1d5`[^aster-docs-2026-04-28-overview-smart-contracts] |

**Earn product contracts (all on BNB Chain).** Each Earn product uses a **two-contract pattern**: a token contract and a separate minting contract[^aster-docs-2026-04-28-overview-smart-contracts]. The Earn-product contracts and USDF contracts are listed only on BNB Chain in the smart-contracts page, consistent with BNB Chain being the primary execution venue for these products[^aster-docs-2026-04-28-overview-smart-contracts]:

| Product | Token contract | Minting contract |
|---|---|---|
| asBTC | `0x184b72289c0992BDf96751354680985a7C4825d6` | `0x8a3C77E6c6A488d26CD44F403b95e44675f46e6A` |
| asUSDF | `0x917AF46B3C3c6e1Bb7286B9F59637Fb7C65851Fb` | `0xdB57a53C428a9faFcbFefFB6dd80d0f427543695` |
| asBNB | `0x77734e70b6E88b4d82fE632a168EDf6e700912b6` | `0x2F31ab8950c50080E77999fa456372f276952fD8` |
| asCAKE | `0x9817F4c9f968a553fF6caEf1a2ef6cF1386F16F7` | `0x1A81A28482Edd40ff1689CB3D857c3dAdF11D502` |
| USDF | `0x5A110fC00474038f6c02E89C707D638602EA44B5` | `0xC271fc70dD9E678ac1AB632f797894fe4BE2C345` |

[^aster-docs-2026-04-28-overview-smart-contracts]

**ALP mint surface.** ALP can be minted on **BNB Chain** and **Arbitrum** with chain-specific deposit assets[^aster-docs-2026-04-28-earn-aster-alp]. Specific ALP mint/burn contract addresses are not surfaced in the Smart Contracts overview page; they are documented through the ALP product UI (see [[parameters/aster/alp]]).

**Tokens.** Native token `$ASTER` is referenced from [[entities/token/aster]] (issuance contract specifics not disclosed on the smart-contracts page). USDF token+minting contract addresses are above.

## Time series

| effective | Treasury chains | Earn products on BNB Chain | ALP mint chains | source |
|---|---|---|---|---|
| 2026-04-28 | BNB Chain, Ethereum, Solana, Arbitrum | asBTC, asUSDF, asBNB, asCAKE, USDF (each token+minting pair) | BNB Chain, Arbitrum | [^aster-docs-2026-04-28-overview-smart-contracts][^aster-docs-2026-04-28-earn-aster-alp] |

## Tiering rules / formulae

Not applicable — parameter is a contract registry, not formulaic.

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-overview-smart-contracts]: [[sources/aster-docs-2026-04-28-overview-smart-contracts]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
