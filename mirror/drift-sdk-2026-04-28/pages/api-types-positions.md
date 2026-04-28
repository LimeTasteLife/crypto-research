# Position Types
URL: https://mintlify.com/drift-labs/protocol-v2/api/types/positions

# Position Types

## PerpPosition

```typescript
type PerpPosition = {
  baseAssetAmount: BN;              // + long, - short
  lastCumulativeFundingRate: BN;
  marketIndex: number;
  quoteAssetAmount: BN;
  quoteEntryAmount: BN;
  quoteBreakEvenAmount: BN;
  openOrders: number;
  openBids: BN;
  openAsks: BN;
  settledPnl: BN;
  lpShares: BN;
  remainderBaseAssetAmount: number;
  maxMarginRatio: number;
  lastQuoteAssetAmountPerLp: BN;
  perLpBase: number;
  positionFlag: number;
  isolatedPositionScaledBalance: BN;
};
```

## SpotPosition

```typescript
type SpotPosition = {
  marketIndex: number;
  balanceType: SpotBalanceType;
  scaledBalance: BN;
  openOrders: number;
  openBids: BN;
  openAsks: BN;
  cumulativeDeposits: BN;
};
```

## PositionFlag (bit flags)

```typescript
class PositionFlag {
  static readonly IsolatedPosition = 1;
  static readonly BeingLiquidated = 2;
  static readonly Bankruptcy = 4;
}
```
