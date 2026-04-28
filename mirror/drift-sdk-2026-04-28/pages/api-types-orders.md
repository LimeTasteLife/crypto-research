# Order Types
URL: https://mintlify.com/drift-labs/protocol-v2/api/types/orders

# Order Types

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

See also:
- `OrderParams` and `ScaleOrderParams` in `api/trading/order-params`
- `OrderType`, `OrderStatus`, `OrderAction`, `OrderTriggerCondition`, `PostOnlyParams` in `api/types/enums`

## OrderActionRecord

```typescript
type OrderActionRecord = {
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
```

## OrderActionExplanation

LITERALS: `orderFilledWithMatch`, `orderFilledWithMatchJit`, `orderFilledWithAmm`, `orderFilledWithAmmJit`, `orderFilledWithOpenbookV2`, `orderFilledWithSerum`, `orderFilledWithPhoenix`, `orderTriggered`, `liquidation`, `cancelled`, etc.
