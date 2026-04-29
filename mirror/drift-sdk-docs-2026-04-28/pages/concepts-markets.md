# Markets - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/markets

# Markets

> Understanding perpetual and spot markets in Drift Protocol

## Market Types

Drift Protocol supports two primary market types, each with distinct characteristics and use cases.

```typescript
export class MarketType {
  static readonly SPOT = { spot: {} };
  static readonly PERP = { perp: {} };
}

```

## Perpetual Markets

Perpetual futures are derivative contracts that track the price of an underlying asset without an expiration date.

### Perpetual Market Account

Each perp market maintains extensive state:

```typescript
export type PerpMarketAccount = {
  status: MarketStatus;
  contractType: ContractType;
  contractTier: ContractTier;
  expiryTs: BN;
  expiryPrice: BN;
  marketIndex: number;
  pubkey: PublicKey;
  name: number[];
  amm: AMM;
  numberOfUsersWithBase: number;
  numberOfUsers: number;
  marginRatioInitial: number;        // Initial margin requirement
  marginRatioMaintenance: number;    // Maintenance margin requirement
  nextFillRecordId: BN;
  nextFundingRateRecordId: BN;
  nextCurveRecordId: BN;
  pnlPool: PoolBalance;
  liquidatorFee: number;
  ifLiquidationFee: number;
  imfFactor: number;                 // Initial margin fraction factor
  unrealizedPnlImfFactor: number;
  unrealizedPnlMaxImbalance: BN;
  unrealizedPnlInitialAssetWeight: number;
  unrealizedPnlMaintenanceAssetWeight: number;
  // ... additional fields
};

```

### Contract Types

Drift supports multiple contract types:

```typescript
export class ContractType {
  static readonly PERPETUAL = { perpetual: {} };  // Standard perpetuals
  static readonly FUTURE = { future: {} };        // Expiring futures
  static readonly PREDICTION = { prediction: {} }; // Binary outcome markets
}

```

Perpetual contracts are the most common and have no expiration. Future contracts settle at a specific expiry time. Prediction markets are binary contracts that settle to 0 or 1.

### AMM Mechanism

The AMM uses a virtual constant product market maker with dynamic repegging:

Constant Product Formula:

$$
k = baseReserves \times quoteReserves
$$

Price Calculation:

$$
price = \frac{quoteReserves}{baseReserves} \times pegMultiplier
$$

The `pegMultiplier` is adjusted periodically to keep the AMM price close to the oracle price, using protocol fees to cover the cost of repegging.

### Funding Rates

Funding rates incentivize the perpetual price to track the oracle (spot) price:

- Positive funding: Longs pay shorts (when mark > oracle)
- Negative funding: Shorts pay longs (when mark < oracle)
- Payment interval: Typically every hour
- Rate calculation: Based on the gap between mark and oracle TWAPs

```typescript
export type FundingRateRecord = {
  ts: BN;
  recordId: BN;
  marketIndex: number;
  fundingRate: BN;
  fundingRateLong: BN;
  fundingRateShort: BN;
  cumulativeFundingRateLong: BN;
  cumulativeFundingRateShort: BN;
  oraclePriceTwap: BN;
  markPriceTwap: BN;
  periodRevenue: BN;
  baseAssetAmountWithAmm: BN;
  baseAssetAmountWithUnsettledLp: BN;
};

```

### Margin Requirements

Perp markets have tiered margin requirements based on size:

Initial Margin Ratio: Required to open new positions

$$
marginRatioInitial + imfFactor \times \sqrt{size \times 10}
$$

Maintenance Margin Ratio: Required to keep positions open

$$
marginRatioMaintenance + imfFactor \times \sqrt{size \times 10}
$$

Larger positions have higher margin requirements due to the IMF (Initial Margin Fraction) factor, which applies size-based scaling.

## Spot Markets

Spot markets enable trading, lending, and borrowing of assets on a cross-collateralized basis.

### Spot Market Account

```typescript
export type SpotMarketAccount = {
  status: MarketStatus;
  assetTier: AssetTier;
  name: number[];
  marketIndex: number;
  pubkey: PublicKey;
  mint: PublicKey;
  vault: PublicKey;
  oracle: PublicKey;
  oracleSource: OracleSource;
  historicalOracleData: HistoricalOracleData;
  historicalIndexData: HistoricalIndexData;
  insuranceFund: { /* insurance fund config */ };
  revenuePool: PoolBalance;
  ifLiquidationFee: number;
  decimals: number;
  optimalUtilization: number;        // Target utilization rate
  optimalBorrowRate: number;         // Borrow rate at optimal util
  maxBorrowRate: number;             // Max borrow rate
  cumulativeDepositInterest: BN;     // Cumulative deposit APY
  cumulativeBorrowInterest: BN;      // Cumulative borrow APY
  totalSocialLoss: BN;
  totalQuoteSocialLoss: BN;
  depositBalance: BN;                // Total scaled deposits
  borrowBalance: BN;                 // Total scaled borrows
  maxTokenDeposits: BN;              // Deposit cap
  initialAssetWeight: number;        // Collateral weight (initial)
  maintenanceAssetWeight: number;    // Collateral weight (maint)
  initialLiabilityWeight: number;    // Borrow weight (initial)
  maintenanceLiabilityWeight: number; // Borrow weight (maint)
  liquidatorFee: number;
  imfFactor: number;
  // ... additional fields
};

```

### Asset Tiers

Spot markets are categorized by asset quality:

```typescript
export class AssetTier {
  static readonly COLLATERAL = { collateral: {} };  // Full collateral weight
  static readonly PROTECTED = { protected: {} };     // Protected from borrows
  static readonly CROSS = { cross: {} };             // Cross-margin only
  static readonly ISOLATED = { isolated: {} };       // Isolated only
  static readonly UNLISTED = { unlisted: {} };       // Not tradeable
}

```

### Interest Rate Model

Spot markets use a utilization-based interest rate curve:

Utilization:

$$
utilization = \frac{totalBorrows}{totalDeposits}
$$

Borrow Rate (when util ≤ optimal):

$$
borrowRate = optimalBorrowRate \times \frac{utilization}{optimalUtilization}
$$

Borrow Rate (when util > optimal):

$$
borrowRate = optimalBorrowRate + (maxBorrowRate - optimalBorrowRate) \times \frac{utilization - optimalUtilization}{1 - optimalUtilization}
$$

Deposit Rate:

$$
depositRate = borrowRate \times utilization \times (1 - protocolFee)
$$

### Scaled Balances

Spot positions use a scaled balance system for efficient interest accrual:

```typescript
export type SpotPosition = {
  marketIndex: number;
  balanceType: SpotBalanceType;
  scaledBalance: BN;           // Balance in scaled units
  openOrders: number;
  openBids: BN;
  openAsks: BN;
  cumulativeDeposits: BN;
};

export class SpotBalanceType {
  static readonly DEPOSIT = { deposit: {} };
  static readonly BORROW = { borrow: {} };
}

```

Token Amount Calculation:

$$
tokenAmount = \frac{scaledBalance \times cumulativeInterest}{10^{9}}
$$

This allows all users' balances to accrue interest without individual updates.

### Collateral Weights

Asset and liability weights determine how much collateral value each asset provides:

- Initial Asset Weight (e.g., 0.8 = 80%): Collateral value for opening positions
- Maintenance Asset Weight (e.g., 0.9 = 90%): Collateral value for maintaining positions
- Initial Liability Weight (e.g., 1.2 = 120%): Borrow weight for opening positions
- Maintenance Liability Weight (e.g., 1.1 = 110%): Borrow weight for maintaining positions

Higher quality assets (like USDC) have weights closer to 1.0, while volatile assets have more conservative weights.

## Market Operations

### Paused Operations

Both perp and spot markets support granular operation pausing:

```typescript
export enum PerpOperation {
  UPDATE_FUNDING = 1,
  AMM_FILL = 2,
  FILL = 4,
  SETTLE_PNL = 8,
  SETTLE_PNL_WITH_POSITION = 16,
  LIQUIDATION = 32,
  SETTLE_REV_POOL = 64,
}

export enum SpotOperation {
  UPDATE_CUMULATIVE_INTEREST = 1,
  FILL = 2,
  DEPOSIT = 4,
  WITHDRAW = 8,
  LIQUIDATION = 16,
}

```

Admins can pause specific operations while keeping other functionality active.

## Market Data

### Historical Oracle Data

Markets track oracle price history for various purposes:

```typescript
export type HistoricalOracleData = {
  lastOraclePrice: BN;
  lastOracleDelay: BN;
  lastOracleConf: BN;
  lastOraclePriceTwap: BN;
  lastOraclePriceTwap5Min: BN;
  lastOraclePriceTwapTs: BN;
};

```

TWAPs (Time-Weighted Average Prices) are used for funding rate calculations and as a manipulation-resistant price source.

## Next Steps

## Positions

Learn how to manage positions in these markets

## Oracles

Understand oracle integrations and price feeds

## Margin System

Deep dive into margin calculations

## Orders

Explore order types and execution
