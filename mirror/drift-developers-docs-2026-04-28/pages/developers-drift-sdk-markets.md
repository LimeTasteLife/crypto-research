# Markets, Oracles, and Positions – Drift Protocol

Source: https://docs.drift.trade/developers/drift-sdk/markets

Markets, Oracles, and Positions – Drift Protocol

Skip to Content

Developers Drift SDK Markets, Oracles, and Positions

Copy page

# Markets, Oracles, and Positions

## How it works

Drift has two types of markets: perp markets (perpetual futures with funding rates) and spot markets (token deposits/borrows that serve as collateral). Each market has an onchain account storing configuration like oracle source, fees, funding rates, AMM parameters, and current open interest.

### Market Indexes

Markets are identified by a numeric index starting from 0. For example:

- Perp market 0 is typically SOL-PERP
- Spot market 0 is typically USDC
- Perp market 1 might be BTC-PERP, and so on

Where to find market indexes:

- State account: Query`driftClient.getStateAccount()` which contains arrays of all perp and spot market configurations
- SDK methods: Use`driftClient.getPerpMarketAccounts()` or`driftClient.getSpotMarketAccounts()` to get all markets and inspect their indexes
- Market account directly: Each market account has a`marketIndex` field you can read
- Symbol lookup: Most bots maintain their own mapping from symbol (e.g., “SOL-PERP”) to market index, or query all markets and build the mapping at startup

Each market integrates with an oracle (usually Pyth or Switchboard) that provides real-time price data. The SDK lets you read oracle prices, check if they’re valid/stale, and use them for quoting or risk calculations. Prices are stored in fixed-point precision (1e6 for PRICE_PRECISION).

Perp markets track funding rates, open interest, and AMM liquidity pools. Spot markets track total deposits, borrows, and utilization rates. When you trade, you’re interacting with these market accounts, opening positions on perp markets or borrowing/depositing in spot markets.

## SDK Usage

These are the most common read-path helpers you’ll use to power bots, dashboards, and risk logic.

### Market Accounts

Read a single spot market account by index (e.g., market config, oracle source, and utilization state).

TypeScript

```
const marketIndex = 0;
const spotMarket = driftClient.getSpotMarketAccount(marketIndex);
console.log(spotMarket?.marketIndex);
```

`Method DriftClient.getSpotMarketAccount` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `SpotMarketAccount | undefined` |

Read a single perp market account by index (e.g., AMM params, funding state, and open interest).

TypeScript

```
const marketIndex = 0;
const perpMarket = driftClient.getPerpMarketAccount(marketIndex);
console.log(perpMarket?.marketIndex);
```

`Method DriftClient.getPerpMarketAccount` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `PerpMarketAccount | undefined` |

Get all spot market accounts at once, useful for startup symbol/index mapping and dashboards.

TypeScript

```
const spotMarkets = driftClient.getSpotMarketAccounts();
console.log(spotMarkets.length);
```

`Method DriftClient.getSpotMarketAccounts` Reference ↗

| Returns |
| --- |
| `SpotMarketAccount[]` |

Get all perp market accounts at once, useful for scanning market metadata and risk parameters.

TypeScript

```
const perpMarkets = driftClient.getPerpMarketAccounts();
console.log(perpMarkets.length);
```

`Method DriftClient.getPerpMarketAccounts` Reference ↗

| Returns |
| --- |
| `PerpMarketAccount[]` |

### Oracle Price

Read the current oracle data for a perp market (price, confidence, and validity flags).

TypeScript

```
const marketIndex = 0;
const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);
console.log(oracle.price.toString());
```

`Method DriftClient.getOracleDataForPerpMarket` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `OraclePriceData` |

Read the current oracle data for a spot market using its market index.

TypeScript

```
const marketIndex = 0;
const oracle = driftClient.getOracleDataForSpotMarket(marketIndex);
console.log(oracle.price.toString());
```

`Method DriftClient.getOracleDataForSpotMarket` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `OraclePriceData` |

Read market-maker-oriented oracle data for perp markets, typically used for DLOB/JIT pricing flows.

TypeScript

```
const marketIndex = 0;
const oracle = driftClient.getMMOracleDataForPerpMarket(marketIndex);
console.log(oracle.price.toString());
```

`Method DriftClient.getMMOracleDataForPerpMarket` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `MMOraclePriceData` |

### Positions and Balances

Get your active subaccount’s spot position for a given market index (deposit or borrow state).

TypeScript

```
const spotPosition = driftClient.getSpotPosition(0);
console.log(spotPosition);
```

`Method DriftClient.getSpotPosition` Reference ↗

`number`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |
| `subAccountId` | No |

| Returns |
| --- |
| `SpotPosition | undefined` |

Get your active subaccount’s perp position for a given perp market index.

TypeScript

```
const perpPosition = driftClient.getPerpPosition(0);
console.log(perpPosition);
```

`Method DriftClient.getPerpPosition` Reference ↗

TypeScript docs unavailable for`getPerpPosition`.

### Protocol State

The global state account holds protocol-level configuration including the number of active markets, admin authority, and fee structures. It is the top-level entry point for querying protocol metadata.

TypeScript

```
const state = driftClient.getStateAccount();
console.log(state);
```

`Method DriftClient.getStateAccount` Reference ↗

| Returns |
| --- |
| `StateAccount` |

Last updated on February 27, 2026
