---
type: source
id: aster-docs-2026-04-28-overview-smart-contracts
title: Smart Contracts
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/overview/smart-contracts
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/overview-smart-contracts.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Smart Contracts

## TL;DR
Aster's smart contract registry lists Treasury contracts deployed across four networks (BNB Chain, Ethereum, Solana, Arbitrum) plus Aster Earn product contracts (asBTC, asUSDF, asBNB, asCAKE — each as a separate token + minting contract pair) and the USDF stablecoin token + minting contract. The multi-chain Treasury footprint suggests cross-chain stack-accounting and treasury operations. All Earn-product contracts and the USDF contracts are listed only on BNB Chain in this page, which is consistent with BNB Chain being the primary Aster execution venue for Earn products.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Aster Treasury is deployed on BNB Chain at 0x128463A60784c4D3f46c23Af3f65Ed859Ba87974. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c2 | Aster Treasury is deployed on Ethereum at 0x604DD02d620633Ae427888d41bfd15e38483736E. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c3 | Aster Treasury is deployed on Solana at EhUtRgu9iEbZXXRpEvDj6n1wnQRjMi2SERDo3c6bmN2c. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c4 | Aster Treasury is deployed on Arbitrum at 0x9E36CB86a159d479cEd94Fa05036f235Ac40E1d5. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c5 | Aster's Treasury exists on at least four networks: BNB Chain, Ethereum, Solana, and Arbitrum. | [[parameters/aster/contract-addresses]] | A6-PIV, A8-PI |
| #c6 | asBTC token contract is at 0x184b72289c0992BDf96751354680985a7C4825d6. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c7 | asBTC minting contract is at 0x8a3C77E6c6A488d26CD44F403b95e44675f46e6A. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c8 | asUSDF token contract is at 0x917AF46B3C3c6e1Bb7286B9F59637Fb7C65851Fb. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c9 | asUSDF minting contract is at 0xdB57a53C428a9faFcbFefFB6dd80d0f427543695. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c10 | asBNB token contract is at 0x77734e70b6E88b4d82fE632a168EDf6e700912b6. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c11 | asBNB minting contract is at 0x2F31ab8950c50080E77999fa456372f276952fD8. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c12 | asCAKE token contract is at 0x9817F4c9f968a553fF6caEf1a2ef6cF1386F16F7. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c13 | asCAKE minting contract is at 0x1A81A28482Edd40ff1689CB3D857c3dAdF11D502. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c14 | USDF token contract is at 0x5A110fC00474038f6c02E89C707D638602EA44B5. | [[parameters/aster/contract-addresses]], [[entities/token/usdf]] | A8-PI |
| #c15 | USDF minting contract is at 0xC271fc70dD9E678ac1AB632f797894fe4BE2C345. | [[parameters/aster/contract-addresses]], [[entities/token/usdf]] | A8-PI |
| #c16 | Aster Earn products (asBTC, asUSDF, asBNB, asCAKE) each use a two-contract pattern: a token contract and a separate minting contract. | [[parameters/aster/contract-addresses]] | A8-PI |
| #c17 | The Aster Earn product contracts and USDF contracts are documented as a single set of addresses, suggesting BNB Chain as the primary execution venue for these products. | [[parameters/aster/contract-addresses]], [[entities/network/bnb-chain]] | A6-PIV |
