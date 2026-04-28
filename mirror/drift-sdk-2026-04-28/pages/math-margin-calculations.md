# Margin Calculations
URL: https://mintlify.com/drift-labs/protocol-v2/math/margin-calculations

# Margin Calculations

## Total Collateral

`totalCollateral = sum(deposit_value * assetWeight) + sum(positiveUnrealizedPnL * pnlAssetWeight)`

## Margin Requirement

`marginRequirement = sum(positionNotional * marginRatio) + sum(borrowValue * liabilityWeight) + openOrderMargin`

## IMF Scaling

`marginRatio_effective = baseMarginRatio + imfFactor * sqrt(size * 10)`
`liabilityWeight_effective = liabilityWeight + imfFactor * sqrt(size * 10)`
`assetWeight_effective = (1.1 * assetWeight) / (1 + imfFactor * sqrt(size * 10))`

## Health

`Health = 1 - maintenanceMargin / totalCollateral`

## Free Collateral

`freeCollateral = totalCollateral - initialMarginRequirement`

## Leverage

`leverage = totalNotional / totalCollateral`

## Liquidation Price

For a perp position, liquidation price calculation:

```
liquidationPrice = (totalCollateral - maintenanceMargin) / baseAssetAmount + currentPrice
```

(Sign and rearrangement depends on long/short direction.)

## Buying Power

`buyingPower = freeCollateral / initialMarginRatio`
