# Ecosystem Builders – Drift Protocol
URL: https://docs.drift.trade/developers/ecosystem-builders

# Ecosystem Builders

This section is for teams building apps, analytics, or integrations on top of Drift. The drift-common monorepo and drift-ui-template use the same building blocks as the official Drift UI.

## Packages

| Package | Purpose |
| --- | --- |
| `@drift-labs/react` | React providers, hooks, and stores |
| `@drift-labs/common` | TypeScript utilities, market types, number formatting, `AuthorityDrift` client |
| `@drift-labs/icons` | Market and token icons |

## Setup

```typescript
import { AuthorityDrift, COMMON_UI_UTILS, MarketId } from "@drift-labs/common";
import { MarketType } from "@drift-labs/sdk";

const drift = new AuthorityDrift({
  solanaRpcEndpoint: "https://...",
  driftEnv: "mainnet-beta",
  wallet: connectedWallet,
  tradableMarkets: [
    new MarketId(0, MarketType.SPOT),
    new MarketId(1, MarketType.SPOT),
    new MarketId(0, MarketType.PERP),
    new MarketId(1, MarketType.PERP),
  ],
});

await drift.subscribe();
```

If wallet not yet connected:

```typescript
const placeholderWallet = COMMON_UI_UTILS.createPlaceholderIWallet();
const drift = new AuthorityDrift({ /* ... */ wallet: placeholderWallet });
await drift.subscribe();
// Later
drift.updateAuthority(realWallet);
```

### Sync into Zustand stores

```typescript
drift.onOraclePricesUpdate((oraclePrices) => { /* update store */ });
drift.onMarkPricesUpdate((markPrices) => { /* update store */ });
drift.onUserAccountUpdate((newUserAccount) => { /* update store */ });
```

### React: DriftProvider

```typescript
import { DriftProvider, DEFAULT_BREAKPOINTS } from "@drift-labs/react";

function App() {
  return (
    <DriftProvider breakpoints={DEFAULT_BREAKPOINTS}>
      <YourApp />
    </DriftProvider>
  );
}
```

Hooks: `useCommonDriftStore`, `useDriftClientIsReady`, `useOraclePriceStore`, `useMarkPriceStore`, `useUserAccountDataStore`.

## Utility modules in @drift-labs/common

`TRADING_UTILS`, `COMMON_UI_UTILS`, `ENUM_UTILS`, `MARKET_UTILS`, `ORDER_COMMON_UTILS`, `USER_UTILS`. Common imports: `UIMarket`, `MarketId`, `NumLib`, `USDC_SPOT_MARKET_INDEX`, `SOL_SPOT_MARKET_INDEX`, `MAIN_POOL_ID`.

## drift-ui-template: quickstart

Next.js 15 + React 19 + TypeScript + Tailwind + Zustand + Solana wallet adapter. Pre-built pages: perps trading, spot trading, market data, account management.

```
git clone https://github.com/drift-labs/drift-ui-template.git
cd drift-ui-template/ui
yarn install
yarn dev
```

Defaults to devnet; switch via `useSetupDrift.ts` config.

Last updated on February 27, 2026
