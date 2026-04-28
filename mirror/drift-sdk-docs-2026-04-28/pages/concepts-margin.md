# Margin System - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/margin

# Margin System

> Cross-margin and isolated margin mechanics in Drift Protocol

## Margin Modes

Drift Protocol supports two margin modes:

```typescript
export class MarginMode {
  static readonly DEFAULT = { default: {} };              // Cross-margin
  static readonly HIGH_LEVERAGE = { highLeverage: {} };   // High leverage cross-margin
  static readonly HIGH_LEVERAGE_MAINTENANCE = { highLeverageMaintenance: {} };
}

```

### Cross-Margin (Default)

Cross-margin mode pools all collateral across positions:

- All deposits act as collateral for all positions
- Unrealized PnL contributes to margin (with haircuts)
- Most capital efficient for diversified portfolios
- Default mode for all users

### Isolated Margin

Isolated margin uses dedicated collateral per position:

- Only available for `ISOLATED` tier markets
- Separate collateral pool per isolated position
- No cross-contamination of risk
- Introduced in v2.154.0

Isolated positions cannot share margin with cross-margin positions. Each isolated position is liquidated independently.

## Margin Calculation

Margin health is determined by comparing total collateral to margin requirements.

### Total Collateral

Total collateral is the sum of:

1. Spot Deposits (weighted by asset weight)
2. Unrealized Perp PnL (positive, with haircuts)
3. Unsettled Perp PnL (positive, settled but not withdrawn)

Formula:

$$
totalCollateral = \sum_{deposits} (tokenAmount \times price \times assetWeight) + \sum_{perpPnL > 0} (pnl \times pnlAssetWeight)
$$

### Margin Requirement

Margin requirement is the sum of:

1. Perp Position Margin (based on position size and market tier)
2. Spot Borrows (weighted by liability weight)
3. Open Order Margins (reserved margin for open orders)
4. Unrealized Perp PnL (negative, with liability weights)

Formula:

$$
marginRequirement = \sum_{perpPositions} (size \times price \times marginRatio) + \sum_{borrows} (tokenAmount \times price \times liabilityWeight)
$$

### Margin Ratio Types

Initial Margin: Required to open new positions

```typescript
type MarginRequirementType = 'Initial' | 'Maintenance';

```

- Initial: Higher requirement, used when opening/increasing positions
- Maintenance: Lower requirement, determines liquidation threshold

### Health Check

```typescript
if (totalCollateral < marginRequirement) {
  // User can be liquidated (maintenance)
  // or cannot open new positions (initial)
}

```

## Size-Based Margin Scaling

Both perp and spot positions have size-based margin scaling using the IMF (Initial Margin Fraction) factor:

### Perp Position Margin

```typescript
export function calculateSizePremiumLiabilityWeight(
  size: BN,
  imfFactor: BN,
  liabilityWeight: BN,
  precision: BN,
  isBounded = true
): BN

```

Formula:

$$
marginRatio = baseMarginRatio + imfFactor \times \sqrt{size \times 10}
$$

Larger positions require proportionally more margin.

### Spot Liability Weight

Borrows also scale with size:

$$
liabilityWeight_{effective} = liabilityWeight + imfFactor \times \sqrt{borrowSize \times 10}
$$

### Spot Asset Weight Discount

Large deposits receive a discounted asset weight:

```typescript
export function calculateSizeDiscountAssetWeight(
  size: BN,
  imfFactor: BN,
  assetWeight: BN
): BN

```

$$
assetWeight_{effective} = \frac{1.1 \times assetWeight}{1 + imfFactor \times \sqrt{size \times 10}}
$$

This prevents excessive concentration in a single asset.

## Perp Margin Components

### Base Margin Requirements

Each perp market defines base margin ratios:

```typescript
// From PerpMarketAccount
marginRatioInitial: number;        // e.g., 500 = 5% = 20x max leverage
marginRatioMaintenance: number;    // e.g., 250 = 2.5% = 40x maintenance
imfFactor: number;                 // Size scaling factor

```

### Oracle Price for Margin

Perp positions are valued with a conservative oracle price:

```typescript
export function calculateOraclePriceForPerpMargin(
  perpPosition: PerpPosition,
  market: PerpMarketAccount,
  oraclePriceData: OraclePriceData
): BN

```

For Long Positions:

$$
marginPrice = oraclePrice - priceOffset
$$

For Short Positions:

$$
marginPrice = oraclePrice + priceOffset
$$

Where:

$$
priceOffset = \min(maxSpread \times oraclePrice, confidence + baseSpread \times oraclePrice)
$$

This provides a buffer against adverse price movements.

### Worst-Case Position Size

Open orders are considered in margin calculations:

```typescript
export function calculateWorstCaseBaseAssetAmount(
  perpPosition: PerpPosition,
  perpMarket: PerpMarketAccount,
  oraclePrice: BN
): BN

```

Considers:

- Current position
- All open bids (could increase position)
- All open asks (could decrease position)

Returns the scenario with maximum liability value.

### Unrealized PnL Weights

Unrealized perp PnL contributes to margin with haircuts:

Positive PnL (Asset):

```typescript
// From PerpMarketAccount
unrealizedPnlInitialAssetWeight: number;      // e.g., 8000 = 80%
unrealizedPnlMaintenanceAssetWeight: number;  // e.g., 9000 = 90%

```

Negative PnL (Liability):

Counted at full value (100% liability weight) or with IMF scaling:

$$
liabilityWeight = 1.0 + unrealizedPnlImfFactor \times \sqrt{|pnl| \times 10}
$$

This prevents users from over-leveraging based on unrealized gains.

### PnL Pool Limits

Positive unrealized PnL is capped by available PnL pool:

```typescript
const maxPnlAsset = min(
  unrealizedPnl,
  pnlPool.balance + settleablePnl
);

```

This ensures PnL can actually be settled.

## Spot Margin Components

### Asset Weights

Each spot market has asset weights for deposits:

```typescript
// From SpotMarketAccount
initialAssetWeight: number;        // e.g., 8000 = 80%
maintenanceAssetWeight: number;    // e.g., 9000 = 90%

```

Example: $100 of SOL with 80% initial weight = $80 of buying power.

### Liability Weights

Borrows have liability weights:

```typescript
// From SpotMarketAccount
initialLiabilityWeight: number;        // e.g., 12000 = 120%
maintenanceLiabilityWeight: number;    // e.g., 11000 = 110%

```

Example: $100 borrowed requires $120 of initial margin.

### Strict Oracle Prices

Spot margin uses strict oracle prices with confidence intervals:

```typescript
// For assets (deposits)
strictPrice = oraclePrice - confidence

// For liabilities (borrows)
strictPrice = oraclePrice + confidence

```

This provides additional safety margins.

## Isolated Position Margin

Isolated positions have separate margin calculations:

```typescript
// From PerpPosition
isolatedPositionScaledBalance: BN;  // Dedicated collateral (scaled)
positionFlag: number;                // Has IsolatedPosition flag

```

### Isolated Margin Calculation

```typescript
isolatedCollateral = getTokenAmount(
  isolatedPositionScaledBalance,
  quoteSpotMarket
);

isolatedMarginRequirement = 
  positionSize * oraclePrice * marginRatio;

if (isolatedCollateral < isolatedMarginRequirement) {
  // Isolated position can be liquidated
}

```

Isolated positions:

- Use only their dedicated collateral
- Don't affect cross-margin positions
- Are liquidated independently
- Cannot cross-collateralize

Isolated positions are ideal for high-risk trades where you want to limit downside to the allocated collateral.

## Open Order Margin

Open orders reserve margin:

```typescript
openOrderMargin = 
  openBids * price * marginRatio +
  openAsks * price * marginRatio;

```

This ensures margin is available if orders fill.

### Open Order Treatment

- Reduce-only orders: Don't require additional margin
- Risk-increasing orders: Require margin for worst-case scenario
- Trigger orders: Require margin as if already filled

## High Leverage Mode

Users can enable high leverage mode for lower margin requirements:

```typescript
export type HighLeverageModeConfig = {
  maxUsers: number;        // Cap on users in HLM
  currentUsers: number;    // Current users in HLM
  reduceOnly: boolean;     // Whether HLM is reduce-only
};

```

In high leverage mode:

- Lower initial and maintenance margin ratios
- Limited to specific markets
- May have user caps
- Higher risk of liquidation

High leverage mode is risky and can lead to rapid liquidation in volatile markets. Use with caution.

## Margin Trading Toggle

Users can disable margin trading:

```typescript
// From User account
isMarginTradingEnabled: boolean;

```

When disabled:

- Cannot open leveraged positions
- Cannot borrow from spot markets
- Can only trade with existing deposits
- Useful for preventing accidental leverage

## Custom Margin Ratios

Users can set custom max margin ratios:

```typescript
// From User account
maxMarginRatio: number;  // Custom cap on leverage

// From PerpPosition
maxMarginRatio: number;  // Per-position override

```

Allows users to voluntarily limit leverage below market maximums.

## Margin Calculation Example

Let's calculate margin for a user with:

- 1000 USDC deposited (initial asset weight: 100%)
- Long 10 SOL-PERP at $100 (initial margin: 10%, maintenance: 5%)
- 500 USDC borrowed (initial liability weight: 105%)

Total Collateral (Initial):

$$
collateral = 1000 \times 1.0 = \$1000
$$

Margin Requirement (Initial):

$$
perp = 10 \times 100 \times 0.10 = \$100
$$

$$
borrow = 500 \times 1.05 = \$525
$$

$$
total = 100 + 525 = \$625
$$

Free Collateral:

$$
free = 1000 - 625 = \$375
$$

The user can open additional positions worth ~$375 in margin requirement.

Liquidation Threshold (Maintenance):

$$
maint = (10 \times 100 \times 0.05) + (500 \times 1.025) = 50 + 512.5 = \$562.5
$$

If total collateral falls below $562.5, the user can be liquidated.

## Next Steps

## Liquidations

Understand the liquidation process

## Positions

Learn about position management

## Markets

Review margin requirements per market

## SDK Guide

Calculate margin in your application
