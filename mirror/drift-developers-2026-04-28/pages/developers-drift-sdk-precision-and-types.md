# Precision and Types – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/precision-and-types

# Precision and Types

The Drift SDK uses integer big numbers (BN) for most values. Always convert using the SDK's precision constants and helpers.

## Precision Constants

Each constant is a `BN` representing a power of 10. Divide a raw value by its precision constant to get the human-readable number.

| Constant | Value | Used For |
| --- | --- | --- |
| `PRICE_PRECISION` | 1e6 | Oracle prices, order prices |
| `BASE_PRECISION` | 1e9 | Perp position sizes |
| `QUOTE_PRECISION` | 1e6 | USD amounts, collateral |

## Converting Between Raw and Human-Readable Values

### BN -> Human Number

```typescript
import { BN, PRICE_PRECISION, BASE_PRECISION, QUOTE_PRECISION, convertToNumber } from "@drift-labs/sdk";

// Oracle price: raw 150_500_000 -> 150.5 USD
const rawPrice = new BN(150_500_000);
const price = convertToNumber(rawPrice, PRICE_PRECISION);
console.log(price); // 150.5

// Position size: raw 2_500_000_000 -> 2.5 SOL
const rawBase = new BN(2_500_000_000);
const size = convertToNumber(rawBase, BASE_PRECISION);
console.log(size); // 2.5

// Collateral: raw 10_000_000 -> 10 USDC
const rawQuote = new BN(10_000_000);
const usd = convertToNumber(rawQuote, QUOTE_PRECISION);
console.log(usd); // 10
```

### Human Number -> BN

```typescript
import { BN, BASE_PRECISION, PRICE_PRECISION } from "@drift-labs/sdk";

// 1 SOL in base precision
const oneSol = new BN(1).mul(BASE_PRECISION); // BN(1_000_000_000)

// $21.23 in price precision
const price = new BN(21_230_000); // 21.23 * 1e6

// Or use DriftClient convenience helpers (available after setup):
const size = driftClient.convertToPerpPrecision(1);
const px = driftClient.convertToPricePrecision(21.23);
const spot = driftClient.convertToSpotPrecision(0, 100);
```

## Token Math Helpers

Spot balances are stored as interest-bearing scaled values. These helpers convert them to actual token amounts.

`getTokenAmount` converts a raw scaled spot balance into a token amount, accounting for accumulated interest since the last update. Pass the user's `scaledBalance`, the spot market account (which contains the cumulative interest index), and the balance type (deposit or borrow).

```typescript
import { getTokenAmount, SpotBalanceType, convertToNumber } from "@drift-labs/sdk";

const spotMarket = driftClient.getSpotMarketAccount(0); // e.g. USDC
const user = driftClient.getUser();
const spotPosition = user.getUserAccount().spotPositions[0];

const tokenAmount = getTokenAmount(
  spotPosition.scaledBalance,
  spotMarket,
  spotPosition.balanceType
);
console.log("Token amount:", tokenAmount.toString());
```

`getSignedTokenAmount` wraps `getTokenAmount` to return a signed value: positive for deposits, negative for borrows.

```typescript
import { getTokenAmount, getSignedTokenAmount } from "@drift-labs/sdk";

const spotMarket = driftClient.getSpotMarketAccount(0);
const spotPosition = driftClient.getUser().getUserAccount().spotPositions[0];

const tokenAmount = getTokenAmount(
  spotPosition.scaledBalance,
  spotMarket,
  spotPosition.balanceType
);
const signed = getSignedTokenAmount(tokenAmount, spotPosition.balanceType);
// signed > 0 means deposit, signed < 0 means borrow
```

Last updated on February 27, 2026
