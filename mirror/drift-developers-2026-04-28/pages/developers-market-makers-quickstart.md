# Market Maker Quickstart – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/quickstart

# Market Maker Quickstart

Get a simple market maker running in under 10 minutes. This guide shows how to place two-sided quotes that automatically update with oracle prices.

## Prerequisites

- Node.js + TypeScript project
- Drift SDK installed: `npm i @drift-labs/sdk`
- Funded Solana account with USDC collateral
- Basic familiarity with async/await

WARNING — RPC choice matters: The default `https://api.mainnet-beta.solana.com` is rate-limited and unsuitable for production bots. Use a dedicated RPC provider (Helius, Triton, etc.) or you'll hit 429 errors within minutes. For WebSocket subscriptions, you need a provider that supports `accountSubscribe`.

## Step 1: Initialize DriftClient

```typescript
import { Connection } from "@solana/web3.js";
import { Wallet, DriftClient, loadKeypair } from "@drift-labs/sdk";

const connection = new Connection("https://api.mainnet-beta.solana.com");
const wallet = new Wallet(loadKeypair("~/.config/solana/id.json"));

const driftClient = new DriftClient({
  connection,
  wallet,
  env: "mainnet-beta",
});

await driftClient.subscribe();

// Initialize your user account (if first time)
// const [txSig] = await driftClient.initializeUserAccount(0);
```

## Step 2: Place Oracle Offset Limit Orders

Place two-sided quotes using `oraclePriceOffset`. Orders automatically track the oracle price without re-quoting.

Key parameters:
- `oraclePriceOffset` — offset from oracle price (PRICE_PRECISION, signed)
- `postOnly: PostOnlyParams.MUST_POST_ONLY` — guarantees maker status
- `auctionDuration: 0` — skip JIT auction (the order rests immediately)

For a typical two-sided market maker, you'd place a bid below oracle and an ask above oracle. The orders re-price automatically as the oracle updates.

## Step 3: Cancel and replace on regime change

When you want to update spreads or sizes, use `cancelAndPlaceOrders` (atomic), or batch a `cancelOrders` instruction with a fresh `placeOrders` instruction within the same transaction to avoid stale-quote risk.

## Step 4: Production hardening

Refer to the FloatingPerpMaker reference implementation in `drift-labs/keeper-bots-v2/src/bots/floatingMaker.ts` for:
- Subscription loops
- Priority fee management
- Health monitoring
- Graceful shutdown

Last updated on February 27, 2026
