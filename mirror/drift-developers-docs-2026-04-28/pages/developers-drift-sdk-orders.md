# Orders – Drift Protocol

Source: https://docs.drift.trade/developers/drift-sdk/orders

Orders – Drift Protocol

Skip to Content

Developers Drift SDK Orders

Copy page

# Orders

## How it works

Orders on Drift go through a multi-stage matching process. When you place an order, it enters a JIT auction (Just-In-Time) where market makers can compete to fill it at better prices. If no one fills during the auction, the order either executes against the DLOB (Decentralized Limit Order Book) or the AMM as a fallback. This design ensures you get the best price from multiple liquidity sources.

Orders are stored in your user account and have both an onchain order ID and an optional user-assigned ID for tracking. When an order fills, your position updates automatically, and you can query fill events to see execution details.

## Order Types

| Type | Description |
| --- | --- |
| `MARKET` | Executes immediately. Goes through a JIT auction first (controlled by`auctionStartPrice`,`auctionEndPrice`,`auctionDuration`), then fills against the DLOB or AMM. |
| `LIMIT` | Rests on the DLOB at a fixed price until filled or canceled. Set`postOnly: PostOnlyParams.MUST_POST_ONLY` to guarantee maker status and avoid crossing the spread. |
| `ORACLE` | Like a market order, but auction prices and the resting limit price are expressed as offsets from the oracle price (not absolute prices). Useful for market makers who want tight spreads without hardcoding prices. |
| `TRIGGER_MARKET` | A stop/take-profit market order. Executes as a market order when the oracle price crosses`triggerPrice` in the specified`triggerCondition` direction. |
| `TRIGGER_LIMIT` | A stop/take-profit limit order. Same trigger mechanism as`TRIGGER_MARKET`, but executes as a limit order at`price` once triggered. |

### Post-Only Params

When placing limit orders, you can control maker/taker behavior with`postOnly`:

| Value | Behavior |
| --- | --- |
| `PostOnlyParams.NONE` | Order can be maker or taker (default) |
| `PostOnlyParams.MUST_POST_ONLY` | Transaction fails if the order would cross the spread |
| `PostOnlyParams.TRY_POST_ONLY` | Order is silently skipped (not placed) if it would cross; tx succeeds |
| `PostOnlyParams.SLIDE` | Order price is adjusted one tick inside the spread to guarantee maker status |

## SDK Usage

This page focuses on placing and canceling orders via`DriftClient`. For concise examples we use helper builders like`getMarketOrderParams(...)`.

### Build Market Order Params

TypeScript

```
import { BN, BASE_PRECISION, MarketType, PositionDirection, getMarketOrderParams } from "@drift-labs/sdk";
 
const orderParams = getMarketOrderParams({
  marketIndex: 0,
  marketType: MarketType.PERP,
  direction: PositionDirection.LONG,
  baseAssetAmount: new BN(1).mul(BASE_PRECISION), // 1 SOL (in 1e9 precision)
});
```

`Function getMarketOrderParams` Reference ↗

`Omit `

| Parameter | Type | Required |
| --- | --- | --- |
| `params` | Yes |

| Returns |
| --- |
| `OptionalOrderParams` |

### Build Order Params (Generic Helper)

If you want a single helper that works for limit/market/oracle/trigger, use`getOrderParams(...)`.

TypeScript

```
import { getOrderParams, OrderType, PositionDirection } from "@drift-labs/sdk";
 
const orderParams = getOrderParams({
  orderType: OrderType.LIMIT,
  marketIndex: 0,
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToPerpPrecision(1),   // 1 base unit → BN(1e9)
  price: driftClient.convertToPricePrecision(21.23),         // $21.23 → BN(21_230_000)
});
```

`Function getOrderParams` Reference ↗

Creates an OrderParams object with the given OptionalOrderParams and any params to override.

example: ``` const orderParams = getOrderParams(optionalOrderParams, { marketType: MarketType.PERP }); ```

`OptionalOrderParams`

`Record `

| Parameter | Type | Required |
| --- | --- | --- |
| `optionalOrderParams` | Yes |
| `overridingParams` | No |

| Returns |
| --- |
| `OrderParams` |

### Place a Perp Order

TypeScript

```
// Assumes `driftClient` is subscribed.
const txSig = await driftClient.placePerpOrder(
  getMarketOrderParams({
    marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: new BN(1).mul(BASE_PRECISION),
  })
);
console.log(txSig);
```

`Method DriftClient.placePerpOrder` Reference ↗

`OptionalOrderParams`

`TxParams`

`number`

`any`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `txParams` | No |
| `subAccountId` | No |
| `isolatedPositionDepositAmount` | No |

| Returns |
| --- |
| `Promise ` |

### Place a Spot Order

TypeScript

```
import { OrderType, PositionDirection } from "@drift-labs/sdk";
 
await driftClient.placeSpotOrder({
  orderType: OrderType.LIMIT,
  marketIndex: 1, // e.g. SOL spot
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToSpotPrecision(1, 1), // 1 SOL
  price: driftClient.convertToPricePrecision(150),
});
```

`Method DriftClient.placeSpotOrder` Reference ↗

`OptionalOrderParams`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

### Place Multiple Orders

TypeScript

```
await driftClient.placeOrders([
  {
    orderType: OrderType.LIMIT,
    marketType: MarketType.PERP,
    marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    price: driftClient.convertToPricePrecision(21.23),
  },
  {
    orderType: OrderType.LIMIT,
    marketType: MarketType.PERP,
    marketIndex: 0,
    direction: PositionDirection.SHORT,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    oraclePriceOffset: driftClient.convertToPricePrecision(0.05).toNumber(),
  },
]);
```

`Method DriftClient.placeOrders` Reference ↗

`OrderParams[]`

`TxParams`

`number`

`TransactionInstruction[]`

`any`

| Parameter | Type | Required |
| --- | --- | --- |
| `params` | Yes |
| `txParams` | No |
| `subAccountId` | No |
| `optionalIxs` | No |
| `isolatedPositionDepositAmount` | No |

| Returns |
| --- |
| `Promise ` |

### Oracle / Auction-Style Orders

Oracle orders have prices that track the oracle feed with an offset. They go through a JIT auction before execution, with auction prices that gradually converge from the start offset to the end offset relative to oracle.

Important: For`OrderType.ORACLE`,`auctionStartPrice`,`auctionEndPrice`, and`oraclePriceOffset` are all offsets from the oracle price (in PRICE_PRECISION, 1e6), not absolute prices.

TypeScript

```
import { BN, OrderType, PositionDirection, PRICE_PRECISION } from "@drift-labs/sdk";
 
const marketIndex = 18;
 
// Offsets are relative to oracle price (in PRICE_PRECISION)
// For a long: auction starts at a better (lower) price and ends at a worse (higher) price
const auctionStartPrice = PRICE_PRECISION.muln(-5).divn(10); // -$0.50 below oracle
const auctionEndPrice = PRICE_PRECISION.muln(5).divn(10);    // +$0.50 above oracle
 
const orderParams = {
  orderType: OrderType.ORACLE,
  baseAssetAmount: driftClient.convertToPerpPrecision(10),
  direction: PositionDirection.LONG,
  marketIndex,
  auctionStartPrice,
  auctionEndPrice,
  oraclePriceOffset: driftClient.convertToPricePrecision(0.30).toNumber(), // +$0.30 from oracle
  auctionDuration: 30, // slots
};
 
await driftClient.placePerpOrder(orderParams);
```

`Example Oracle order` Reference ↗

TypeScript docs unavailable for`Oracle order`.

### Cancel Orders

Cancel a specific order by its onchain order ID.

TypeScript

```
await driftClient.cancelOrder(1);
```

`Method DriftClient.cancelOrder` Reference ↗

`number`

`TxParams`

`number`

`{ withdrawIsolatedDepositAmount?: any; }`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderId` | No |
| `txParams` | No |
| `subAccountId` | No |
| `overrides` | No |

| Returns |
| --- |
| `Promise ` |

Cancel multiple specific orders by their onchain order IDs in a single transaction.

TypeScript

```
await driftClient.cancelOrdersByIds([1, 2, 3]);
```

`Method DriftClient.cancelOrdersByIds` Reference ↗

`number[]`

The order ids to cancel.

`TxParams`

The transaction parameters.

`number`

The sub account id to cancel the orders for.

`User`

The user to cancel the orders for. If provided, it will be prioritized over the subAccountId.

`{ authority?: PublicKey; }`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderIds` | No |
| `txParams` | No |
| `subAccountId` | No |
| `user` | No |
| `overrides` | No |

| Returns |
| --- |
| `Promise ` |

Cancel all orders matching the given market and direction filters. Pass`null` for any filter to match all. Omit all parameters to cancel every open order.

TypeScript

```
import { MarketType, PositionDirection } from "@drift-labs/sdk";
 
// Cancel all long perp orders on market 0
await driftClient.cancelOrders(MarketType.PERP, 0, PositionDirection.LONG);
 
// Cancel all orders across all markets
await driftClient.cancelOrders(null, null, null);
```

`Method DriftClient.cancelOrders` Reference ↗

`MarketType`

`number`

`PositionDirection`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketType` | No |
| `marketIndex` | No |
| `direction` | No |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

### Cancel and Place (Atomic)

Atomically cancels existing orders and places new ones in a single transaction. This is the preferred approach for market makers who need to replace quotes without risk of being filled on stale orders in the gap between a separate cancel and re-quote.

TypeScript

```
await driftClient.cancelAndPlaceOrders(
  { marketType: MarketType.PERP, marketIndex: 0 },
  [
    {
      orderType: OrderType.LIMIT,
      marketIndex: 0,
      direction: PositionDirection.LONG,
      baseAssetAmount: driftClient.convertToPerpPrecision(1),
      price: driftClient.convertToPricePrecision(21.23),
    },
  ]
);
```

`Method DriftClient.cancelAndPlaceOrders` Reference ↗

`{ marketType?: MarketType; marketIndex?: number; direction?: PositionDirection; }`

`OrderParams[]`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `cancelOrderParams` | Yes |
| `placeOrderParams` | Yes |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

### Modify Orders

TypeScript

```
await driftClient.modifyOrder({
  orderId: 1,
  newBaseAmount: driftClient.convertToPerpPrecision(2),
});
```

`Method DriftClient.modifyOrder` Reference ↗

`{ orderId: number; newDirection?: PositionDirection; newBaseAmount?: any; newLimitPrice?: any; newOraclePriceOffset?: number; newTriggerPrice?: any; newTriggerCondition?: OrderTriggerCondition; ... 7 more ...; policy?: number; }`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

TypeScript

```
await driftClient.modifyOrderByUserOrderId({
  userOrderId: 1,
  newBaseAmount: driftClient.convertToPerpPrecision(2),
});
```

`Method DriftClient.modifyOrderByUserOrderId` Reference ↗

`{ userOrderId: number; newDirection?: PositionDirection; newBaseAmount?: any; newLimitPrice?: any; newOraclePriceOffset?: number; newTriggerPrice?: any; newTriggerCondition?: OrderTriggerCondition; ... 7 more ...; maxTs?: any; }`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

### Trigger Orders (Stop / Take-Profit)

TypeScript

```
import { OrderTriggerCondition, OrderType, PositionDirection } from "@drift-labs/sdk";
 
const orderParams = {
  orderType: OrderType.TRIGGER_MARKET,
  marketIndex: 0,
  direction: PositionDirection.SHORT,
  baseAssetAmount: driftClient.convertToPerpPrecision(1),
  triggerPrice: driftClient.convertToPricePrecision(95),
  triggerCondition: OrderTriggerCondition.BELOW,
};
 
await driftClient.placePerpOrder(orderParams);
```

`Example Trigger order` Reference ↗

TypeScript docs unavailable for`Trigger order`.

### Instruction Builders (Advanced)

Higher-level methods like`placePerpOrder()` build, sign, and send a transaction in one call. Instruction (IX) builders give you the raw`TransactionInstruction` objects so you can:

- Set a custom compute budget with priority fees for faster inclusion
- Batch multiple instructions into a single transaction (e.g., cancel + place atomically)
- Use Address Lookup Tables (ALTs) to fit more accounts into a transaction
- Compose with other programs (e.g., add a memo or call another protocol in the same tx)

#### Complete Example: Batching IXs with Compute Budget

TypeScript

```
import { ComputeBudgetProgram } from "@solana/web3.js";
import {
  MarketType, PositionDirection, OrderType, getOrderParams,
} from "@drift-labs/sdk";
 
// 1. Build individual instructions
const cancelIx = await driftClient.getCancelOrdersIx(
  MarketType.PERP, // marketType (null to cancel all types)
  0,               // marketIndex (null to cancel across all markets)
  null             // direction (null to cancel both sides)
);
 
const placeIx = await driftClient.getPlacePerpOrderIx(
  getOrderParams({
    orderType: OrderType.LIMIT,
    marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    price: driftClient.convertToPricePrecision(21.0),
  })
);
 
// 2. Add compute budget instructions for priority fees
const computeUnitPrice = ComputeBudgetProgram.setComputeUnitPrice({
  microLamports: 50_000, // priority fee in micro-lamports per CU
});
const computeUnitLimit = ComputeBudgetProgram.setComputeUnitLimit({
  units: 400_000, // max compute units for the transaction
});
 
// 3. Build a versioned transaction with all instructions
const tx = await driftClient.txSender.getVersionedTransaction(
  [computeUnitLimit, computeUnitPrice, cancelIx, placeIx],
  [],                       // lookup table accounts (AddressLookupTableAccount[])
  driftClient.wallet.publicKey
);
 
// 4. Send the transaction
const { txSig } = await driftClient.txSender.sendVersionedTransaction(
  tx,
  [],
  driftClient.opts
);
console.log("Batch tx:", txSig);
```

`Example IX batching example` Reference ↗

TypeScript docs unavailable for`IX batching example`.

#### Individual IX Builders

getPlacePerpOrderIx builds an instruction to place a perp order.

TypeScript

```
// Params:
//   orderParams: OptionalOrderParams - same params as placePerpOrder()
//   subAccountId?: number - defaults to active subaccount
const ix = await driftClient.getPlacePerpOrderIx(
  getOrderParams({
    orderType: OrderType.LIMIT,
    marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    price: driftClient.convertToPricePrecision(21.0),
  })
);
```

`Method DriftClient.getPlacePerpOrderIx` Reference ↗

`OptionalOrderParams`

`number`

`{ isMakingNewAccount: boolean; depositMarketIndex: number; }`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `subAccountId` | No |
| `depositToTradeArgs` | No |

| Returns |
| --- |
| `Promise ` |

getPlaceSpotOrderIx builds an instruction to place a spot order.

TypeScript

```
// Params:
//   orderParams: OptionalOrderParams - same params as placeSpotOrder()
//   subAccountId?: number - defaults to active subaccount
const ix = await driftClient.getPlaceSpotOrderIx({
  orderType: OrderType.LIMIT,
  marketIndex: 1,
  direction: PositionDirection.LONG,
  baseAssetAmount: driftClient.convertToSpotPrecision(1, 1),
  price: driftClient.convertToPricePrecision(150),
});
```

`Method DriftClient.getPlaceSpotOrderIx` Reference ↗

`OptionalOrderParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `orderParams` | Yes |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

getCancelOrdersIx builds an instruction to cancel orders matching the given filters. Pass`null` for any filter to match all.

TypeScript

```
import { MarketType, PositionDirection } from "@drift-labs/sdk";
 
// Params:
//   marketType: MarketType | null - filter by PERP or SPOT (null = all)
//   marketIndex: number | null - filter by market index (null = all)
//   direction: PositionDirection | null - filter by LONG or SHORT (null = both)
//   subAccountId?: number - defaults to active subaccount
 
// Cancel all perp orders on market 0
const ix = await driftClient.getCancelOrdersIx(MarketType.PERP, 0, null);
 
// Cancel ALL orders across all markets
const ixAll = await driftClient.getCancelOrdersIx(null, null, null);
```

`Method DriftClient.getCancelOrdersIx` Reference ↗

`MarketType`

`number`

`PositionDirection`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketType` | Yes |
| `marketIndex` | Yes |
| `direction` | Yes |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

getFillPerpOrderIx builds an instruction to fill another user’s perp order (used by filler/keeper bots).

TypeScript

```
// Params:
//   userAccountPublicKey: PublicKey - the taker's user account address
//   userAccount: UserAccount - the taker's deserialized user account
//   order: { marketIndex, orderId } - the order to fill
//   makerInfo?: MakerInfo | MakerInfo[] - optional maker(s) to match against
//   referrerInfo?: ReferrerInfo - optional referrer for fee sharing
//   fillerSubAccountId?: number - filler's subaccount
 
const takerPubkey = takerUser.userAccountPublicKey;
const takerAccount = takerUser.getUserAccount();
const order = takerAccount.orders[0]; // the order to fill
 
const ix = await driftClient.getFillPerpOrderIx(
  takerPubkey,
  takerAccount,
  { marketIndex: order.marketIndex, orderId: order.orderId }
);
```

`Method DriftClient.getFillPerpOrderIx` Reference ↗

`PublicKey`

`UserAccount`

`Pick `

`MakerInfo | MakerInfo[]`

`ReferrerInfo`

`number`

`boolean`

`PublicKey`

`boolean`

| Parameter | Type | Required |
| --- | --- | --- |
| `userAccountPublicKey` | Yes |
| `userAccount` | Yes |
| `order` | Yes |
| `makerInfo` | No |
| `referrerInfo` | No |
| `fillerSubAccountId` | No |
| `isSignedMsg` | No |
| `fillerAuthority` | No |
| `hasBuilderFee` | No |

| Returns |
| --- |
| `Promise ` |

getFillSpotOrderIx builds an instruction to fill another user’s spot order.

TypeScript

```
// Same pattern as getFillPerpOrderIx but for spot markets.
const ix = await driftClient.getFillSpotOrderIx(
  takerPubkey,
  takerAccount,
  { marketIndex: order.marketIndex, orderId: order.orderId }
);
```

`Method DriftClient.getFillSpotOrderIx` Reference ↗

`PublicKey`

`UserAccount`

`Pick `

`SerumV3FulfillmentConfigAccount | PhoenixV1FulfillmentConfigAccount | OpenbookV2FulfillmentConfigAccount`

`MakerInfo | MakerInfo[]`

`ReferrerInfo`

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `userAccountPublicKey` | Yes |
| `userAccount` | Yes |
| `order` | No |
| `fulfillmentConfig` | No |
| `makerInfo` | No |
| `referrerInfo` | No |
| `fillerPublicKey` | No |

| Returns |
| --- |
| `Promise ` |

getTriggerOrderIx builds an instruction to trigger a conditional order (stop-loss or take-profit) that has met its trigger condition.

TypeScript

```
// Params:
//   userAccountPublicKey: PublicKey - the user whose order to trigger
//   userAccount: UserAccount - the deserialized user account
//   order: Order - the full order object (must have trigger condition met)
//   fillerPublicKey?: PublicKey - optional, defaults to your user account
 
const userPubkey = targetUser.userAccountPublicKey;
const userAccount = targetUser.getUserAccount();
const triggerOrder = userAccount.orders.find(
  (o) => o.orderType.triggerMarket !== undefined || o.orderType.triggerLimit !== undefined
);
 
const ix = await driftClient.getTriggerOrderIx(
  userPubkey,
  userAccount,
  triggerOrder
);
```

`Method DriftClient.getTriggerOrderIx` Reference ↗

`PublicKey`

`UserAccount`

`Order`

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `userAccountPublicKey` | Yes |
| `userAccount` | Yes |
| `order` | Yes |
| `fillerPublicKey` | No |

| Returns |
| --- |
| `Promise ` |

getRevertFillIx builds an instruction to revert a fill (used by filler bots when a fill was invalid).

TypeScript

```
// Params:
//   fillerPublicKey?: PublicKey - defaults to your user account
const ix = await driftClient.getRevertFillIx();
```

`Method DriftClient.getRevertFillIx` Reference ↗

`PublicKey`

| Parameter | Type | Required |
| --- | --- | --- |
| `fillerPublicKey` | No |

| Returns |
| --- |
| `Promise ` |

getSettlePNLsIxs builds instructions to settle PnL for one or more users across multiple markets. Returns an array of instructions (one per user per market).

TypeScript

```
// Params:
//   users: Array of { settleeUserAccountPublicKey, settleeUserAccount }
//   marketIndexes: number[] - perp market indexes to settle
 
const user = driftClient.getUser();
const ixs = await driftClient.getSettlePNLsIxs(
  [
    {
      settleeUserAccountPublicKey: user.userAccountPublicKey,
      settleeUserAccount: user.getUserAccount(),
    },
  ],
  [0, 1] // settle PnL on perp markets 0 and 1
);
// ixs is an array of TransactionInstruction, one per user per market
```

`Method DriftClient.getSettlePNLsIxs` Reference ↗

`{ settleeUserAccountPublicKey: PublicKey; settleeUserAccount: UserAccount; }[]`

`number[]`

`RevenueShareEscrowMap`

| Parameter | Type | Required |
| --- | --- | --- |
| `users` | Yes |
| `marketIndexes` | Yes |
| `revenueShareEscrowMap` | No |

| Returns |
| --- |
| `Promise ` |

getJupiterSwapIxV6 builds a Jupiter swap instruction routed through Drift.

TypeScript

```
// Params:
//   inMarketIndex: number - spot market index of the input token
//   outMarketIndex: number - spot market index of the output token
//   amount: BN - amount of input token (in spot precision)
//   slippageBps: number - max slippage in basis points
 
const ix = await driftClient.getJupiterSwapIxV6({
  inMarketIndex: 0,   // e.g. USDC
  outMarketIndex: 1,  // e.g. SOL
  amount: driftClient.convertToSpotPrecision(0, 10), // 10 USDC
  slippageBps: 50,    // 0.5% max slippage
});
```

`Method DriftClient.getJupiterSwapIxV6` Reference ↗

`{ jupiterClient: JupiterClient; outMarketIndex: number; inMarketIndex: number; outAssociatedTokenAccount?: PublicKey; inAssociatedTokenAccount?: PublicKey; ... 6 more ...; userAccountPublicKey?: PublicKey; }`

| Parameter | Type | Required |
| --- | --- | --- |
| `__0` | Yes |

| Returns |
| --- |
| `Promise<{ ixs: TransactionInstruction[]; lookupTables: AddressLookupTableAccount[]; }>` |

Last updated on February 27, 2026

Markets, Oracles, and Positions PnL & Risk
