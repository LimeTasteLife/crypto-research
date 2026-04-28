# Protocol Overview
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/overview

# Protocol Overview

Drift Protocol v2 is a fully on-chain decentralized exchange on Solana offering perpetual futures and spot trading with up to 20x leverage. Combines an AMM with a CLOB for liquidity and price discovery.

## Core Architecture

Modules: State Management, Market Operations, Risk Engine, Oracle Integration.

### Account Types

- State Account: global protocol configuration
- Market Accounts: per-market config (perp + spot)
- User Accounts: positions, orders, margin
- User Stats: aggregate stats for fee tiers, referrals, volume

### State Account Structure

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
  perpFeeStructure: FeeStructure;
  spotFeeStructure: FeeStructure;
  lpCooldownTime: BN;
  initialPctToLiquidate: number;
  liquidationDuration: number;
  maxInitializeUserFee: number;
  featureBitFlags: number;
};
```

## Market Types

### Perpetual Markets

No expiration; funding payments between longs and shorts to keep mark close to oracle. Up to 20x leverage. AMM + CLOB hybrid.

### Spot Markets

Borrow and lend, cross-collateral, dynamic interest rates based on utilization, atomic swaps. Use scaled balance system with cumulative interest tracking.

## Market Status

```typescript
class MarketStatus {
  static readonly INITIALIZED;
  static readonly ACTIVE;
  static readonly FUNDING_PAUSED;
  static readonly AMM_PAUSED;
  static readonly FILL_PAUSED;
  static readonly WITHDRAW_PAUSED;
  static readonly REDUCE_ONLY;
  static readonly SETTLEMENT;
  static readonly DELISTED;
}
```

## Contract Tiers

```typescript
class ContractTier {
  static readonly A;                  // Highest insurance coverage
  static readonly B;                  // Medium
  static readonly C;                  // Lower
  static readonly SPECULATIVE;        // No insurance
  static readonly HIGHLY_SPECULATIVE; // No insurance
  static readonly ISOLATED;           // Isolated margin only
}
```

## AMM Design

Virtual AMM (vAMM) with virtual reserves of base and quote assets, constant product formula with repegging, peg multiplier tracking oracle prices, concentrated liquidity, PnL pool for socialized P&L.

```typescript
type AMM = {
  baseAssetReserve: BN;
  quoteAssetReserve: BN;
  sqrtK: BN;
  pegMultiplier: BN;
  cumulativeFundingRate: BN;
  oracle: PublicKey;
  oracleSource: OracleSource;
  baseAssetAmountWithAmm: BN;
  baseAssetAmountLong: BN;
  baseAssetAmountShort: BN;
};
```

## Exchange Status

```typescript
enum ExchangeStatus {
  ACTIVE = 0,
  DEPOSIT_PAUSED = 1,
  WITHDRAW_PAUSED = 2,
  AMM_PAUSED = 4,
  FILL_PAUSED = 8,
  LIQ_PAUSED = 16,
  FUNDING_PAUSED = 32,
  SETTLE_PNL_PAUSED = 64,
  AMM_IMMEDIATE_FILL_PAUSED = 128,
  PAUSED = 255,
}
```

## Key Features

- Cross-Margin by Default
- Sub-Accounts (up to 1000)
- Decentralized Keepers (permissionless bots for liquidations, funding, fills)
- Insurance Fund (protocol-owned backstop)
