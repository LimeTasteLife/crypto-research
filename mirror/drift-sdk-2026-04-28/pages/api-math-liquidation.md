# Liquidation Calculations
URL: https://mintlify.com/drift-labs/protocol-v2/api/math/liquidation

# Liquidation Calculations

## Key Functions

```typescript
calculateBaseAssetAmountToCoverMarginShortage(
  marginShortage, marginRatio, liquidationFee, ifLiquidationFee,
  oraclePrice, quoteOraclePrice
): BN | undefined
```

Returns minimum base asset amount the liquidator must take to cover the margin shortage; `undefined` means liquidate all.

```typescript
calculateMaxPctToLiquidate(
  userLastActiveSlot, userLiquidationMarginFreed, marginShortage,
  slot, initialPctToLiquidate, liquidationDuration
): BN
```

Progressive liquidation cap — ramps from initialPctToLiquidate to 100% over liquidationDuration slots.

## Liquidation Types

See `concepts/liquidations` for `LiquidationType` enum and per-type record schemas.

## User helpers

- `user.canBeLiquidated()` — bool
- `user.getLiquidationStatuses()` — Map per cross/isolated position
- `user.liquidationPrice(marketIndex, ...)` — estimated price
