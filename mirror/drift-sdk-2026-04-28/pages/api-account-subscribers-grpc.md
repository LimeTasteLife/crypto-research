# gRPC Subscribers
URL: https://mintlify.com/drift-labs/protocol-v2/api/account-subscribers/grpc

# gRPC Subscribers

High-performance account streaming using Yellowstone gRPC plugin for Solana validators. Lowest latency available.

## Configuration

```typescript
const driftClient = new DriftClient({
  connection, wallet,
  accountSubscription: {
    type: 'grpc',
    grpcConfigs: {
      endpoint: 'https://grpc.mainnet.jito.wtf',
      token: 'YOUR_GRPC_TOKEN',
    },
  },
});
```

## Considerations

- Requires gRPC-enabled RPC provider (Jito, Triton, dedicated nodes)
- More complex setup; may require authentication
- Sub-second updates, most efficient bandwidth usage

Best for: HFT bots, JIT market makers, competitive filling.
