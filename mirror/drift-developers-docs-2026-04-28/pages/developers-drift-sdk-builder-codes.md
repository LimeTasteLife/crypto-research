# Builder Codes – Drift Protocol

Source: https://docs.drift.trade/developers/drift-sdk/builder-codes

Builder Codes – Drift Protocol

Skip to Content

Developers Drift SDK Builder Codes

Copy page

# Builder Codes

Builder Codes (DBC) let integrators earn fees by routing flow through their application. The system is built on top of Swift: when a user places a Swift order through your app, you include a`builderIdx` and`builderFee` in the signed order message, and fees are automatically settled to your revenue-share account.

Note: Builder Codes are currently limited to Swift orders only.

The workflow has 3 steps:

1. Builder initializes a revenue-share account
2. User creates an escrow account for tracking approved builders and fees
3. User approves the builder with a maximum fee cap

## Setup

Create and subscribe separate`DriftClient` instances for the builder and user authorities:

TypeScript

```
import { DriftClient } from "@drift-labs/sdk";
import { Connection, Keypair, PublicKey } from "@solana/web3.js";
 
// Initialize connection
const connection = new Connection("https://api.mainnet-beta.solana.com");
 
// Builder wallet (revenue share provider)
const builderWallet = Keypair.fromSecretKey(/* builder secret key */);
const builderAuthority = builderWallet.publicKey;
 
// User wallet (end user)
const userWallet = Keypair.fromSecretKey(/* user secret key */);
const takerAuthority = userWallet.publicKey;
 
// Builder client
const builderClient = new DriftClient({
  connection,
  wallet: builderWallet,
  env: "mainnet-beta"
});
await builderClient.subscribe();
 
// User client
const userClient = new DriftClient({
  connection,
  wallet: userWallet,
  env: "mainnet-beta"
});
await userClient.subscribe();
```

`Example Builder codes setup` Reference ↗

TypeScript docs unavailable for `Builder codes setup`.

## SDK Usage

### Builder: Initialize Revenue Share

Create the builder’s onchain revenue-share configuration account. This is a one-time setup step that must be completed before the builder can receive fees:

TypeScript

```
await builderClient.initializeRevenueShare(builderAuthority);
```

`Method DriftClient.initializeRevenueShare` Reference ↗

`PublicKey`

`TxParams`

| Parameter | Type | Required |
| --- | --- | --- |
| `authority` | Yes |
| `txParams` | No |

| Returns |
| --- |
| `Promise ` |

### User: Initialize Escrow

Create the user’s revenue-share escrow account used for builder fee routing. The`numOrders` parameter controls how many concurrent approved builders the account can hold. Set this to at least 8 since users can have multiple subaccounts with open orders:

TypeScript

```
// numOrders should be >= 8 to accommodate multiple subaccounts
await userClient.initializeRevenueShareEscrow(takerAuthority, 16);
```

`Method DriftClient.initializeRevenueShareEscrow` Reference ↗

`PublicKey`

`number`

`TxParams`

| Parameter | Type | Required |
| --- | --- | --- |
| `authority` | Yes |
| `numOrders` | Yes |
| `txParams` | No |

| Returns |
| --- |
| `Promise ` |

### User: Approve a Builder (Max Fee)

Approve a builder for this user and set the maximum fee they can charge. The`builderIdx` in the signed order message references the position of this approval in the user’s escrow account:

TypeScript

```
// max fee is expressed in tenths of a basis point (100 = 10 bps, 200 = 20 bps)
await userClient.changeApprovedBuilder(builderAuthority, 200, true);
```

`Method DriftClient.changeApprovedBuilder` Reference ↗

`PublicKey`

The public key of the builder to add or update.

`number`

The maximum fee tenth bps to set for the builder.

`boolean`

Whether to add or update the builder. If the builder already exists, `add = true` will update the `maxFeeTenthBps`, otherwise it will add the builder. If `add = false`, the builder's `maxFeeTenthBps` will be set to 0.

`TxParams`

The transaction parameters to use for the transaction.

| Parameter | Type | Required |
| --- | --- | --- |
| `builder` | Yes |
| `maxFeeTenthBps` | Yes |
| `add` | Yes |
| `txParams` | No |

| Returns |
| --- |
| `Promise ` |

### Order Placement (Builder adds fee to Swift order)

When your app constructs a Swift order on behalf of a user, include`builderIdx` and`builderFeeTenthBps` in the signed message. The`builderIdx` references the index of your approval in the user’s`RevenueShareEscrow.approved_builders` list:

TypeScript

```
import { generateSignedMsgUuid } from "@drift-labs/sdk";
 
const slot = await takerClient.connection.getSlot();
 
const orderMessage = {
  signedMsgOrderParams: marketOrderParams,
  subAccountId: takerClient.activeSubAccountId,
  slot: new BN(slot),
  uuid: generateSignedMsgUuid(),
  stopLossOrderParams: null,
  takeProfitOrderParams: null,
 
  // Builder fee fields, added by the builder's app UI
  builderIdx: 0,           // index in taker's approved_builders list
  builderFeeTenthBps: 50,  // fee for this order: 5 bps (50 * 0.1bps)
};
 
const { orderParams: message, signature } =
  takerClient.signSignedMsgOrderParamsMessage(orderMessage);
 
// Submit to Swift API as normal (see Swift docs)
```

`Example Builder codes order placement` Reference ↗

TypeScript docs unavailable for `Builder codes order placement`.

The builder’s app constructs this signed message and submits it to the Swift server. The keeper then bundles the fill transaction, and fees are automatically settled to the builder’s revenue-share account upon fill.

Last updated on February 27, 2026

Swift (off-chain signed orders) SDK Internals
