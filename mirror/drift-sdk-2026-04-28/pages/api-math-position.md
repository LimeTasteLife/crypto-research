# Position Calculations
URL: https://mintlify.com/drift-labs/protocol-v2/api/math/position

# Position Calculations

Functions for calculating position values, PnL, funding, and other position metrics.

## Key Functions

```typescript
calculatePositionPNL(market, perpPosition, withFunding?, oraclePriceData): BN
calculateBaseAssetValue(market, userPosition, mmOraclePriceData, useSpread?, skipUpdate?, latestSlot?): BN
calculateBaseAssetValueWithOracle(market, perpPosition, oraclePriceData, includeOpenOrders?): BN
calculateEntryPrice(userPosition: PerpPosition): BN
calculatePositionFundingPNL(market, perpPosition): BN
calculateUnsettledPnl(market, perpPosition, oraclePrice): BN
calculatePositionLeverage(perpPosition, oraclePrice, totalCollateral): BN
```

## User-class position methods

See `api/user.md` for: `getPerpPosition`, `getSpotPosition`, `getActivePerpPositions`, `getActiveSpotPositions`, `getUnrealizedPNL`, `getUnrealizedFundingPNL`, `getPositionEstimatedExitPriceAndPnl`, `getPerpPositionValue`, `getTotalAssetValue`, `getTotalLiabilityValue`, `getNetUsdValue`.
