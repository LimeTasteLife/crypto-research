# Market Accounts - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/program/state/market-accounts

# Market Accounts

> Market account structures in Drift Protocol

Market accounts store configuration and state for perpetual and spot markets.

## PerpMarket Account

Perpetual market configuration and AMM state.

### Key Fields

Unique market identifier

Automated market maker state including reserves, oracle, and funding

Initial margin requirement

Maintenance margin requirement

Initial margin fraction factor for size-based scaling

Market status (ACTIVE, PAUSED, etc.)

PERPETUAL or FUTURE

Risk tier (A, B, C, SPECULATIVE, ISOLATED)

## SpotMarket Account

Spot market configuration for collateral assets.

### Key Fields

Unique market identifier

SPL token mint address

Token vault holding deposits

Weight for initial margin calculations

Weight for maintenance margin

Total deposits in the market

Total borrows in the market

Optimal utilization rate for interest

## TypeScript Types

## Market Types

Full TypeScript interfaces

## Perp Markets API

Access market data

## Spot Markets API

Spot market methods

## Market Concepts

Understanding markets
