# State Account
URL: https://mintlify.com/drift-labs/protocol-v2/program/state/state-account

# State Account

Singleton account holding protocol-wide configuration.

```typescript
type StateAccount = {
  admin: PublicKey;
  exchangeStatus: number;
  whitelistMint: PublicKey;
  discountMint: PublicKey;
  oracleGuardRails: OracleGuardRails;
  numberOfAuthorities: BN;
  numberOfSubAccounts: BN;
  numberOfMarkets: number;
  numberOfSpotMarkets: number;
  minPerpAuctionDuration: number;
  defaultMarketOrderTimeInForce: number;
  defaultSpotAuctionDuration: number;
  liquidationMarginBufferRatio: number;
  settlementDuration: number;
  maxNumberOfSubAccounts: number;
  signer: PublicKey;
  signerNonce: number;
  srmVault: PublicKey;
  perpFeeStructure: FeeStructure;
  spotFeeStructure: FeeStructure;
  lpCooldownTime: BN;
  initialPctToLiquidate: number;
  liquidationDuration: number;
  maxInitializeUserFee: number;
  featureBitFlags: number;
};
```

Read via `driftClient.getStateAccount()`.
