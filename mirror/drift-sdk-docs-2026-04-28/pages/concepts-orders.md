# Orders

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/orders

> Order types, parameters, and execution behavior in Drift Protocol

## Order Structure

```typescript
export type Order = {
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
  postedSlotTail: number;
};
```

## Order Types

```typescript
export class OrderType {
  static readonly LIMIT = { limit: {} };
  static readonly TRIGGER_MARKET = { triggerMarket: {} };
  static readonly TRIGGER_LIMIT = { triggerLimit: {} };
  static readonly MARKET = { market: {} };
  static readonly ORACLE = { oracle: {} };
}
```

### Market Orders

Execute immediately at the best available price; fill against AMM or matching limit orders; may use Dutch auction; default auction duration configured per market. Market orders use a brief Dutch auction starting at a premium/discount to oracle and converging toward the oracle over time.

### Limit Orders

Specify max/min price. Long fills at `price` or lower; Short fills at `price` or higher. Rest on orderbook if not immediately fillable. Can be maker or taker depending on execution.

### Trigger Orders

`OrderTriggerCondition` values: ABOVE, BELOW, TRIGGERED_ABOVE, TRIGGERED_BELOW. `Trigger Market` becomes a market order when triggered; `Trigger Limit` becomes a limit order. Examples: stop-loss (TRIGGER_MARKET, BELOW); take-profit (TRIGGER_LIMIT, ABOVE).

### Oracle Orders

Use an offset from the oracle price: `effective limit price = oraclePrice + oraclePriceOffset`. This allows orders to track the oracle automatically.

## Order Parameters

```typescript
export type OrderParams = {
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

### Post-Only Orders

```typescript
export class PostOnlyParams {
  static readonly NONE = { none: {} };
  static readonly MUST_POST_ONLY = { mustPostOnly: {} };  // Tx fails if taker
  static readonly TRY_POST_ONLY = { tryPostOnly: {} };    // Skip if taker
  static readonly SLIDE = { slide: {} };                  // Adjust price to be maker
}
```

### Reduce-Only Orders

Can only decrease position size. Cannot open a new position, increase existing, or flip direction. Commonly used for stop-loss / take-profit.

### Immediate-or-Cancel (IOC)

```typescript
export class OrderParamsBitFlag {
  static readonly ImmediateOrCancel = 1;
  static readonly UpdateHighLeverageMode = 2;
}
```

Set via `immediateOrCancel: true` or in `bitFlags`.

### Time-in-Force

```typescript
maxTs: new BN(Date.now() / 1000 + 3600), // expire in 1 hour
```

Expired orders auto-cancelled.

## Order Status

```typescript
export class OrderStatus {
  static readonly INIT = { init: {} };
  static readonly OPEN = { open: {} };
  static readonly FILLED = { filled: {} };
  static readonly CANCELED = { canceled: {} };
}
```

## Order Execution

### Dutch Auction Mechanism

1. Auction Start: order at premium (buy) / discount (sell)
2. Price Improvement: price moves toward oracle over time
3. Auction End: after `auctionDuration` slots, fills at oracle price
4. Early Fill: can fill at improved price during auction

`getAuctionPrice(order, slot, oraclePrice)` interpolates between `auctionStartPrice` and `auctionEndPrice` based on slots elapsed.

### Order Matching

Sources: 1) DLOB Matching (resting limit orders); 2) AMM Fill; 3) JIT Auction (keeper provides liquidity); 4) External DEX (Serum, Phoenix, OpenBook v2).

```typescript
export class OrderActionExplanation {
  static readonly ORDER_FILLED_WITH_MATCH = { orderFilledWithMatch: {} };
  static readonly ORDER_FILLED_WITH_AMM = { orderFilledWithAmm: {} };
  static readonly ORDER_FILLED_WITH_AMM_JIT = { orderFilledWithAmmJit: {} };
  static readonly ORDER_FILLED_WITH_OPENBOOK_V2 = { orderFilledWithOpenbookV2: {} };
}
```

### Fill Price Priority

Best price for taker is selected: lowest for buys, highest for sells, considering all liquidity sources.

## Scale Orders

Place multiple orders across a price range. `ScaleOrderParams` supports `orderCount` (2-32), `sizeDistribution` of `FLAT | ASCENDING | DESCENDING`. Example: 5 orders distributed FLAT from $95 to $90 each for 2 SOL.

## Order Events

```typescript
export type OrderActionRecord = {
  ts: BN;
  action: OrderAction;
  actionExplanation: OrderActionExplanation;
  marketIndex: number;
  marketType: MarketType;
  filler: PublicKey | null;
  fillerReward: BN | null;
  fillRecordId: BN | null;
  baseAssetAmountFilled: BN | null;
  quoteAssetAmountFilled: BN | null;
  takerFee: BN | null;
  makerFee: BN | null;
  referrerReward: number | null;
};

export class OrderAction {
  static readonly PLACE = { place: {} };
  static readonly CANCEL = { cancel: {} };
  static readonly EXPIRE = { expire: {} };
  static readonly FILL = { fill: {} };
  static readonly TRIGGER = { trigger: {} };
}
```

## Order Management

### Modifying Orders

```typescript
export type ModifyOrderParams = {
  [Property in keyof OrderParams]?: OrderParams[Property] | null;
} & { policy?: ModifyOrderPolicy };

export enum ModifyOrderPolicy {
  MustModify = 1,
  ExcludePreviousFill = 2,
}
```

### Cancelling Orders

By the user at any time, automatically when expired (`maxTs`), when user is liquidated (risk-increasing orders), or when reduce-only conditions are violated.

## Protected Maker Mode

```typescript
export type ProtectedMakerParams = {
  limitPriceDivisor: number;
  tickSize: BN;
  dynamicOffset: BN;
};
```

Markets can enable protected maker mode for certain users; protected makers get price adjustments to ensure maker status and better fill prices.
