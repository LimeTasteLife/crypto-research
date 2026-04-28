# Program Architecture
URL: https://mintlify.com/drift-labs/protocol-v2/program/architecture

# Program Architecture

Drift Protocol v2 is implemented as a Solana program with modules: State Management, Market Operations, Risk Engine, Oracle Integration.

## Program ID

Mainnet: `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH`

## Module Layout

- State Management: global state, market accounts, user accounts, user stats
- Market Operations: order matching, position management, settlements
- Risk Engine: margin calculations, liquidations, risk parameters
- Oracle Integration: price feeds (Pyth, Switchboard, Pyth Lazer, Prelaunch)

## Account Hierarchy

```
State (singleton)
  ├── PerpMarket[0..N]
  ├── SpotMarket[0..M]
  └── Insurance Fund

Wallet
  ├── UserStats (one per wallet)
  └── UserAccount[0..N] (subaccounts; max 1000)
        ├── PerpPosition[0..8]
        ├── SpotPosition[0..8]
        └── Order[0..32]
```

## PDAs

Deterministic addresses derived via seeds:

```
User PDA: ["user", authority, subAccountId]
UserStats PDA: ["user_stats", authority]
PerpMarket PDA: ["perp_market", marketIndex]
SpotMarket PDA: ["spot_market", marketIndex]
```

## Instruction Categories

- Admin: market initialization, parameter updates, pauses
- User: account creation, deposits, withdrawals, settling
- Trading: place/cancel/modify orders, fills
- Keeper: liquidations, triggers, fills, settle PnL

## Remaining Accounts Pattern

Many instructions accept a dynamic list of remaining accounts (oracles, market accounts, user accounts) rather than fixed slots. The SDK handles this automatically.

## Events

Major event types: OrderRecord, OrderActionRecord, FundingRateRecord, FundingPaymentRecord, DepositRecord, LiquidationRecord, SettlePnlRecord, LPRecord, InsuranceFundRecord, SpotInterestRecord, InsuranceFundStakeRecord, CurveRecord, SwapRecord.
