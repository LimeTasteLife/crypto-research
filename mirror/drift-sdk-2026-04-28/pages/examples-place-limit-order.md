# Place Limit Order
URL: https://mintlify.com/drift-labs/protocol-v2/examples/place-limit-order

# Place Limit Order

```typescript
import {
  getLimitOrderParams, PositionDirection, BASE_PRECISION, PRICE_PRECISION, BN, PostOnlyParams
} from '@drift-labs/sdk';

const orderParams = getLimitOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  direction: PositionDirection.LONG,
  marketIndex: 0,
  price: new BN(100).mul(PRICE_PRECISION), // $100
  postOnly: PostOnlyParams.MUST_POST_ONLY, // optional, for maker-only
});

const txSig = await driftClient.placePerpOrder(orderParams);
```

Use `getOracleOrderParams` for oracle-offset orders; the order auto-tracks the oracle without re-quoting.
