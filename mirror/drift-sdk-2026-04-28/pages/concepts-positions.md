# Positions
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/positions

# Positions

Two types: perpetual and spot.

## Perpetual Positions

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

### Position Direction

```typescript
class PositionDirection {
  static readonly LONG;   // baseAssetAmount > 0
  static readonly SHORT;  // baseAssetAmount < 0
}
```

### Position Flags

```typescript
class PositionFlag {
  static readonly IsolatedPosition = 1;
  static readonly BeingLiquidated = 2;
  static readonly Bankruptcy = 4;
}
```

Isolated positions (v2.154.0+) use dedicated collateral and don't share risk.

## Spot Positions

```typescript
type SpotPosition = {
  marketIndex: number;
  balanceType: SpotBalanceType; // DEPOSIT or BORROW
  scaledBalance: BN;
  openOrders: number;
  openBids: BN;
  openAsks: BN;
  cumulativeDeposits: BN;
};
```

Token amount = (scaledBalance * cumulativeInterest) / SPOT_BALANCE_PRECISION

## PnL Calculations

### Unrealized PnL

```typescript
calculatePositionPNL(market, perpPosition, withFunding, oraclePriceData): BN
```

Formula: PnL = baseAssetValue * sign(baseAssetAmount) + quoteAssetAmount

### Including Funding

```
PnL_total = PnL_position + fundingPayment
fundingPayment = baseAssetAmount * (cumulativeFundingRate_current - lastCumulativeFundingRate)
```

### Base Asset Value

`calculateBaseAssetValue(market, userPosition, mmOraclePriceData, useSpread, skipUpdate, latestSlot): BN`

Simulates swapping the position through the AMM with spread.

### Break-Even Price

breakEvenPrice = quoteBreakEvenAmount / |baseAssetAmount|

## Position Management

### Opening
1. baseAssetAmount increases
2. quoteAssetAmount decreases by fill quote amount
3. quoteEntryAmount updated
4. quoteBreakEvenAmount includes fees
5. Funding rate checkpoint updated

### Closing
1. baseAssetAmount decreases toward zero
2. quoteAssetAmount increases by exit quote
3. PnL realized -> settledPnl
4. If fully closed, position reset

### Flipping (long -> short)
1. Old position fully closed, PnL realized
2. New position opened opposite direction
3. Entry amounts reset

## Margin Calculations for Positions

```typescript
calculateBaseAssetValueWithOracle(market, perpPosition, oraclePriceData, includeOpenOrders): BN
```

Formula: value = |baseAssetAmount| * oraclePrice

### Worst-Case Base Amount

```typescript
calculateWorstCaseBaseAssetAmount(perpPosition, perpMarket, oraclePrice): BN
```

Considers current position + all open bids + all open asks; returns scenario with maximum liability.

### Liability Value (prediction markets)

```typescript
if (isPredictionMarket && baseAssetAmount < 0) {
  liabilityValue = |baseAssetAmount| * (MAX_PRICE - oraclePrice)
} else {
  liabilityValue = |baseAssetAmount| * oraclePrice
}
```

## Isolated Positions

When opening: deposit collateral into `isolatedPositionScaledBalance`, position flagged `IsolatedPosition`. Constraints: only one isolated position per market, must be in ISOLATED tier market, cannot mix with cross-margin positions in same market, liquidation isolated.

## LP Positions

When adding liquidity: receives lpShares proportional to deposit; user's position effectively transferred to AMM; LP earns portion of trading fees and shares AMM PnL.

When removing: lpShares burned; user receives proportional share of base, quote, and accrued fees. LP positions have ~24h cooldown after adding before removal.

## Position Limits

- Up to 8 perp positions
- Up to 8 spot positions
- Up to 32 open orders
- Open interest caps per market: max(baseAssetAmountLong, |baseAssetAmountShort|) <= maxOpenInterest
