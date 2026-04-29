# Drift Protocol v2 - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/introduction

# Drift Protocol v2

> On-chain perpetuals DEX on Solana with lightning-fast execution and deep liquidity

# Welcome to Drift Protocol v2

Drift Protocol v2 is a decentralized perpetuals exchange built on Solana, offering lightning-fast execution, deep liquidity, and a powerful TypeScript SDK for seamless integration.

## Getting Started

## Installation

Install the Drift SDK and set up your development environment

## Quick Start

Place your first trade in minutes with our step-by-step guide

## TypeScript API Reference

Explore the complete TypeScript SDK documentation

## v2-teacher Docs

Comprehensive guides and examples for TypeScript and Python

## What is Drift Protocol?

Drift Protocol v2 is a decentralized perpetuals trading platform that enables:

- Perpetual Futures Trading: Trade crypto perpetuals with leverage on Solana
- Deep Liquidity: Access liquidity through Drift's innovative vAMM (virtual Automated Market Maker)
- Low Latency: Benefit from Solana's high-throughput blockchain for near-instant trade execution
- Cross-Collateral: Use multiple assets as collateral for your positions
- Comprehensive SDK: Build trading bots, integrations, and applications with our TypeScript SDK

## Key Features

## Virtual AMM (vAMM)

Drift's vAMM provides deep liquidity and competitive pricing without requiring traditional order books. The vAMM dynamically adjusts prices based on market conditions and oracle data.

## Cross-Collateral Margin

Use USDC and other supported assets as collateral across all your positions. The protocol automatically calculates your total collateral value and margin requirements.

## TypeScript SDK

The `@drift-labs/sdk` package provides a complete set of tools for:

- Account management and deposits
- Placing and managing orders
- Monitoring positions and market data
- Building automated trading strategies

## Oracle Integration

Drift integrates with multiple oracle providers (Pyth, Switchboard) to ensure accurate and reliable price feeds for all markets.

## Core Concepts

### BigNum Precision

The Drift SDK uses bn.js for numerical values to handle Solana's precise token amounts. All numbers are represented as integers with specific precision levels:

| Precision Name | Value | Use Case |
| --- | --- | --- |
| `QUOTE_PRECISION` | 10^6 | USDC amounts |
| `PRICE_PRECISION` | 10^6 | Market prices |
| `BASE_PRECISION` | 10^9 | Base asset amounts (e.g., SOL) |
| `AMM_RESERVE_PRECISION` | 10^9 | AMM calculations |

A value of `10,500,000` with `QUOTE_PRECISION` (10^6) equals `10.5 USDC`

### Markets

Drift supports multiple perpetual markets (SOL-PERP, BTC-PERP, ETH-PERP, etc.). Each market has:

- A unique market index
- An oracle for price feeds
- AMM parameters for liquidity
- Funding rate mechanisms

### Account Structure

Users interact with Drift through:

1. User Account: Your trading account on Drift (created on first deposit)
2. Collateral: USDC or other supported tokens deposited as margin
3. Positions: Open perpetual positions across various markets
4. Orders: Limit orders, market orders, and other order types

## Example Bots & Integrations

Looking to build automated strategies? Check out example implementations:

- Keeper Bots - Market makers, liquidators, fillers, and more
- Automated trading strategies
- Arbitrage bots
- Liquidation engines

## Network Support

The SDK supports both Solana networks:

```typescript
const sdkConfig = initialize({ env: 'mainnet-beta' });

```

```typescript
const sdkConfig = initialize({ env: 'devnet' });

```

Devnet provides a USDC faucet for testing. Mainnet requires real USDC deposits.

## Community & Support

## Discord

Join the Drift community

## Documentation

Universal Drift docs

## GitHub

View the source code

## Next Steps

## Install the SDK

Follow our installation guide to set up the Drift SDK in your project

## Complete the Quickstart

Learn how to place your first trade with our step-by-step tutorial

## Explore Advanced Features

Dive into the TypeScript API docs to build sophisticated trading applications

## License

Drift Protocol v2 is licensed under Apache 2.0.
