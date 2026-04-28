# ALP Fees

Source: https://docs.asterdex.com/earn/overview/aster-alp/alp-fees

### Mint and Burn Fees

To encourage a balanced pool composition, mint and burn fees adjust dynamically based on how far each asset's current weight deviates from its target weight. Depositing an underweight asset lowers your fee; depositing an overweight asset raises it.

#### Fee Parameters (USDT current values)

| Parameter | Description | Current Value |
| --- | --- | --- |
| FeeBasisPoints | Base fee rate | 0.25% |
| TaxBasisPoints | Adjustment rate applied based on weight deviation | 0.05% |

### Mint Fee Calculation

1. Current asset value: `InitialValue = AssetValueInPool + AssetUnrealizedPnL`
2. Asset value after minting: `AfterMintValue = InitialValue + MintValue`
3. Target asset value: `TargetValue = (TotalPoolValue + TotalUnrealizedPnL) × TargetWeight`
4. Weight deviation before minting: `InitialDiff = InitialValue − TargetValue`
5. Weight deviation after minting: `AfterDiff = AfterMintValue − TargetValue`

| Condition | Formula |
| --- | --- |
| `AfterDiff < InitialDiff` (minting moves asset closer to target) | `MintFee = Max(FeeBasisPoints − TaxBasisPoints × InitialDiff / TargetValue, 0)` |
| `AfterDiff ≥ InitialDiff` (minting moves asset further from target) | `MintFee = FeeBasisPoints + TaxBasisPoints × Min((InitialDiff + AfterDiff) / 2, TargetValue) / TargetValue` |

### Burn Fee Calculation

1. Current asset value: `InitialValue = AssetValueInPool + AssetUnrealizedPnL`
2. Asset value after burning: `AfterBurnValue = InitialValue − BurnValue`
3. Target asset value: `TargetValue = TotalPoolValue × TargetWeight`
4. Weight deviation before burning: `InitialDiff = InitialValue − TargetValue`
5. Weight deviation after burning: `AfterDiff = AfterBurnValue − TargetValue`

| Condition | Formula |
| --- | --- |
| `AfterDiff < InitialDiff` (burning moves asset closer to target) | `BurnFee = Max(FeeBasisPoints − TaxBasisPoints × InitialDiff / TargetValue, 0)` |
| `AfterDiff ≥ InitialDiff` (burning moves asset further from target) | `BurnFee = FeeBasisPoints + TaxBasisPoints × Min((InitialDiff + AfterDiff) / 2, TargetValue) / TargetValue` |

#### Example

Pool value: $10,000,000 | Unrealised PnL: +$ 10,000 | BTC in pool: $1,000

BTC target weight: 2% | Current weight: 0.01% | FeeBasisPoints: 0.25% | TaxBasisPoints: 0.45%

Since BTC is significantly underweight, minting ALP with 1 BTC incurs a 0% fee. Burning ALP to receive 1 BTC (removing an already scarce asset) incurs a 0.7% fee (0.007 BTC).

You can view the current pool composition, asset quantities, values, and target vs. current weights directly on the ALP page. After selecting an asset and quantity, the interface will display the exact fee before you confirm the transaction.
