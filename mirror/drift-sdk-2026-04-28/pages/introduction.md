# Drift Protocol v2 — Introduction
URL: https://mintlify.com/drift-labs/protocol-v2/introduction

# Welcome to Drift Protocol v2

Drift Protocol v2 is a decentralized perpetuals exchange built on Solana, offering fast execution, deep liquidity, and a TypeScript SDK for integration.

## What is Drift Protocol?

- Perpetual Futures Trading: Trade crypto perpetuals with leverage on Solana
- Deep Liquidity: Access liquidity through Drift's vAMM (virtual Automated Market Maker)
- Low Latency: Solana's high-throughput blockchain
- Cross-Collateral: Use multiple assets as collateral
- Comprehensive SDK: Build trading bots, integrations, applications with the TypeScript SDK

## Key Features

- Virtual AMM (vAMM): provides deep liquidity and competitive pricing without traditional order books; dynamically adjusts based on market conditions and oracle data.
- Cross-Collateral Margin: USDC and other supported assets across all positions.
- TypeScript SDK (`@drift-labs/sdk`): account management, deposits, orders, positions, market data, automated strategies.
- Oracle Integration: Pyth, Switchboard for accurate price feeds.

## Core Concepts

### BigNum Precision

| Precision | Value | Use Case |
| --- | --- | --- |
| `QUOTE_PRECISION` | 10^6 | USDC amounts |
| `PRICE_PRECISION` | 10^6 | Market prices |
| `BASE_PRECISION` | 10^9 | Base asset amounts |
| `AMM_RESERVE_PRECISION` | 10^9 | AMM calculations |

### Markets

Drift supports multiple perpetual markets (SOL-PERP, BTC-PERP, ETH-PERP, etc.). Each market has: unique market index, oracle for price feeds, AMM parameters, funding rate mechanisms.

### Account Structure

1. User Account: trading account on Drift (created on first deposit)
2. Collateral: USDC or other supported tokens deposited as margin
3. Positions: open perpetual positions across markets
4. Orders: limit, market, and other order types

## Network Support

```typescript
const sdkConfig = initialize({ env: 'mainnet-beta' });
// or
const sdkConfig = initialize({ env: 'devnet' });
```

License: Apache 2.0.
