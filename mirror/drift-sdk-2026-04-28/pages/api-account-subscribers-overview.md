# Account Subscribers Overview
URL: https://mintlify.com/drift-labs/protocol-v2/api/account-subscribers/overview

# Account Subscribers Overview

Account subscribers manage real-time on-chain account updates for the SDK.

## Strategies

| Type | Mechanism | Best for |
| --- | --- | --- |
| Polling | `getMultipleAccounts` periodic | Development, low-frequency bots |
| WebSocket | Solana `onAccountChange` | Production trading |
| gRPC | Yellowstone gRPC plugin | HFT, JIT market making |

## DriftClient subscriber config

```typescript
new DriftClient({
  // ...
  accountSubscription: {
    type: 'polling' | 'websocket' | 'grpc',
    accountLoader,         // for polling
    grpcConfigs,           // for grpc: { endpoint, token }
    resubTimeoutMs,        // websocket
    resyncIntervalMs,      // websocket: full resync interval
  },
});
```

## Common subscribers

- `BulkAccountLoader` — batches accounts into single `getMultipleAccounts` calls
- `OrderSubscriber` — tracks all open user orders
- `DLOBSubscriber` — builds aggregated orderbook from order stream
- `SlotSubscriber` — tracks current Solana slot
- `EventSubscriber` — tracks protocol events from transaction logs
- `AuctionSubscriber` — streams active JIT auctions
- `SwiftOrderSubscriber` — receives signed taker orders offchain
- `UserMap` — tracks many user accounts efficiently
- `PriorityFeeSubscriber` — tracks recent priority fee levels
- `IndicativeQuotesSender` — publishes offchain indicative quotes
- `CandleClient` — fetches/streams OHLCV candles
