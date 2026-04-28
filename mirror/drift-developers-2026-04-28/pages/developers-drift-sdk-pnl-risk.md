# PnL & Risk – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/pnl-risk

# PnL & Risk

## How it works

Drift calculates your account's risk using a health metric (0-100) derived from total collateral vs margin requirements. Health 100 = no margin used, health 0 = liquidation eligible.

PnL (Profit and Loss) comes in two forms: unrealized (mark-to-market value of open positions) and realized (settled when positions close). Unrealized PnL is calculated by comparing your position's entry price to the current oracle price. For perps, you also have funding PnL from periodic funding rate payments between longs and shorts.

Free collateral is the amount of collateral not currently backing positions, it's what you can withdraw or use to open new positions. Margin requirements increase with position size and vary by market. Leverage is calculated as notional position value divided by total collateral.

## SDK Usage

### User health

```typescript
const user = driftClient.getUser();
const health = user.getHealth(); // returns number 0-100
```

### Collateral, margin requirement, leverage

```typescript
import { QUOTE_PRECISION, convertToNumber, TEN_THOUSAND } from "@drift-labs/sdk";

const total = driftClient.getUser().getTotalCollateral();
console.log(convertToNumber(total, QUOTE_PRECISION));

const req = driftClient.getUser().getMarginRequirement('Initial');

const free = driftClient.getUser().getFreeCollateral();

const lev = driftClient.getUser().getLeverage();
console.log(lev.toNumber() / TEN_THOUSAND.toNumber()); // e.g. 2.5x
```

### Unrealized PnL

```typescript
const pnl = driftClient.getUser().getUnrealizedPNL(true); // withFunding=true
const fundingPnl = driftClient.getUser().getUnrealizedFundingPNL();
```

### Entry price helper

```typescript
import { calculateEntryPrice, PRICE_PRECISION, convertToNumber } from "@drift-labs/sdk";

const position = driftClient.getUser().getPerpPosition(0);
if (position) {
  const entryPrice = calculateEntryPrice(position);
}
```

### Settle perp PnL

```typescript
const user = driftClient.getUser();
await driftClient.settlePNL(user.userAccountPublicKey, user.getUserAccount(), 0);
```

Last updated on February 27, 2026
