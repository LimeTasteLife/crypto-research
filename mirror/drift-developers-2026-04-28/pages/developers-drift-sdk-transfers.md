# Transfers – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/transfers

# Transfers

Transfers let you move balances and positions between subaccounts owned by the same authority.

## Why Use Subaccount Transfers?

Subaccounts let you isolate risk and organize trading strategies. Common use cases for transfers include:

- Strategy isolation: Separate market making from directional trading
- Risk management: Move profits from an active trading account to a safer holding account
- Rebalancing: Redistribute collateral when one subaccount needs more margin
- Bot separation: Isolate automated trading bots on separate subaccounts
- Experimentation: Test new strategies on a subaccount with limited capital

All subaccounts under the same wallet share cross-margin, but transfers let you explicitly move balances and positions to reorganize your capital.

## SDK Usage

### Transfer a Spot Deposit Between Subaccounts

```typescript
const marketIndex = 0; // e.g. USDC
const amount = driftClient.convertToSpotPrecision(marketIndex, 100);

// transferDeposit(amount, marketIndex, fromSubAccountId, toSubAccountId)
await driftClient.transferDeposit(amount, marketIndex, 0, 1);
```

### Transfer a Perp Position Between Subaccounts

```typescript
import { BASE_PRECISION, BN } from "@drift-labs/sdk";

// transferPerpPosition(fromSubAccountId, toSubAccountId, marketIndex, amount)
const amount = new BN(1).mul(BASE_PRECISION); // 1 base unit
await driftClient.transferPerpPosition(0, 1, 0, amount);
```

### Transfer Between Insurance Fund Pools

```typescript
// Transfer between insurance fund pools (admin only)
await driftClient.transferPools();
```

### Transfer Isolated Perp Position Deposit

```typescript
// Move deposits associated with an isolated perp position between subaccounts
await driftClient.transferIsolatedPerpPositionDeposit(0, 1, 0);
```

Last updated on February 27, 2026
