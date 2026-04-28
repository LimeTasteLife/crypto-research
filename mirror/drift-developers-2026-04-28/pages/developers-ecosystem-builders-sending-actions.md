# Sending Actions – Drift Protocol
URL: https://docs.drift.trade/developers/ecosystem-builders/sending-actions

# Sending Actions

## AuthorityDrift methods

### Place a perp order

```typescript
import { BigNum, PositionDirection } from "@drift-labs/sdk";

// Market
await drift.openPerpOrder({
  subAccountId: 0,
  marketIndex: 0,
  direction: PositionDirection.LONG,
  assetType: "base",
  size: BigNum.fromPrint("1", 9), // 1 SOL
  orderConfig: { orderType: "market" },
});

// Limit
await drift.openPerpOrder({
  subAccountId: 0, marketIndex: 0, direction: PositionDirection.LONG,
  assetType: "base", size: BigNum.fromPrint("1", 9),
  orderConfig: { orderType: "limit", limitPrice: BigNum.fromPrint("120", 6) },
});
```

### Cancel orders

```typescript
await drift.cancelOrders({ subAccountId: 0, orderIds: [1, 2, 3] });
```

### Settle PnL

```typescript
await drift.settleAccountPnl({ subAccountId: 0 });
```

### Deposit / withdraw

```typescript
await drift.deposit({ subAccountId: 0, spotMarketIndex: 0, amount: depositAmount });
await drift.withdraw({ subAccountId: 0, spotMarketIndex: 0, amount: withdrawAmount });
```

### Swap

```typescript
const quote = await drift.getSwapQuote({
  fromMarketIndex: 1, toMarketIndex: 0,
  amount: swapAmount, subAccountId: 0,
});

await drift.swap({
  subAccountId: 0, fromMarketIndex: 1, toMarketIndex: 0,
  amount: swapAmount, quote,
});
```

## SDK instruction builders

For multi-instruction atomic transactions and custom compute budget:

```typescript
import { ComputeBudgetProgram } from "@solana/web3.js";
import { getMarketOrderParams, PositionDirection } from "@drift-labs/sdk";

const orderParams = getMarketOrderParams({
  marketIndex: 0,
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToPerpPrecision(1),
});

const placeOrderIx = await driftClient.getPlacePerpOrderIx(orderParams);

const tx = await driftClient.txSender.getVersionedTransaction(
  [
    ComputeBudgetProgram.setComputeUnitLimit({ units: 400000 }),
    ComputeBudgetProgram.setComputeUnitPrice({ microLamports: 50000 }),
    placeOrderIx,
  ],
  [],
  driftClient.wallet.publicKey
);

const signature = await driftClient.txSender.sendVersionedTransaction(
  tx, [], driftClient.opts
);
```

### Atomic cancel-and-place

Common for trading UIs to prevent the window where you have no orders resting while updating prices.

## Transaction performance

- Priority fees (`ComputeUnitPrice`) — land transactions faster during congestion
- Compute budget (`setComputeUnitLimit`) — allocate enough CU for multi-instruction transactions
- Address Lookup Tables (ALTs) — reduce transaction size
- Retry logic with backoff for production

Last updated on February 27, 2026
