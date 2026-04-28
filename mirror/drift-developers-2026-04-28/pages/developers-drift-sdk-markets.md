# Markets, Oracles, and Positions – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/markets

# Markets, Oracles, and Positions

## How it works

Drift has two types of markets: perp markets (perpetual futures with funding rates) and spot markets (token deposits/borrows that serve as collateral). Each market has an onchain account storing configuration like oracle source, fees, funding rates, AMM parameters, and current open interest.

### Market Indexes

Markets are identified by a numeric index starting from 0. For example:

- Perp market 0 is typically SOL-PERP
- Spot market 0 is typically USDC
- Perp market 1 might be BTC-PERP, and so on

Where to find market indexes:

- State account: Query `driftClient.getStateAccount()` which contains arrays of all perp and spot market configurations
- SDK methods: Use `driftClient.getPerpMarketAccounts()` or `driftClient.getSpotMarketAccounts()` to get all markets and inspect their indexes
- Market account directly: Each market account has a `marketIndex` field you can read
- Symbol lookup: Most bots maintain their own mapping from symbol (e.g., "SOL-PERP") to market index

Each market integrates with an oracle (usually Pyth or Switchboard) that provides real-time price data. Prices are stored in fixed-point precision (1e6 for PRICE_PRECISION).

Perp markets track funding rates, open interest, and AMM liquidity pools. Spot markets track total deposits, borrows, and utilization rates.

## SDK Usage

### Market Accounts

```typescript
const marketIndex = 0;
const spotMarket = driftClient.getSpotMarketAccount(marketIndex);
const perpMarket = driftClient.getPerpMarketAccount(marketIndex);

// All at once
const spotMarkets = driftClient.getSpotMarketAccounts();
const perpMarkets = driftClient.getPerpMarketAccounts();
```

### Oracle Price

```typescript
// For perp market
const oracle = driftClient.getOracleDataForPerpMarket(0);
console.log(oracle.price.toString());

// For spot market
const oracleSpot = driftClient.getOracleDataForSpotMarket(0);

// Market-maker oriented oracle data (DLOB/JIT pricing)
const mmOracle = driftClient.getMMOracleDataForPerpMarket(0);
```

### Positions and Balances

```typescript
// Active subaccount's spot/perp position
const spotPosition = driftClient.getSpotPosition(0);
const perpPosition = driftClient.getPerpPosition(0);
```

### Protocol State

The global state account holds protocol-level configuration including the number of active markets, admin authority, and fee structures.

```typescript
const state = driftClient.getStateAccount();
```

Last updated on February 27, 2026
