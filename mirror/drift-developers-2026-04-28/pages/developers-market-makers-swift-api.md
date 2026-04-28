# SWIFT API – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/swift-api

# SWIFT API

SWIFT (Signed Wrapped Instant Fulfillment Transactions) allows market makers to receive signed taker orders offchain via WebSocket before they hit the JIT auction. This enables ultra-low-latency market making.

## How SWIFT works

1. Taker signs order offchain
2. Order is broadcast to SWIFT WebSocket simultaneously with onchain submission
3. Makers receive order ~100-500ms before it lands onchain
4. Makers submit place-and-make tx with ed25519 verification, atomically filling the taker

Key benefit: 100-500ms head start lets you price more accurately, win more auctions, react to flow faster.

Tradeoff: Requires fast infrastructure (dedicated RPC node, low-latency WebSocket).

## Subscribing to SWIFT orders

```typescript
import { SwiftOrderSubscriber, loadKeypair } from "@drift-labs/sdk";

const swiftSubscriber = new SwiftOrderSubscriber({
  driftClient,
  driftEnv: "mainnet-beta",
  marketIndexes: [0, 1, 2], // SOL, BTC, ETH perp markets
  keypair: loadKeypair("<KEYPAIR_PATH>"),
});

await swiftSubscriber.subscribe(
  async (orderMessageRaw, signedMessage, isDelegateSigner) => {
    const orderParams = signedMessage.signedMsgOrderParams;

    if (shouldFill(orderParams)) {
      await fillSwiftOrder(signedMessage);
    }
  }
);
```

### With UserAccount getter

Optionally provide a `userAccountGetter` (e.g., `UserMap`) to resolve taker UserAccount details for risk analysis.

## Place-and-make with SWIFT

SWIFT fills use `placeAndMakeSignedMsgPerpOrder`, which includes an ed25519 signature verification.

```typescript
import {
  getLimitOrderParams, getUserAccountPublicKey, getUserStatsAccountPublicKey,
  isVariant, PositionDirection, PostOnlyParams,
} from "@drift-labs/sdk";

async function fillSwiftOrder(orderMessageRaw, signedMessage, isDelegateSigner) {
  const takerAuthority = new PublicKey(orderMessageRaw.taker_authority);
  const signingAuthority = new PublicKey(orderMessageRaw.signing_authority);
  const subAccountId = signedMessage.subAccountId;

  const signedOrderParams = {
    orderParams: Buffer.from(orderMessageRaw.order_message, "hex"),
    signature: Buffer.from(orderMessageRaw.order_signature, "base64"),
  };

  const uuidBytes = new TextEncoder().encode(orderMessageRaw.uuid);

  const takerPubkey = await getUserAccountPublicKey(
    driftClient.program.programId, takerAuthority, subAccountId
  );
  const takerStatsPubkey = getUserStatsAccountPublicKey(
    driftClient.program.programId, takerAuthority
  );

  const takerIsLong = isVariant(signedMessage.signedMsgOrderParams.direction, "long");
  const makerOrderParams = getLimitOrderParams({
    marketIndex: signedMessage.signedMsgOrderParams.marketIndex,
    direction: takerIsLong ? PositionDirection.SHORT : PositionDirection.LONG,
    baseAssetAmount: signedMessage.signedMsgOrderParams.baseAssetAmount,
    price: myFillPrice,
    postOnly: PostOnlyParams.MUST_POST_ONLY,
  });

  const takerUserAccount = await userMap.mustGetUserAccount(takerPubkey.toString());

  const txSig = await driftClient.placeAndMakeSignedMsgPerpOrder(
    signedOrderParams,
    uuidBytes,
    { taker: takerPubkey, takerStats: takerStatsPubkey, takerUserAccount, signingAuthority },
    makerOrderParams,
  );
}
```

For more transaction-construction control, use `getPlaceAndMakeSignedMsgPerpOrderIxs`.

## Detecting SWIFT orders in onchain feeds

When subscribed to both SWIFT and onchain feeds, use `isSignedMsgOrder()` to identify SWIFT-origin orders and avoid double-handling.

```typescript
import { isSignedMsgOrder } from "@drift-labs/sdk";

if (isSignedMsgOrder(order)) continue; // already saw it via SWIFT
```

## Performance

- Use dedicated RPC nodes for fastest tx submission
- Pre-compute oracle prices and risk checks
- Persistent WebSocket with auto-reconnect
- `commitment: "processed"` for fastest confirmations

Cost: SWIFT fills pay same maker rebates as regular fills; no additional fees.

## Gotchas

- SWIFT is not guaranteed flow; always also subscribe to `AuctionSubscriber` and dedupe via `isSignedMsgOrder()`.
- ed25519 instruction must be first in transaction (SDK handles this).
- Latency advantage is perishable — slow RPC negates it.
- `userAccountGetter` should return quickly; pre-load via `UserMap`.
- SWIFT signed orders have `maxTs` field; check before submitting.
- Implement fallback: WebSocket disconnects must not stop your bot from filling.

Last updated on February 27, 2026
