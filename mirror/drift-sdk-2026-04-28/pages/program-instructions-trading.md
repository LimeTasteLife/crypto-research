# Trading Instructions
URL: https://mintlify.com/drift-labs/protocol-v2/program/instructions/trading

# Trading Instructions

User-callable trading instructions.

## Common Instructions

- `placePerpOrder` — place a perpetual order (market/limit/oracle/trigger)
- `placeSpotOrder` — place a spot order
- `placeOrders` — batch-place multiple orders atomically
- `cancelOrder` — cancel a specific order by orderId
- `cancelOrderByUserId` — cancel by user-defined orderId
- `cancelOrders` — cancel multiple by filter (marketType, marketIndex, direction)
- `cancelOrdersByIds` — cancel a list of orderIds
- `cancelAndPlaceOrders` — atomic cancel + place (preferred for makers)
- `modifyOrder` — modify by orderId
- `modifyOrderByUserId` — modify by user-defined orderId
- `placeAndTakePerpOrder` — place taker order with maker list to fill against
- `placeAndMakePerpOrder` — place maker order while filling a specific taker
- `placeAndMakeSignedMsgPerpOrder` — SWIFT (signed message) place-and-make
- `addPerpLpShares` / `removePerpLpShares` — provide/remove AMM liquidity
- `swap` — Jupiter-routed spot swap

## Order Direction & Type

```typescript
class PositionDirection {
  static readonly LONG;
  static readonly SHORT;
}

class OrderType {
  static readonly LIMIT;
  static readonly MARKET;
  static readonly ORACLE;
  static readonly TRIGGER_MARKET;
  static readonly TRIGGER_LIMIT;
}
```

Trading instructions go through the AMM, DLOB, and JIT auction in priority order. See concepts/orders for details.
