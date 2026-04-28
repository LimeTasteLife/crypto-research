# Positions - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/positions

# Positions

> Position management and PnL calculations in Drift Protocol

## Position Types

Drift Protocol manages two types of positions: perpetual futures positions and spot positions.

## Perpetual Positions

Perpetual positions represent a user's exposure to a perpetual market.

### Position Structure

```typescript
export type PerpPosition = {
  baseAssetAmount: BN;              // Position size (+ long, - short)
  lastCumulativeFundingRate: BN;    // Last settled funding rate
  marketIndex: number;              // Market identifier
  quoteAssetAmount: BN;             // Quote locked in position
  quoteEntryAmount: BN;             // Entry cost basis
  quoteBreakEvenAmount: BN;         // Break-even including fees/funding
  openOrders: number;               // Count of open orders
  openBids: BN;                     // Base amount in open bids
  openAsks: BN;                     // Base amount in open asks
  settledPnl: BN;                   // Realized PnL
  lpShares: BN;                     // LP shares (if providing liquidity)
  remainderBaseAssetAmount: number; // Remainder from precision
  maxMarginRatio: number;           // Custom margin ratio
  lastQuoteAssetAmountPerLp: BN;    // Last LP accounting
  perLpBase: number;                // LP base per share
  positionFlag: number;             // Position flags (isolated, etc.)
  isolatedPositionScaledBalance: BN; // Isolated margin balance
};

```

### Position Direction

```typescript
export class PositionDirection {
  static readonly LONG = { long: {} };   // baseAssetAmount > 0
  static readonly SHORT = { short: {} }; // baseAssetAmount < 0
}

```

### Position Flags

Positions can have special flags that affect their behavior:

```typescript
export class PositionFlag {
  static readonly IsolatedPosition = 1;
  static readonly BeingLiquidated = 2;
  static readonly Bankruptcy = 4;
}

```

Isolated positions use dedicated collateral and don't share risk with other positions. They were introduced in v2.154.0.

## Spot Positions

Spot positions represent deposits or borrows in a spot market.

### Spot Position Structure

```typescript
export type SpotPosition = {
  marketIndex: number;
  balanceType: SpotBalanceType;     // DEPOSIT or BORROW
  scaledBalance: BN;                // Balance in scaled units
  openOrders: number;               // Count of open orders
  openBids: BN;                     // Quote reserved in bids
  openAsks: BN;                     // Base reserved in asks
  cumulativeDeposits: BN;           // Total deposits (for tracking)
};

```

### Token Amount Calculation

The actual token amount is calculated from the scaled balance:

```typescript
tokenAmount = (scaledBalance * cumulativeInterest) / SPOT_BALANCE_PRECISION

```

Where `cumulativeInterest` is either `cumulativeDepositInterest` or `cumulativeBorrowInterest` from the spot market, depending on the balance type.

## PnL Calculations

### Unrealized PnL

Unrealized PnL is calculated as the difference between current position value and entry cost:

```typescript
export function calculatePositionPNL(
  market: PerpMarketAccount,
  perpPosition: PerpPosition,
  withFunding = false,
  oraclePriceData: Pick<OraclePriceData, 'price'>
): BN

```

Formula:

$$
PnL = baseAssetValue \times sign(baseAssetAmount) + quoteAssetAmount
$$

Where:

- `baseAssetValue` = current market value of the position
- `sign(baseAssetAmount)` = 1 for long, -1 for short
- `quoteAssetAmount` = negative of the quote used to open position

### Including Funding Payments

When `withFunding = true`, unsettled funding payments are included:

$$
PnL_{total} = PnL_{position} + fundingPayment
$$

$$
fundingPayment = baseAssetAmount \times (cumulativeFundingRate_{current} - lastCumulativeFundingRate)
$$

### Base Asset Value

The base asset value calculation uses the AMM to determine the exit price:

```typescript
export function calculateBaseAssetValue(
  market: PerpMarketAccount,
  userPosition: PerpPosition,
  mmOraclePriceData: MMOraclePriceData,
  useSpread = true,
  skipUpdate = false,
  latestSlot?: BN
): BN

```

This simulates swapping the position through the AMM (with spread if applicable) to get the exit quote amount.

### Break-Even Price

The break-even price includes entry price plus fees and funding:

$$
breakEvenPrice = \frac{quoteBreakEvenAmount}{|baseAssetAmount|}
$$

The `quoteBreakEvenAmount` is updated when:

- Opening/closing positions (includes trading fees)
- Settling funding payments
- Taking maker rebates

## Position Management

### Opening Positions

Positions are opened or increased through order fills. When a long order fills:

1. `baseAssetAmount` increases
2. `quoteAssetAmount` decreases by the fill quote amount
3. `quoteEntryAmount` is updated for cost basis tracking
4. `quoteBreakEvenAmount` includes fees
5. Funding rate checkpoint is updated

### Closing Positions

When closing a position:

1. `baseAssetAmount` decreases toward zero
2. `quoteAssetAmount` increases by the exit quote amount
3. PnL is realized and moved to `settledPnl`
4. If fully closed, position is reset

### Flipping Positions

When an order flips a position (e.g., long → short):

1. Old position is fully closed and PnL realized
2. New position is opened in opposite direction
3. Entry amounts are reset for the new position

## Margin Calculations

### Position Value for Margin

For margin calculations, positions are valued differently than for PnL:

```typescript
export function calculateBaseAssetValueWithOracle(
  market: PerpMarketAccount,
  perpPosition: PerpPosition,
  oraclePriceData: Pick<OraclePriceData, 'price'>,
  includeOpenOrders = false
): BN

```

Formula:

$$
value = |baseAssetAmount| \times oraclePrice
$$

### Worst-Case Base Amount

When `includeOpenOrders = true`, margin calculations use worst-case scenarios:

```typescript
export function calculateWorstCaseBaseAssetAmount(
  perpPosition: PerpPosition,
  perpMarket: PerpMarketAccount,
  oraclePrice: BN
): BN

```

This considers:

- Current position
- All open bids (could increase long or decrease short)
- All open asks (could increase short or decrease long)

Returns the scenario with maximum liability.

### Liability Value

For prediction markets, liability is calculated differently:

```typescript
if (isPredictionMarket && baseAssetAmount < 0) {
  // Short in prediction market
  liabilityValue = |baseAssetAmount| * (MAX_PRICE - oraclePrice)
} else {
  liabilityValue = |baseAssetAmount| * oraclePrice
}

```

## Isolated Positions

Introduced in v2.154.0, isolated positions use dedicated collateral.

### Creating Isolated Positions

When opening an isolated position:

1. Deposit collateral into `isolatedPositionScaledBalance`
2. Position is flagged with `PositionFlag.IsolatedPosition`
3. Only the isolated collateral backs this position
4. Position cannot use cross-margin collateral

### Isolated Position Constraints

- Only one isolated position allowed per market
- Must be in an `ISOLATED` tier market
- Cannot mix with cross-margin positions in same market
- Liquidation affects only the isolated position

Isolated positions have separate margin calculations and are liquidated independently from cross-margin positions.

## LP Positions

Users can provide liquidity to the AMM:

### LP Shares

When adding liquidity:

1. User receives `lpShares` proportional to deposit
2. User's position in the market is effectively transferred to the AMM
3. LP earns a portion of trading fees
4. LP shares PnL of the AMM position

### Removing Liquidity

When removing liquidity:

1. LP shares are burned
2. User receives their proportional share of:

- Base asset position from AMM
- Quote asset from AMM
- Accrued fees

LP positions are subject to a cooldown period (typically 24 hours) after adding liquidity before removal is allowed.

## Position Limits

### Max Positions

Each user account can have:

- Up to 8 perp positions
- Up to 8 spot positions
- Up to 32 open orders

### Open Interest Limits

Markets may have maximum open interest caps:

```typescript
if (amm.maxOpenInterest > 0) {
  currentOpenInterest = max(baseAssetAmountLong, baseAssetAmountShort.abs())
  require(currentOpenInterest <= maxOpenInterest)
}

```

## Next Steps

## Orders

Learn how orders create and modify positions

## Margin System

Understand margin requirements for positions

## Liquidations

See how underwater positions are liquidated

## Markets

Review market mechanics and parameters
