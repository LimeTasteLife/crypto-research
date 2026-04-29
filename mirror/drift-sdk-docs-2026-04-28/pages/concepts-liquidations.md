# Liquidations - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/liquidations

# Liquidations

> Liquidation mechanism and bankruptcy procedures in Drift Protocol

## Liquidation Overview

Liquidations occur when a user's margin requirement exceeds their total collateral. The protocol relies on permissionless liquidators (keepers) to identify and liquidate underwater positions.

## Liquidation Trigger

A user can be liquidated when:

```typescript
totalCollateral < maintenanceMarginRequirement

```

Where:

- `totalCollateral` = value of all deposits and positive PnL (with haircuts)
- `maintenanceMarginRequirement` = required margin to maintain positions

### User Status During Liquidation

```typescript
export enum UserStatus {
  BeingLiquidated = 1,
  Bankrupt = 2,
  ReduceOnly = 4,
  AdvancedLp = 8,
  ProtectedMaker = 16,
}

```

When liquidation starts, user is marked with `BeingLiquidated` status.

## Liquidation Types

Drift supports multiple liquidation types depending on the user's state:

```typescript
export class LiquidationType {
  static readonly LIQUIDATE_PERP = { liquidatePerp: {} };
  static readonly LIQUIDATE_SPOT = { liquidateSpot: {} };
  static readonly LIQUIDATE_BORROW_FOR_PERP_PNL = { liquidateBorrowForPerpPnl: {} };
  static readonly LIQUIDATE_PERP_PNL_FOR_DEPOSIT = { liquidatePerpPnlForDeposit: {} };
  static readonly PERP_BANKRUPTCY = { perpBankruptcy: {} };
  static readonly SPOT_BANKRUPTCY = { spotBankruptcy: {} };
}

```

### Liquidate Perp

Reduces perp positions to improve margin health:

```typescript
export type LiquidatePerpRecord = {
  marketIndex: number;
  oraclePrice: BN;
  baseAssetAmount: BN;       // Amount liquidated
  quoteAssetAmount: BN;      // Quote from liquidation
  lpShares: BN;              // LP shares liquidated
  userOrderId: BN;
  liquidatorOrderId: BN;
  fillRecordId: BN;
  liquidatorFee: BN;         // Fee to liquidator
  ifFee: BN;                 // Fee to insurance fund
};

```

Process:

1. Calculate margin shortage
2. Determine max position size to liquidate
3. Transfer position to liquidator at oracle price
4. Apply liquidation fees
5. Update user margin

### Liquidate Spot

Reduces spot borrows or converts deposits:

```typescript
export type LiquidateSpotRecord = {
  assetMarketIndex: number;
  assetPrice: BN;
  assetTransfer: BN;         // Asset given to liquidator
  liabilityMarketIndex: number;
  liabilityPrice: BN;
  liabilityTransfer: BN;     // Liability taken from user
  ifFee: BN;                 // Fee to insurance fund
};

```

Process:

1. Liquidator selects asset and liability markets
2. Calculate transfer amounts with liquidation multiplier
3. Transfer liability from user to liquidator
4. Transfer asset from user to liquidator
5. Apply insurance fund fee

### Liquidate Borrow for Perp PnL

Uses positive perp PnL to repay spot borrows:

```typescript
export type LiquidateBorrowForPerpPnlRecord = {
  perpMarketIndex: number;
  marketOraclePrice: BN;
  pnlTransfer: BN;           // PnL used to repay
  liabilityMarketIndex: number;
  liabilityPrice: BN;
  liabilityTransfer: BN;     // Borrow amount repaid
};

```

This settles unrealized perp profits to reduce spot liability.

### Liquidate Perp PnL for Deposit

Takes user's deposits to cover negative perp PnL:

```typescript
export type LiquidatePerpPnlForDepositRecord = {
  perpMarketIndex: number;
  marketOraclePrice: BN;
  pnlTransfer: BN;           // Negative PnL covered
  assetMarketIndex: number;
  assetPrice: BN;
  assetTransfer: BN;         // Deposit used to cover
};

```

This uses deposits to cover unrealized perp losses.

## Liquidation Fees

Liquidators receive fees as incentive:

### Perp Liquidation Fees

```typescript
// From PerpMarketAccount
liquidatorFee: number;        // e.g., 500 = 0.5%
ifLiquidationFee: number;     // e.g., 100 = 0.1%

```

Total fee = `liquidatorFee + ifLiquidationFee`

Example: Liquidating $1000 position with 0.5% + 0.1% = $6 total fee

- Liquidator receives: $5
- Insurance fund receives: $1

### Spot Liquidation Multipliers

Spot liquidations use liability/asset multipliers:

```typescript
liabilityLiquidationMultiplier = 1.0;  // Liquidator takes full liability
assetLiquidationMultiplier = 0.95;      // Liquidator pays 95% of asset value

```

The 5% difference is split between liquidator profit and IF fee.

## Liquidation Amount Limits

Liquidations happen progressively, not all at once:

### Max Percentage to Liquidate

```typescript
export function calculateMaxPctToLiquidate(
  userLastActiveSlot: BN,
  userLiquidationMarginFreed: BN,
  marginShortage: BN,
  slot: BN,
  initialPctToLiquidate: BN,
  liquidationDuration: BN
): BN

```

Formula:

$$
maxPct = \min\left(\frac{slotsElapsed}{liquidationDuration} + initialPct, 100\%\right)
$$

This ramps up from `initialPctToLiquidate` (e.g., 10%) to 100% over `liquidationDuration` slots (e.g., 150 slots = ~1 minute).

Progressive liquidation gives users time to add margin and prevents excessive position closure during brief volatility.

### Base Asset Amount to Cover Shortage

```typescript
export function calculateBaseAssetAmountToCoverMarginShortage(
  marginShortage: BN,
  marginRatio: number,
  liquidationFee: number,
  ifLiquidationFee: number,
  oraclePrice: BN,
  quoteOraclePrice: BN
): BN | undefined

```

Calculates the minimum position size to liquidate to cover the margin shortage:

$$
baseAmount = \frac{marginShortage}{oraclePrice \times (marginRatio - liquidationFee - ifFee)}
$$

If this exceeds the position size, returns `undefined` (liquidate all).

## Bankruptcy

When a user's collateral is insufficient even after full liquidation, bankruptcy procedures activate.

### Perp Bankruptcy

```typescript
export type PerpBankruptcyRecord = {
  marketIndex: number;
  pnl: BN;                      // Outstanding negative PnL
  ifPayment: BN;                // Insurance fund covers
  clawbackUser: PublicKey | null;
  clawbackUserPayment: BN | null;
  cumulativeFundingRateDelta: BN; // Socialized loss
};

```

Process:

1. Calculate remaining negative PnL
2. Insurance fund covers what it can
3. Remaining loss is socialized via funding rate adjustment
4. If applicable, clawback from recent profitable traders

### Spot Bankruptcy

```typescript
export type SpotBankruptcyRecord = {
  marketIndex: number;
  borrowAmount: BN;             // Outstanding borrow
  cumulativeDepositInterestDelta: BN; // Socialized loss
  ifPayment: BN;                // Insurance fund covers
};

```

Process:

1. Calculate remaining borrow after liquidating all deposits
2. Insurance fund covers what it can
3. Remaining loss is socialized to depositors via cumulative deposit interest adjustment

Socialized losses are rare but can occur during extreme market conditions. They are distributed proportionally to all depositors in the affected spot market.

## Liquidation Record

Each liquidation emits a comprehensive record:

```typescript
export type LiquidationRecord = {
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

## Liquidation Margin Freed

Tracks how much margin has been freed through liquidations:

```typescript
// From User account
liquidationMarginFreed: BN;  // Cumulative margin freed
lastActiveSlot: BN;          // Last user activity

```

This determines the liquidation speed ramp:

- If `liquidationMarginFreed > 0`, liquidation is in progress
- Slots since `lastActiveSlot` determine current max liquidation percentage
- Resets to 0 when user is healthy again

## Order Cancellation During Liquidation

When liquidation begins:

1. All risk-increasing orders are cancelled
2. Reduce-only orders may remain
3. Order IDs are recorded in `canceledOrderIds`
4. Users cannot place new risk-increasing orders

## Isolated Position Liquidation

Isolated positions are liquidated independently:

```typescript
isolatedCollateral = getTokenAmount(
  position.isolatedPositionScaledBalance,
  quoteSpotMarket
);

isolatedMarginReq = 
  positionSize * price * marginRatio;

if (isolatedCollateral < isolatedMarginReq) {
  // Liquidate isolated position only
  // Other positions unaffected
}

```

Isolated Liquidation Process:

1. Check isolated position margin independently
2. Liquidate only the isolated position if underwater
3. Use only isolated collateral
4. Cross-margin positions remain unaffected
5. If isolated collateral insufficient, bankruptcy on isolated position only

Isolated positions protect your main account from high-risk trades. Only the isolated collateral is at risk.

## Liquidation Bit Flags

```typescript
export class LiquidationBitFlag {
  static readonly IsolatedPosition = 1;
}

```

Flags indicate special liquidation circumstances like isolated positions.

## Insurance Fund

The insurance fund backs the protocol against insolvency:

- Receives portion of liquidation fees
- Covers bankruptcy losses before socialization
- Per-market insurance funds for spot markets
- Shared perp insurance fund

### Insurance Fund Structure

```typescript
// From SpotMarketAccount.insuranceFund
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
}

```

Users can stake to the insurance fund and earn a portion of protocol revenue.

## Liquidator Incentives

Liquidators are incentivized through:

1. Liquidation fees: Direct fee on liquidated amount
2. Price improvement: Acquire positions below market price
3. Insurance fund fees: Additional fee to IF

Example:

- User has 10 SOL short at $100, underwater by $50
- Liquidator takes over the short position
- Liquidator pays: 10 * $100 * (1 - 0.5% liquidatorFee - 0.1% ifFee) = $994
- User receives: $994 for $1000 position
- Liquidator profit: $6 (plus any favorable position movement)
- IF receives: $1

## Preventing Liquidation

Users can avoid liquidation by:

1. Adding collateral: Deposit more funds
2. Reducing positions: Close or reduce losing positions
3. Settling PnL: Settle positive unrealized PnL
4. Repaying borrows: Reduce spot liabilities
5. Cancelling orders: Free up margin from open orders

Monitor your margin ratio regularly. Set up alerts when approaching maintenance margin threshold.

## Next Steps

## Margin System

Understand margin requirements in detail

## Positions

Learn about position management

## Markets

Review market-specific liquidation parameters

## Keeper Bots

Build a liquidator bot
