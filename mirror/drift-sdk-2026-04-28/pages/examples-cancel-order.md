# Cancel Order
URL: https://mintlify.com/drift-labs/protocol-v2/examples/cancel-order

# Cancel Order

```typescript
import { MarketType, PositionDirection } from '@drift-labs/sdk';

// Cancel a specific order
await driftClient.cancelOrder(orderId);

// Cancel by user-defined order id
await driftClient.cancelOrderByUserId(userOrderId);

// Cancel by filter (any null = match all)
await driftClient.cancelOrders(MarketType.PERP, 0, PositionDirection.LONG);

// Cancel ALL orders
await driftClient.cancelOrders();

// Cancel multiple by ids
await driftClient.cancelOrdersByIds([1, 2, 3]);
```

For atomic cancel + place (preferred for market makers):

```typescript
await driftClient.cancelAndPlaceOrders(
  { marketType: MarketType.PERP, marketIndex: 0 },
  [/* new orders */]
);
```
