# Quick Start - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/quickstart

# Quick Start

> Place your first trade on Drift Protocol in minutes

# Quick Start Guide

This guide will walk you through placing your first perpetual trade on Drift Protocol, from initialization to order execution.

This quickstart uses devnet for testing. No real funds are required!

## Overview

You'll learn how to:

1. Initialize the Drift SDK
2. Connect your wallet
3. Create a Drift user account
4. Deposit collateral (USDC)
5. Place a perpetual order
6. Monitor your position

## Complete Example

Here's a complete example that places a 1 SOL-PERP long order:

```typescript
import * as anchor from '@coral-xyz/anchor';
import { Connection, Keypair, PublicKey } from '@solana/web3.js';
import { getAssociatedTokenAddress } from '@solana/spl-token';
import {
  DriftClient,
  User,
  initialize,
  PositionDirection,
  convertToNumber,
  PRICE_PRECISION,
  QUOTE_PRECISION,
  BASE_PRECISION,
  Wallet,
  PerpMarkets,
  getMarketOrderParams,
  BulkAccountLoader,
  BN,
  calculateBidAskPrice,
} from '@drift-labs/sdk';

const main = async () => {
  // Step 1: Choose your environment
  const env = 'devnet';
  // const env = 'mainnet-beta'; // Uncomment for mainnet

  // Step 2: Initialize Drift SDK
  const sdkConfig = initialize({ env });
  console.log('Initialized Drift SDK for', env);

  // Step 3: Set up wallet and provider
  const rpcUrl = process.env.ANCHOR_PROVIDER_URL || 'https://api.devnet.solana.com';
  const connection = new Connection(rpcUrl, 'confirmed');
  
  // Load your wallet keypair
  const privateKey = JSON.parse(process.env.BOT_PRIVATE_KEY || '[]');
  const keypair = Keypair.fromSecretKey(Uint8Array.from(privateKey));
  const wallet = new Wallet(keypair);
  
  const provider = new anchor.AnchorProvider(
    connection,
    wallet,
    { preflightCommitment: 'confirmed', commitment: 'confirmed' }
  );

  // Step 4: Check SOL balance
  const lamportsBalance = await connection.getBalance(wallet.publicKey);
  console.log('Wallet:', wallet.publicKey.toString());
  console.log('SOL balance:', lamportsBalance / 10 ** 9);

  if (lamportsBalance < 0.1 * 10 ** 9) {
    throw new Error('Insufficient SOL balance. Need at least 0.1 SOL for fees.');
  }

  // Step 5: Initialize Drift Client
  const driftPublicKey = new PublicKey(sdkConfig.DRIFT_PROGRAM_ID);
  const bulkAccountLoader = new BulkAccountLoader(
    connection,
    'confirmed',
    1000
  );
  
  const driftClient = new DriftClient({
    connection,
    wallet,
    programID: driftPublicKey,
    accountSubscription: {
      type: 'polling',
      accountLoader: bulkAccountLoader,
    },
  });
  
  await driftClient.subscribe();
  console.log('✅ Connected to Drift Protocol');

  // Step 6: Set up User client
  const userPublicKey = await driftClient.getUserAccountPublicKey();
  const user = new User({
    driftClient,
    userAccountPublicKey: userPublicKey,
    accountSubscription: {
      type: 'polling',
      accountLoader: bulkAccountLoader,
    },
  });

  // Step 7: Check if user account exists
  const userAccountExists = await user.exists();

  if (!userAccountExists) {
    console.log('Creating Drift user account...');
    
    // Get USDC token address
    const usdcTokenAddress = await getAssociatedTokenAddress(
      new PublicKey(sdkConfig.USDC_MINT_ADDRESS),
      wallet.publicKey
    );

    // Deposit $10,000 USDC as collateral
    const depositAmount = new BN(10000).mul(QUOTE_PRECISION);
    
    console.log('Depositing', depositAmount.toString(), 'USDC (raw amount)...');
    
    await driftClient.initializeUserAccountAndDepositCollateral(
      depositAmount,
      usdcTokenAddress
    );
    
    console.log('✅ User account created and funded');
  } else {
    console.log('✅ User account already exists');
  }

  await user.subscribe();

  // Step 8: Get market information
  const solMarketInfo = PerpMarkets[env].find(
    (market) => market.baseAssetSymbol === 'SOL'
  );
  
  if (!solMarketInfo) {
    throw new Error('SOL-PERP market not found');
  }

  const marketIndex = solMarketInfo.marketIndex;
  console.log('\n📊 SOL-PERP Market (Index:', marketIndex + ')');

  // Step 9: Get current market price
  const perpMarketAccount = driftClient.getPerpMarketAccount(marketIndex);
  const oracleData = driftClient.getOracleDataForPerpMarket(marketIndex);
  
  const [bid, ask] = calculateBidAskPrice(
    perpMarketAccount.amm,
    oracleData
  );

  const formattedBidPrice = convertToNumber(bid, PRICE_PRECISION);
  const formattedAskPrice = convertToNumber(ask, PRICE_PRECISION);

  console.log('Current Bid:', '$' + formattedBidPrice.toFixed(2));
  console.log('Current Ask:', '$' + formattedAskPrice.toFixed(2));

  // Step 10: Place a market order
  console.log('\n🚀 Placing 1 SOL-PERP LONG order...');
  
  const orderParams = getMarketOrderParams({
    baseAssetAmount: new BN(1).mul(BASE_PRECISION), // 1 SOL
    direction: PositionDirection.LONG,
    marketIndex: marketIndex,
  });

  const txSig = await driftClient.placePerpOrder(orderParams);
  
  console.log('✅ Order placed successfully!');
  console.log('Transaction signature:', txSig);
  console.log('View on Solscan:', `https://solscan.io/tx/${txSig}?cluster=${env}`);

  // Step 11: Get position info
  await user.fetchAccounts();
  const position = user.getPerpPosition(marketIndex);
  
  if (position) {
    const baseAmount = convertToNumber(position.baseAssetAmount, BASE_PRECISION);
    const quoteAmount = convertToNumber(position.quoteAssetAmount, QUOTE_PRECISION);
    
    console.log('\n📈 Position Summary:');
    console.log('Base Asset Amount:', baseAmount.toFixed(4), 'SOL');
    console.log('Quote Asset Amount:', '$' + quoteAmount.toFixed(2));
  }

  console.log('\n✨ Trade complete!');
};

main()
  .catch(console.error)
  .finally(() => process.exit());

```

## Step-by-Step Breakdown

Let's break down each step in detail:

### 1. Initialize the SDK

```typescript
import { initialize } from '@drift-labs/sdk';

const sdkConfig = initialize({ env: 'devnet' });

```

The `initialize` function returns configuration for the specified environment:

- `DRIFT_PROGRAM_ID` - The Drift program address
- `USDC_MINT_ADDRESS` - The USDC token mint
- Market configurations and more

### 2. Set Up Connection and Wallet

```typescript
import { Connection, Keypair } from '@solana/web3.js';
import { Wallet } from '@drift-labs/sdk';

const connection = new Connection('https://api.devnet.solana.com', 'confirmed');
const privateKey = JSON.parse(process.env.BOT_PRIVATE_KEY || '[]');
const keypair = Keypair.fromSecretKey(Uint8Array.from(privateKey));
const wallet = new Wallet(keypair);

```

Keep your private key secure! Never hardcode it or commit it to version control.

### 3. Initialize Drift Client

```typescript
import { DriftClient, BulkAccountLoader } from '@drift-labs/sdk';

const bulkAccountLoader = new BulkAccountLoader(
  connection,
  'confirmed',
  1000 // poll interval in ms
);

const driftClient = new DriftClient({
  connection,
  wallet,
  programID: new PublicKey(sdkConfig.DRIFT_PROGRAM_ID),
  accountSubscription: {
    type: 'polling',
    accountLoader: bulkAccountLoader,
  },
});

await driftClient.subscribe();

```

The `DriftClient` is your main interface to the Drift Protocol.

## Account Subscription Types

Drift supports multiple subscription types:

- Polling: Regular interval updates (good for bots)
- Websocket: Real-time updates (good for UIs)
- gRPC: High-performance streaming (requires additional setup)

For most use cases, polling is sufficient and easiest to set up.

### 4. Create User Account

```typescript
import { User } from '@drift-labs/sdk';

const user = new User({
  driftClient,
  userAccountPublicKey: await driftClient.getUserAccountPublicKey(),
  accountSubscription: {
    type: 'polling',
    accountLoader: bulkAccountLoader,
  },
});

const exists = await user.exists();

if (!exists) {
  const depositAmount = new BN(10000).mul(QUOTE_PRECISION);
  await driftClient.initializeUserAccountAndDepositCollateral(
    depositAmount,
    usdcTokenAddress
  );
}

```

The first time you use Drift, you need to create a user account by depositing collateral.

### 5. Place an Order

```typescript
import { getMarketOrderParams, PositionDirection, BASE_PRECISION } from '@drift-labs/sdk';

const orderParams = getMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION), // 1 SOL
  direction: PositionDirection.LONG,
  marketIndex: 0, // SOL-PERP market index
});

const txSig = await driftClient.placePerpOrder(orderParams);

```

`BASE_PRECISION` is 10^9, so `new BN(1).mul(BASE_PRECISION)` equals 1 SOL

## Order Types

Drift supports multiple order types:

## Market Order

Execute immediately at the best available price:

```typescript
import { getMarketOrderParams } from '@drift-labs/sdk';

const params = getMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
});

await driftClient.placePerpOrder(params);

```

## Limit Order

Execute only at a specific price or better:

```typescript
import { getLimitOrderParams, PRICE_PRECISION } from '@drift-labs/sdk';

const params = getLimitOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
  price: new BN(100).mul(PRICE_PRECISION), // $100
});

await driftClient.placePerpOrder(params);

```

## Trigger Order

Execute when price reaches a trigger:

```typescript
import { getTriggerMarketOrderParams, OrderTriggerCondition } from '@drift-labs/sdk';

const params = getTriggerMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
  triggerPrice: new BN(105).mul(PRICE_PRECISION),
  triggerCondition: OrderTriggerCondition.ABOVE,
});

await driftClient.placePerpOrder(params);

```

## Working with Positions

After placing orders, monitor and manage your positions:

```typescript
import { convertToNumber, BASE_PRECISION, QUOTE_PRECISION } from '@drift-labs/sdk';

// Refresh user account data
await user.fetchAccounts();

// Get specific position
const position = user.getPerpPosition(marketIndex);

if (position) {
  const baseAmount = convertToNumber(position.baseAssetAmount, BASE_PRECISION);
  const quoteAmount = convertToNumber(position.quoteAssetAmount, QUOTE_PRECISION);
  
  console.log('Position size:', baseAmount, 'SOL');
  console.log('Entry value:', '$' + quoteAmount);
  
  // Calculate unrealized PnL
  const unrealizedPnL = user.getUnrealizedPNL(true, marketIndex);
  console.log('Unrealized PnL:', '$' + convertToNumber(unrealizedPnL, QUOTE_PRECISION));
}

// Get all positions
const allPositions = user.getActivePerpPositions();
console.log('Active positions:', allPositions.length);

```

## Closing Positions

To close a position, place an order in the opposite direction:

```typescript
// If you have a LONG position, place a SHORT order to close
const closeParams = getMarketOrderParams({
  baseAssetAmount: position.baseAssetAmount.abs(), // Use current position size
  direction: PositionDirection.SHORT, // Opposite of current position
  marketIndex: marketIndex,
  reduceOnly: true, // Important: prevents opening a new position
});

await driftClient.placePerpOrder(closeParams);

```

Always use `reduceOnly: true` when closing positions to avoid accidentally opening a new position in the opposite direction.

## Getting Market Data

Access real-time market information:

```typescript
import { calculateBidAskPrice, convertToNumber, PRICE_PRECISION } from '@drift-labs/sdk';

// Get market account
const marketAccount = driftClient.getPerpMarketAccount(marketIndex);

// Get oracle price data
const oracleData = driftClient.getOracleDataForPerpMarket(marketIndex);
const oraclePrice = convertToNumber(oracleData.price, PRICE_PRECISION);
console.log('Oracle price:', '$' + oraclePrice);

// Get bid/ask from AMM
const [bid, ask] = calculateBidAskPrice(marketAccount.amm, oracleData);
console.log('Bid:', '$' + convertToNumber(bid, PRICE_PRECISION));
console.log('Ask:', '$' + convertToNumber(ask, PRICE_PRECISION));

// Get funding rate
const fundingRate = convertToNumber(
  marketAccount.amm.lastFundingRate,
  PRICE_PRECISION
);
console.log('Funding rate:', fundingRate);

```

## Best Practices

## Always Use BigNum for Amounts

Never use regular JavaScript numbers for token amounts:

```typescript
// ❌ Wrong
const amount = 1.5;

// ✅ Correct
import { BN, BASE_PRECISION } from '@drift-labs/sdk';
const amount = new BN(1.5 * BASE_PRECISION.toNumber());

// ✅ Even better - avoid decimals entirely
const amount = new BN(15).mul(BASE_PRECISION).div(new BN(10));

```

## Handle Errors Gracefully

Wrap operations in try-catch blocks:

```typescript
try {
  const txSig = await driftClient.placePerpOrder(params);
  console.log('Success:', txSig);
} catch (error) {
  console.error('Order failed:', error);
  // Handle error appropriately
}

```

## Refresh Data Before Trading

Always fetch the latest account data:

```typescript
await user.fetchAccounts();
const freeCollateral = user.getFreeCollateral();
// Now use freeCollateral for risk checks

```

## Use Reduce-Only for Closing

Prevent accidentally opening opposite positions:

```typescript
const closeParams = getMarketOrderParams({
  baseAssetAmount: existingPosition.baseAssetAmount.abs(),
  direction: PositionDirection.SHORT,
  marketIndex: 0,
  reduceOnly: true, // Important!
});

```

## Running Your First Trade

## Save the code

Copy the complete example to `trade-example.ts`

## Set environment variables

Ensure your `.env` file contains:

```bash
BOT_PRIVATE_KEY=[your,private,key,array]
ANCHOR_PROVIDER_URL=https://api.devnet.solana.com

```

## Get devnet SOL

```bash
solana airdrop 1 --url devnet

```

## Run the script

```bash
npx ts-node trade-example.ts

```

## What's Next?

## Advanced Trading

Learn about limit orders, stop losses, and advanced strategies

## Build a Trading Bot

Explore example bot implementations

## API Reference

Complete TypeScript SDK documentation

## Risk Management

Learn about margin, liquidations, and risk controls

## Common Issues

## Insufficient collateral error

Ensure you have enough USDC deposited:

```typescript
const freeCollateral = user.getFreeCollateral();
console.log('Free collateral:', convertToNumber(freeCollateral, QUOTE_PRECISION));

```

Deposit more if needed:

```typescript
await driftClient.deposit(
  new BN(5000).mul(QUOTE_PRECISION),
  0, // market index for USDC
  usdcTokenAddress
);

```

## Transaction simulation failed

Common causes:

- Insufficient SOL for transaction fees
- Slippage too high on large orders
- Market conditions changed

Try reducing order size or checking your SOL balance.

## User account not found

The user account doesn't exist yet. Create it:

```typescript
await driftClient.initializeUserAccountAndDepositCollateral(
  depositAmount,
  usdcTokenAddress
);

```
