# Initialize DriftClient
URL: https://mintlify.com/drift-labs/protocol-v2/guides/initialization

# Initialize DriftClient

Set up and initialize the Drift SDK client.

```typescript
import { Connection, PublicKey } from '@solana/web3.js';
import { DriftClient, Wallet, loadKeypair, initialize, BulkAccountLoader } from '@drift-labs/sdk';

const env = 'mainnet-beta';
const sdkConfig = initialize({ env });

const connection = new Connection('<RPC_URL>', 'confirmed');
const wallet = new Wallet(loadKeypair('~/.config/solana/id.json'));

// Polling subscription
const accountLoader = new BulkAccountLoader(connection, 'confirmed', 1000);
const driftClient = new DriftClient({
  connection, wallet,
  programID: new PublicKey(sdkConfig.DRIFT_PROGRAM_ID),
  accountSubscription: { type: 'polling', accountLoader },
});

// Or WebSocket subscription
const driftClientWs = new DriftClient({
  connection, wallet, env,
  accountSubscription: { type: 'websocket', resyncIntervalMs: 300_000 },
});

await driftClient.subscribe();

// Cleanup
await driftClient.unsubscribe();
```

## Configuration parameters

| Parameter | Description | Default |
| --- | --- | --- |
| `connection` | Solana RPC connection | required |
| `wallet` | Anchor-compatible wallet | required |
| `env` | `devnet` or `mainnet-beta` | optional |
| `programID` | Drift program PublicKey | optional (env-derived) |
| `accountSubscription` | polling/websocket/grpc config | required |
| `perpMarketIndexes` | array of perp market indexes | env-derived |
| `spotMarketIndexes` | array of spot market indexes | env-derived |
| `oracleInfos` | array of oracle accounts | env-derived |
| `activeSubAccountId` | initial active subaccount | 0 |
| `subAccountIds` | all subaccount ids to subscribe to | [] |
| `authority` | only set for delegate flow | wallet.publicKey |
