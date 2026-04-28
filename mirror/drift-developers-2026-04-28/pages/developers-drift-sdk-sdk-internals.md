# SDK Internals – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/sdk-internals

# SDK Internals

The Drift SDK handles onchain interactions, account subscriptions, and transaction construction.

## Core architecture

DriftClient — main interface (constructs txs, manages account subscriptions, helper methods, caches market and state data).

User — represents a single user account (subscribes to user account updates, calculates positions/PnL/health, convenience methods).

AccountSubscriber — handles real-time account updates (polls or streams account data, notifies clients, caches account data).

## Account subscription patterns

### Polling subscription

How: periodic `connection.getAccountInfo()` calls.

```typescript
import { BulkAccountLoader } from "@drift-labs/sdk";

const accountLoader = new BulkAccountLoader(connection, "confirmed", 1000);

const driftClient = new DriftClient({
  connection, wallet,
  accountSubscription: { type: "polling", accountLoader },
});
```

Pros: Simple, reliable, predictable resource usage. Cons: Higher latency, more RPC calls. Best for: Development, low-frequency trading.

### WebSocket subscription

How: Solana's `onAccountChange` notifications.

```typescript
const driftClient = new DriftClient({
  connection, wallet,
  accountSubscription: { type: "websocket" },
});
```

Pros: Lower latency, fewer RPC calls. Cons: WebSocket can disconnect. Best for: Market makers, latency-sensitive bots.

### gRPC subscription (fastest)

How: Yellowstone gRPC plugin.

```typescript
const driftClient = new DriftClient({
  connection, wallet,
  accountSubscription: {
    type: "grpc",
    grpcConfigs: { endpoint: "https://grpc.mainnet.jito.wtf", token: "YOUR_GRPC_TOKEN" },
  },
});
```

Best for: HFT, JIT market makers.

## BulkAccountLoader

Batches multiple accounts into single `getMultipleAccounts` RPC calls for efficiency.

## Transaction construction layers

```typescript
// 1. Get instruction
const ix = await driftClient.getPlacePerpOrderIx(orderParams);

// 2. Build versioned transaction
const tx = await driftClient.txSender.getVersionedTransaction(
  [ix], [], wallet.publicKey
);

// 3. Send transaction
const { txSig } = await driftClient.txSender.sendVersionedTransaction(
  tx, [], driftClient.opts
);
```

## Remaining accounts pattern

```typescript
const remainingAccounts = driftClient.getRemainingAccounts({
  userAccounts: [user.getUserAccount()],
  writableSpotMarketIndexes: [0],
});
```

Handles oracle, market, and cross-position accounts automatically.

## Event subscriptions

```typescript
import { EventSubscriber, isVariant } from "@drift-labs/sdk";

const eventSubscriber = new EventSubscriber(connection, driftClient.program, {
  commitment: "confirmed",
  logProviderConfig: { type: "websocket" },
});
await eventSubscriber.subscribe();

eventSubscriber.eventEmitter.on("newEvent", (event) => {
  if (event.eventType === "OrderActionRecord" && isVariant(event.action, "fill")) {
    console.log("Order filled:", event);
  }
});
```

## Caching and performance

Subscribed market accounts, oracle prices, and user accounts are cached. Queries hit memory (microseconds) instead of RPC (milliseconds).

## UserMap for multiple users

```typescript
import { UserMap } from "@drift-labs/sdk";

const userMap = new UserMap({
  driftClient,
  subscriptionConfig: { type: "websocket" },
});

await userMap.addUserAccount(userAccountPubkey);
const user = userMap.get(userAccountPubkey.toString());
```

UserMap handles subscription lifecycle for all users automatically.

## Common patterns

```typescript
import { ComputeBudgetProgram } from "@solana/web3.js";

// Transaction with priority fee
const ix = await driftClient.getPlacePerpOrderIx(orderParams);
const tx = await driftClient.txSender.getVersionedTransaction([
  ComputeBudgetProgram.setComputeUnitPrice({ microLamports: 50000 }),
  ix,
], [], wallet.publicKey);
const { txSig } = await driftClient.txSender.sendVersionedTransaction(
  tx, [], driftClient.opts
);
```

## Performance tips

- Commitment: `processed` (fastest), `confirmed` (recommended), `finalized` (slowest, most secure)
- Batch operations: `placeOrders([...])`
- Precompute precision values once and reuse
- Use Address Lookup Tables (ALTs) to reduce transaction size

Last updated on February 27, 2026
