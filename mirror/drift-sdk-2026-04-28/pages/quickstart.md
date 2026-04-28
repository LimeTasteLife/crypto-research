# Quick Start
URL: https://mintlify.com/drift-labs/protocol-v2/quickstart

# Quick Start Guide

This guide walks you through placing your first perpetual trade on Drift Protocol, from initialization to order execution. Uses devnet for testing.

## Steps

1. Initialize the Drift SDK
2. Connect your wallet
3. Create a Drift user account
4. Deposit collateral (USDC)
5. Place a perpetual order
6. Monitor your position

## Complete Example (1 SOL-PERP long order)

```typescript
import * as anchor from '@coral-xyz/anchor';
import { Connection, Keypair, PublicKey } from '@solana/web3.js';
import { getAssociatedTokenAddress } from '@solana/spl-token';
import {
  DriftClient, User, initialize, PositionDirection, convertToNumber,
  PRICE_PRECISION, QUOTE_PRECISION, BASE_PRECISION, Wallet, PerpMarkets,
  getMarketOrderParams, BulkAccountLoader, BN, calculateBidAskPrice,
} from '@drift-labs/sdk';

const main = async () => {
  const env = 'devnet';
  const sdkConfig = initialize({ env });

  const rpcUrl = process.env.ANCHOR_PROVIDER_URL || 'https://api.devnet.solana.com';
  const connection = new Connection(rpcUrl, 'confirmed');

  const privateKey = JSON.parse(process.env.BOT_PRIVATE_KEY || '[]');
  const keypair = Keypair.fromSecretKey(Uint8Array.from(privateKey));
  const wallet = new Wallet(keypair);

  const driftPublicKey = new PublicKey(sdkConfig.DRIFT_PROGRAM_ID);
  const bulkAccountLoader = new BulkAccountLoader(connection, 'confirmed', 1000);

  const driftClient = new DriftClient({
    connection, wallet,
    programID: driftPublicKey,
    accountSubscription: { type: 'polling', accountLoader: bulkAccountLoader },
  });
  await driftClient.subscribe();

  const userPublicKey = await driftClient.getUserAccountPublicKey();
  const user = new User({
    driftClient,
    userAccountPublicKey: userPublicKey,
    accountSubscription: { type: 'polling', accountLoader: bulkAccountLoader },
  });

  const userAccountExists = await user.exists();
  if (!userAccountExists) {
    const usdcTokenAddress = await getAssociatedTokenAddress(
      new PublicKey(sdkConfig.USDC_MINT_ADDRESS),
      wallet.publicKey
    );
    const depositAmount = new BN(10000).mul(QUOTE_PRECISION);
    await driftClient.initializeUserAccountAndDepositCollateral(
      depositAmount, usdcTokenAddress
    );
  }
  await user.subscribe();

  const solMarketInfo = PerpMarkets[env].find(m => m.baseAssetSymbol === 'SOL');
  const marketIndex = solMarketInfo.marketIndex;

  const perpMarketAccount = driftClient.getPerpMarketAccount(marketIndex);
  const oracleData = driftClient.getOracleDataForPerpMarket(marketIndex);
  const [bid, ask] = calculateBidAskPrice(perpMarketAccount.amm, oracleData);

  const orderParams = getMarketOrderParams({
    baseAssetAmount: new BN(1).mul(BASE_PRECISION),
    direction: PositionDirection.LONG,
    marketIndex,
  });

  const txSig = await driftClient.placePerpOrder(orderParams);
  console.log('Tx:', txSig);

  await user.fetchAccounts();
  const position = user.getPerpPosition(marketIndex);
};

main().catch(console.error).finally(() => process.exit());
```

## Order Types

### Market Order

```typescript
const params = getMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
});
await driftClient.placePerpOrder(params);
```

### Limit Order

```typescript
const params = getLimitOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
  price: new BN(100).mul(PRICE_PRECISION),
});
```

### Trigger Order

```typescript
const params = getTriggerMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
  triggerPrice: new BN(105).mul(PRICE_PRECISION),
  triggerCondition: OrderTriggerCondition.ABOVE,
});
```

## Closing Positions

```typescript
const closeParams = getMarketOrderParams({
  baseAssetAmount: position.baseAssetAmount.abs(),
  direction: PositionDirection.SHORT,
  marketIndex,
  reduceOnly: true, // CRITICAL
});
await driftClient.placePerpOrder(closeParams);
```

## Best Practices

1. Always use BigNum for amounts (never JS numbers)
2. Wrap operations in try-catch
3. Refresh data with `await user.fetchAccounts()` before trading
4. Use `reduceOnly: true` for closing

## Common Issues

- Insufficient collateral: check `user.getFreeCollateral()`, deposit more if needed.
- Transaction simulation failed: insufficient SOL fees, slippage too high, market changed. Reduce order size.
- User account not found: call `initializeUserAccountAndDepositCollateral`.
