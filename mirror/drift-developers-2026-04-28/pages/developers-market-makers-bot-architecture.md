# Bot Architecture Patterns – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/bot-architecture

# Bot Architecture Patterns

Production market making bots need more than just order placement logic. This page covers infrastructure patterns used across Drift's keeper-bots-v2, applicable to market making, filling, and triggering bots.

## Subscription loop + resubscribe

```typescript
import { OrderSubscriber } from "@drift-labs/sdk";

const orderSubscriber = new OrderSubscriber({
  driftClient,
  subscriptionConfig: {
    type: "websocket",
    resubTimeoutMs: 30_000,
    resyncIntervalMs: 300_000, // full resync every 5 minutes
  },
});
await orderSubscriber.subscribe();
```

WebSocket subscriptions can silently miss updates; `resyncIntervalMs` catches this.

## Periodic tasks + mutex guard

```typescript
import { Mutex } from "async-mutex";

const periodicTaskMutex = new Mutex();

setInterval(async () => {
  if (periodicTaskMutex.isLocked()) return;
  const release = await periodicTaskMutex.acquire();
  try {
    await refreshQuotes();
    await runRiskChecks();
  } finally {
    release();
  }
}, 10_000);
```

## Throttling / backoff

Track recent attempts and enforce a cooldown to avoid hammering the same order.

## Priority fees and compute budget

```typescript
import { ComputeBudgetProgram } from "@solana/web3.js";
import { PriorityFeeSubscriber } from "@drift-labs/sdk";

const priorityFeeSubscriber = new PriorityFeeSubscriber({ connection, frequencyMs: 5000 });
await priorityFeeSubscriber.subscribe();

const priorityFee = priorityFeeSubscriber.getCustomStrategyResult();
const computeBudgetIx = ComputeBudgetProgram.setComputeUnitPrice({
  microLamports: Math.floor(priorityFee * driftClient.txSender.getSuggestedPriorityFeeMultiplier()),
});

const computeLimitIx = ComputeBudgetProgram.setComputeUnitLimit({ units: 400_000 });
```

Place-and-make transactions typically use 200-400k compute units.

## Address Lookup Tables (ALTs)

Drift transactions reference many accounts. Use ALTs to compress transaction size and stay under Solana's 1232-byte limit.

```typescript
const lookupTableAccounts = await driftClient.fetchAllLookupTableAccounts();
const { blockhash } = await driftClient.connection.getLatestBlockhash({ commitment: "confirmed" });
```

## Health monitoring

```typescript
async function checkHealth() {
  const user = driftClient.getUser();
  const freeCollateral = convertToNumber(user.getFreeCollateral(), QUOTE_PRECISION);
  const leverage = convertToNumber(user.getLeverage(), new BN(10_000));

  if (freeCollateral < MIN_FREE_COLLATERAL || leverage > MAX_LEVERAGE) {
    await driftClient.cancelOrders(); // emergency
    return false;
  }
  return true;
}

setInterval(checkHealth, 5_000);
```

## Graceful shutdown

```typescript
async function gracefulShutdown(signal: string) {
  await driftClient.cancelOrders();
  await orderSubscriber.unsubscribe();
  await driftClient.unsubscribe();
  process.exit(0);
}

process.on("SIGINT", () => gracefulShutdown("SIGINT"));
process.on("SIGTERM", () => gracefulShutdown("SIGTERM"));
process.on("uncaughtException", (err) => gracefulShutdown("uncaughtException"));
```

## Error handling patterns

Common transaction errors and handling:
- `BlockhashNotFound` / `block height exceeded` -> retry
- `exceeded CUs meter` -> raise CU limit
- `insufficient lamports` -> need to top up SOL, don't retry
- `PostOnlyOrderWouldBeFilled` -> price moved, skip

## Risk and filtering

For JIT and SWIFT flows, apply these filters before filling:

```typescript
const oracle = driftClient.getMMOracleDataForPerpMarket(marketIndex);
if (!oracle.isValid) return;
if (oracle.confidence > maxConfidence) return;

// Position limits
const newPosition = currentPosition.baseAssetAmount + fillSize;
if (Math.abs(newPosition) > maxPositionSize) return;

// Toxic flow
if (isRiskIncreasing(order, currentPosition)) return;
if (Math.abs(oraclePrice - indexPrice) > maxDivergence) return;

// SWIFT dedup
if (isSignedMsgOrder(order)) return; // handled by SWIFT subscriber
```

## Subaccount isolation

```typescript
const driftClient = new DriftClient({
  connection, wallet, env: "mainnet-beta",
  activeSubAccountId: 0,
  subAccountIds: [0, 1, 2], // one per market
});

driftClient.switchActiveUser(subAccountId);
```

## Gotchas

- WebSocket silent failures: monitor last-update timestamp, force-reconnect if stale >60s
- Priority fee spikes during congestion (set `maxPriorityFee` cap)
- Transaction size limits: always use ALTs
- Blockhash expiry: ~60 seconds; use `commitment: "confirmed"` and set `lastValidBlockHeight`
- Rate limits even on paid RPCs: batch reads with `getMultipleAccounts`

Reference implementations (keeper-bots-v2):
- floatingMaker.ts: mutex guards, slot cooldowns, watchdog
- jitMaker.ts: subaccount isolation, DLOB integration, volatility checks
- utils.ts: throttling, market type conversion, volatility helpers

Last updated on February 27, 2026
