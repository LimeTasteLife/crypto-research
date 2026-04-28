# Keeper Instructions
URL: https://mintlify.com/drift-labs/protocol-v2/program/instructions/keeper

# Keeper Instructions

Permissionless keeper bot instructions; anyone can call them. Earn rewards for performing protocol-critical actions.

## Categories

- Order filling (matching against AMM, DLOB, JIT)
- Trigger orders (stop/take-profit activation)
- Liquidations (perp, spot, borrow-for-PnL, etc.)
- Funding rate updates
- PnL settlement
- Insurance fund settlement

## Common Instructions

- `fillPerpOrder` — match a taker against AMM/DLOB/JIT
- `fillSpotOrder` — match spot order, including external venues
- `triggerOrder` — activate a triggered conditional order
- `liquidatePerp` — reduce underwater perp position
- `liquidateSpot` — reduce underwater spot position
- `liquidateBorrowForPerpPnl` — settle borrow with positive perp PnL
- `liquidatePerpPnlForDeposit` — cover negative PnL with deposits
- `resolvePerpBankruptcy` — handle perp bankruptcy with IF/socialized loss
- `resolveSpotBankruptcy` — handle spot bankruptcy
- `updateFundingRate` — settle funding rate hourly
- `settlePnl` — settle a user's PnL
- `settleRevenueToInsuranceFund` — sweep revenue to IF
- `updateAmm` — refresh AMM state
- `revertFill` — revert a fill (filler-only when invalid)

## Rewards

- Filler reward: portion of taker fee (capped, oldest-largest priority)
- Liquidator fee: per-market percentage of liquidated value
- IF fee: portion routed to insurance fund

See `Keeper Bots` tutorial pages and `keeper-bots-v2` repository for reference implementations.
