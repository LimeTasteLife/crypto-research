# Protocol Overview

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/overview

> Architectural overview of Drift Protocol v2, a decentralized perpetuals and spot exchange on Solana

## Introduction

Drift Protocol v2 is a fully on-chain decentralized exchange (DEX) on Solana that offers perpetual futures and spot trading with up to 20x leverage. The protocol combines an Automated Market Maker (AMM) with a central limit order book (CLOB) to provide deep liquidity and efficient price discovery.

## Core Architecture

Drift's architecture consists of several key components that work together to enable decentralized trading:

### Program Structure

The protocol is implemented as a Solana program with the following core modules:

- State Management: Global state, market accounts, and user accounts
- Market Operations: Order matching, position management, and settlements
- Risk Engine: Margin calculations, liquidations, and risk parameters
- Oracle Integration: Price feeds from Pyth, Switchboard, and other sources

### Account Types

- State Account: Global protocol configuration including exchange status, fee structures, and admin settings
- Market Accounts: Per-market configuration for perpetual and spot markets, including AMM parameters
- User Accounts: Individual trading accounts holding positions, orders, and margin
- User Stats: Aggregate statistics for fee tiers, referrals, and trading volume

### State Account Structure

```typescript
export type StateAccount = {
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

## Market Types

Drift supports two primary market types:

### Perpetual Markets

Perpetual futures contracts that track the price of an underlying asset through funding rates. Key features:

- No expiration date: Positions can be held indefinitely
- Funding payments: Periodic payments between longs and shorts to keep mark price close to oracle price
- Up to 20x leverage: Depending on contract tier and position size
- AMM + CLOB hybrid: Combines automated market making with order book matching

### Spot Markets

Spot markets allow trading and borrowing of assets:

- Borrow and lend: Earn interest on deposits or borrow with collateral
- Cross-collateral: Use any whitelisted asset as collateral
- Interest rates: Dynamic rates based on utilization
- Swaps: Atomic swaps between spot assets

Spot markets use a scaled balance system with cumulative interest tracking to efficiently manage deposits and borrows across all users.

## Market Status

Markets can be in various states that control allowed operations:

```typescript
export class MarketStatus {
  static readonly INITIALIZED = { initialized: {} };
  static readonly ACTIVE = { active: {} };
  static readonly FUNDING_PAUSED = { fundingPaused: {} };
  static readonly AMM_PAUSED = { ammPaused: {} };
  static readonly FILL_PAUSED = { fillPaused: {} };
  static readonly WITHDRAW_PAUSED = { withdrawPaused: {} };
  static readonly REDUCE_ONLY = { reduceOnly: {} };
  static readonly SETTLEMENT = { settlement: {} };
  static readonly DELISTED = { delisted: {} };
}
```

## Contract Tiers

Perp markets are categorized by risk tiers that determine insurance coverage and margin requirements:

```typescript
export class ContractTier {
  static readonly A = { a: {} };              // Highest insurance coverage
  static readonly B = { b: {} };              // Medium insurance coverage
  static readonly C = { c: {} };              // Lower insurance coverage
  static readonly SPECULATIVE = { speculative: {} };           // No insurance
  static readonly HIGHLY_SPECULATIVE = { highlySpeculative: {} }; // No insurance
  static readonly ISOLATED = { isolated: {} }; // Isolated margin only
}
```

Isolated tier markets require isolated margin positions and cannot be used as cross-collateral.

## AMM Design

Drift uses a novel AMM design based on a virtual AMM (vAMM) that:

- Maintains virtual reserves of base and quote assets
- Uses a constant product formula with repegging capability
- Adjusts the peg multiplier to track oracle prices
- Concentrates liquidity around the current price
- Socializes profit and loss through the PnL pool

### AMM Structure

The AMM maintains several key parameters:

```typescript
export type AMM = {
  baseAssetReserve: BN;          // Virtual base reserves
  quoteAssetReserve: BN;         // Virtual quote reserves
  sqrtK: BN;                     // Sqrt of constant product
  pegMultiplier: BN;             // Price peg to oracle
  cumulativeFundingRate: BN;     // Cumulative funding
  oracle: PublicKey;             // Oracle address
  oracleSource: OracleSource;    // Oracle type
  baseAssetAmountWithAmm: BN;    // Net AMM position
  baseAssetAmountLong: BN;       // Total long positions
  baseAssetAmountShort: BN;      // Total short positions
  // ... additional fields
};
```

## Exchange Status

The protocol has various operational modes:

```typescript
export enum ExchangeStatus {
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

- Cross-Margin by Default: All positions and collateral are pooled by default, maximizing capital efficiency. Users can also opt for isolated margin on supported markets.
- Sub-Accounts: Each user can create multiple sub-accounts (up to 1000) to separate trading strategies or risk profiles.
- Decentralized Keepers: The protocol relies on permissionless keeper bots to trigger liquidations, settle funding, and fill orders.
- Insurance Fund: Protocol-owned insurance fund backstops losses from liquidations and bankruptcy events.
