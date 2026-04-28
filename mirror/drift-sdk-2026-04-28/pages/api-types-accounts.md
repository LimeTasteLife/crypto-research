# Account Types
URL: https://mintlify.com/drift-labs/protocol-v2/api/types/accounts

# Account Types

TypeScript type definitions for Drift on-chain accounts.

See also:
- `program/state/state-account` — `StateAccount`
- `program/state/market-accounts` — `PerpMarketAccount`, `SpotMarketAccount`
- `program/state/user-account` — `UserAccount`, `UserStatsAccount`

## Other account types

- `InsuranceFundStakeAccount` — IF staking position
- `PrelaunchOracle` — prelaunch market price source
- `PerpMarketLiquidityProviderInfoAccount` — LP info
- `RevenueShareAccount` — builder code revenue share
- `RevenueShareEscrow` — user-side builder code escrow
- `SignedMsgUserOrders` — SWIFT signed message orders
- `HighLeverageModeConfig` — HLM configuration
- `OpenbookV2FulfillmentConfigAccount`, `PhoenixV1FulfillmentConfigAccount`, `SerumV3FulfillmentConfigAccount` — external venue routing configs

## Read account data

```typescript
const stateAccount = driftClient.getStateAccount();
const perpMarket = driftClient.getPerpMarketAccount(marketIndex);
const spotMarket = driftClient.getSpotMarketAccount(marketIndex);
const userAccount = driftClient.getUserAccount();
const userStats = driftClient.getUserStats();
```
