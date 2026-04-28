# Orders
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/orders

# Orders

## Order Structure

```typescript
type Order = {
  status: OrderStatus;
  orderType: OrderType;
  marketType: MarketType;
  slot: BN;
  orderId: number;
  userOrderId: number;
  marketIndex: number;
  price: BN;
  baseAssetAmount: BN;
  quoteAssetAmount: BN;
  baseAssetAmountFilled: BN;
  quoteAssetAmountFilled: BN;
  direction: PositionDirection;
  reduceOnly: boolean;
  triggerPrice: BN;
  triggerCondition: OrderTriggerCondition;
  existingPositionDirection: PositionDirection;
  postOnly: boolean;
  immediateOrCancel: boolean;
  oraclePriceOffset: number;
  auctionDuration: number;
  auctionStartPrice: BN;
  auctionEndPrice: BN;
  maxTs: BN;
  bitFlags: number;
};
```

## Order Types

```typescript
class OrderType {
  static readonly LIMIT;
  static readonly TRIGGER_MARKET;
  static readonly TRIGGER_LIMIT;
  static readonly MARKET;
  static readonly ORACLE;
}
```

### Market Orders

Execute immediately at best available price. Use brief Dutch auction by default. May fill against AMM or matching limit orders.

### Limit Orders

Specify max/min price. Long: fill at price or better (lower); Short: fill at price or better (higher). Rest on orderbook if not immediately fillable.

### Trigger Orders

```typescript
class OrderTriggerCondition {
  static readonly ABOVE;
  static readonly BELOW;
  static readonly TRIGGERED_ABOVE;
  static readonly TRIGGERED_BELOW;
}
```

Stop-loss example:
```typescript
{ orderType: OrderType.TRIGGER_MARKET, direction: SHORT,
  triggerPrice: $95, triggerCondition: BELOW }
```

Take-profit example:
```typescript
{ orderType: OrderType.TRIGGER_LIMIT, direction: SHORT,
  triggerPrice: $110, triggerCondition: ABOVE, price: $109 }
```

### Oracle Orders

Use offset from oracle price. Effective limit price = oraclePrice + oraclePriceOffset.

## Order Parameters

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

### Post-Only Params

```typescript
class PostOnlyParams {
  static readonly NONE;            // Can be maker or taker
  static readonly MUST_POST_ONLY;  // Tx fails if taker
  static readonly TRY_POST_ONLY;   // Skip if taker
  static readonly SLIDE;           // Adjust price to be maker
}
```

### Reduce-Only

Cannot open new position, increase existing, or flip direction. Common for stop-loss/take-profit.

### IOC

```typescript
class OrderParamsBitFlag {
  static readonly ImmediateOrCancel = 1;
  static readonly UpdateHighLeverageMode = 2;
}
```

### Time-in-Force

`maxTs: new BN(Date.now() / 1000 + 3600)` — expire in 1 hour. Expired orders auto-cancelled.

## Order Status

```typescript
class OrderStatus {
  static readonly INIT;
  static readonly OPEN;
  static readonly FILLED;
  static readonly CANCELED;
}
```

## Order Execution

### Dutch Auction

1. Auction Start: order at premium (buy) / discount (sell)
2. Price Improvement: moves toward oracle over time
3. Auction End: after auctionDuration slots, fills at oracle price
4. Early Fill: at improved price during auction

`getAuctionPrice(order, slot, oraclePrice): BN`

### Order Matching Sources

1. DLOB Matching (resting limit orders)
2. AMM Fill
3. JIT Auction (keeper provides liquidity)
4. External DEX (Serum, Phoenix, OpenBook v2)

```typescript
class OrderActionExplanation {
  static readonly ORDER_FILLED_WITH_MATCH;
  static readonly ORDER_FILLED_WITH_AMM;
  static readonly ORDER_FILLED_WITH_AMM_JIT;
  static readonly ORDER_FILLED_WITH_OPENBOOK_V2;
}
```

## Scale Orders

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

class SizeDistribution {
  static readonly FLAT;
  static readonly ASCENDING;
  static readonly DESCENDING;
}
```

## Order Events

```typescript
type OrderActionRecord = {
  ts: BN;
  action: OrderAction;
  actionExplanation: OrderActionExplanation;
  marketIndex: number;
  marketType: MarketType;
  filler: PublicKey | null;
  baseAssetAmountFilled: BN | null;
  quoteAssetAmountFilled: BN | null;
  takerFee: BN | null;
  makerFee: BN | null;
};

class OrderAction {
  static readonly PLACE;
  static readonly CANCEL;
  static readonly EXPIRE;
  static readonly FILL;
  static readonly TRIGGER;
}
```

## Modify Orders

```typescript
type ModifyOrderParams = {
  [Property in keyof OrderParams]?: OrderParams[Property] | null;
} & { policy?: ModifyOrderPolicy };

enum ModifyOrderPolicy {
  MustModify = 1,
  ExcludePreviousFill = 2,
}
```

## Protected Maker Mode

```typescript
type ProtectedMakerParams = {
  limitPriceDivisor: number;
  tickSize: BN;
  dynamicOffset: BN;
};
```
