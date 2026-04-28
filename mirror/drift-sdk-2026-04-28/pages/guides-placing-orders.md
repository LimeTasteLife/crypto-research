# Placing Orders
URL: https://mintlify.com/drift-labs/protocol-v2/guides/placing-orders

# Placing Orders

## Order helpers

```typescript
import {
  getMarketOrderParams, getLimitOrderParams,
  getTriggerMarketOrderParams, getTriggerLimitOrderParams,
  getOracleOrderParams, getOrderParams,
  PositionDirection, PostOnlyParams, OrderType, MarketType,
  BN, BASE_PRECISION, PRICE_PRECISION
} from '@drift-labs/sdk';
```

## Place perp order

```typescript
const orderParams = getMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
});

const txSig = await driftClient.placePerpOrder(orderParams);
```

## Place spot order

```typescript
await driftClient.placeSpotOrder({
  orderType: OrderType.LIMIT,
  marketIndex: 1, // SOL spot
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToSpotPrecision(1, 1),
  price: driftClient.convertToPricePrecision(150),
});
```

## Place multiple orders

```typescript
await driftClient.placeOrders([
  { orderType: OrderType.LIMIT, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.LONG, baseAssetAmount: ..., price: ... },
  { orderType: OrderType.LIMIT, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.SHORT, baseAssetAmount: ..., oraclePriceOffset: ... },
]);
```

## Order flags

| Flag | Effect |
| --- | --- |
| `reduceOnly: true` | Cannot increase position; required for safe close |
| `postOnly: PostOnlyParams.MUST_POST_ONLY` | Tx fails if order would cross |
| `immediateOrCancel: true` | Cancel any unfilled portion immediately |

## Trigger orders (stop / take-profit)

```typescript
const stopLoss = getTriggerMarketOrderParams({
  baseAssetAmount: position.baseAssetAmount.abs(),
  direction: PositionDirection.SHORT, // for closing long
  marketIndex,
  triggerPrice: new BN(95).mul(PRICE_PRECISION),
  triggerCondition: OrderTriggerCondition.BELOW,
});
```

## Oracle orders (auto-track oracle)

```typescript
const orderParams = {
  orderType: OrderType.ORACLE,
  marketIndex: 0,
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToPerpPrecision(1),
  oraclePriceOffset: -1_000_000, // -$1 from oracle
  postOnly: PostOnlyParams.MUST_POST_ONLY,
};
```

## Cancel + place atomically (re-quoting)

```typescript
await driftClient.cancelAndPlaceOrders(
  { marketType: MarketType.PERP, marketIndex: 0 },
  [/* new orders */]
);
```
