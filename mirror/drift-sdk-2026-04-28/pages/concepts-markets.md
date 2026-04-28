# Markets
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/markets

# Markets

Drift Protocol supports two primary market types: perpetuals and spot.

```typescript
class MarketType {
  static readonly SPOT;
  static readonly PERP;
}
```

## Perpetual Markets

```typescript
type PerpMarketAccount = {
  status: MarketStatus;
  contractType: ContractType;
  contractTier: ContractTier;
  expiryTs: BN;
  expiryPrice: BN;
  marketIndex: number;
  pubkey: PublicKey;
  amm: AMM;
  marginRatioInitial: number;
  marginRatioMaintenance: number;
  pnlPool: PoolBalance;
  liquidatorFee: number;
  ifLiquidationFee: number;
  imfFactor: number;
  unrealizedPnlImfFactor: number;
  unrealizedPnlMaxImbalance: BN;
  unrealizedPnlInitialAssetWeight: number;
  unrealizedPnlMaintenanceAssetWeight: number;
};
```

### Contract Types

```typescript
class ContractType {
  static readonly PERPETUAL;
  static readonly FUTURE;
  static readonly PREDICTION;
}
```

### AMM Mechanism

Virtual constant-product market maker with dynamic repegging:

- Constant product: k = baseReserves * quoteReserves
- Price: price = (quoteReserves / baseReserves) * pegMultiplier
- pegMultiplier adjusted to track oracle price

### Funding Rates

- Positive: longs pay shorts (when mark > oracle)
- Negative: shorts pay longs (when mark < oracle)
- Hourly typically; based on mark vs oracle TWAPs

### Margin Requirements

Initial margin: marginRatioInitial + imfFactor * sqrt(size * 10)
Maintenance margin: marginRatioMaintenance + imfFactor * sqrt(size * 10)

## Spot Markets

```typescript
type SpotMarketAccount = {
  status: MarketStatus;
  assetTier: AssetTier;
  marketIndex: number;
  mint: PublicKey;
  vault: PublicKey;
  oracle: PublicKey;
  oracleSource: OracleSource;
  insuranceFund: { /* config */ };
  decimals: number;
  optimalUtilization: number;
  optimalBorrowRate: number;
  maxBorrowRate: number;
  cumulativeDepositInterest: BN;
  cumulativeBorrowInterest: BN;
  depositBalance: BN;
  borrowBalance: BN;
  maxTokenDeposits: BN;
  initialAssetWeight: number;
  maintenanceAssetWeight: number;
  initialLiabilityWeight: number;
  maintenanceLiabilityWeight: number;
};
```

### Asset Tiers

```typescript
class AssetTier {
  static readonly COLLATERAL;  // Full collateral weight
  static readonly PROTECTED;
  static readonly CROSS;
  static readonly ISOLATED;
  static readonly UNLISTED;
}
```

### Interest Rate Model

- Utilization = totalBorrows / totalDeposits
- Borrow rate (util <= optimal): optimalBorrowRate * (utilization / optimalUtilization)
- Borrow rate (util > optimal): optimalBorrowRate + (maxBorrowRate - optimalBorrowRate) * (utilization - optimalUtilization) / (1 - optimalUtilization)
- Deposit rate: borrowRate * utilization * (1 - protocolFee)

### Scaled Balances

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

class SpotBalanceType {
  static readonly DEPOSIT;
  static readonly BORROW;
}
```

Token amount = (scaledBalance * cumulativeInterest) / 10^9

### Collateral Weights

- Initial Asset Weight (e.g., 0.8 = 80%): collateral value for opening
- Maintenance Asset Weight (e.g., 0.9): for maintaining
- Initial Liability Weight (e.g., 1.2 = 120%): borrow weight for opening
- Maintenance Liability Weight (e.g., 1.1): for maintaining

## Market Operations

### Paused Operations

```typescript
enum PerpOperation {
  UPDATE_FUNDING = 1,
  AMM_FILL = 2,
  FILL = 4,
  SETTLE_PNL = 8,
  SETTLE_PNL_WITH_POSITION = 16,
  LIQUIDATION = 32,
  SETTLE_REV_POOL = 64,
}

enum SpotOperation {
  UPDATE_CUMULATIVE_INTEREST = 1,
  FILL = 2,
  DEPOSIT = 4,
  WITHDRAW = 8,
  LIQUIDATION = 16,
}
```

### Historical Oracle Data

```typescript
type HistoricalOracleData = {
  lastOraclePrice: BN;
  lastOracleDelay: BN;
  lastOracleConf: BN;
  lastOraclePriceTwap: BN;
  lastOraclePriceTwap5Min: BN;
  lastOraclePriceTwapTs: BN;
};
```
