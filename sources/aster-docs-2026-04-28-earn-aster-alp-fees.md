---
type: source
id: aster-docs-2026-04-28-earn-aster-alp-fees
title: ALP Fees
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/earn/overview/aster-alp/alp-fees
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/earn-aster-alp-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# ALP Fees

## TL;DR
ALP mint and burn fees adjust dynamically to push the pool toward target weights. Base parameters (current USDT values): FeeBasisPoints = 0.25%, TaxBasisPoints = 0.05%. The mechanism rewards rebalancing actions (depositing an underweight asset or withdrawing an overweight asset can drop the fee toward 0%) and penalizes destabilizing actions (depositing overweight or burning underweight scales fee up by tax × midpoint deviation / target). The example shows a 0% mint fee for adding underweight BTC and a 0.7% burn fee for removing scarce BTC — a 70bps round-trip asymmetry that disincentivizes draining underweight assets. Note: the example uses TaxBasisPoints 0.45% (not the listed 0.05%), suggesting per-asset tax parameters or a stale/inconsistent example value.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | ALP mint and burn fees adjust dynamically based on how far each asset's current weight deviates from its target weight. | [[parameters/aster/alp]] | A5-PIV |
| #c2 | Depositing an underweight asset lowers the mint fee. | [[parameters/aster/alp]] | A5-PIV |
| #c3 | Depositing an overweight asset raises the mint fee. | [[parameters/aster/alp]] | A5-PIV |
| #c4 | The current FeeBasisPoints (base fee rate) for USDT in ALP is 0.25%. | [[parameters/aster/alp]] | A2-PI, A5-PIV |
| #c5 | The current TaxBasisPoints (deviation adjustment rate) for USDT in ALP is 0.05%. | [[parameters/aster/alp]] | A2-PI, A5-PIV |
| #c6 | Mint fee when minting moves an asset closer to its target: MintFee = max(FeeBasisPoints − TaxBasisPoints × InitialDiff / TargetValue, 0). | [[parameters/aster/alp]] | A5-PIV |
| #c7 | Mint fee when minting moves an asset further from target: MintFee = FeeBasisPoints + TaxBasisPoints × min((InitialDiff + AfterDiff)/2, TargetValue) / TargetValue. | [[parameters/aster/alp]] | A5-PIV |
| #c8 | Burn fee when burning moves an asset closer to its target: BurnFee = max(FeeBasisPoints − TaxBasisPoints × InitialDiff / TargetValue, 0). | [[parameters/aster/alp]] | A5-PIV |
| #c9 | Burn fee when burning moves an asset further from target: BurnFee = FeeBasisPoints + TaxBasisPoints × min((InitialDiff + AfterDiff)/2, TargetValue) / TargetValue. | [[parameters/aster/alp]] | A5-PIV |
| #c10 | InitialValue (current asset value used in fee calc) = AssetValueInPool + AssetUnrealizedPnL. | [[parameters/aster/alp]] | A5-PIV |
| #c11 | TargetValue for mint = (TotalPoolValue + TotalUnrealizedPnL) × TargetWeight. | [[parameters/aster/alp]] | A5-PIV |
| #c12 | TargetValue for burn = TotalPoolValue × TargetWeight (excluding unrealized PnL). | [[parameters/aster/alp]] | A5-PIV |
| #c13 | The fee mechanism creates round-trip asymmetry that penalizes draining underweight assets — example: 0% mint fee on adding underweight BTC vs 0.7% burn fee on removing the same scarce BTC. | [[parameters/aster/alp]] | A5-PIV, A5-PIII |
| #c14 | The published fee example uses a TaxBasisPoints of 0.45% rather than the listed default 0.05%, suggesting per-asset tax parameters (BTC: 0.45%) or inconsistent documentation. | [[parameters/aster/alp]] | A5-PIV |
| #c15 | The interface displays the exact mint or burn fee before transaction confirmation. | [[parameters/aster/alp]] | - |
| #c16 | Live ALP pool composition (asset quantities, values, target vs. current weights) is viewable on the ALP product page. | [[parameters/aster/alp]] | - |
