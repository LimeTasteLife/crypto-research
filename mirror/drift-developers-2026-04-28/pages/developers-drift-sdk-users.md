# Users – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/users

# Users

## How it works

A user account is the onchain account that holds your positions, orders, and collateral on Drift. Each wallet can create multiple user accounts (called subaccounts), identified by a numeric ID (0, 1, 2, etc.). All subaccounts under the same wallet share cross-margin, meaning collateral and risk are calculated across all of them together.

User accounts store your perp positions (long/short), spot balances (deposits/borrows), open orders, and leverage settings. When you interact with Drift (place orders, deposit, trade), you're modifying data in your user account. The account is a Solana PDA (Program Derived Address) owned by the Drift program.

Subaccounts are useful for separating strategies, isolating risk between different trading styles, or delegating specific accounts to bots while keeping others manual.

## SDK Usage

### Initialize a User Account

```typescript
const [txSig, userAccountPublicKey] = await driftClient.initializeUserAccount(0, "my-account");
console.log(txSig, userAccountPublicKey.toBase58());
```

#### Get the Next Subaccount ID

```typescript
const nextId = driftClient.getNextSubAccountId();
```

### Get a User and Subscribe

```typescript
import { User } from "@drift-labs/sdk";
const user = driftClient.getUser();
await user.subscribe();
```

#### Get active subaccount user
```typescript
const user = driftClient.getUser();
```

#### Get a specific subaccount user
```typescript
const user = driftClient.getUser(1);
```

#### Read account via User
```typescript
const account = driftClient.getUser().getUserAccount();
```

#### Read account via DriftClient
```typescript
const account = driftClient.getUserAccount();
```

#### Refresh user accounts
```typescript
const user = driftClient.getUser(0);
await user.fetchAccounts();
```

### Derived Addresses (User Account)

User accounts are Program Derived Addresses (PDAs) - deterministic addresses generated from seeds (the program ID, wallet authority, and subaccount ID). PDAs are a Solana concept that lets you calculate an account's address without making an RPC call.

```typescript
const userAccountPublicKey = await driftClient.getUserAccountPublicKey(0);
```

### Query User State (Orders / Positions)

```typescript
import { BN } from "@drift-labs/sdk";

const user = driftClient.getUser();

// Get token amount (signed: + deposit, - borrow)
const tokenAmount = user.getTokenAmount(0);

// Get a perp position
const position = user.getPerpPosition(0);

// Get an order by orderId
const order = user.getOrder(1);

// Get an order by user-order-id
const order2 = user.getOrderByUserOrderId(1);

// Get all open orders
const orders = user.getOpenOrders();
```

### Active Subaccount

The active subaccount is the default subaccount that DriftClient methods operate on when you don't explicitly specify a subaccount ID. By default, the active subaccount is 0.

Many SDK methods use the active subaccount implicitly:
- `driftClient.getUser()`
- `driftClient.getUserAccount()`
- `driftClient.placePerpOrder(orderParams)`
- `driftClient.getSpotPosition(marketIndex)`
- `driftClient.getPerpPosition(marketIndex)`

### Switch Active Subaccount

```typescript
await driftClient.switchActiveUser(1);
```

### Update Delegate

A delegate is another wallet that can trade on behalf of your user account without being able to withdraw funds.

```typescript
import { PublicKey } from "@solana/web3.js";
await driftClient.updateUserDelegate(new PublicKey("<DELEGATE_PUBKEY>"), 0);
```

### Update Margin Settings

```typescript
// Enable / disable margin trading
await driftClient.updateUserMarginTradingEnabled([
  { marginTradingEnabled: true, subAccountId: 0 },
]);

// Set custom margin ratio cap (scaled by MARGIN_PRECISION = 10000)
// 10000 = 1x max leverage, 5000 = 2x, 2000 = 5x
await driftClient.updateUserCustomMarginRatio([
  { marginRatio: 5000, subAccountId: 0 }, // 2x max leverage
]);
```

### Delete a User Account

If a subaccount has no assets/liabilities, it can be deleted to reclaim rent.

```typescript
await driftClient.deleteUser(1);
```

## User-class methods (key risk/account helpers)

The `User` class exposes computed views: `getFreeCollateral`, `getMarginRequirement`, `getInitialMarginRequirement`, `getMaintenanceMarginRequirement`, `getUnrealizedPNL`, `getUnrealizedFundingPNL`, `getTotalCollateral`, `getHealth`, `getLeverage`, `getMaxLeverageForPerp`, `getMaxLeverageForSpot`, `getMarginRatio`, `canBeLiquidated`, `liquidationPrice`, `spotLiquidationPrice`, `getMaxTradeSizeUSDCForPerp`, `getMaxSwapAmount`, `getWithdrawalLimit`. See SDK reference docs for full signatures.

Last updated on February 27, 2026
