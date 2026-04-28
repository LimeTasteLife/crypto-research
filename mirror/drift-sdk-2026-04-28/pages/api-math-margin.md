# Margin Calculations API
URL: https://mintlify.com/drift-labs/protocol-v2/api/math/margin

# Margin Calculations

Functions for calculating margin requirements, collateral values, and liquidation prices.

## Key Functions

```typescript
calculateSizePremiumLiabilityWeight(size, imfFactor, liabilityWeight, precision, isBounded?): BN
calculateSizeDiscountAssetWeight(size, imfFactor, assetWeight): BN
calculateOraclePriceForPerpMargin(perpPosition, market, oraclePriceData): BN
calculateWorstCaseBaseAssetAmount(perpPosition, perpMarket, oraclePrice): BN
```

## User-class margin methods

See `api/user.md` for: `getMarginRequirement`, `getInitialMarginRequirement`, `getMaintenanceMarginRequirement`, `getTotalCollateral`, `getFreeCollateral`, `getHealth`, `getMarginRatio`, `getMaxLeverageForPerp`, `getMaxLeverageForSpot`, `liquidationPrice`, `spotLiquidationPrice`, `canBeLiquidated`, `getMarginCalculation`.

## Margin Categories

```typescript
type MarginCategory = 'Initial' | 'Maintenance';
```

## Best practice

Use `user.getMarginCalculation(marginCategory, opts)` once and read all margin values from the result, instead of calling individual methods repeatedly.
