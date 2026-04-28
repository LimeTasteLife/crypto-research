# Setup – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/setup

# Setup

The examples below use placeholders like `<RPC_URL>` and `<KEYPAIR_PATH>`.

### Program Addresses

| Network | Program ID |
| --- | --- |
| Drift (mainnet & devnet) | `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH` |
| Drift Vaults | `vAuLTsyrvSfZRuRB3XgvkPwNGgYSs9YRYymVebLKoxR` |

You can also import the Drift program ID directly from the SDK:

```typescript
import { DRIFT_PROGRAM_ID } from "@drift-labs/sdk";
console.log(DRIFT_PROGRAM_ID.toBase58());
// dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH
```

### Wallet / Authentication

Generate a new keypair using the Solana CLI:

```
solana-keygen new --outfile ~/.config/solana/my-keypair.json
```

Set ANCHOR_WALLET env var, then load:

```typescript
import { Wallet, loadKeypair } from "@drift-labs/sdk";
const keyPairFile = `${process.env.HOME}/.config/solana/my-keypair.json`;
const wallet = new Wallet(loadKeypair(keyPairFile));
```

### Install

```
npm i @drift-labs/sdk
```

### Create a Drift Client

```typescript
import { Connection } from "@solana/web3.js";
import { DriftClient, Wallet, loadKeypair } from "@drift-labs/sdk";

const connection = new Connection("<RPC_URL>", "confirmed");
const wallet = new Wallet(loadKeypair("<KEYPAIR_PATH>"));

const driftClient = new DriftClient({
  connection,
  wallet,
  env: "mainnet-beta",
});

await driftClient.subscribe();
```

Key DriftClient parameters:

| Parameter | Description | Default |
| --- | --- | --- |
| `connection` | Solana RPC connection | (required) |
| `wallet` | Wallet used to sign transactions | (required) |
| `env` | `devnet` or `mainnet-beta` | optional |
| `perpMarketIndexes` | Perp market accounts to subscribe to | Derived from env |
| `spotMarketIndexes` | Spot market accounts to subscribe to | Derived from env |
| `oracleInfos` | Oracle accounts to subscribe to | Derived from env |
| `accountSubscription` | WebSocket or polling subscription mode | WebSocket |
| `activeSubAccountId` | Which subaccount to use initially | 0 |
| `subAccountIds` | All subaccount IDs to subscribe to | [] |
| `authority` | Authority you're signing for, only set for delegated accounts | wallet.publicKey |

Delegated accounts: When signing on behalf of a delegated account, you must explicitly set `subAccountIds`, `activeSubAccountId`, and `authority`. Omitting any of these will cause the client to subscribe to the wrong accounts.

### Account Subscriptions (WebSocket vs Polling)

For most bots, websocket subscriptions are the easiest way to keep markets and users up to date. For read-only workflows or when you need tighter control over RPC load, you can switch to polling with a `BulkAccountLoader`:

```typescript
import { BulkAccountLoader } from "@drift-labs/sdk";

const accountLoader = new BulkAccountLoader(connection, "confirmed", 0);

const driftClient = new DriftClient({
  connection,
  wallet,
  env: "mainnet-beta",
  accountSubscription: {
    type: "polling",
    accountLoader,
  },
});
```

### Multiple Subaccounts

Drift supports multiple subaccounts per wallet, each with its own isolated position and order state. Use `addUser()` to subscribe to additional subaccounts after initialization.

```typescript
if (!driftClient.hasUser(1)) {
  await driftClient.addUser(1);
}
```

### High Leverage Mode

High Leverage Mode allows eligible accounts to trade with increased maximum leverage (up to 50x on supported markets) compared to the standard 10x cap. It is an opt-in feature that requires the account to meet specific criteria set by the protocol.

```typescript
import { getHighLeverageModeConfigPublicKey } from "@drift-labs/sdk";

const pda = getHighLeverageModeConfigPublicKey(driftClient.program.programId);
const config = await driftClient.program.account.highLeverageModeConfig.fetch(pda);
```

Last updated on February 27, 2026
