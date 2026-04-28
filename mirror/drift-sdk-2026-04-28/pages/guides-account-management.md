# Account Management
URL: https://mintlify.com/drift-labs/protocol-v2/guides/account-management

# Account Management

Create and manage Drift user accounts (subaccounts).

## Initialize account

```typescript
const [txSig, userAccountPublicKey] = await driftClient.initializeUserAccount(0, 'main');

// Or atomic init + deposit
const usdcAta = await getAssociatedTokenAddress(
  new PublicKey(sdkConfig.USDC_MINT_ADDRESS), wallet.publicKey
);
await driftClient.initializeUserAccountAndDepositCollateral(
  new BN(10000).mul(QUOTE_PRECISION), usdcAta
);
```

## Subaccounts

```typescript
// Add subaccount
const nextId = driftClient.getNextSubAccountId();
await driftClient.initializeUserAccount(nextId, 'strategy-a');

// Subscribe to additional subaccount
if (!driftClient.hasUser(1)) await driftClient.addUser(1);

// Switch active subaccount (default for many methods)
await driftClient.switchActiveUser(1);

// Read specific subaccount
const user = driftClient.getUser(0);
```

## Delegated accounts

```typescript
// Set a delegate (can place/cancel orders, cannot withdraw)
await driftClient.updateUserDelegate(new PublicKey('<DELEGATE>'), 0);
```

## Margin settings

```typescript
// Toggle margin trading
await driftClient.updateUserMarginTradingEnabled([{ marginTradingEnabled: true, subAccountId: 0 }]);

// Set custom max margin ratio (MARGIN_PRECISION = 10000)
// 5000 = 2x max leverage, 2000 = 5x, 10000 = 1x
await driftClient.updateUserCustomMarginRatio([{ marginRatio: 5000, subAccountId: 0 }]);
```

## Delete account (reclaim rent)

Subaccount must have no positions, orders, or balances:

```typescript
await driftClient.deleteUser(1);
```
