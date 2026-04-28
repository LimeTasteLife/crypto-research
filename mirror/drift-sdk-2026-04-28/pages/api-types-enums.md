# Enum Types
URL: https://mintlify.com/drift-labs/protocol-v2/api/types/enums

# Enum Types

## Anchor enum pattern

Drift enums use Anchor's tagged variant style:

```typescript
class PositionDirection {
  static readonly LONG = { long: {} };
  static readonly SHORT = { short: {} };
}
```

Use `isVariant(value, 'long')` to check, or `ENUM_UTILS.match(value, PositionDirection.LONG)`.

## Common enums

- `MarketType`: SPOT, PERP
- `MarketStatus`: INITIALIZED, ACTIVE, FUNDING_PAUSED, AMM_PAUSED, FILL_PAUSED, WITHDRAW_PAUSED, REDUCE_ONLY, SETTLEMENT, DELISTED
- `ContractType`: PERPETUAL, FUTURE, PREDICTION
- `ContractTier`: A, B, C, SPECULATIVE, HIGHLY_SPECULATIVE, ISOLATED
- `AssetTier`: COLLATERAL, PROTECTED, CROSS, ISOLATED, UNLISTED
- `PositionDirection`: LONG, SHORT
- `OrderType`: LIMIT, TRIGGER_MARKET, TRIGGER_LIMIT, MARKET, ORACLE
- `OrderStatus`: INIT, OPEN, FILLED, CANCELED
- `OrderAction`: PLACE, CANCEL, EXPIRE, FILL, TRIGGER
- `OrderTriggerCondition`: ABOVE, BELOW, TRIGGERED_ABOVE, TRIGGERED_BELOW
- `PostOnlyParams`: NONE, MUST_POST_ONLY, TRY_POST_ONLY, SLIDE
- `SizeDistribution`: FLAT, ASCENDING, DESCENDING
- `SpotBalanceType`: DEPOSIT, BORROW
- `MarginMode`: DEFAULT, HIGH_LEVERAGE, HIGH_LEVERAGE_MAINTENANCE
- `LiquidationType`: LIQUIDATE_PERP, LIQUIDATE_SPOT, LIQUIDATE_BORROW_FOR_PERP_PNL, LIQUIDATE_PERP_PNL_FOR_DEPOSIT, PERP_BANKRUPTCY, SPOT_BANKRUPTCY
- `OracleSource`: PYTH, PYTH_1K, PYTH_1M, PYTH_PULL, PYTH_1K_PULL, PYTH_1M_PULL, SWITCHBOARD, QUOTE_ASSET, PYTH_STABLE_COIN, PYTH_STABLE_COIN_PULL, Prelaunch, SWITCHBOARD_ON_DEMAND, PYTH_LAZER, PYTH_LAZER_1K, PYTH_LAZER_1M, PYTH_LAZER_STABLE_COIN
- `OracleValidity`: NonPositive, TooVolatile, TooUncertain, StaleForMargin, InsufficientDataPoints, StaleForAMMLowRisk, isStaleForAmmImmediate, Valid

## Bit-flag enums

```typescript
enum ExchangeStatus {
  ACTIVE = 0, DEPOSIT_PAUSED = 1, WITHDRAW_PAUSED = 2,
  AMM_PAUSED = 4, FILL_PAUSED = 8, LIQ_PAUSED = 16,
  FUNDING_PAUSED = 32, SETTLE_PNL_PAUSED = 64,
  AMM_IMMEDIATE_FILL_PAUSED = 128, PAUSED = 255,
}

enum UserStatus {
  BeingLiquidated = 1, Bankrupt = 2, ReduceOnly = 4,
  AdvancedLp = 8, ProtectedMaker = 16,
}

enum PerpOperation {
  UPDATE_FUNDING = 1, AMM_FILL = 2, FILL = 4,
  SETTLE_PNL = 8, SETTLE_PNL_WITH_POSITION = 16,
  LIQUIDATION = 32, SETTLE_REV_POOL = 64,
}

enum SpotOperation {
  UPDATE_CUMULATIVE_INTEREST = 1, FILL = 2, DEPOSIT = 4,
  WITHDRAW = 8, LIQUIDATION = 16,
}

enum OrderParamsBitFlag {
  ImmediateOrCancel = 1,
  UpdateHighLeverageMode = 2,
}
```
