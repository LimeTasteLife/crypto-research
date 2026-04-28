# Orders – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/orders

# Orders

## How it works

Orders on Drift go through a multi-stage matching process. When you place an order, it enters a JIT auction (Just-In-Time) where market makers can compete to fill it at better prices. If no one fills during the auction, the order either executes against the DLOB (Decentralized Limit Order Book) or the AMM as a fallback.

Orders are stored in your user account and have both an onchain order ID and an optional user-assigned ID for tracking. When an order fills, your position updates automatically.

## Order Types

| Type | Description |
| --- | --- |
| `MARKET` | Executes immediately. Goes through a JIT auction first (controlled by `auctionStartPrice`, `auctionEndPrice`, `auctionDuration`), then fills against the DLOB or AMM. |
| `LIMIT` | Rests on the DLOB at a fixed price until filled or canceled. Set `postOnly: PostOnlyParams.MUST_POST_ONLY` to guarantee maker status. |
| `ORACLE` | Like a market order, but auction prices and the resting limit price are expressed as offsets from the oracle price (not absolute prices). |
| `TRIGGER_MARKET` | A stop/take-profit market order. Executes as a market order when the oracle price crosses `triggerPrice` in the specified `triggerCondition` direction. |
| `TRIGGER_LIMIT` | A stop/take-profit limit order. Same trigger mechanism but executes as a limit order at `price` once triggered. |

### Post-Only Params

| Value | Behavior |
| --- | --- |
| `PostOnlyParams.NONE` | Order can be maker or taker (default) |
| `PostOnlyParams.MUST_POST_ONLY` | Transaction fails if the order would cross the spread |
| `PostOnlyParams.TRY_POST_ONLY` | Order is silently skipped (not placed) if it would cross |
| `PostOnlyParams.SLIDE` | Order price is adjusted one tick inside the spread to guarantee maker status |

## SDK Usage

### Build Market Order Params

```typescript
import { BN, BASE_PRECISION, MarketType, PositionDirection, getMarketOrderParams } from "@drift-labs/sdk";

const orderParams = getMarketOrderParams({
  marketIndex: 0,
  marketType: MarketType.PERP,
  direction: PositionDirection.LONG,
  baseAssetAmount: new BN(1).mul(BASE_PRECISION), // 1 SOL (in 1e9 precision)
});
```

### Build Order Params (Generic Helper)

```typescript
import { getOrderParams, OrderType, PositionDirection } from "@drift-labs/sdk";

const orderParams = getOrderParams({
  orderType: OrderType.LIMIT,
  marketIndex: 0,
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToPerpPrecision(1),
  price: driftClient.convertToPricePrecision(21.23),
});
```

### Place a Perp Order

```typescript
const txSig = await driftClient.placePerpOrder(
  getMarketOrderParams({
    marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  })
);
```

### Place a Spot Order

```typescript
import { OrderType, PositionDirection } from "@drift-labs/sdk";

await driftClient.placeSpotOrder({
  orderType: OrderType.LIMIT,
  marketIndex: 1, // e.g. SOL spot
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToSpotPrecision(1, 1), // 1 SOL
  price: driftClient.convertToPricePrecision(150),
});
```

### Place Multiple Orders

```typescript
await driftClient.placeOrders([
  { orderType: OrderType.LIMIT, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    price: driftClient.convertToPricePrecision(21.23) },
  { orderType: OrderType.LIMIT, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.SHORT,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    oraclePriceOffset: driftClient.convertToPricePrecision(0.05).toNumber() },
]);
```

### Oracle / Auction-Style Orders

```typescript
import { BN, OrderType, PositionDirection, PRICE_PRECISION } from "@drift-labs/sdk";

const auctionStartPrice = PRICE_PRECISION.muln(-5).divn(10); // -$0.50 below oracle
const auctionEndPrice = PRICE_PRECISION.muln(5).divn(10);    // +$0.50 above oracle

await driftClient.placePerpOrder({
  orderType: OrderType.ORACLE,
  baseAssetAmount: driftClient.convertToPerpPrecision(10),
  direction: PositionDirection.LONG,
  marketIndex: 18,
  auctionStartPrice,
  auctionEndPrice,
  oraclePriceOffset: driftClient.convertToPricePrecision(0.30).toNumber(),
  auctionDuration: 30, // slots
});
```

### Cancel Orders

```typescript
await driftClient.cancelOrder(1);                              // by order id
await driftClient.cancelOrdersByIds([1, 2, 3]);                // multiple
await driftClient.cancelOrders(MarketType.PERP, 0, PositionDirection.LONG); // filtered
await driftClient.cancelOrders(null, null, null);              // cancel ALL
```

### Cancel and Place (Atomic)

Atomically cancels existing orders and places new ones in a single transaction. Preferred for market makers replacing quotes.

```typescript
await driftClient.cancelAndPlaceOrders(
  { marketType: MarketType.PERP, marketIndex: 0 },
  [{ orderType: OrderType.LIMIT, marketIndex: 0, direction: PositionDirection.LONG,
     baseAssetAmount: driftClient.convertToPerpPrecision(1),
     price: driftClient.convertToPricePrecision(21.23) }]
);
```

### Modify Orders

```typescript
await driftClient.modifyOrder({ orderId: 1, newBaseAmount: driftClient.convertToPerpPrecision(2) });
await driftClient.modifyOrderByUserOrderId({ userOrderId: 1, newBaseAmount: driftClient.convertToPerpPrecision(2) });
```

### Trigger Orders (Stop / Take-Profit)

```typescript
import { OrderTriggerCondition, OrderType, PositionDirection } from "@drift-labs/sdk";

await driftClient.placePerpOrder({
  orderType: OrderType.TRIGGER_MARKET,
  marketIndex: 0,
  direction: PositionDirection.SHORT,
  baseAssetAmount: driftClient.convertToPerpPrecision(1),
  triggerPrice: driftClient.convertToPricePrecision(95),
  triggerCondition: OrderTriggerCondition.BELOW,
});
```

### Instruction Builders (Advanced)

The IX builders return raw `TransactionInstruction` objects so you can: set custom compute budget with priority fees, batch multiple instructions atomically, use Address Lookup Tables (ALTs), compose with other programs.

Available IX builders: `getPlacePerpOrderIx`, `getPlaceSpotOrderIx`, `getCancelOrdersIx`, `getFillPerpOrderIx`, `getFillSpotOrderIx`, `getTriggerOrderIx`, `getRevertFillIx`, `getSettlePNLsIxs`, `getJupiterSwapIxV6`.

Last updated on February 27, 2026
