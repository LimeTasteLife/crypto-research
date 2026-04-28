# JIT-only MM – Drift Protocol

Source: https://docs.drift.trade/developers/market-makers/jit-only

JIT-only MM – Drift Protocol

Skip to Content

Developers Market Makers JIT-only MM

Copy page

# JIT-only MM

JIT-only market making means you do not keep a standing book. Instead of resting limit orders on the DLOB, you compete in JIT auctions(see Matching Engine for liquidity sources) by reacting to incoming taker orders in real-time.

Why JIT-only?

- No adverse selection from stale quotes: you only commit capital when you choose to fill
- Selective flow: you inspect each taker order and decide if it’s profitable to fill
- Capital efficiency: no capital locked in resting orders that may never fill
- Dynamic pricing: price each fill based on current oracle, inventory, and market conditions

Tradeoff: You need lower-latency infrastructure than DLOB MM (to react within the auction window), and you may miss fills in fast markets if your bot is slow.

## Architecture overview

A JIT-only bot follows this loop:

### Subscribe

Subscribe to auction and order feeds (onchain via`AuctionSubscriber`, or offchain via SWIFT).

### Filter

Filter incoming auctions by oracle checks, position limits, toxic flow, and profitability.

### Price

Compute the best price you’re willing to offer based on current market and inventory conditions.

### Fill

Fill atomically via`placeAndMakePerpOrder` so your maker order is placed and matched in one transaction.

## Subscribe to auctions / orders

The`AuctionSubscriber` gives you a stream of active JIT auctions. Use`commitment: "processed"` for lowest latency.

TypeScript

```
import { AuctionSubscriber } from "@drift-labs/sdk";
```

`Class AuctionSubscriber` Reference ↗

`any`

`any`

`any`

`StrictEventEmitter `

`any`

`() => Promise `

`() => Promise `

| Property | Type | Required |
| --- | --- | --- |
| `driftClient` | Yes |
| `opts` | Yes |
| `resubOpts` | No |
| `eventEmitter` | Yes |
| `subscriber` | Yes |
| `subscribe` | Yes |
| `unsubscribe` | Yes |

```
import { AuctionSubscriber } from "@drift-labs/sdk";
 
const auctionSubscriber = new AuctionSubscriber({
  driftClient,
  opts: { commitment: "processed" },
});
await auctionSubscriber.subscribe();
```

For even lower latency, subscribe to SWIFT to receive signed taker orders 100-500ms before they land onchain.

`OrderSubscriber` is a lower-level alternative to`AuctionSubscriber`. It streams all user order state changes rather than only active auction events. Most JIT bots use`AuctionSubscriber` because it surfaces only the orders that are currently in an open auction window. Use`OrderSubscriber` if you need visibility into the full lifecycle of orders (e.g., tracking when orders are placed, partially filled, or cancelled) rather than just reacting to active auctions.

TypeScript

```
import { OrderSubscriber } from "@drift-labs/sdk";
```

`Class OrderSubscriber` Reference ↗

`DriftClient`

`Map `

`PollingSubscription | WebsocketSubscription | grpcSubscription`

`Commitment`

`StrictEventEmitter `

`Promise `

`() => void`

`number`

`(name: string, data: Buffer) => UserAccount`

`boolean`

`boolean`

`() => Promise `

`() => Promise `

`(key: string, dataType: "raw" | "decoded" | "buffer", data: UserAccount | Buffer | string[], slot: number) => void`

`(protectedMakerParamsMap?: ProtectMakerParamsMap | undefined) => DLOB`

Creates a new DLOB for the order subscriber to fill. This will allow a caller to extend the DLOB Subscriber with a custom DLOB type.

`(slot: number, protectedMakerParamsMap?: ProtectMakerParamsMap | undefined) => Promise `

`() => number`

`(userAccountPublicKey: PublicKey) => Promise `

`(key: string) => Promise `

`() => Promise `

| Property | Type | Required |
| --- | --- | --- |
| `driftClient` | Yes |
| `usersAccounts` | Yes |
| `subscription` | Yes |
| `commitment` | Yes |
| `eventEmitter` | Yes |
| `fetchPromise` | No |
| `fetchPromiseResolver` | Yes |
| `mostRecentSlot` | Yes |
| `decodeFn` | Yes |
| `decodeData` | No |
| `fetchAllNonIdleUsers` | No |
| `subscribe` | Yes |
| `fetch` | Yes |
| `tryUpdateUserAccount` | Yes |
| `createDLOB` | Yes |
| `getDLOB` | Yes |
| `getSlot` | Yes |
| `addPubkey` | Yes |
| `mustGetUserAccount` | Yes |
| `unsubscribe` | Yes |

## Compute auction prices (helpers)

Use`getAuctionPrice` to compute the current interpolated auction price at any slot. This tells you the worst price the taker would accept right now, so you need to offer a price at least this good.

TypeScript

```
import { getAuctionPrice, convertToNumber, PRICE_PRECISION } from "@drift-labs/sdk";
 
const currentSlot = await connection.getSlot();
const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);
 
// Get the current auction price at this slot
const auctionPriceBN = getAuctionPrice(takerOrder, currentSlot, oracle.price);
const auctionPrice = convertToNumber(auctionPriceBN, PRICE_PRECISION);
 
console.log(`Auction price at slot ${currentSlot}: $${auctionPrice.toFixed(4)}`);
```

`Function getAuctionPrice` Reference ↗

`Order`

`number`

`any`

Use MMOraclePriceData source for perp orders, OraclePriceData for spot

| Parameter | Type | Required |
| --- | --- | --- |
| `order` | Yes |
| `slot` | Yes |
| `oraclePrice` | Yes |

BN

| Returns |
| --- |
| `BN` |

See JIT Auctions - Auction pricing for the full interpolation formula and timeline explanation.

## Fill as maker (atomic place-and-make)

This pattern places your maker order and fills against the taker in one transaction. You earn maker rebates and the taker gets filled, all atomic.

TypeScript

```
import {
  OrderType,
  PositionDirection,
  PostOnlyParams,
} from "@drift-labs/sdk";
 
// Build your maker order (opposite direction of taker)
const makerOrderParams = {
  orderType: OrderType.LIMIT,
  marketIndex: takerOrder.marketIndex,
  direction: PositionDirection.SHORT, // if taker is LONG
  baseAssetAmount: takerOrder.baseAssetAmount,
  price: driftClient.convertToPricePrecision(myFillPrice),
  postOnly: PostOnlyParams.MUST_POST_ONLY,
};
 
// takerInfo: includes taker's public keys, user account, and the order to fill
const takerInfo = {
  taker: takerPubkey,                 // PublicKey of taker's user account PDA
  takerStats: takerStatsPubkey,       // PublicKey of taker's UserStats PDA
  takerUserAccount: takerUserAccount, // decoded UserAccount data
  order: takerOrder,                  // the specific Order to fill against
};
 
await driftClient.placeAndMakePerpOrder(makerOrderParams, takerInfo);
```

`Method DriftClient.placeAndMakePerpOrder` Reference ↗

`OptionalOrderParams`

`TakerInfo`

`ReferrerInfo`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `takerInfo` | Yes |
| `referrerInfo` | No |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

## Complete fill loop

Here’s a more complete example that ties the pieces together:

```
import {
  AuctionSubscriber,
  getAuctionPrice,
  getUserStatsAccountPublicKey,
  isSignedMsgOrder,
  isVariant,
  convertToNumber,
  PRICE_PRECISION,
  BASE_PRECISION,
  OrderType,
  PositionDirection,
  PostOnlyParams,
} from "@drift-labs/sdk";
 
const MAX_POSITION = 100; // max 100 SOL position
const MIN_SPREAD = 0.02;  // minimum $0.02 edge required
 
const auctionSubscriber = new AuctionSubscriber({
  driftClient,
  opts: { commitment: "processed" },
});
await auctionSubscriber.subscribe();
 
// Listen for auction events instead of polling
auctionSubscriber.eventEmitter.on("onAccountUpdate", async (takerUserAccount, pubkey, slot) => {
  for (const order of takerUserAccount.orders) {
    if (order.baseAssetAmount.isZero() || order.baseAssetAmount.eq(order.baseAssetAmountFilled)) continue;
    const userAccount = takerUserAccount;
 
    // Skip SWIFT orders if handling them via SwiftOrderSubscriber
    if (isSignedMsgOrder(order)) continue;
 
    const marketIndex = order.marketIndex;
    const oracle = driftClient.getMMOracleDataForPerpMarket(marketIndex);
 
    // Check oracle validity
    if (!oracle.isValid) continue;
 
    // Check position limits
    const user = driftClient.getUser();
    const position = user.getPerpPosition(marketIndex);
    const currentSize = position
      ? Math.abs(convertToNumber(position.baseAssetAmount, BASE_PRECISION))
      : 0;
    const fillSize = convertToNumber(order.baseAssetAmount, BASE_PRECISION);
    if (currentSize + fillSize > MAX_POSITION) continue;
 
    // Get current auction price (use slot from the event, not an RPC call)
    const auctionPriceBN = getAuctionPrice(order, slot, oracle.price);
    const auctionPrice = convertToNumber(auctionPriceBN, PRICE_PRECISION);
    const oraclePrice = convertToNumber(oracle.price, PRICE_PRECISION);
 
    // Calculate our fill price (oracle + small edge)
    const takerIsLong = isVariant(order.direction, "long");
    const edge = MIN_SPREAD;
    const myFillPrice = takerIsLong
      ? oraclePrice + edge   // sell to long taker above oracle
      : oraclePrice - edge;  // buy from short taker below oracle
 
    // Check if our price is within the auction range
    const isCompetitive = takerIsLong
      ? myFillPrice <= auctionPrice
      : myFillPrice >= auctionPrice;
 
    if (!isCompetitive) continue;
 
    // Fill!
    try {
      await driftClient.placeAndMakePerpOrder(
        {
          orderType: OrderType.LIMIT,
          marketIndex,
          direction: takerIsLong ? PositionDirection.SHORT : PositionDirection.LONG,
          baseAssetAmount: order.baseAssetAmount.sub(order.baseAssetAmountFilled),
          price: driftClient.convertToPricePrecision(myFillPrice),
          postOnly: PostOnlyParams.MUST_POST_ONLY,
        },
        {
          taker: pubkey,
          takerStats: getUserStatsAccountPublicKey(driftClient.program.programId, userAccount.authority),
          takerUserAccount: userAccount,
          order,
        }
      );
      console.log(`Filled ${fillSize} @ $${myFillPrice.toFixed(4)}`);
    } catch (err) {
      console.error("Fill failed:", err);
    }
  }
});
```

## Practical filters

Apply risk and filtering checks before filling: oracle validity, position limits, toxic-flow detection, and (if you use both feeds) skip Swift-origin orders via`isSignedMsgOrder()` so you don’t double-handle. See Bot Architecture - Risk and filtering for shared patterns and code.

TypeScript

```
import { isSignedMsgOrder } from "@drift-labs/sdk";
 
// In your AuctionSubscriber callback, skip orders that came from SWIFT
// so your onchain handler and SWIFT handler don't both try to fill the same order.
auctionSubscriber.eventEmitter.on("onAccountUpdate", async (userAccount, pubkey, slot) => {
  for (const order of userAccount.orders) {
    if (order.baseAssetAmount.isZero()) continue;
 
    if (isSignedMsgOrder(order)) {
      // Already handled via SwiftOrderSubscriber callback -- skip here
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

`getMMOracleDataForPerpMarket` is the recommended oracle getter for market makers. Unlike`getOracleDataForPerpMarket`, it returns MM-specific oracle data that includes a validity flag and confidence interval. Always check`oracle.isValid` before using the price. An invalid oracle means the data is stale or the price feed is unhealthy, and you should skip the fill rather than quote at a bad price.

Key fields:

- `oracle.price`: current oracle price as a`BN` in`PRICE_PRECISION`(1e6) units
- `oracle.isValid`: whether the oracle data is fresh and trustworthy
- `oracle.confidence`: price confidence interval from the oracle provider

TypeScript

```
import { convertToNumber, PRICE_PRECISION } from "@drift-labs/sdk";
 
const oracle = driftClient.getMMOracleDataForPerpMarket(marketIndex);
 
// Always guard against stale or unhealthy oracle data
if (!oracle.isValid) {
  console.warn("Oracle invalid for market", marketIndex, "-- skipping");
  return;
}
 
const oraclePrice = convertToNumber(oracle.price, PRICE_PRECISION);
const confidence = convertToNumber(oracle.confidence, PRICE_PRECISION);
 
console.log(`Oracle price: $${oraclePrice.toFixed(4)}, confidence: ±$${confidence.toFixed(4)}`);
 
// Optionally widen your spread when confidence is low
const minSpread = Math.max(0.05, confidence * 2);
```

`Method DriftClient.getMMOracleDataForPerpMarket` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `MMOraclePriceData` |

## Using JIT Proxy (JitterSniper / JitterShotgun)

Instead of building fill logic from scratch, use the@drift-labs/jit-proxy library which handles auction timing, transaction building, and retry logic:

```
import { JitterSniper, PriceType } from "@drift-labs/jit-proxy/lib";
 
const jitter = new JitterSniper({
  auctionSubscriber,
  driftClient,
  slotSubscriber,
});
 
await jitter.subscribe();
 
// The jitter handles auction timing automatically
// You just need to configure pricing and filters
```

See the JitMaker bot for a complete production example using`JitterSniper`/`JitterShotgun` with:

- Per-market subaccount isolation (1 subaccount per market)
- Volatility-based fill rejection (`isMarketVolatile`)
- DLOB-aware pricing (excludes own orders from best bid/ask calculation)
- Configurable target leverage and aggressiveness

## Gotchas

- Don’t poll`getSlot()` per auction: the example above calls`getSlot()` for each auction, which is expensive at scale. Instead, use a`SlotSubscriber` to cache the current slot and read from it synchronously.
- `isSignedMsgOrder` filtering: if you also subscribe to SWIFT, onchain auctions for SWIFT orders will appear in`AuctionSubscriber` too. Use`isSignedMsgOrder(order)` to skip them in your onchain loop (handle them in SWIFT callback instead). See SWIFT API.
- One subaccount per market: JIT fills can conflict if two markets try to use the same subaccount simultaneously. The`JitMaker` enforces 1:1 subaccount-to-market mapping.
- Fill rate tracking: track your fill success rate per market. If it drops below ~20%, your pricing or latency may need adjustment.

## Related

- JIT Auctions- Auction mechanics, pricing formula, and timeline
- SWIFT API- Receive orders 100-500ms faster via offchain WebSocket
- Bot Architecture- Priority fees, health monitoring, graceful shutdown
- DLOB MM- Resting order approach (can be combined with JIT)
- @drift-labs/jit-proxy- JIT proxy SDK with`JitterSniper` and`JitterShotgun`

Last updated on February 27, 2026

DLOB MM Bot Architecture Patterns
