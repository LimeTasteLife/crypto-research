# Swift (off-chain signed orders) – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/swift

# Swift (off-chain signed orders)

Swift is an extension to Drift that lets users place orders without submitting a transaction to the Solana network. Instead of paying gas and waiting for confirmation, users sign an order message off-chain and submit it to the Swift API. Keepers and market makers then bundle the signed message with their own transaction to fill the order on-chain.

This enables faster order placement, lower latency, and a gas-free experience for takers, while market makers still settle on-chain.

Order flow:

1. Define order parameters
2. Sign the order message off-chain
3. Submit to the Swift API (`https://swift.drift.trade/orders`)
4. Keepers/market makers pick up the order and fill it on-chain

### Step 1: Define order parameters

Set up a standard Drift order. For Swift, you typically use a market order with auction parameters that give market makers a window to fill:

```typescript
import { getMarketOrderParams, MarketType, PositionDirection, isVariant } from "@drift-labs/sdk";

const marketIndex = 0; // SOL-PERP

const oracleInfo = driftClient.getOracleDataForPerpMarket(marketIndex);
const direction = PositionDirection.LONG;

const highPrice = oracleInfo.price.muln(101).divn(100); // oracle + 1%
const lowPrice = oracleInfo.price;

const orderParams = getMarketOrderParams({
  marketIndex,
  marketType: MarketType.PERP,
  direction,
  baseAssetAmount: driftClient.convertToPerpPrecision(0.1),
  auctionStartPrice: isVariant(direction, "long") ? lowPrice : highPrice,
  auctionEndPrice: isVariant(direction, "long") ? highPrice : lowPrice,
  auctionDuration: 50, // slots for market makers to compete
});
```

### Step 2: Sign the order message

```typescript
import { generateSignedMsgUuid } from "@drift-labs/sdk";

const slot = await driftClient.connection.getSlot();

const orderMessage = {
  signedMsgOrderParams: orderParams,
  subAccountId: driftClient.activeSubAccountId,
  slot: new BN(slot),
  uuid: generateSignedMsgUuid(),
  stopLossOrderParams: null,
  takeProfitOrderParams: null,
};

const { orderParams: message, signature } =
  driftClient.signSignedMsgOrderParamsMessage(orderMessage);
```

### Step 3: Submit to the Swift API

```typescript
const swiftUrl = "https://swift.drift.trade/orders";

const response = await fetch(swiftUrl, {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    market_index: orderParams.marketIndex,
    market_type: "perp",
    message: message.toString("hex"),
    signature: signature.toString("hex"),
    taker_authority: driftClient.wallet.publicKey.toBase58(),
  }),
});
```

Delegate flows: When signing as a delegate for another account, also pass `signing_authority` (the delegate's public key) and ensure `taker_authority` is the account owner's public key.

### Signed message accounts (delegate flow)

For delegate accounts, you can initialize a `SignedMsgUserOrders` account to allow a delegate to place Swift orders on behalf of the owner:

```typescript
import { getSignedMsgUserAccountPublicKey } from "@drift-labs/sdk";

const pda = getSignedMsgUserAccountPublicKey(driftClient.program.programId, authority);

// Initialize with space for 8 concurrent orders
const [txSig, signedMsgUserAccount] =
  await driftClient.initializeSignedMsgUserOrders(authority, 8);
```

### Decode signed messages

```typescript
const signedMessage = driftClient.decodeSignedMsgOrderParamsMessage(
  Buffer.from(orderMessageHex, "hex"),
  isDelegateSigner
);
```

### Instruction builders (Swift taker + maker)

```typescript
// Taker-side: keeper places a taker's signed Swift order on-chain
const ixs = await driftClient.getPlaceSignedMsgTakerPerpOrderIxs(
  { orderParams: orderMessageHex, signature },
  marketIndex,
  takerInfo
);

// Place-and-make: market maker fills a pending Swift taker order atomically
const ixs2 = await driftClient.getPlaceAndMakeSignedMsgPerpOrderIxs(
  signedMsgOrderParams,
  signedMsgOrderUuid,
  takerInfo,
  makerOrderParams
);
```

### Helper functions

```typescript
import { generateSignedMsgUuid, digestSignature, getUserStatsAccountPublicKey } from "@drift-labs/sdk";

const uuid = generateSignedMsgUuid();
const hash = digestSignature(Uint8Array.from(signature));
const userStats = getUserStatsAccountPublicKey(driftClient.program.programId, authority);
```

Last updated on February 27, 2026
