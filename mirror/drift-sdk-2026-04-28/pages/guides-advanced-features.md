# Advanced Features
URL: https://mintlify.com/drift-labs/protocol-v2/guides/advanced-features

# Advanced Features

## SWIFT (signed message orders)

Off-chain signed orders for ultra-low-latency trading. Takers sign orders off-chain and broadcast via WebSocket; makers fill on-chain with ed25519 verification 100-500ms before the order lands on-chain.

```typescript
import { SwiftOrderSubscriber } from '@drift-labs/sdk';

const swiftSubscriber = new SwiftOrderSubscriber({
  driftClient, driftEnv: 'mainnet-beta',
  marketIndexes: [0, 1, 2],
  keypair,
});
await swiftSubscriber.subscribe(async (orderMessageRaw, signedMessage) => {
  // Inspect and fill
});
```

Use `driftClient.placeAndMakeSignedMsgPerpOrder(...)` to fill SWIFT orders atomically.

## Builder Codes (Drift Builder Codes / DBC)

Per-order monetization for third-party frontends. Currently limited to SWIFT orders.

```typescript
// Builder setup (one-time)
await builderClient.initializeRevenueShare(builderAuthority);

// User setup (one-time)
await userClient.initializeRevenueShareEscrow(takerAuthority, 16);
await userClient.changeApprovedBuilder(builderAuthority, 200, true); // 20bps max

// Order placement: include builderIdx + builderFeeTenthBps in signed message
```

## Jupiter swaps (spot)

Route spot swaps through Jupiter directly from your Drift account.

```typescript
import { JupiterClient } from '@drift-labs/sdk';

const jupiterClient = new JupiterClient({ connection });
await driftClient.swap({
  jupiterClient,
  inMarketIndex: 0,  // USDC
  outMarketIndex: 1, // SOL
  amount: driftClient.convertToSpotPrecision(0, 10),
  slippageBps: 50,
});
```

## High Leverage Mode

```typescript
import { getHighLeverageModeConfigPublicKey } from '@drift-labs/sdk';

const pda = getHighLeverageModeConfigPublicKey(driftClient.program.programId);
const config = await driftClient.program.account.highLeverageModeConfig.fetch(pda);

// Opt in via order param `bitFlags: OrderParamsBitFlag.UpdateHighLeverageMode`
```

## Isolated margin positions

Available for ISOLATED tier markets (introduced v2.154.0). Use dedicated collateral per position; no cross-margin risk sharing.

```typescript
await driftClient.placePerpOrder(orderParams, undefined, undefined, isolatedDepositAmount);
```

## Indicative quotes

Publish off-chain liquidity signals without committing on-chain orders.

```typescript
import { IndicativeQuotesSender } from '@drift-labs/sdk';

const quoter = new IndicativeQuotesSender('wss://dlob.drift.trade/quotes/ws', keypair);
await quoter.connect();

quoter.setQuote({
  bidPrice, askPrice, bidBaseAssetAmount, askBaseAssetAmount,
  marketIndex, isOracleOffset: true,
});
```

## Priority fees

```typescript
import { PriorityFeeSubscriber } from '@drift-labs/sdk';
import { ComputeBudgetProgram } from '@solana/web3.js';

const priorityFeeSubscriber = new PriorityFeeSubscriber({ connection, frequencyMs: 5000 });
await priorityFeeSubscriber.subscribe();

const fee = priorityFeeSubscriber.getCustomStrategyResult();
const cbIx = ComputeBudgetProgram.setComputeUnitPrice({ microLamports: fee });
```
