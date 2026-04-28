# User Account
URL: https://mintlify.com/drift-labs/protocol-v2/program/state/user-account

# User Account

Per-subaccount state for trading.

```typescript
type UserAccount = {
  authority: PublicKey;
  delegate: PublicKey;
  name: number[];
  spotPositions: SpotPosition[];        // up to 8
  perpPositions: PerpPosition[];        // up to 8
  orders: Order[];                      // up to 32
  totalDeposits: BN;
  totalWithdraws: BN;
  totalSocialLoss: BN;
  settledPerpPnl: BN;
  cumulativeSpotFees: BN;
  cumulativePerpFunding: BN;
  liquidationMarginFreed: BN;
  lastActiveSlot: BN;
  subAccountId: number;
  status: number;        // bit-flag UserStatus
  isMarginTradingEnabled: boolean;
  idle: boolean;
  openOrders: number;
  hasOpenOrder: boolean;
  openAuctions: number;
  hasOpenAuction: boolean;
  poolId: number;
  maxMarginRatio: number;
  marginMode: MarginMode;
};
```

PDA: `["user", authority, subAccountId]`

## UserStatsAccount

```typescript
type UserStatsAccount = {
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
};
```

PDA: `["user_stats", authority]`
