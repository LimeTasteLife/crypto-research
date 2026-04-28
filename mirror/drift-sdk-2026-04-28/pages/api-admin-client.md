# AdminClient
URL: https://mintlify.com/drift-labs/protocol-v2/api/admin-client

# AdminClient

Extends `DriftClient` with admin-only methods. Only callable by the `admin` keypair from the State account.

## Common Methods

- Initialize: `initialize()`, `initializePerpMarket()`, `initializeSpotMarket()`, `initializePrelaunchOracle()`
- Update market params: `updatePerpMarketStatus()`, `updatePerpMarketMarginRatio()`, `updatePerpMarketContractTier()`, `updatePerpMarketMaxOpenInterest()`, `updateSpotMarketAssetTier()`, `updateSpotMarketBorrowRate()`, `updateSpotMarketMaxTokenDeposits()`
- Pause/resume: `updateExchangeStatus()`, `updatePerpMarketPausedOperations()`, `updateSpotMarketPausedOperations()`
- Fees: `updateFeeStructure()`, `updateInitialPctToLiquidate()`, `updateLiquidationDuration()`
- Oracle: `updatePerpMarketOracle()`, `updateSpotMarketOracle()`, `updateOracleGuardRails()`
- Insurance Fund: `transferProtocolIfShares()`
- Delisting: `settleExpiredMarket()`, `settleExpiredMarketPoolsToRevenuePool()`
- High Leverage: `initializeHighLeverageModeConfig()`, `updateHighLeverageModeConfig()`

Construction same as `DriftClient` plus admin signer.
