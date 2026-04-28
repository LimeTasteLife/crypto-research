# Liquidations
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/liquidations

# Liquidations

## Trigger

`totalCollateral < maintenanceMarginRequirement`

```typescript
enum UserStatus {
  BeingLiquidated = 1,
  Bankrupt = 2,
  ReduceOnly = 4,
  AdvancedLp = 8,
  ProtectedMaker = 16,
}
```

## Liquidation Types

```typescript
class LiquidationType {
  static readonly LIQUIDATE_PERP;
  static readonly LIQUIDATE_SPOT;
  static readonly LIQUIDATE_BORROW_FOR_PERP_PNL;
  static readonly LIQUIDATE_PERP_PNL_FOR_DEPOSIT;
  static readonly PERP_BANKRUPTCY;
  static readonly SPOT_BANKRUPTCY;
}
```

### Liquidate Perp

Process: calculate margin shortage -> determine max position size -> transfer position to liquidator at oracle price -> apply liquidation fees -> update margin.

```typescript
type LiquidatePerpRecord = {
  marketIndex: number;
  oraclePrice: BN;
  baseAssetAmount: BN;
  quoteAssetAmount: BN;
  lpShares: BN;
  liquidatorFee: BN;
  ifFee: BN;
};
```

### Liquidate Spot

Liquidator selects asset and liability markets, applies multiplier, transfers liability + asset, IF fee.

### Liquidate Borrow for Perp PnL

Uses positive perp PnL to repay spot borrows.

### Liquidate Perp PnL for Deposit

Takes deposits to cover negative perp PnL.

## Liquidation Fees

```typescript
liquidatorFee: number;        // e.g., 500 = 0.5%
ifLiquidationFee: number;     // e.g., 100 = 0.1%
```

Total fee = liquidatorFee + ifLiquidationFee.

Spot liquidation multipliers:
```
liabilityLiquidationMultiplier = 1.0
assetLiquidationMultiplier = 0.95
```

## Progressive Liquidation Limits

```typescript
calculateMaxPctToLiquidate(
  userLastActiveSlot, userLiquidationMarginFreed, marginShortage,
  slot, initialPctToLiquidate, liquidationDuration
): BN
```

`maxPct = min(slotsElapsed / liquidationDuration + initialPct, 100%)`

Ramps from initialPctToLiquidate (e.g., 10%) to 100% over liquidationDuration slots (e.g., 150 slots ≈ 1 minute).

## Bankruptcy

### Perp Bankruptcy

```typescript
type PerpBankruptcyRecord = {
  marketIndex: number;
  pnl: BN;
  ifPayment: BN;
  clawbackUser: PublicKey | null;
  clawbackUserPayment: BN | null;
  cumulativeFundingRateDelta: BN; // Socialized loss
};
```

### Spot Bankruptcy

```typescript
type SpotBankruptcyRecord = {
  marketIndex: number;
  borrowAmount: BN;
  cumulativeDepositInterestDelta: BN; // Socialized loss
  ifPayment: BN;
};
```

Process: insurance fund covers what it can; remaining loss socialized.

## Liquidation Record

```typescript
type LiquidationRecord = {
  ts: BN;
  user: PublicKey;
  liquidator: PublicKey;
  liquidationType: LiquidationType;
  marginRequirement: BN;
  totalCollateral: BN;
  marginFreed: BN;
  liquidationId: number;
  bankrupt: boolean;
  canceledOrderIds: BN[];
  liquidatePerp: LiquidatePerpRecord;
  liquidateSpot: LiquidateSpotRecord;
  liquidateBorrowForPerpPnl: LiquidateBorrowForPerpPnlRecord;
  liquidatePerpPnlForDeposit: LiquidatePerpPnlForDepositRecord;
  perpBankruptcy: PerpBankruptcyRecord;
  spotBankruptcy: SpotBankruptcyRecord;
};
```

## Order Cancellation

When liquidation begins: all risk-increasing orders cancelled, reduce-only orders may remain. Order IDs recorded in `canceledOrderIds`.

## Isolated Position Liquidation

Independent — only the isolated position liquidated; cross-margin positions unaffected. If isolated collateral insufficient -> bankruptcy on isolated position only.

## Insurance Fund

```typescript
insuranceFund: {
  vault: PublicKey;
  totalShares: BN;
  userShares: BN;
  sharesBase: BN;
  unstakingPeriod: BN;
  lastRevenueSettleTs: BN;
  revenueSettlePeriod: BN;
  totalFactor: number;
  userFactor: number;
};
```

Users can stake to IF and earn portion of protocol revenue.

## Liquidator Incentives

- Liquidation fees (direct)
- Price improvement (acquire below market)
- Insurance fund fees

## Preventing Liquidation

1. Add collateral
2. Reduce positions
3. Settle PnL
4. Repay borrows
5. Cancel orders
