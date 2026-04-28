# Account Model – Drift Protocol
URL: https://docs.drift.trade/developers/concepts/account-model

# Account Model

The Drift protocol is a Solana program (smart contract) that manages user accounts, positions, orders, and markets. Understanding the onchain data model helps you work effectively with any Drift SDK (TypeScript, Python, Rust) and understand how state updates propagate.

## Core accounts

### State account

Single global account holding protocol-wide configuration:

- Oracle guards - Stale price thresholds and validity checks
- Fee structures - Separate fee tiers for perpetual and spot markets
- Sequencer settings - Transaction ordering parameters
- Admin controls - Protocol admin addresses and permissions
- Emergency flags - Circuit breakers and pause mechanisms

The State account is a singleton, there's only one per deployment.

```typescript
interface State {
  admin: PublicKey;
  whitelistMint: PublicKey;
  discountMint: PublicKey;
  signer: PublicKey;
  srmVault: PublicKey;
  perpFeeStructure: FeeStructure;
  spotFeeStructure: FeeStructure;
  oracleGuardRails: OracleGuardRails;
  numberOfAuthorities: BN;
  numberOfSubAccounts: BN;
  lpCooldownTime: BN;
  liquidationMarginBufferRatio: number;
  settlementDuration: number;
  numberOfMarkets: number;
  numberOfSpotMarkets: number;
  signerNonce: number;
  minPerpAuctionDuration: number;
  defaultMarketOrderTimeInForce: number;
  defaultSpotAuctionDuration: number;
  exchangeStatus: number;
  liquidationDuration: number;
  initialPctToLiquidate: number;
}
```

### Market accounts

PerpMarketAccount (One per perp market) — manages perpetual futures markets with AMM state, funding rates, oracle integration, fee config, risk parameters (margin ratios, OI limits, contract tier), and market status.

```typescript
interface PerpMarketAccount {
  pubkey: PublicKey;
  marketIndex: number;
  amm: AMM;
  pnlPool: PoolBalance;
  name: number[];
  insuranceClaim: InsuranceClaim;
  unrealizedPnlMaxImbalance: BN;
  expiryTs: BN;
  expiryPrice: BN;
  imfFactor: number;
  unrealizedPnlImfFactor: number;
  liquidatorFee: number;
  ifLiquidationFee: number;
  marginRatioInitial: number;
  marginRatioMaintenance: number;
  unrealizedPnlInitialAssetWeight: number;
  unrealizedPnlMaintenanceAssetWeight: number;
  numberOfUsersWithBase: number;
  numberOfUsers: number;
  status: MarketStatus;
  contractTier: ContractTier;
  contractType: ContractType;
  pausedOperations: number;
}
```

SpotMarketAccount (One per spot market) — manages spot markets and lending pools with interest rates, utilization tracking, insurance fund stake, oracle integration, deposit/borrow limits, and asset weights.

```typescript
interface SpotMarketAccount {
  pubkey: PublicKey;
  oracle: PublicKey;
  mint: PublicKey;
  vault: PublicKey;
  insuranceFund: InsuranceFund;
  depositBalance: BN;
  borrowBalance: BN;
  cumulativeDepositInterest: BN;
  cumulativeBorrowInterest: BN;
  totalSocialLoss: BN;
  withdrawGuardThreshold: BN;
  maxTokenDeposits: BN;
  optimalUtilization: number;
  optimalBorrowRate: number;
  maxBorrowRate: number;
  initialAssetWeight: number;
  maintenanceAssetWeight: number;
  initialLiabilityWeight: number;
  maintenanceLiabilityWeight: number;
  imfFactor: number;
  liquidatorFee: number;
  ifLiquidationFee: number;
  oracleSource: OracleSource;
  status: MarketStatus;
  assetTier: AssetTier;
}
```

Markets are identified by numeric indices (market 0, market 1, etc.).

### User accounts

UserAccount — holds all trading state for a specific subaccount. Stores perp positions, spot positions, open orders (up to 32), margin settings, permissions.

```typescript
interface UserAccount {
  authority: PublicKey;
  delegate: PublicKey;
  name: number[];
  spotPositions: SpotPosition[];
  perpPositions: PerpPosition[];
  orders: Order[];
  totalDeposits: BN;
  totalWithdraws: BN;
  totalSocialLoss: BN;
  settledPerpPnl: BN;
  cumulativeSpotFees: BN;
  cumulativePerpFunding: BN;
  liquidationMarginFreed: BN;
  lastActiveSlot: BN;
  subAccountId: number;
  status: number;
  isMarginTradingEnabled: boolean;
  idle: boolean;
  openOrders: number;
}
```

UserStatsAccount — tracks aggregated stats across all subaccounts (fees, volume metrics 30d rolling, referral data, fuel points).

```typescript
interface UserStatsAccount {
  authority: PublicKey;
  referrer: PublicKey;
  fees: UserFees;
  nextEpochTs: BN;
  makerVolume30d: BN;
  takerVolume30d: BN;
  fillerVolume30d: BN;
  ifStakedQuoteAssetAmount: BN;
  numberOfSubAccounts: number;
  numberOfSubAccountsCreated: number;
  isReferrer: boolean;
  fuel: Fuel;
}
```

Users are PDAs derived from: `[authority, subaccount_id]`.

### Order accounting

Orders are stored directly in the UserAccount, not as separate accounts. Each order contains: market identification, order parameters (type/direction/base amount/price), order IDs, execution flags (post-only/reduce-only/IOC), JIT auction settings.

```typescript
interface Order {
  slot: BN;
  price: BN;
  baseAssetAmount: BN;
  baseAssetAmountFilled: BN;
  quoteAssetAmountFilled: BN;
  triggerPrice: BN;
  auctionStartPrice: BN;
  auctionEndPrice: BN;
  maxTs: BN;
  oraclePriceOffset: number;
  orderId: number;
  marketIndex: number;
  status: OrderStatus;
  orderType: OrderType;
  marketType: MarketType;
  userOrderId: number;
  existingPositionDirection: PositionDirection;
  direction: PositionDirection;
  reduceOnly: boolean;
  postOnly: boolean;
  immediateOrCancel: boolean;
  triggerCondition: OrderTriggerCondition;
  auctionDuration: number;
}
```

## PDAs (Program Derived Addresses)

```
User PDA: [b"user", authority.key(), subaccount_id as bytes]
UserStats PDA: [b"user_stats", authority.key()]
PerpMarket PDA: [b"perp_market", market_index as bytes]
SpotMarket PDA: [b"spot_market", market_index as bytes]
```

## Account relationships

```
State (1)
  ├── PerpMarket[0..N]
  ├── SpotMarket[0..M]
  └── Insurance Fund

Wallet
  ├── UserStats (1 per wallet)
  └── UserAccount[0..N] (subaccounts)
        ├── PerpPosition[0..N]
        ├── SpotPosition[0..M]
        └── Order[0..32]
```

## How instructions modify state

When you call an instruction (e.g., `placePerpOrder`), the program:

1. Loads accounts passed in the instruction
2. Validates account ownership and PDAs
3. Loads oracle price data
4. Applies protocol rules from State account
5. Updates UserAccount (adds order, updates positions, etc.)
6. Updates market state if needed (AMM, funding, etc.)
7. Emits event logs for offchain indexing

## Remaining accounts pattern

Many instructions use "remaining accounts" to dynamically pass oracle, market, and user accounts. This lets a single instruction handle variable market sets without requiring specific account slots.

Last updated on February 27, 2026
