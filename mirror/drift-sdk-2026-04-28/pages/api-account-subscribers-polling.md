# Polling Subscribers
URL: https://mintlify.com/drift-labs/protocol-v2/api/account-subscribers/polling

# Polling Subscribers

Periodic `getAccountInfo`/`getMultipleAccounts` calls. Simple, reliable, predictable resource usage. Higher latency than WebSocket; works with any RPC endpoint.

## BulkAccountLoader

Batches multiple accounts into single `getMultipleAccounts` calls.

```typescript
import { BulkAccountLoader } from '@drift-labs/sdk';

const loader = new BulkAccountLoader(connection, 'confirmed', 1000); // 1s poll

const driftClient = new DriftClient({
  connection, wallet,
  accountSubscription: { type: 'polling', accountLoader: loader },
});
```

## Properties

- `connection`, `commitment`, `pollingFrequency` (ms)
- `accountsToLoad`, `bufferAndSlotMap`, `errorCallbacks`
- `mostRecentSlot`

## Methods

- `addAccount(publicKey, callback)`, `removeAccount(publicKey, callbackId)`
- `addErrorCallbacks(callback)`, `removeErrorCallbacks(callbackId)`
- `load()` — manual trigger
- `startPolling()`, `stopPolling()`
- `getBufferAndSlot(publicKey)`, `getSlot()`
- `updatePollingFrequency(pollingFrequency)`

Best for: development, low-frequency trading, simple bots.
