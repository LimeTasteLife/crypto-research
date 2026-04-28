# OrderParams
URL: https://mintlify.com/drift-labs/protocol-v2/api/trading/order-params

# OrderParams

Parameters and configuration for placing orders.

## OrderParams type

```typescript
type OrderParams = {
  orderType: OrderType;
  marketType: MarketType;
  userOrderId: number;
  direction: PositionDirection;
  baseAssetAmount: BN;
  price: BN;
  marketIndex: number;
  reduceOnly: boolean;
  postOnly: PostOnlyParams;
  bitFlags: number;
  triggerPrice: BN | null;
  triggerCondition: OrderTriggerCondition;
  oraclePriceOffset: number | null;
  auctionDuration: number | null;
  maxTs: BN | null;
  auctionStartPrice: BN | null;
  auctionEndPrice: BN | null;
};
```

## Helper functions

```typescript
getMarketOrderParams(params): OptionalOrderParams
getLimitOrderParams(params): OptionalOrderParams
getTriggerMarketOrderParams(params): OptionalOrderParams
getTriggerLimitOrderParams(params): OptionalOrderParams
getOracleOrderParams(params): OptionalOrderParams
getOrderParams(optionalOrderParams, overridingParams?): OrderParams
```

## ScaleOrderParams

```typescript
type ScaleOrderParams = {
  marketType: MarketType;
  direction: PositionDirection;
  marketIndex: number;
  totalBaseAssetAmount: BN;
  startPrice: BN;
  endPrice: BN;
  orderCount: number; // 2-32
  sizeDistribution: SizeDistribution;
  reduceOnly: boolean;
  postOnly: PostOnlyParams;
  bitFlags: number;
  maxTs: BN | null;
};
```

## ModifyOrderParams

```typescript
type ModifyOrderParams = {
  [Property in keyof OrderParams]?: OrderParams[Property] | null;
} & { policy?: ModifyOrderPolicy };
```
