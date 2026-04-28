# User Instructions
URL: https://mintlify.com/drift-labs/protocol-v2/program/instructions/user

# User Instructions

User account management instructions.

## Common Instructions

- `initializeUserAccount` — create a Drift user account (subaccount)
- `initializeUserAccountAndDepositCollateral` — atomic create + deposit
- `initializeUserStats` — create UserStats account (one per wallet)
- `deposit` — deposit tokens into a spot market
- `withdraw` — withdraw tokens from a spot market
- `transferDeposit` — move spot deposit between subaccounts
- `transferPerpPosition` — move perp position between subaccounts
- `transferIsolatedPerpPositionDeposit` — move isolated perp deposit
- `updateUserDelegate` — set/clear delegate authority
- `updateUserMarginTradingEnabled` — toggle margin trading
- `updateUserCustomMarginRatio` — set custom max margin ratio
- `updateUserPerpPositionCustomMarginRatio` — per-position margin cap
- `deleteUser` — delete an empty subaccount (reclaim rent)
- `reclaimRent` — claim excess rent paid during sybil-fee periods
- `enableHighLeverageMode` — opt into high-leverage tier
- `transferPools` — admin: transfer between insurance fund pools
- `initializeRevenueShare` — set up builder code revenue sharing
- `initializeRevenueShareEscrow` — user escrow for builder approvals
- `changeApprovedBuilder` — approve/revoke a builder code

## Account Types

- UserAccount: positions, orders, balances
- UserStats: aggregate stats, fees, referrer
- SignedMsgUserOrders: SWIFT signed message orders account
- RevenueShareAccount / RevenueShareEscrow: builder code accounts

See concepts/positions and SDK guides for details.
