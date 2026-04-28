# WebSocket Subscribers
URL: https://mintlify.com/drift-labs/protocol-v2/api/account-subscribers/websocket

# WebSocket Subscribers

Real-time updates via Solana's `onAccountChange` WebSocket notifications. Lower latency, fewer RPC calls. Requires WebSocket-enabled RPC.

## Configuration

```typescript
const driftClient = new DriftClient({
  connection, wallet,
  accountSubscription: {
    type: 'websocket',
    resubTimeoutMs: 30_000,    // resubscribe if no update in 30s
    resyncIntervalMs: 300_000, // full resync every 5 min
  },
});
```

## Considerations

- WebSocket can disconnect — implement auto-reconnect
- RPC providers may have connection limits
- `resyncIntervalMs` catches silently dropped updates
- Set higher commitment (`confirmed`) for stability vs `processed` for lowest latency

Best for: market makers, latency-sensitive bots, production trading.
