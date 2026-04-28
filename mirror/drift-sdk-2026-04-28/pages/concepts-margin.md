# Margin System
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/margin

# Margin System

## Margin Modes

```typescript
class MarginMode {
  static readonly DEFAULT;
  static readonly HIGH_LEVERAGE;
  static readonly HIGH_LEVERAGE_MAINTENANCE;
}
```

### Cross-Margin (Default)

All deposits act as collateral for all positions. Unrealized PnL contributes to margin (with haircuts). Most capital efficient.

### Isolated Margin (v2.154.0+)

Only available for ISOLATED tier markets. Separate collateral pool per isolated position. No cross-contamination.

## Margin Calculation

### Total Collateral

`totalCollateral = sum(deposits * price * assetWeight) + sum(perpPnL * pnlAssetWeight)`

### Margin Requirement

`marginRequirement = sum(perpPositions * price * marginRatio) + sum(borrows * price * liabilityWeight)`

### Initial vs Maintenance

- Initial: opening/increasing positions
- Maintenance: avoid liquidation

### Health Check

```typescript
if (totalCollateral < marginRequirement) {
  // Liquidatable (maintenance) or cannot open new positions (initial)
}
```

## Size-Based Margin Scaling (IMF)

`marginRatio = baseMarginRatio + imfFactor * sqrt(size * 10)`

`liabilityWeight_effective = liabilityWeight + imfFactor * sqrt(borrowSize * 10)`

`assetWeight_effective = (1.1 * assetWeight) / (1 + imfFactor * sqrt(size * 10))`

## Perp Margin Components

```typescript
marginRatioInitial: number;     // e.g., 500 = 5% = 20x
marginRatioMaintenance: number; // e.g., 250 = 2.5% = 40x
imfFactor: number;
```

### Oracle Price for Margin (conservative)

For Long: `marginPrice = oraclePrice - offset`
For Short: `marginPrice = oraclePrice + offset`
`offset = min(maxSpread * oraclePrice, confidence + baseSpread * oraclePrice)`

### Worst-Case Position Size

Considers current position + all open bids + all open asks; returns scenario with maximum liability.

### Unrealized PnL Weights

Positive PnL (asset): unrealizedPnlInitialAssetWeight (e.g., 80%), Maintenance (e.g., 90%).
Negative PnL (liability): full or `1.0 + unrealizedPnlImfFactor * sqrt(|pnl| * 10)`.

### PnL Pool Limits

`maxPnlAsset = min(unrealizedPnl, pnlPool.balance + settleablePnl)`

## Spot Margin Components

```typescript
initialAssetWeight: number;     // e.g., 8000 = 80%
maintenanceAssetWeight: number; // e.g., 9000 = 90%
initialLiabilityWeight: number;     // e.g., 12000 = 120%
maintenanceLiabilityWeight: number; // e.g., 11000 = 110%
```

### Strict Oracle Prices

Asset: `strictPrice = oraclePrice - confidence`
Liability: `strictPrice = oraclePrice + confidence`

## Isolated Position Margin

```typescript
isolatedCollateral = getTokenAmount(isolatedPositionScaledBalance, quoteSpotMarket);
isolatedMarginRequirement = positionSize * oraclePrice * marginRatio;

if (isolatedCollateral < isolatedMarginRequirement) {
  // Liquidate isolated position only
}
```

Constraints: only dedicated collateral; doesn't affect cross-margin; liquidated independently.

## Open Order Margin

`openOrderMargin = openBids * price * marginRatio + openAsks * price * marginRatio`

- Reduce-only orders: no additional margin
- Risk-increasing: worst-case margin
- Trigger orders: as if filled

## High Leverage Mode

```typescript
type HighLeverageModeConfig = {
  maxUsers: number;
  currentUsers: number;
  reduceOnly: boolean;
};
```

Lower margin ratios; limited markets; user caps possible.

## Margin Trading Toggle

`isMarginTradingEnabled: boolean` — when disabled: no leveraged positions, no spot borrowing.

## Custom Margin Ratios

`maxMarginRatio: number` (per user and per perp position).

## Example

User with 1000 USDC deposit, long 10 SOL-PERP at $100 (initial 10%), 500 USDC borrowed (initial 105%):

- Total collateral: $1000
- Perp margin: 10 * 100 * 0.10 = $100
- Borrow margin: 500 * 1.05 = $525
- Total margin requirement: $625
- Free collateral: $1000 - $625 = $375

Maintenance threshold: 10 * 100 * 0.05 + 500 * 1.025 = $562.5. Below this -> liquidation.
