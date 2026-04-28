# Market Accounts
URL: https://mintlify.com/drift-labs/protocol-v2/program/state/market-accounts

# Market Accounts

## PerpMarketAccount

```typescript
type PerpMarketAccount = {
  status: MarketStatus;
  contractType: ContractType;
  contractTier: ContractTier;
  expiryTs: BN;
  expiryPrice: BN;
  marketIndex: number;
  pubkey: PublicKey;
  name: number[];
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
  numberOfUsersWithBase: number;
  numberOfUsers: number;
};
```

PDA: `["perp_market", marketIndex]`

Read via `driftClient.getPerpMarketAccount(marketIndex)` or `getPerpMarketAccounts()`.

## SpotMarketAccount

```typescript
type SpotMarketAccount = {
  status: MarketStatus;
  assetTier: AssetTier;
  marketIndex: number;
  pubkey: PublicKey;
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
  liquidatorFee: number;
  imfFactor: number;
};
```

PDA: `["spot_market", marketIndex]`

Read via `driftClient.getSpotMarketAccount(marketIndex)` or `getSpotMarketAccounts()`.
