# Admin Instructions
URL: https://mintlify.com/drift-labs/protocol-v2/program/instructions/admin

# Admin Instructions

Admin-only instructions for initializing and managing protocol state.

## Categories

- Initialize protocol state and markets
- Update market parameters (margin ratios, fees, contract tier, etc.)
- Pause/unpause exchange or specific operations
- Manage insurance funds
- Update oracle sources
- Update fee structures
- Manage delisting and settlement
- Set/rotate admin authority

## Common Instructions

- `initialize` — initialize global state
- `initializePerpMarket` — create new perp market
- `initializeSpotMarket` — create new spot market
- `updatePerpMarketStatus` — pause/resume operations
- `updatePerpMarketMarginRatio` — adjust margin requirements
- `updatePerpMarketContractTier` — change risk tier
- `updateSpotMarketAssetTier` — change asset tier
- `updateExchangeStatus` — pause exchange-wide operations
- `updateFeeStructure` — modify perp/spot fee tiers
- `updateOracleSource` — switch oracle provider for a market
- `settleExpiredMarket` — settle expired perp/future
- `transferProtocolIfShares` — manage IF shares

Admin instructions require the `admin` keypair from the State account.
