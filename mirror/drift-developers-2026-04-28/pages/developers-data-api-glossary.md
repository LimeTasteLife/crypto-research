# Data API Glossary – Drift Protocol
URL: https://docs.drift.trade/developers/data-api/glossary

# Data API Glossary

This is an extensive list for every API endpoint with column definitions per category.

### Shared columns

| Column | Unit | Description |
| --- | --- | --- |
| ts | int | Unix timestamp (seconds since 1970) of the event. |
| txSig | pubkey | Transaction signature. |
| slot | int | Slot number of the event. |
| user | pubkey | |
| amount | int | |
| programId | pubkey | Solana program identifier. |
| marketType | perp/spot | Type of market. |
| marketIndex | int | Perpetual contract market index |
| spotMarketIndex | int | Index of the spot market. |
| perpMarketIndex | int | Index of the perpetual contract market. |
| userAuthority | pubkey | Public key of the user's authority account. |
| oraclePrice | int | Oracle price at the time of an event. |

### Trades

Columns: `fillerReward`, `baseAssetAmountFilled`, `quoteAssetAmountFilled`, `takerFee`, `makerRebate`, `referrerReward`, `quoteAssetAmountSurplus`, `takerOrderBaseAssetAmount`, `takerOrderCumulativeBaseAssetAmountFilled`, `takerOrderCumulativeQuoteAssetAmountFilled`, `makerOrderBaseAssetAmount`, `makerOrderCumulativeBaseAssetAmountFilled`, `makerOrderCumulativeQuoteAssetAmountFilled`, `makerFee`, `action` (fill), `actionExplanation` (orderExpired/orderFilledWithMatch), `filler`, `fillRecordId`, `taker`, `takerOrderId`, `takerOrderDirection` (long/short), `maker`, `makerOrderId`, `makerOrderDirection`, `spotFulfillmentMethodFee`.

### Market Trades

Same as Trades, with action explanations including `orderFilledWithMatch`, `orderFilledWithMatchJit`, `orderFilledWithAmmjit`.

### Funding Rates

Columns: `recordId`, `fundingRate`, `fundingRateLong`, `fundingRateShort`, `cumulativeFundingRateLong`, `cumulativeFundingRateShort`, `oraclePriceTwap`, `markPriceTwap`, `periodRevenue`, `baseAssetAmountWithAmm`, `baseAssetAmountWithUnsettledLp`.

### Funding Payments

Columns: `fundingPayment`, `baseAssetAmount`, `userLastCumulativeFunding`, `ammCumulativeFundingLong`, `ammCumulativeFundingShort`.

### Deposits

Columns: `marketDepositBalance`, `marketWithdrawBalance`, `marketCumulativeDepositInterest`, `marketCumulativeBorrowInterest`, `totalDepositsAfter`, `totalWithdrawsAfter`, `depositRecordId`, `direction` (deposit/withdrawal), `explanation`.

### Liquidations

Columns: `liquidationType` (liquidatePerp / liquidateSpot / liquidateBorrowForPerpPnl / liquidatePerpPnlForDeposit / perpBankruptcy / spotBankruptcy), `liquidator`, `marginRequirement`, `totalCollateral`, `marginFreed`, `liquidationId`, `bankrupt`, `canceledOrderIds`. Each liquidation type has additional detail columns (marketIndex, oraclePrice, etc.).

### Settle PNL

Columns: `pnl`, `baseAssetAmount`, `quoteAssetAmountAfter`, `quoteEntryAmount`, `settlePrice`, `explanation`.

### LP (BAL)

Columns: `action` (addLiquidity / settleLiquidity), `nShares`, `deltaBaseAssetAmount`, `deltaQuoteAssetAmount`, `pnl`.

### Insurance Fund

Columns: `vaultAmountBefore`, `insuranceVaultAmountBefore`, `totalIfSharesBefore`, `totalIfSharesAfter`, `userIfFactor`, `totalIfFactor`.

### Insurance Fund Stake

Columns: `action` (stakeTransfer), `ifSharesBefore`, `userIfSharesBefore`, `totalIfSharesBefore`, `ifSharesAfter`, `userIfSharesAfter`, `totalIfSharesAfter`, `insuranceVaultAmountBefore`.

## v1 (legacy)

### Trades

Columns: `id`, `programId`, `recordId`, `userAuthority`, `user`, `baseAssetAmount` (1e13 precision), `quoteAssetAmount` (1e6), `markPriceBefore` (1e10), `markPriceAfter` (1e10), `fee` (1e6), `liquidation` (bool), `direction` (Long/Short), `blockChainTimeStamp`, `serverTimeStamp`, `marketIndex`, `oraclePrice` (1e10).

Last updated on February 27, 2026
