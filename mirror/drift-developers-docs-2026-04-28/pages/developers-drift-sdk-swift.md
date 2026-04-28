# Swift (off-chain signed orders) – Drift Protocol

Source: https://docs.drift.trade/developers/drift-sdk/swift

Swift (off-chain signed orders) – Drift Protocol

Skip to Content

Developers Drift SDK Swift (off-chain signed orders)

Copy page

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

TypeScript

```
import {
  getMarketOrderParams, MarketType, PositionDirection, isVariant
} from "@drift-labs/sdk";
 
const marketIndex = 0; // SOL-PERP
 
const oracleInfo = driftClient.getOracleDataForPerpMarket(marketIndex);
const direction = PositionDirection.LONG;
 
// Set auction price range around the current oracle price
const highPrice = oracleInfo.price.muln(101).divn(100); // oracle + 1%
const lowPrice = oracleInfo.price;
 
const orderParams = getMarketOrderParams({
  marketIndex,
  marketType: MarketType.PERP,
  direction,
  baseAssetAmount: driftClient.convertToPerpPrecision(0.1), // 0.1 SOL
  auctionStartPrice: isVariant(direction, "long") ? lowPrice : highPrice,
  auctionEndPrice: isVariant(direction, "long") ? highPrice : lowPrice,
  auctionDuration: 50, // slots for market makers to compete
});
```

`Example Swift order setup` Reference ↗

TypeScript docs unavailable for`Swift order setup`.

### Step 2: Sign the order message

Sign the order parameters off-chain using your DriftClient’s wallet. This produces a serialized message and signature that the Swift API will verify:

TypeScript

```
import { generateSignedMsgUuid } from "@drift-labs/sdk";
 
const slot = await driftClient.connection.getSlot();
 
const orderMessage = {
  signedMsgOrderParams: orderParams,
  subAccountId: driftClient.activeSubAccountId,
  slot: new BN(slot),
  uuid: generateSignedMsgUuid(), // unique ID for deduplication
  stopLossOrderParams: null,
  takeProfitOrderParams: null,
};
 
const { orderParams: message, signature } =
  driftClient.signSignedMsgOrderParamsMessage(orderMessage);
```

`Method DriftClient.signSignedMsgOrderParamsMessage` Reference ↗

`SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage`

`boolean`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParamsMessage` | Yes |
| `delegateSigner` | No |

| Returns |
| --- |
| `SignedMsgOrderParams` |

### Step 3: Submit to the Swift API

POST the signed message to the Swift endpoint. The API validates the signature and queues the order for keepers and market makers:

TypeScript

```
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
    // signing_authority: delegatePublicKey.toBase58(), // only needed for delegate flows
  }),
});
 
if (!response.ok) {
  const errorText = await response.text();
  throw new Error("Swift error: " + response.status + " " + errorText);
}
```

`Example Swift API submit` Reference ↗

TypeScript docs unavailable for`Swift API submit`.

Delegate flows: When signing as a delegate for another account, also pass`signing_authority`(the delegate’s public key) and ensure`taker_authority` is the account owner’s public key. Initialize the DriftClient with`authority` set to the owner’s key.

### Signed message accounts (delegate flow)

For delegate accounts, you can initialize a`SignedMsgUserOrders` account to allow a delegate to place Swift orders on behalf of the owner:

TypeScript

```
import { getSignedMsgUserAccountPublicKey } from "@drift-labs/sdk";
 
// Derive the PDA for the signed message orders account
const pda = getSignedMsgUserAccountPublicKey(driftClient.program.programId, authority);
```

`Function getSignedMsgUserAccountPublicKey` Reference ↗

`PublicKey`

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `programId` | Yes |
| `authority` | Yes |

| Returns |
| --- |
| `PublicKey` |

TypeScript

```
// Initialize the signed message orders account for `authority`
// with space for 8 concurrent orders
const [txSig, signedMsgUserAccount] =
  await driftClient.initializeSignedMsgUserOrders(authority, 8);
```

`Method DriftClient.initializeSignedMsgUserOrders` Reference ↗

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
| `Promise<[string, PublicKey]>` |

### Decode signed messages

Decode a raw signed message (e.g., received from the Swift API or another source) back into structured order params:

TypeScript

```
const signedMessage = driftClient.decodeSignedMsgOrderParamsMessage(
  Buffer.from(orderMessageHex, "hex"),
  isDelegateSigner  // true if the message was signed by a delegate
);
```

`Method DriftClient.decodeSignedMsgOrderParamsMessage` Reference ↗

`Buffer`

`boolean`

| Parameter | Type | Required |
| --- | --- | --- |
| `encodedMessage` | Yes |
| `delegateSigner` | No |

| Returns |
| --- |
| `SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage` |

### Instruction builders (Swift taker + maker)

For advanced use cases (such as building keeper or market-maker bots), you can construct Swift fill instructions directly instead of using the HTTP API flow.

Build the taker-side instructions for placing a Swift order on-chain:

TypeScript

```
// Used by keeper bots to submit a taker's signed Swift order on-chain
const ixs = await driftClient.getPlaceSignedMsgTakerPerpOrderIxs(
  { orderParams: orderMessageHex, signature },
  marketIndex,
  takerInfo
);
```

`Method DriftClient.getPlaceSignedMsgTakerPerpOrderIxs` Reference ↗

`SignedMsgOrderParams`

`number`

`{ taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }`

`TransactionInstruction[]`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `signedSignedMsgOrderParams` | Yes |
| `marketIndex` | Yes |
| `takerInfo` | Yes |
| `precedingIxs` | No |
| `overrideCustomIxIndex` | No |

| Returns |
| --- |
| `Promise ` |

Build instructions to place a maker order and simultaneously fill a pending Swift taker order (atomic maker fill):

TypeScript

```
// Used by market makers to fill a taker's Swift order with their own maker quote
const ixs = await driftClient.getPlaceAndMakeSignedMsgPerpOrderIxs(
  signedMsgOrderParams,
  signedMsgOrderUuid,
  takerInfo,
  makerOrderParams
);
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

### Helper functions

Generate a unique UUID for a Swift order message. Each order must have a distinct UUID to prevent replay attacks:

TypeScript

```
import { generateSignedMsgUuid } from "@drift-labs/sdk";
 
const uuid = generateSignedMsgUuid();
```

`Function generateSignedMsgUuid` Reference ↗

| Returns |
| --- |
| `Uint8Array ` |

Hash a signature for use in order deduplication or indexing:

TypeScript

```
import { digestSignature } from "@drift-labs/sdk";
 
const hash = digestSignature(Uint8Array.from(signature));
```

`Function digestSignature` Reference ↗

`Uint8Array `

| Parameter | Type | Required |
| --- | --- | --- |
| `signature` | Yes |

| Returns |
| --- |
| `string` |

Derive the user stats account PDA for an authority:

TypeScript

```
import { getUserStatsAccountPublicKey } from "@drift-labs/sdk";
 
const userStats = getUserStatsAccountPublicKey(
  driftClient.program.programId,
  authority
);
```

`Function getUserStatsAccountPublicKey` Reference ↗

`PublicKey`

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `programId` | Yes |
| `authority` | Yes |

| Returns |
| --- |
| `PublicKey` |

Last updated on February 27, 2026

Swaps (Jupiter) Builder Codes
