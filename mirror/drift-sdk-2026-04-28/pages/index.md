# Drift Protocol v2
URL: https://mintlify.com/drift-labs/protocol-v2

# Drift Protocol v2 — TypeScript SDK API reference root

> On-chain perpetuals DEX on Solana with lightning-fast execution and deep liquidity

This is the auto-generated TypeScript SDK API reference for `@drift-labs/sdk` (protocol-v2 monorepo).

## What's covered

- Installation, wallet setup, and quickstart
- TypeScript SDK API: DriftClient, AdminClient, User, Account Subscribers, Markets, Math utilities, Trading helpers (DLOB, OrderParams, Position management), Type definitions
- Concept primers: Liquidations, Margin, Markets, Oracles, Orders, Positions, Protocol Overview
- Worked examples: Connect & deposit, Place market/limit order, Cancel/Modify order, Event listening, Liquidation bot, Market making bot, Arbitrage strategies
- SDK guides: Initialization, Account management, Account subscriptions, Placing orders, Managing positions, Oracle integration, Advanced features
- Math reference: AMM, Funding rates, Margin calculations, PnL, Precision & BigNum
- Program reference: Architecture, Instructions (admin/keeper/trading/user), State (market/state/user accounts), Security

### Index

The full page index is at https://mintlify.com/drift-labs/protocol-v2/llms.txt — 60 pages total.

## Core SDK Concepts

### BigNum Precision

| Precision Name | Value | Use Case |
| --- | --- | --- |
| `QUOTE_PRECISION` | 10^6 | USDC amounts |
| `PRICE_PRECISION` | 10^6 | Market prices |
| `BASE_PRECISION` | 10^9 | Base asset amounts (e.g., SOL) |
| `AMM_RESERVE_PRECISION` | 10^9 | AMM calculations |

A value of `10,500,000` with `QUOTE_PRECISION` (10^6) equals `10.5 USDC`.

### Network Support

```typescript
// Mainnet
const sdkConfig = initialize({ env: 'mainnet-beta' });

// Devnet (with USDC faucet for testing)
const sdkConfig = initialize({ env: 'devnet' });
```

License: Apache 2.0.
