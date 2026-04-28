# Setup – Drift Protocol

Source: https://docs.drift.trade/developers/drift-sdk/setup

Setup – Drift Protocol

Skip to Content

Copy page

# Setup

The examples below use placeholders like` ` and` `.

### Program Addresses

| Network | Program ID |
| --- | --- |
| Drift (mainnet & devnet) | `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH` |
| Drift Vaults | `vAuLTsyrvSfZRuRB3XgvkPwNGgYSs9YRYymVebLKoxR` |

You can also import the Drift program ID directly from the SDK:

TypeScript

```
import { DRIFT_PROGRAM_ID } from "@drift-labs/sdk";
 
// The Drift program's public key on mainnet-beta and devnet.
// Use this when deriving PDAs or referencing the program directly.
console.log(DRIFT_PROGRAM_ID.toBase58());
// dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH
```

`Variable DRIFT_PROGRAM_ID` Reference ↗

`() => string`

`(pos: number) => string`

`(index: number) => number`

`(...strings: string[]) => string`

`(searchString: string, position?: number | undefined) => number`

`(searchString: string, position?: number | undefined) => number`

`{ (that: string): number; (that: string, locales?: string | string[] | undefined, options?: CollatorOptions | undefined): number; (that: string, locales?: LocalesArgument, options?: CollatorOptions | undefined): number; }`

`{ (regexp: string | RegExp): RegExpMatchArray | null; (matcher: { [Symbol.match](string: string): RegExpMatchArray | null; }): RegExpMatchArray | null; }`

`{ (searchValue: string | RegExp, replaceValue: string): string; (searchValue: string | RegExp, replacer: (substring: string, ...args: any[]) => string): string; (searchValue: { ...; }, replaceValue: string): string; (searchValue: { ...; }, replacer: (substring: string, ...args: any[]) => string): string; }`

`{ (regexp: string | RegExp): number; (searcher: { [Symbol.search](string: string): number; }): number; }`

`(start?: number | undefined, end?: number | undefined) => string`

`{ (separator: string | RegExp, limit?: number | undefined): string[]; (splitter: { [Symbol.split](string: string, limit?: number | undefined): string[]; }, limit?: number | undefined): string[]; }`

`(start: number, end?: number | undefined) => string`

`() => string`

`{ (locales?: string | string[] | undefined): string; (locales?: LocalesArgument): string; }`

`() => string`

`{ (locales?: string | string[] | undefined): string; (locales?: LocalesArgument): string; }`

`() => string`

`number`

`(from: number, length?: number | undefined) => string`

`() => string`

`(pos: number) => number | undefined`

`(searchString: string, position?: number | undefined) => boolean`

`(searchString: string, endPosition?: number | undefined) => boolean`

`{ (form: "NFC" | "NFD" | "NFKC" | "NFKD"): string; (form?: string | undefined): string; }`

`(count: number) => string`

`(searchString: string, position?: number | undefined) => boolean`

`(name: string) => string`

`() => string`

`() => string`

`() => string`

`() => string`

`(color: string) => string`

`{ (size: number): string; (size: string): string; }`

`() => string`

`(url: string) => string`

`() => string`

`() => string`

`() => string`

`() => string`

`(maxLength: number, fillString?: string | undefined) => string`

`(maxLength: number, fillString?: string | undefined) => string`

`() => string`

`() => string`

`() => string`

`() => string`

`(regexp: RegExp) => RegExpStringIterator `

`{ (searchValue: string | RegExp, replaceValue: string): string; (searchValue: string | RegExp, replacer: (substring: string, ...args: any[]) => string): string; }`

`(index: number) => string | undefined`

`() => boolean`

`() => string`

`() => StringIterator `

| Property | Type | Required |
| --- | --- | --- |
| `toString` | Yes |
| `charAt` | Yes |
| `charCodeAt` | Yes |
| `concat` | Yes |
| `indexOf` | Yes |
| `lastIndexOf` | Yes |
| `localeCompare` | Yes |
| `match` | Yes |
| `replace` | Yes |
| `search` | Yes |
| `slice` | Yes |
| `split` | Yes |
| `substring` | Yes |
| `toLowerCase` | Yes |
| `toLocaleLowerCase` | Yes |
| `toUpperCase` | Yes |
| `toLocaleUpperCase` | Yes |
| `trim` | Yes |
| `length` | Yes |
| `substr` | Yes |
| `valueOf` | Yes |
| `codePointAt` | Yes |
| `includes` | Yes |
| `endsWith` | Yes |
| `normalize` | Yes |
| `repeat` | Yes |
| `startsWith` | Yes |
| `anchor` | Yes |
| `big` | Yes |
| `blink` | Yes |
| `bold` | Yes |
| `fixed` | Yes |
| `fontcolor` | Yes |
| `fontsize` | Yes |
| `italics` | Yes |
| `link` | Yes |
| `small` | Yes |
| `strike` | Yes |
| `sub` | Yes |
| `sup` | Yes |
| `padStart` | Yes |
| `padEnd` | Yes |
| `trimEnd` | Yes |
| `trimStart` | Yes |
| `trimLeft` | Yes |
| `trimRight` | Yes |
| `matchAll` | Yes |
| `replaceAll` | Yes |
| `at` | Yes |
| `isWellFormed` | Yes |
| `toWellFormed` | Yes |
| `__@iterator@2718` | Yes |

### Wallet / Authentication

To interact with Solana you need a keypair, which consists of a public key and a private key. The private key is used to sign transactions and should be kept secure.

Generate a new keypair using the Solana CLI:

```
solana-keygen new --outfile ~/.config/solana/my-keypair.json
```

To allow SDK code to use this keypair, set the`ANCHOR_WALLET` environment variable to the path of the keypair file:

```
export ANCHOR_WALLET=~/.config/solana/my-keypair.json
```

Then load the keypair in your code:

TypeScript

```
import { Wallet, loadKeypair } from "@drift-labs/sdk";
 
const keyPairFile = `${process.env.HOME}/.config/solana/my-keypair.json`;
const wallet = new Wallet(loadKeypair(keyPairFile));
```

`Example Wallet / Authentication` Reference ↗

TypeScript docs unavailable for`Wallet / Authentication`.

Make sure the wallet has some SOL, as it is used to pay for transaction fees and rent for account initializations.

### Install

TypeScript

```
npm i @drift-labs/sdk
```

### Create a Drift Client

At a minimum you provide a Solana`connection`, a`wallet`, and the`env`. Then call`subscribe()` to start receiving account updates.

TypeScriptRust

```
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

TypeScriptRust

```
await driftClient.subscribe();
```

`Method DriftClient.subscribe` Reference ↗

| Returns |
| --- |
| `Promise ` |

TypeScript

```
await driftClient.unsubscribe();
```

`Method DriftClient.unsubscribe` Reference ↗

| Returns |
| --- |
| `Promise ` |

Key DriftClient parameters:

| Parameter | Description | Optional | Default |
| --- | --- | --- | --- |
| `connection` | Solana RPC connection | No |
| `wallet` | Wallet used to sign transactions | No |
| `env` | `devnet` or`mainnet-beta`, used to derive market accounts | Yes |
| `perpMarketIndexes` | Perp market accounts to subscribe to | Yes | Derived from env |
| `spotMarketIndexes` | Spot market accounts to subscribe to | Yes | Derived from env |
| `oracleInfos` | Oracle accounts to subscribe to | Yes | Derived from env |
| `accountSubscription` | WebSocket or polling subscription mode | Yes | WebSocket |
| `activeSubAccountId` | Which subaccount to use initially | Yes | 0 |
| `subAccountIds` | All subaccount IDs to subscribe to | Yes | [] |
| `authority` | Authority you’re signing for, only set for delegated accounts | Yes | `wallet.publicKey` |

Delegated accounts: When signing on behalf of a delegated account, you must explicitly set`subAccountIds`,`activeSubAccountId`, and`authority`. Omitting any of these will cause the client to subscribe to the wrong accounts.

### Account Subscriptions (WebSocket vs Polling)

For most bots, websocket subscriptions are the easiest way to keep markets and users up to date. For read-only workflows or when you need tighter control over RPC load, you can switch to polling with a`BulkAccountLoader`.

TypeScript

```
import { BulkAccountLoader } from "@drift-labs/sdk";
```

`Class BulkAccountLoader` Reference ↗

`Connection`

`Commitment`

`number`

`Map `

`Map `

`Map void>`

`Timeout`

`Promise `

`() => void`

`number`

`number`

`(publicKey: PublicKey, callback: (buffer: Buffer, slot: number) => void) => Promise `

`(publicKey: PublicKey, callbackId: string) => void`

`(callback: (error: Error) => void) => string`

`(callbackId: string) => void`

` (array: readonly T[], size: number) => T[][]`

`() => Promise `

`(accountsToLoadChunks: AccountToLoad[][]) => Promise `

`(accountToLoad: AccountToLoad, buffer: Buffer, slot: number) => void`

`(publicKey: PublicKey) => BufferAndSlot | undefined`

`() => number`

`() => void`

`() => void`

`(msg: string) => void`

`(pollingFrequency: number) => void`

| Property | Type | Required |
| --- | --- | --- |
| `connection` | Yes |
| `commitment` | Yes |
| `pollingFrequency` | Yes |
| `accountsToLoad` | Yes |
| `bufferAndSlotMap` | Yes |
| `errorCallbacks` | Yes |
| `intervalId` | No |
| `loadPromise` | No |
| `loadPromiseResolver` | Yes |
| `lastTimeLoadingPromiseCleared` | Yes |
| `mostRecentSlot` | Yes |
| `addAccount` | Yes |
| `removeAccount` | Yes |
| `addErrorCallbacks` | Yes |
| `removeErrorCallbacks` | Yes |
| `chunks` | Yes |
| `load` | Yes |
| `loadChunk` | Yes |
| `handleAccountCallbacks` | Yes |
| `getBufferAndSlot` | Yes |
| `getSlot` | Yes |
| `startPolling` | Yes |
| `stopPolling` | Yes |
| `log` | Yes |
| `updatePollingFrequency` | Yes |

TypeScript

```
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
  // Optional: explicitly list markets/oracles to load.
  // perpMarketIndexes: [0, 1],
  // spotMarketIndexes: [0],
  // oracleInfos: [{ publicKey: ORACLE_PUBKEY, source: ORACLE_SOURCE }],
});
```

`Example Polling subscription` Reference ↗

TypeScript docs unavailable for`Polling subscription`.

### Multiple Subaccounts

Drift supports multiple subaccounts per wallet, each with its own isolated position and order state. This lets you run separate strategies (e.g., a market-making bot and a hedging bot) under the same authority without cross-contaminating risk or PnL. Use`addUser()` to subscribe to additional subaccounts after initialization.

TypeScript

```
if (!driftClient.hasUser(1)) {
  await driftClient.addUser(1);
}
```

`Method DriftClient.hasUser` Reference ↗

`number`

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `subAccountId` | No |
| `authority` | No |

| Returns |
| --- |
| `boolean` |

TypeScript

```
await driftClient.addUser(1);
```

`Method DriftClient.addUser` Reference ↗

`number`

`PublicKey`

`UserAccount`

| Parameter | Type | Required |
| --- | --- | --- |
| `subAccountId` | Yes |
| `authority` | No |
| `userAccount` | No |

| Returns |
| --- |
| `Promise ` |

### High Leverage Mode

High Leverage Mode allows eligible accounts to trade with increased maximum leverage (up to 50x on supported markets) compared to the standard 10x cap. It is an opt-in feature that requires the account to meet specific criteria set by the protocol. You can fetch the current high leverage configuration to check limits and eligibility conditions.

TypeScript

```
import { getHighLeverageModeConfigPublicKey } from "@drift-labs/sdk";
 
const pda = getHighLeverageModeConfigPublicKey(driftClient.program.programId);
const config = await driftClient.program.account.highLeverageModeConfig.fetch(pda);
```

`Function getHighLeverageModeConfigPublicKey` Reference ↗

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `programId` | Yes |

| Returns |
| --- |
| `PublicKey` |

Last updated on February 27, 2026

Account Model Precision and Types
