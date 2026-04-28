# SWIFT API – Drift Protocol

Source: https://docs.drift.trade/developers/market-makers/swift-api

SWIFT API – Drift Protocol

Skip to Content

Developers Market Makers SWIFT API

Copy page

# SWIFT API

SWIFT (Signed Wrapped Instant Fulfillment Transactions) allows market makers to receive signed taker orders offchain via WebSocket before they hit the JIT auction. This enables ultra-low-latency market making.

## How SWIFT works

### Flow overview

### Taker signs order offchain

Order is signed with the user’s private key and broadcast to the SWIFT WebSocket feed.

### Makers receive order via WebSocket

Order arrives before hitting onchain auction, and makers inspect direction, size, and auction params.

### Makers submit place-and-make

Maker order is submitted onchain with ed25519 verification and atomically fills the taker.

Key benefit: Market makers see orders 100-500ms before they land onchain, allowing faster response times and better fills.

### SWIFT vs standard JIT: why the latency matters

In the standard JIT flow, the taker submits a transaction to Solana → it lands onchain → your RPC/gRPC subscription fires → you compute and submit your fill. This takes 1-2 seconds minimum.

With SWIFT, the taker broadcasts the signed order offchain to the SWIFT WebSocket simultaneously with submitting it onchain. You receive it over WebSocket in 100-500ms, before it even lands onchain. This head start lets you:

- Price more accurately: you see the order while the oracle is fresher
- Win more auctions: your fill tx can land at the same slot or even before other makers who rely on onchain feeds
- React to flow faster: critical for inventory management and toxic flow avoidance

The tradeoff: you need fast infrastructure (dedicated RPC node, low-latency WebSocket connection) to capitalize on this advantage. If your fill tx doesn’t land quickly, the latency edge is wasted.

## Subscribing to SWIFT orders

### Basic subscription

TypeScript

```
import { SwiftOrderSubscriber, loadKeypair } from "@drift-labs/sdk";
 
const swiftSubscriber = new SwiftOrderSubscriber({
  driftClient,
  driftEnv: "mainnet-beta",
  marketIndexes: [0, 1, 2], // SOL, BTC, ETH perp markets to listen to
  keypair: loadKeypair("<KEYPAIR_PATH>"), // used for WebSocket auth
  // endpoint: "wss://swift.drift.trade/ws", // optional, defaults based on driftEnv
});
 
await swiftSubscriber.subscribe(
  async (orderMessageRaw, signedMessage, isDelegateSigner) => {
    // Inspect the incoming signed order
    const orderParams = signedMessage.signedMsgOrderParams;
 
    console.log("Market:", orderParams.marketIndex);
    console.log("Direction:", orderParams.direction);
    console.log("Size:", orderParams.baseAssetAmount);
    console.log("Auction start:", orderParams.auctionStartPrice);
    console.log("Auction end:", orderParams.auctionEndPrice);
 
    // Decide if you want to fill it
    if (shouldFill(orderParams)) {
      await fillSwiftOrder(signedMessage);
    }
  }
);
```

`Class SwiftOrderSubscriber` Reference ↗

`any`

`any`

`any`

`any`

`any`

`AccountGetter`

`(orderMessageRaw: SwiftOrderMessage, signedMessage: SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage, isDelegateSigner?: boolean | undefined) => Promise<...>`

`boolean`

`() => void`

`(marketIndex: number) => string`

`(nonce: string) => string`

`(message: any) => void`

`(onOrder: (orderMessageRaw: SwiftOrderMessage, signedMessage: SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage, isDelegateSigner?: boolean | undefined) => Promise<...>, acceptSanitized?: boolean | undefined, acceptDepositTrade?: boolean | undefined) => Promise<...>`

`(orderMessageRaw: SwiftOrderMessage, signedMsgOrderParamsMessage: SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage, makerOrderParams: OptionalOrderParams) => Promise<...>`

`any`

`any`

| Property | Type | Required |
| --- | --- | --- |
| `config` | Yes |
| `heartbeatTimeout` | Yes |
| `heartbeatIntervalMs` | Yes |
| `ws` | Yes |
| `driftClient` | Yes |
| `userAccountGetter` | No |
| `onOrder` | Yes |
| `subscribed` | Yes |
| `unsubscribe` | Yes |
| `getSymbolForMarketIndex` | Yes |
| `generateChallengeResponse` | Yes |
| `handleAuthMessage` | Yes |
| `subscribe` | Yes |
| `getPlaceAndMakeSignedMsgOrderIxs` | Yes |
| `startHeartbeatTimer` | Yes |
| `reconnect` | Yes |

### With UserAccount getter

Optionally provide a`userAccountGetter` to resolve taker UserAccount details. This lets you inspect the taker’s positions, collateral, and health before deciding to fill, which is useful for toxic flow filtering.

TypeScript

```
import { UserMap, loadKeypair } from "@drift-labs/sdk";
 
const userMap = new UserMap({
  driftClient,
  connection,
  subscriptionConfig: { type: "websocket" },
});
await userMap.subscribe();
 
const swiftSubscriber = new SwiftOrderSubscriber({
  driftClient,
  driftEnv: "mainnet-beta",
  marketIndexes: [0, 1, 2],
  keypair: loadKeypair("<KEYPAIR_PATH>"),
  // userAccountGetter implements { mustGetUserAccount(publicKey: string): Promise<UserAccount> }
  userAccountGetter: userMap,
});
```

`Class UserMap` Reference ↗

`any`

`DriftClient`

`StrictEventEmitter `

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`() => Promise `

`(userAccountPublicKey: PublicKey, userAccount?: UserAccount | undefined, slot?: number | undefined, accountSubscription?: UserSubscriptionConfig | undefined) => Promise<...>`

`(key: string) => boolean`

`(key: string) => User | undefined`

gets the User for a particular userAccountPublicKey, if no User exists, undefined is returned

`(key: string) => DataAndSlot | undefined`

`(key: string, accountSubscription?: UserSubscriptionConfig | undefined) => Promise `

gets the User for a particular userAccountPublicKey, if no User exists, new one is created

`(key: string, accountSubscription?: UserSubscriptionConfig | undefined) => Promise >`

`(key: string) => Promise `

`(key: string) => PublicKey | undefined`

gets the Authority for a particular userAccountPublicKey, if no User exists, undefined is returned

`(slot: number, protectedMakerParamsMap?: ProtectMakerParamsMap | undefined) => Promise `

implements the DLOBSource interface create a DLOB from all the subscribed users

`(record: OrderRecord) => Promise `

`(record: any) => Promise `

`() => IterableIterator `

`() => IterableIterator >`

`() => IterableIterator<[string, User]>`

`() => IterableIterator<[string, DataAndSlot]>`

`() => number`

`(filterCriteria?: UserAccountFilterCriteria | undefined) => PublicKey[]`

Returns a unique list of authorities for all users in the UserMap that meet the filter criteria

`() => Promise `

`any`

`any`

Syncs the UserMap using the default sync method (single getProgramAccounts call with filters). This method may fail when drift has too many users. (nodejs response size limits)

`any`

Syncs the UserMap using the paginated sync method (multiple getMultipleAccounts calls with filters). This method is more reliable when drift has many users.

`() => Promise `

`(key: string, userAccount: UserAccount, slot: number) => Promise `

`(slot: number) => void`

`() => number`

| Property | Type | Required |
| --- | --- | --- |
| `userMap` | Yes |
| `driftClient` | Yes |
| `eventEmitter` | Yes |
| `connection` | Yes |
| `commitment` | Yes |
| `includeIdle` | Yes |
| `filterByPoolId` | No |
| `additionalFilters` | No |
| `disableSyncOnTotalAccountsChange` | Yes |
| `lastNumberOfSubAccounts` | Yes |
| `subscription` | Yes |
| `stateAccountUpdateCallback` | Yes |
| `decode` | Yes |
| `mostRecentSlot` | Yes |
| `syncConfig` | Yes |
| `syncPromise` | No |
| `syncPromiseResolver` | Yes |
| `throwOnFailedSync` | Yes |
| `subscribe` | Yes |
| `addPubkey` | Yes |
| `has` | Yes |
| `get` | Yes |
| `getWithSlot` | Yes |
| `mustGet` | Yes |
| `mustGetWithSlot` | Yes |
| `mustGetUserAccount` | Yes |
| `getUserAuthority` | Yes |
| `getDLOB` | Yes |
| `updateWithOrderRecord` | Yes |
| `updateWithEventRecord` | Yes |
| `values` | Yes |
| `valuesWithSlot` | Yes |
| `entries` | Yes |
| `entriesWithSlot` | Yes |
| `size` | Yes |
| `getUniqueAuthorities` | Yes |
| `sync` | Yes |
| `getFilters` | Yes |
| `defaultSync` | Yes |
| `paginatedSync` | Yes |
| `unsubscribe` | Yes |
| `updateUserAccount` | Yes |
| `updateLatestSlot` | Yes |
| `getSlot` | Yes |

## Place-and-make with SWIFT

SWIFT fills use a special instruction (`placeAndMakeSignedMsgPerpOrder`) that includes an ed25519 signature verification, proving the taker actually signed this order offchain. The SDK handles building this instruction for you.

For the standard onchain place-and-make pattern, see JIT Auctions - Place-and-make. The SWIFT variant adds the signature verification step.

### Using DriftClient (recommended)

TypeScript

```
import {
  getLimitOrderParams,
  getUserAccountPublicKey,
  getUserStatsAccountPublicKey,
  isVariant,
  PositionDirection,
  PostOnlyParams,
} from "@drift-labs/sdk";
import { PublicKey } from "@solana/web3.js";
 
// From the SWIFT subscription callback
async function fillSwiftOrder(orderMessageRaw, signedMessage, isDelegateSigner) {
  const takerAuthority = new PublicKey(orderMessageRaw.taker_authority);
  const signingAuthority = new PublicKey(orderMessageRaw.signing_authority);
  const subAccountId = signedMessage.subAccountId;
 
  // Build the signed order params (message + signature from the raw order)
  const signedOrderParams = {
    orderParams: Buffer.from(orderMessageRaw.order_message, "hex"),
    signature: Buffer.from(orderMessageRaw.order_signature, "base64"),
  };
 
  // Build UUID as Uint8Array
  const uuidBytes = new TextEncoder().encode(orderMessageRaw.uuid);
 
  // Resolve taker account addresses
  const takerPubkey = await getUserAccountPublicKey(
    driftClient.program.programId, takerAuthority, subAccountId
  );
  const takerStatsPubkey = getUserStatsAccountPublicKey(
    driftClient.program.programId, takerAuthority
  );
 
  // Build your maker order params (opposite direction of taker)
  const takerIsLong = isVariant(signedMessage.signedMsgOrderParams.direction, "long");
  const makerOrderParams = getLimitOrderParams({
    marketIndex: signedMessage.signedMsgOrderParams.marketIndex,
    direction: takerIsLong ? PositionDirection.SHORT : PositionDirection.LONG,
    baseAssetAmount: signedMessage.signedMsgOrderParams.baseAssetAmount,
    price: myFillPrice,
    postOnly: PostOnlyParams.MUST_POST_ONLY,
  });
 
  // Resolve taker user account (from UserMap or userAccountGetter)
  const takerUserAccount = await userMap.mustGetUserAccount(takerPubkey.toString());
 
  // Submit place-and-make (SDK handles ed25519 verification ix)
  const txSig = await driftClient.placeAndMakeSignedMsgPerpOrder(
    signedOrderParams,          // { orderParams: Buffer, signature: Buffer }
    uuidBytes,                  // Uint8Array
    {
      taker: takerPubkey,
      takerStats: takerStatsPubkey,
      takerUserAccount,
      signingAuthority,
    },
    makerOrderParams,           // your maker order
  );
 
  console.log("Filled SWIFT order:", txSig);
}
```

`Method DriftClient.placeAndMakeSignedMsgPerpOrder` Reference ↗

`SignedMsgOrderParams`

`Uint8Array `

`{ taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }`

`OptionalOrderParams`

`ReferrerInfo`

`TxParams`

`number`

`TransactionInstruction[]`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `signedSignedMsgOrderParams` | Yes |
| `signedMsgOrderUuid` | Yes |
| `takerInfo` | Yes |
| `orderParams` | Yes |
| `referrerInfo` | No |
| `txParams` | No |
| `subAccountId` | No |
| `precedingIxs` | No |
| `overrideCustomIxIndex` | No |

| Returns |
| --- |
| `Promise ` |

### Build instructions manually

If you need more control over transaction construction (e.g., custom priority fees, specific ALTs, or bundling multiple instructions):

TypeScript

```
import { Transaction } from "@solana/web3.js";
 
// Same params as placeAndMakeSignedMsgPerpOrder, returns instruction array
const ixs = await driftClient.getPlaceAndMakeSignedMsgPerpOrderIxs(
  signedOrderParams,  // { orderParams, signature }
  uuidBytes,          // Uint8Array
  { taker: takerPubkey, takerStats: takerStatsPubkey, takerUserAccount, signingAuthority },
  makerOrderParams,
);
 
// ixs includes:
// 1. ed25519 verification instruction (proves taker signature)
// 2. place-and-make instruction (places your order + fills taker)
 
// Send transaction with your preferred method
const tx = new Transaction().add(...ixs);
const txSig = await connection.sendTransaction(tx, [wallet.payer]);
```

`Method DriftClient.getPlaceAndMakeSignedMsgPerpOrderIxs` Reference ↗

`SignedMsgOrderParams`

`Uint8Array `

`{ taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }`

`OptionalOrderParams`

`ReferrerInfo`

`number`

`TransactionInstruction[]`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `signedSignedMsgOrderParams` | Yes |
| `signedMsgOrderUuid` | Yes |
| `takerInfo` | Yes |
| `orderParams` | Yes |
| `referrerInfo` | No |
| `subAccountId` | No |
| `precedingIxs` | No |
| `overrideCustomIxIndex` | No |

| Returns |
| --- |
| `Promise ` |

## SWIFT vs onchain auction flow

### SWIFT flow

Timeline:

### Taker signs order offchain

Taker signs and prepares the order message.

### Broadcast to SWIFT WebSocket

The signed message is broadcast to SWIFT (~50ms).

### Maker receives order

Maker gets the order before it lands onchain (~100-500ms total).

### Maker submits place-and-make

Maker submits a place-and-make transaction.

### Taker order lands onchain

Taker transaction lands onchain (~1-2s total).

### Maker fill lands

Maker fill transaction lands (ideally same slot).

Latency advantage:

- Makers see orders 100-500ms before onchain
- Faster reaction time → better auction slot
- Competitive edge for pricing and flow selection

Requirements:

- Subscribe to SWIFT WebSocket
- Handle ed25519 verification (SDK does this)
- Fast infrastructure to capitalize on latency advantage
- Dedicated RPC node recommended

### Standard onchain auction

Timeline:

### Taker submits tx to Solana

Order transaction is sent directly onchain.

### Transaction lands onchain

The taker tx lands (~1-2s).

### RPC/gRPC subscription fires

Makers receive the auction event from onchain subscriptions.

### Maker computes fill

Maker processes pricing and risk checks.

### Maker submits place-and-make

Maker sends the fill transaction.

### Fill lands

Fill lands onchain (~1-2s later).

Total latency: 2-4 seconds from taker intent to maker fill

See JIT Auctions for full auction mechanics.

## Filtering and risk management

Use the same filters as other JIT flows: oracle validation, position limits, and toxic-flow detection. See Bot Architecture - Risk and filtering for shared patterns and code.

## Detecting SWIFT orders in onchain feeds

When subscribed to both SWIFT and onchain feeds, you may see the same order twice:

### First via SWIFT WebSocket (offchain)

You receive the signed order from SWIFT before onchain landing.

### Again when it lands onchain

The same order appears in your onchain subscription stream later.

Use`isSignedMsgOrder()` to identify SWIFT-origin orders and avoid double-handling:

TypeScript

```
import { isSignedMsgOrder } from "@drift-labs/sdk";
 
// In your AuctionSubscriber callback
auctionSubscriber.eventEmitter.on("onAccountUpdate", async (userAccount, pubkey, slot) => {
  for (const order of userAccount.orders) {
    if (order.baseAssetAmount.isZero()) continue;
 
    if (isSignedMsgOrder(order)) {
      // This came from SWIFT, you already saw it via WebSocket
      // Skip to avoid submitting a duplicate fill
      continue;
    }
 
    // Handle regular onchain auction
    await handleAuction(order, userAccount, pubkey, slot);
  }
});
```

`Function isSignedMsgOrder` Reference ↗

`Order`

| Parameter | Type | Required |
| --- | --- | --- |
| `order` | Yes |

| Returns |
| --- |
| `boolean` |

## Performance considerations

Latency optimization:

- Use dedicated RPC nodes for fastest transaction submission
- Pre-compute oracle prices and risk checks
- Keep WebSocket connection persistent (auto-reconnect on disconnect)
- Use`commitment: "processed"` for fastest confirmations

Reliability:

- Handle WebSocket reconnections gracefully
- Have fallback to standard auction participation (via`AuctionSubscriber`)
- Monitor fill rates and adjust strategy
- Track SWIFT vs onchain fill success rates separately

Cost:

- SWIFT fills pay same maker rebates as regular fills
- No additional fees for SWIFT participation
- Transaction costs same as place-and-make

## Gotchas

- SWIFT is not guaranteed flow: not all taker orders go through SWIFT. Takers using the standard SDK flow submit directly onchain. You should subscribe to both SWIFT and`AuctionSubscriber` for complete coverage, using`isSignedMsgOrder()` to deduplicate.
- ed25519 instruction ordering: the ed25519 verification instruction must be the first instruction in the transaction. The SDK handles this, but if building transactions manually, incorrect ordering causes silent verification failures.
- Latency advantage is perishable: the 100-500ms head start from SWIFT only helps if your fill transaction lands quickly. With a slow RPC node, the advantage is wasted. Use a dedicated RPC node with staked connections for fastest landing.
- UserAccount resolution: the`userAccountGetter` callback should return quickly. If it requires an RPC call per order, you’ll negate the latency advantage. Pre-load user accounts via`UserMap` subscription.
- Order expiry: SWIFT signed orders have a`maxTs` field. If your fill transaction lands after this timestamp, it will fail. Check remaining time before submitting.
- Fallback strategy: if the SWIFT WebSocket disconnects, your bot should seamlessly fall back to standard`AuctionSubscriber` flow. Don’t let a SWIFT outage stop you from filling auctions.

## Related

- JIT Auctions- Understanding auction mechanics and pricing
- JIT-only MM- JIT market making strategy
- Orderbook & Matching- How orders are matched
- Bot Architecture- Reconnection, error handling, and production patterns
- Indicative Quotes- Signal liquidity offchain alongside SWIFT fills

Last updated on February 27, 2026

JIT Auctions Indicative Quotes

 

---
