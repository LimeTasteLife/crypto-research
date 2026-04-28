# Market Maker Quickstart – Drift Protocol

Source: https://docs.drift.trade/developers/market-makers/quickstart

Market Maker Quickstart – Drift Protocol

Skip to Content

Developers Market Makers Market Maker Quickstart

Copy page

# Market Maker Quickstart

Get a simple market maker running in under 10 minutes. This guide shows how to place two-sided quotes that automatically update with oracle prices.

## Prerequisites

- Node.js + TypeScript project
- Drift SDK installed:`npm i @drift-labs/sdk`
- Funded Solana account with USDC collateral
- Basic familiarity with async/await

⚠️ RPC choice matters: The default`https://api.mainnet-beta.solana.com` is rate-limited and unsuitable for production bots. Use a dedicated RPC provider (Helius, Triton, etc.) or you’ll hit 429 errors within minutes. For WebSocket subscriptions, you need a provider that supports`accountSubscribe`.

## Step 1: Initialize DriftClient

Set up your connection and subscribe to market data.

TypeScript

```
import { Connection } from "@solana/web3.js";
import { Wallet, DriftClient, loadKeypair } from "@drift-labs/sdk";
 
const connection = new Connection("https://api.mainnet-beta.solana.com");
const wallet = new Wallet(loadKeypair("~/.config/solana/id.json"));
 
const driftClient = new DriftClient({
  connection,
  wallet,
  env: "mainnet-beta",
});
 
 
await driftClient.subscribe();
 
// Initialize your user account (if first time)
// const [txSig] = await driftClient.initializeUserAccount(0);
```

`Class DriftClient` Reference ↗

# DriftClient This class is the main way to interact with Drift Protocol. It allows you to subscribe to the various accounts where the Market's state is stored, as well as: opening positions, liquidating, settling funding, depositing & withdrawing, and more.

`Connection`

`IWallet`

`Program `

`AnchorProvider`

`DriftEnv`

`ConfirmOptions`

`boolean`

`Map `

`UserStats`

`number`

`UserSubscriptionConfig`

`UserStatsSubscriptionConfig`

`DriftClientAccountSubscriber`

`StrictEventEmitter `

`StrictEventEmitter `

`boolean`

`TxSender`

`Map `

`Map `

`Set `

`Set `

`PublicKey`

`PublicKey`

`AddressLookupTableAccount`

`PublicKey[]`

`AddressLookupTableAccount[]`

`boolean`

`Map `

`boolean`

`TransactionVersion`

`TxParams`

`boolean`

`TxHandler`

`Program `

`Program `

`PublicKey`

`Program `

`Map `

`boolean`

`any`

`(subAccountId: number, authority: PublicKey) => string`

`(subAccountId: number, accountSubscriptionConfig: UserSubscriptionConfig, authority?: PublicKey | undefined) => User`

`() => Promise `

`() => Promise []`

`() => Promise `

Forces the accountSubscriber to fetch account updates from rpc

`() => Promise `

`() => Promise []`

`PublicKey`

`() => Promise `

`PublicKey`

`() => PublicKey`

`() => StateAccount`

`() => Promise `

Forces a fetch to rpc before returning accounts. Useful for anchor tests.

`(marketIndex: number) => PerpMarketAccount | undefined`

`(marketIndex: number) => Promise `

Forces a fetch to rpc before returning accounts. Useful for anchor tests.

`() => PerpMarketAccount[]`

`(marketIndex: number) => SpotMarketAccount | undefined`

`(marketIndex: number) => Promise `

Forces a fetch to rpc before returning accounts. Useful for anchor tests.

`() => SpotMarketAccount[]`

`() => SpotMarketAccount`

`(oraclePublicKey: PublicKey, oracleSource: OracleSource) => DataAndSlot | undefined`

`(serumMarket: PublicKey) => Promise `

`() => Promise `

`(phoenixMarket: PublicKey) => Promise `

`() => Promise `

`(openbookMarket: PublicKey) => Promise `

`() => Promise `

`() => Promise `

`() => Promise `

`any`

`(newWallet: IWallet, subAccountIds?: number[] | undefined, activeSubAccountId?: number | undefined, includeDelegates?: boolean | undefined, authoritySubaccountMap?: Map | undefined) => Promise<...>`

Update the wallet to use for drift transactions and linked user account

`(emulateAuthority: PublicKey) => Promise `

Update the subscribed accounts to a given authority, while leaving the connected wallet intact. This allows a user to emulate another user's account on the UI and sign permissionless transactions with their own wallet.

`(subAccountId: number, authority?: PublicKey | undefined) => Promise `

`(subAccountId: number, authority?: PublicKey | undefined, userAccount?: UserAccount | undefined) => Promise `

`(authority?: PublicKey | undefined) => Promise `

Adds and subscribes to users based on params set by the constructor or by updateWallet.

`(subAccountId?: number | undefined, name?: string | undefined, referrerInfo?: ReferrerInfo | undefined, poolId?: number | undefined) => Promise<[TransactionInstruction[], PublicKey]>`

Returns the instructions to initialize a user account and the public key of the user account.

`(subAccountId?: number | undefined, name?: string | undefined, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined) => Promise<[...]>`

Initializes a user account and returns the transaction signature and the public key of the user account.

`(overrides?: { externalWallet?: PublicKey; } | undefined) => Promise `

`(authority: PublicKey, numOrders: number, txParams?: TxParams | undefined) => Promise<[string, PublicKey]>`

`(authority: PublicKey, numOrders: number, overrides?: { externalWallet?: PublicKey; } | undefined) => Promise<[PublicKey, TransactionInstruction]>`

`(authority: PublicKey, numOrders: number, userSubaccountId?: number | undefined, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, numOrders: number, userSubaccountId?: number | undefined) => Promise `

`(authority: PublicKey, delegates?: PublicKey[] | undefined, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, delegates?: PublicKey[] | undefined) => Promise `

`(authority: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, overrides?: { payer?: PublicKey; } | undefined) => Promise `

`(authority: PublicKey, numOrders: number, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, numOrders: number, overrides?: { payer?: PublicKey; } | undefined) => Promise `

`(authority: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey) => Promise `

`(authority: PublicKey, numOrders: number, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, numOrders: number) => Promise `

`(builder: PublicKey, maxFeeTenthBps: number, add: boolean, txParams?: TxParams | undefined) => Promise `

Creates the transaction to add or update an approved builder. This allows the builder to receive revenue share from referrals.

`(builder: PublicKey, maxFeeTenthBps: number, add: boolean, overrides?: { authority?: PublicKey; payer?: PublicKey; } | undefined) => Promise `

Creates the transaction instruction to add or update an approved builder. This allows the builder to receive revenue share from referrals.

`(authority: PublicKey, delegate: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, delegate: PublicKey) => Promise `

`(authority: PublicKey, delegate: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, delegate: PublicKey) => Promise `

`(authority?: PublicKey | undefined) => Promise `

`(authority?: PublicKey | undefined) => Promise `

`(authority?: PublicKey | undefined) => Promise `

`(authority?: PublicKey | undefined) => Promise `

`any`

`() => Promise `

`(name: string) => Promise `

`(name: string, subAccountId?: number | undefined) => Promise `

`(updates: { marginRatio: number; subAccountId: number; }[], txParams?: TxParams | undefined) => Promise `

`(marginRatio: number, subAccountId?: number | undefined) => Promise `

`(perpMarketIndex: number, marginRatio: number, subAccountId?: number | undefined, overrides?: { userAccountPublicKey?: PublicKey; authority?: PublicKey; signingAuthority?: PublicKey; } | undefined) => Promise<...>`

`(perpMarketIndex: number, marginRatio: number, subAccountId?: number | undefined, txParams?: TxParams | undefined, enterHighLeverageMode?: boolean | undefined) => Promise<...>`

`(marginTradingEnabled: boolean, subAccountId?: number | undefined, userAccountPublicKey?: PublicKey | undefined) => Promise `

`(updates: { marginTradingEnabled: boolean; subAccountId: number; }[]) => Promise `

`(delegate: PublicKey, overrides: { subAccountId?: number; userAccountPublicKey?: PublicKey; authority?: PublicKey; }) => Promise `

`(delegate: PublicKey, subAccountId?: number | undefined) => Promise `

`(updates: { advancedLp: boolean; subAccountId: number; }[]) => Promise `

`(advancedLp: boolean, subAccountId: number) => Promise `

`(updates: { reduceOnly: boolean; subAccountId: number; }[]) => Promise `

`(reduceOnly: boolean, subAccountId: number) => Promise `

`(updates: { poolId: number; subAccountId: number; }[]) => Promise `

`(poolId: number, subAccountId: number) => Promise `

`(includeIdle?: boolean | undefined) => Promise []>`

`(delegate: PublicKey) => Promise `

`(authority: PublicKey) => Promise []>`

`(authority: PublicKey) => Promise `

`(referrer: PublicKey) => Promise `

`(authority: PublicKey) => Promise `

`(subAccountId?: number | undefined, txParams?: TxParams | undefined) => Promise `

`(userAccountPublicKey: PublicKey) => Promise `

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, txParams?: TxParams | undefined) => Promise `

`(userAccountPublicKey: PublicKey, userAccount: UserAccount) => Promise `

`(txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey) => Promise `

`(authority: PublicKey) => Promise `

Checks if a SignedMsg User Orders account exists for the given authority. The account pubkey is derived using the program ID and authority as seeds. Makes an RPC call to check if the account exists on-chain.

`(subAccountId?: number | undefined, txParams?: TxParams | undefined) => Promise `

`(userAccountPublicKey: PublicKey) => Promise `

`(subAccountId?: number | undefined, authority?: PublicKey | undefined) => User`

`(subAccountId?: number | undefined, authority?: PublicKey | undefined) => boolean`

`() => User[]`

`() => UserStats`

`(name: string) => Promise `

`PublicKey`

`() => PublicKey`

`(subAccountId?: number | undefined, authority?: PublicKey | undefined) => Promise `

`(subAccountId?: number | undefined, authority?: PublicKey | undefined) => UserAccount | undefined`

`(subAccountId?: number | undefined, authority?: PublicKey | undefined) => Promise `

Forces a fetch to rpc before returning accounts. Useful for anchor tests.

`(subAccountId?: number | undefined, authority?: PublicKey | undefined) => DataAndSlot | undefined`

`(marketIndex: number, subAccountId?: number | undefined) => SpotPosition | undefined`

`() => BN`

`(perpMarketIndex: number, subAccountId?: number | undefined) => BN`

`(marketIndex: number) => BN`

Returns the token amount for a given market. The spot market precision is based on the token mint decimals. Positive if it is a deposit, negative if it is a borrow.

`(marketIndex: number, amount: any) => BN`

Converts an amount to the spot precision for a given market. The spot market precision is based on the token mint decimals.

`(amount: any) => BN`

Converts an amount to the perp precision. The perp market precision is BASE_PRECISION (1e9).

`(amount: any) => BN`

Converts an amount to the price precision. The perp market precision is PRICE_PRECISION (1e6).

`({ perpMarketIndexes, spotMarketIndexes, }: { perpMarketIndexes: number[]; spotMarketIndexes: number[]; }) => void`

Each drift instruction must include perp and sport market accounts in the ix remaining accounts. Use this function to force a subset of markets to be included in the remaining accounts for every ix

`(params: RemainingAccountParams) => AccountMeta[]`

`(marketIndex: number, writable: boolean, oracleAccountMap: Map, spotMarketAccountMap: Map, perpMarketAccountMap: Map<...>) => void`

`(marketIndex: number, writable: boolean, oracleAccountMap: Map, spotMarketAccountMap: Map) => void`

`(builders: PublicKey[], remainingAccounts: AccountMeta[]) => void`

`(userAccounts: UserAccount[]) => { oracleAccountMap: Map; spotMarketAccountMap: Map; perpMarketAccountMap: Map<...>; }`

`(orderId: number, subAccountId?: number | undefined) => Order | undefined`

`(userOrderId: number, subAccountId?: number | undefined) => Order | undefined`

`(marketIndex: number, useNative?: boolean | undefined, tokenProgram?: PublicKey | undefined, authority?: PublicKey | undefined, allowOwnerOffCurve?: boolean | undefined) => Promise<...>`

Get the associated token address for the given spot market

`(account: PublicKey, payer: PublicKey, owner: PublicKey, mint: PublicKey, tokenProgram?: PublicKey | undefined) => TransactionInstruction`

`(amount: BN, marketIndex: number, associatedTokenAccount: PublicKey, subAccountId?: number | undefined, reduceOnly?: boolean | undefined, overrides?: { authority?: PublicKey; } | undefined) => Promise<...>`

`(signedOrderParams: SignedMsgOrderParams, takerInfo: { taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }, depositAmount: BN, depositSpotMarketIndex: number, tradePerpMarketIndex: number, subAccountId: number, takerAssociatedTokenAccount: PublicKey, initSwiftAccoun...`

`(amount: BN, marketIndex: number, associatedTokenAccount: PublicKey, subAccountId?: number | undefined, reduceOnly?: boolean | undefined, txParams?: TxParams | undefined, initSwiftAccount?: boolean | undefined, overrides?: { ...; } | undefined) => Promise<...>`

`(amount: BN, marketIndex: number, associatedTokenAccount: PublicKey, subAccountId?: number | undefined, reduceOnly?: boolean | undefined, txParams?: TxParams | undefined, initSwiftAccount?: boolean | undefined, overrides?: { ...; } | undefined) => Promise<...>`

Deposit funds into the given spot market

`(amount: BN, marketIndex: number, userTokenAccount: PublicKey, subAccountId?: number | undefined, reduceOnly?: boolean | undefined, userInitialized?: boolean | undefined, overrides?: { ...; } | undefined) => Promise<...>`

`any`

`(amount: BN, includeRent?: boolean | undefined, overrides?: { authority?: PublicKey; } | undefined) => Promise<{ ixs: TransactionInstruction[]; signers: Signer[]; pubkey: PublicKey; }>`

`(spotMarketAccount: SpotMarketAccount) => PublicKey`

`(spotMarketAccount: SpotMarketAccount) => boolean`

`(spotMarketAccount: SpotMarketAccount) => boolean`

`(spotMarketAccount: SpotMarketAccount, remainingAccounts: AccountMeta[]) => void`

`(mint: PublicKey, remainingAccounts: AccountMeta[]) => Promise `

`(tokenMintAddress: PublicKey, associatedTokenAddress: PublicKey, tokenProgram: PublicKey) => TransactionInstruction`

`(amount: BN, userTokenAccount: PublicKey, marketIndex?: number | undefined, subAccountId?: number | undefined, name?: string | undefined, fromSubAccountId?: number | undefined, referrerInfo?: ReferrerInfo | undefined, donateAmount?: any, customMaxMarginRatio?: number | undefined, poolId?: number | undefined, overrid...`

`(amount: BN, userTokenAccount: PublicKey, marketIndex?: number | undefined, subAccountId?: number | undefined, name?: string | undefined, fromSubAccountId?: number | undefined, referrerInfo?: ReferrerInfo | undefined, donateAmount?: any, txParams?: TxParams | undefined, customMaxMarginRatio?: number | undefined, poo...`

`(amount: BN, userTokenAccount: PublicKey, marketIndex?: number | undefined, subAccountId?: number | undefined, name?: string | undefined, fromSubAccountId?: number | undefined, referrerInfo?: ReferrerInfo | undefined, donateAmount?: any, txParams?: TxParams | undefined, customMaxMarginRatio?: number | undefined, poo...`

Creates the User account for a user, and deposits some initial collateral

`(subAccountId: number, name: string, marketIndex: number, tokenFaucet: TokenFaucet, amount: BN, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined) => Promise<...>`

`(amount: BN, marketIndex: number, associatedTokenAddress: PublicKey, reduceOnly?: boolean | undefined, subAccountId?: number | undefined, _updateFuel?: boolean | undefined) => Promise<...>`

`(amount: BN, marketIndex: number, associatedTokenAddress: PublicKey, reduceOnly?: boolean | undefined, subAccountId?: number | undefined, txParams?: TxParams | undefined, updateFuel?: boolean | undefined) => Promise<...>`

Withdraws from a user account. If deposit doesn't already exist, creates a borrow

`(subAccountId?: number | undefined, txParams?: TxParams | undefined, opts?: { dustPositionCountCallback?: (count: number) => void; } | undefined) => Promise `

`(amount: BN, marketIndex: number, userTokenAccount: PublicKey, reduceOnly?: boolean | undefined, subAccountId?: number | undefined) => Promise `

`(amount: BN, marketIndex: number, fromSubAccountId: number, toSubAccountId: number, txParams?: TxParams | undefined) => Promise `

Withdraws from the fromSubAccount and deposits into the toSubAccount

`(amount: BN, marketIndex: number, fromSubAccountId: number, toSubAccountId: number) => Promise `

`(depositFromMarketIndex: number, depositToMarketIndex: number, borrowFromMarketIndex: number, borrowToMarketIndex: number, depositAmount: any, borrowAmount: any, fromSubAccountId: number, toSubAccountId: number, txParams?: TxParams | undefined) => Promise<...>`

`(depositFromMarketIndex: number, depositToMarketIndex: number, borrowFromMarketIndex: number, borrowToMarketIndex: number, depositAmount: any, borrowAmount: any, fromSubAccountId: number, toSubAccountId: number, isToNewSubAccount?: boolean | undefined) => Promise<...>`

`(fromSubAccountId: number, toSubAccountId: number, marketIndex: number, amount: BN, txParams?: TxParams | undefined) => Promise `

`(fromSubAccountId: number, toSubAccountId: number, marketIndex: number, amount: BN) => Promise `

`(amount: BN, perpMarketIndex: number, userTokenAccount: PublicKey, subAccountId?: number | undefined, txParams?: TxParams | undefined) => Promise `

`(amount: BN, perpMarketIndex: number, userTokenAccount: PublicKey, subAccountId?: number | undefined) => Promise `

`(amount: BN, perpMarketIndex: number, subAccountId?: number | undefined, txParams?: TxParams | undefined, trySettle?: boolean | undefined, noBuffer?: boolean | undefined) => Promise<...>`

`(amount: BN, perpMarketIndex: number, subAccountId?: number | undefined, noAmountBuffer?: boolean | undefined, signingAuthority?: PublicKey | undefined) => Promise `

`(amount: BN, perpMarketIndex: number, userTokenAccount: PublicKey, subAccountId?: number | undefined, txParams?: TxParams | undefined) => Promise `

`(amount: BN, perpMarketIndex: number, subAccountId?: number | undefined, userTokenAccount?: PublicKey | undefined) => Promise `

`(amount: BN, perpMarketIndex: number, userTokenAccount: PublicKey, subAccountId?: number | undefined) => Promise `

`(marketIndex: number, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number) => Promise `

`(settleeUserAccountPublicKey: PublicKey, marketIndex: number, txParams?: TxParams | undefined) => Promise `

`(settleeUserAccountPublicKey: PublicKey, marketIndex: number) => Promise `

`(marketIndex: number, sharesToBurn?: any, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise `

`(marketIndex: number, userAccountPublicKey: PublicKey, sharesToBurn?: any, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number, userAccountPublicKey: PublicKey, sharesToBurn?: any) => Promise `

`(marketIndex: number, sharesToBurn?: any, subAccountId?: number | undefined) => Promise `

`(amount: BN, marketIndex: number, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise `

`(amount: BN, marketIndex: number, subAccountId?: number | undefined) => Promise `

`(marketIndex: number) => BN`

`(direction: PositionDirection, amount: BN, marketIndex: number, limitPrice?: any, subAccountId?: number | undefined) => Promise `

`(tx: VersionedTransaction | Transaction, opts?: ConfirmOptions | undefined) => Promise `

`(orderParams: OptionalOrderParams, userAccountPublicKey: PublicKey, userAccount: UserAccount, makerInfo?: MakerInfo | MakerInfo[] | undefined, txParams?: TxParams | undefined, bracketOrdersParams?: OptionalOrderParams[] | undefined, referrerInfo?: ReferrerInfo | undefined, cancelExistingOrders?: boolean | undefined,...`

`(orderParams: OptionalOrderParams, userAccountPublicKey: PublicKey, userAccount: UserAccount, makerInfo?: MakerInfo | MakerInfo[] | undefined, txParams?: TxParams | undefined, bracketOrdersParams?: OptionalOrderParams[] | undefined, referrerInfo?: ReferrerInfo | undefined, cancelExistingOrders?: boolean | undefined,...`

Sends a market order and returns a signed tx which can fill the order against the vamm, which the caller can use to fill their own order if required.

`(orderParams: OptionalOrderParams, txParams?: TxParams | undefined, subAccountId?: number | undefined, isolatedPositionDepositAmount?: any) => Promise<...>`

`(orderParams: OptionalOrderParams, subAccountId?: number | undefined, depositToTradeArgs?: { isMakingNewAccount: boolean; depositMarketIndex: number; } | undefined) => Promise<...>`

`(marketIndexes: number[], txParams?: TxParams | undefined) => Promise `

`(marketIndexes: number[]) => Promise `

`(marketIndex: number, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number) => Promise `

`(marketIndex: number, txParams?: TxParams | undefined) => Promise `

`(perpMarketIndex: number) => Promise `

`(orderId?: number | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined, overrides?: { withdrawIsolatedDepositAmount?: any; } | undefined) => Promise<...>`

`(orderId?: number | undefined, subAccountId?: number | undefined) => Promise `

`(userOrderId: number, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise `

`(userOrderId: number, subAccountId?: number | undefined) => Promise `

`(orderIds?: number[] | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined, user?: User | undefined, overrides?: { authority?: PublicKey; } | undefined) => Promise<...>`

Sends a transaction to cancel the provided order ids.

`(orderIds?: number[] | undefined, subAccountId?: number | undefined, user?: User | undefined, overrides?: { authority?: PublicKey; } | undefined) => Promise `

Returns the transaction instruction to cancel the provided order ids.

`(marketType?: MarketType | undefined, marketIndex?: number | undefined, direction?: PositionDirection | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<...>`

`(marketType: MarketType | null, marketIndex: number | null, direction: PositionDirection | null, subAccountId?: number | undefined) => Promise<...>`

`(cancelOrderParams: { marketType?: MarketType; marketIndex?: number; direction?: PositionDirection; }, placeOrderParams: OrderParams[], txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<...>`

`(params: OrderParams[], txParams?: TxParams | undefined, subAccountId?: number | undefined, optionalIxs?: TransactionInstruction[] | undefined, isolatedPositionDepositAmount?: any) => Promise<...>`

`(params: OrderParams[], txParams?: TxParams | undefined, subAccountId?: number | undefined, optionalIxs?: TransactionInstruction[] | undefined, isolatedPositionDepositAmount?: any) => Promise<...>`

`(params: OptionalOrderParams[], subAccountId?: number | undefined, overrides?: { authority?: PublicKey; } | undefined) => Promise `

`(params: OptionalOrderParams[], positionMaxLev: number, subAccountId?: number | undefined) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, order?: Pick | undefined, makerInfo?: MakerInfo | MakerInfo[] | undefined, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined, fillerSubAccountId?: number | undefined, fillerAuthority?: PublicKey | undefined,...`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, order: Pick, makerInfo?: MakerInfo | MakerInfo[] | undefined, referrerInfo?: ReferrerInfo | undefined, fillerSubAccountId?: number | undefined, isSignedMsg?: boolean | undefined, fillerAuthority?: PublicKey | undefined, has...`

`(fillerPublicKey?: PublicKey | undefined) => Promise `

`(orderParams: OptionalOrderParams, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise `

`(orderParams: OptionalOrderParams, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<{ placeSpotOrderTx: Transaction | VersionedTransaction; }>`

`(orderParams: OptionalOrderParams, subAccountId?: number | undefined) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, order?: Pick | undefined, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | PhoenixV1FulfillmentConfigAccount | OpenbookV2FulfillmentConfigAccount | undefined, makerInfo?: MakerInfo | ... 1 more ... | undefined, referrerInfo?:...`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, order?: Pick | undefined, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | PhoenixV1FulfillmentConfigAccount | OpenbookV2FulfillmentConfigAccount | undefined, makerInfo?: MakerInfo | ... 1 more ... | undefined, referre...`

`(marketIndex: number, remainingAccounts: AccountMeta[], fulfillmentConfig?: SerumV3FulfillmentConfigAccount | PhoenixV1FulfillmentConfigAccount | OpenbookV2FulfillmentConfigAccount | undefined) => void`

`(marketIndex: number, remainingAccounts: AccountMeta[], fulfillmentConfig: SerumV3FulfillmentConfigAccount) => void`

`(marketIndex: number, remainingAccounts: AccountMeta[], fulfillmentConfig: PhoenixV1FulfillmentConfigAccount) => void`

`(marketIndex: number, remainingAccounts: AccountMeta[], fulfillmentConfig: OpenbookV2FulfillmentConfigAccount) => void`

`({ swapClient, jupiterClient, outMarketIndex, inMarketIndex, outAssociatedTokenAccount, inAssociatedTokenAccount, amount, slippageBps, swapMode, reduceOnly, txParams, v6, quote, onlyDirectRoutes, }: { swapClient?: UnifiedSwapClient | SwapClient; jupiterClient?: JupiterClient; outMarketIndex: number; inMarketIndex: n...`

Swap tokens in drift account using titan or jupiter

`({ titanClient, outMarketIndex, inMarketIndex, outAssociatedTokenAccount, inAssociatedTokenAccount, amount, slippageBps, swapMode, onlyDirectRoutes, reduceOnly, userAccountPublicKey, }: { titanClient: TitanClient; outMarketIndex: number; inMarketIndex: number; outAssociatedTokenAccount?: PublicKey; inAssociatedToken...`

`({ jupiterClient, outMarketIndex, inMarketIndex, outAssociatedTokenAccount, inAssociatedTokenAccount, amount, slippageBps, swapMode, onlyDirectRoutes, quote, reduceOnly, userAccountPublicKey, }: { jupiterClient: JupiterClient; outMarketIndex: number; inMarketIndex: number; outAssociatedTokenAccount?: PublicKey; inAs...`

`({ outMarketIndex, inMarketIndex, amountIn, inTokenAccount, outTokenAccount, limitPrice, reduceOnly, userAccountPublicKey, }: { outMarketIndex: number; inMarketIndex: number; amountIn: BN; inTokenAccount: PublicKey; outTokenAccount: PublicKey; limitPrice?: any; reduceOnly?: SwapReduceOnly; userAccountPublicKey?: Pub...`

Get the drift begin_swap and end_swap instructions

`({ swapClient, outMarketIndex, inMarketIndex, outAssociatedTokenAccount, inAssociatedTokenAccount, amount, slippageBps, swapMode, onlyDirectRoutes, reduceOnly, quote, v6, userAccountPublicKey, }: { swapClient: UnifiedSwapClient; outMarketIndex: number; inMarketIndex: number; outAssociatedTokenAccount?: PublicKey; in...`

`({ amount }: { amount: BN; }) => Promise `

`({ amount, userAccountPublicKey, }: { amount: BN; userAccountPublicKey?: PublicKey; }) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, order: Order, txParams?: TxParams | undefined, fillerPublicKey?: PublicKey | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, order: Order, fillerPublicKey?: PublicKey | undefined) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, txParams?: TxParams | undefined, fillerPublicKey?: PublicKey | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, fillerPublicKey?: PublicKey | undefined) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, txParams?: TxParams | undefined, fillerPublicKey?: PublicKey | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, fillerPublicKey?: PublicKey | undefined) => Promise `

`(userAccountPublicKey: PublicKey, txParams?: TxParams | undefined) => Promise `

`(userAccountPublicKey: PublicKey) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, userAuthority: PublicKey, txParams?: TxParams | undefined) => Promise `

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, userAuthority: PublicKey) => Promise `

`(userAuthority: PublicKey, txParams?: TxParams | undefined) => Promise `

`(userAuthority: PublicKey) => Promise `

`(userAccountPublicKey: PublicKey, user: UserAccount, txParams?: TxParams | undefined, fillerPublicKey?: PublicKey | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, fillerPublicKey?: PublicKey | undefined) => Promise `

`(orderParams: OptionalOrderParams, makerInfo?: MakerInfo | MakerInfo[] | undefined, referrerInfo?: ReferrerInfo | undefined, successCondition?: PlaceAndTakeOrderSuccessCondition | undefined, auctionDurationPercentage?: number | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise...`

`(orderParams: OptionalOrderParams, makerInfo?: MakerInfo | MakerInfo[] | undefined, referrerInfo?: ReferrerInfo | undefined, bracketOrdersParams?: OptionalOrderParams[] | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined, cancelExistingOrders?: boolean | undefined, settlePnl?: boolean | u...`

`(orderParams: OptionalOrderParams, makerInfo?: MakerInfo | MakerInfo[] | undefined, referrerInfo?: ReferrerInfo | undefined, bracketOrdersParams?: OptionalOrderParams[] | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined, cancelExistingOrders?: boolean | undefined, settlePnl?: boolean | u...`

`(orderParams: OptionalOrderParams, makerInfo?: MakerInfo | MakerInfo[] | undefined, referrerInfo?: ReferrerInfo | undefined, successCondition?: PlaceAndTakeOrderSuccessCondition | undefined, auctionDurationPercentage?: number | undefined, subAccountId?: number | undefined, overrides?: { ...; } | undefined) => Promis...`

`(orderParams: OptionalOrderParams, takerInfo: TakerInfo, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<...>`

`(orderParams: OptionalOrderParams, takerInfo: TakerInfo, referrerInfo?: ReferrerInfo | undefined, subAccountId?: number | undefined) => Promise<...>`

`(orderParamsMessage: SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage, delegateSigner?: boolean | undefined) => SignedMsgOrderParams`

`(depositTx: VersionedTransaction, orderParamsMessage: SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage, delegateSigner?: boolean | undefined) => { ...; }`

Builds a deposit and place request for Swift service

`(orderParamsMessage: SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage, delegateSigner?: boolean | undefined) => Buffer`

`(encodedMessage: Buffer, delegateSigner?: boolean | undefined) => SignedMsgOrderParamsMessage | SignedMsgOrderParamsDelegateMessage`

`(message: Uint8Array, keypair?: Keypair | undefined) => Buffer`

`(signedSignedMsgOrderParams: SignedMsgOrderParams, marketIndex: number, takerInfo: { taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }, precedingIxs?: TransactionInstruction[] | undefined, overrideCustomIxIndex?: number | undefined, txParams?: TxParams | undefined...`

`(signedSignedMsgOrderParams: SignedMsgOrderParams, marketIndex: number, takerInfo: { taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }, precedingIxs?: TransactionInstruction[] | undefined, overrideCustomIxIndex?: number | undefined) => Promise<...>`

`(signedSignedMsgOrderParams: SignedMsgOrderParams, signedMsgOrderUuid: Uint8Array, takerInfo: { taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }, orderParams: OptionalOrderParams, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | und...`

`(signedSignedMsgOrderParams: SignedMsgOrderParams, signedMsgOrderUuid: Uint8Array, takerInfo: { taker: PublicKey; takerStats: PublicKey; takerUserAccount: UserAccount; signingAuthority: PublicKey; }, orderParams: OptionalOrderParams, referrerInfo?: ReferrerInfo | undefined, subAccountId?: number | u...`

`(orderParams: OptionalOrderParams, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | undefined, makerInfo?: MakerInfo | undefined, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<...>`

`(orderParams: OptionalOrderParams, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | undefined, makerInfo?: MakerInfo | undefined, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<...>`

`(orderParams: OptionalOrderParams, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | undefined, makerInfo?: MakerInfo | undefined, referrerInfo?: ReferrerInfo | undefined, subAccountId?: number | undefined) => Promise<...>`

`(orderParams: OptionalOrderParams, takerInfo: TakerInfo, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | undefined, referrerInfo?: ReferrerInfo | undefined, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Promise<...>`

`(orderParams: OptionalOrderParams, takerInfo: TakerInfo, fulfillmentConfig?: SerumV3FulfillmentConfigAccount | undefined, referrerInfo?: ReferrerInfo | undefined, subAccountId?: number | undefined) => Promise<...>`

`(marketIndex: number, limitPrice?: any, subAccountId?: number | undefined) => Promise `

`(orderId: number, newBaseAmount?: any, newLimitPrice?: any, newOraclePriceOffset?: number | undefined) => Promise `

Modifies an open order by closing it and replacing it with a new order.

`(userOrderId: number, newBaseAmount?: any, newLimitPrice?: any, newOraclePriceOffset?: number | undefined) => Promise `

Modifies an open order by closing it and replacing it with a new order.

`(orderParams: { orderId: number; newDirection?: PositionDirection; newBaseAmount?: any; newLimitPrice?: any; newOraclePriceOffset?: number; newTriggerPrice?: any; newTriggerCondition?: OrderTriggerCondition; ... 7 more ...; policy?: number; }, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Pr...`

Modifies an open order (spot or perp) by closing it and replacing it with a new order.

`({ orderId, newDirection, newBaseAmount, newLimitPrice, newOraclePriceOffset, newTriggerPrice, newTriggerCondition, auctionDuration, auctionStartPrice, auctionEndPrice, reduceOnly, postOnly, bitFlags, maxTs, policy, }: { orderId: number; newDirection?: PositionDirection; newBaseAmount?: any; newLimitPrice?: any; new...`

`(orderParams: { userOrderId: number; newDirection?: PositionDirection; newBaseAmount?: any; newLimitPrice?: any; newOraclePriceOffset?: number; newTriggerPrice?: any; newTriggerCondition?: OrderTriggerCondition; ... 7 more ...; maxTs?: any; }, txParams?: TxParams | undefined, subAccountId?: number | undefined) => Pr...`

Modifies an open order by closing it and replacing it with a new order.

`({ userOrderId, newDirection, newBaseAmount, newLimitPrice, newOraclePriceOffset, newTriggerPrice, newTriggerCondition, auctionDuration, auctionStartPrice, auctionEndPrice, reduceOnly, postOnly, bitFlags, maxTs, policy, }: { userOrderId: number; newDirection?: PositionDirection; newBaseAmount?: any; newLimitPrice?: ...`

`(users: { settleeUserAccountPublicKey: PublicKey; settleeUserAccount: UserAccount; }[], marketIndexes: number[], opts?: { filterInvalidMarkets?: boolean; } | undefined, txParams?: TxParams | undefined) => Promise<...>`

`(users: { settleeUserAccountPublicKey: PublicKey; settleeUserAccount: UserAccount; }[], marketIndexes: number[], revenueShareEscrowMap?: RevenueShareEscrowMap | undefined) => Promise<...>`

`(settleeUserAccountPublicKey: PublicKey, settleeUserAccount: UserAccount, marketIndex: number, txParams?: TxParams | undefined, optionalIxs?: TransactionInstruction[] | undefined, revenueShareEscrowMap?: RevenueShareEscrowMap | undefined) => Promise<...>`

`(settleeUserAccountPublicKey: PublicKey, settleeUserAccount: UserAccount, marketIndex: number, revenueShareEscrowMap?: RevenueShareEscrowMap | undefined) => Promise<...>`

`(settleeUserAccountPublicKey: PublicKey, settleeUserAccount: UserAccount, marketIndexes: number[], mode: SettlePnlMode, revenueShareEscrowMap?: RevenueShareEscrowMap | undefined, txParams?: TxParams | undefined) => Promise<...>`

`(settleeUserAccountPublicKey: PublicKey, settleeUserAccount: UserAccount, marketIndexes: number[], mode: SettlePnlMode, txParams?: TxParams | undefined, optionalIxs?: TransactionInstruction[] | undefined, revenueShareEscrowMap?: RevenueShareEscrowMap | undefined) => Promise<...>`

`(settleeUserAccountPublicKey: PublicKey, settleeUserAccount: UserAccount, marketIndexes: number[], mode: SettlePnlMode, overrides?: { authority?: PublicKey; } | undefined, revenueShareEscrowMap?: RevenueShareEscrowMap | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount) => Promise `

`(userAccountPublicKey: PublicKey, userAccount: UserAccount) => Promise `

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, maxBaseAssetAmount: BN, limitPrice?: any, txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, maxBaseAssetAmount: BN, limitPrice?: any, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, makerInfos: MakerInfo[], txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, makerInfos: MakerInfo[], liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, assetMarketIndex: number, liabilityMarketIndex: number, maxLiabilityTransfer: BN, limitPrice?: any, txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, assetMarketIndex: number, liabilityMarketIndex: number, maxLiabilityTransfer: BN, limitPrice?: any, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`({ jupiterClient, liabilityMarketIndex, assetMarketIndex, swapAmount, assetTokenAccount, liabilityTokenAccount, slippageBps, swapMode, onlyDirectRoutes, quote, userAccount, userAccountPublicKey, userStatsAccountPublicKey, liquidatorSubAccountId, maxAccounts, }: { jupiterClient: JupiterClient; liabilityMarketIndex: n...`

`({ liabilityMarketIndex, assetMarketIndex, swapAmount: swapAmount, assetTokenAccount, liabilityTokenAccount, userAccount, userAccountPublicKey, userStatsAccountPublicKey, liquidatorSubAccountId, }: { liabilityMarketIndex: number; assetMarketIndex: number; swapAmount: BN; assetTokenAccount: PublicKey; liabilityTokenA...`

Get the drift liquidate_spot_with_swap instructions

`({ inMarketIndex, outMarketIndex, amountIn, inTokenAccount, outTokenAccount, }: { inMarketIndex: number; outMarketIndex: number; amountIn: BN; inTokenAccount: PublicKey; outTokenAccount: PublicKey; }) => Promise<{ beginSwapIx: TransactionInstruction; endSwapIx: TransactionInstruction; }>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, perpMarketIndex: number, liabilityMarketIndex: number, maxLiabilityTransfer: BN, limitPrice?: any, txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, perpMarketIndex: number, liabilityMarketIndex: number, maxLiabilityTransfer: BN, limitPrice?: any, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, perpMarketIndex: number, assetMarketIndex: number, maxPnlTransfer: BN, limitPrice?: any, txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, perpMarketIndex: number, assetMarketIndex: number, maxPnlTransfer: BN, limitPrice?: any, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, liquidatorSubAccountId?: number | undefined) => Promise `

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, txParams?: TxParams | undefined, liquidatorSubAccountId?: number | undefined) => Promise<...>`

`(userAccountPublicKey: PublicKey, userAccount: UserAccount, marketIndex: number, liquidatorSubAccountId?: number | undefined) => Promise `

`(perpMarketIndex: number, oracle: PublicKey, txParams?: TxParams | undefined) => Promise `

`(perpMarketIndex: number, oracle: PublicKey) => Promise `

`(perpMarketIndex: number, txParams?: TxParams | undefined) => Promise `

`(perpMarketIndex: number) => Promise `

`(perpMarketIndex: number, makers: [PublicKey, PublicKey][], txParams?: TxParams | undefined) => Promise `

`(perpMarketIndex: number, makers: [PublicKey, PublicKey][]) => Promise `

`(userAccountPublicKey: PublicKey, txParams?: TxParams | undefined) => Promise `

`(userAccountPublicKey: PublicKey) => Promise `

`(eventName: keyof DriftClientAccountEvents, data?: any) => void`

`(marketIndex: number) => OraclePriceData`

`(marketIndex: number) => MMOraclePriceData`

`(marketIndex: number) => OraclePriceData`

`(marketIndex: number, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number) => Promise `

`(marketIndex: number, amount: BN, collateralAccountPublicKey: PublicKey) => Promise `

`({ marketIndex, amount, collateralAccountPublicKey, initializeStakeAccount, fromSubaccount, txParams, }: { marketIndex: number; amount: BN; collateralAccountPublicKey: PublicKey; initializeStakeAccount?: boolean; fromSubaccount?: boolean; txParams?: TxParams; }) => Promise<...>`

Add to an insurance fund stake and optionally initialize the account

`({ marketIndex, amount, collateralAccountPublicKey, initializeStakeAccount, fromSubaccount, }: { marketIndex: number; amount: BN; collateralAccountPublicKey: PublicKey; initializeStakeAccount?: boolean; fromSubaccount?: boolean; }) => Promise `

Get instructions to add to an insurance fund stake and optionally initialize the account

`(marketIndex: number, amount: BN, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number, collateralAccountPublicKey: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey) => Promise `

`(authority: PublicKey, txParams?: TxParams | undefined) => Promise `

`(authority: PublicKey) => Promise `

`(spotMarketIndex: number, txParams?: TxParams | undefined) => Promise `

`(spotMarketIndex: number) => Promise `

`(spotMarketIndex: number, perpMarketIndex: number, txParams?: TxParams | undefined) => Promise `

`(spotMarketIndex: number, perpMarketIndex: number) => Promise `

`(marketIndex: number, amount: BN, userTokenAccountPublicKey: PublicKey) => Promise `

`(marketIndex: number, amount: BN, userTokenAccountPublicKey: PublicKey) => Promise `

This ix will donate your funds to drift revenue pool. It does not deposit into your user account

`(marketIndex: number) => PerpMarketExtendedInfo`

`(marketType: MarketType, marketIndex?: number | undefined, user?: User | undefined, enteringHighLeverageMode?: boolean | undefined) => { takerFee: number; makerFee: number; }`

Calculates taker / maker fee (as a percentage, e.g. .001 = 10 basis points) for particular marketType

`(name: string) => { marketIndex: number; marketType: MarketType; } | undefined`

Returns the market index and type for a given market name E.g. "SOL-PERP" -> { marketIndex: 0, marketType: MarketType.PERP }

`() => Program `

`() => Promise >`

`(vaaString: string, feedId: string) => Promise `

`(vaaString: string, feedIds: string[]) => Promise `

`(vaaString: string, feedIds: string | string[], numSignatures?: number | undefined) => Promise `

`any`

`(vaaString: string, feedId: string) => Promise `

`(params: { merklePriceUpdate: { message: Buffer; proof: number[][]; }; }, feedId: string, encodedVaaAddress: PublicKey) => Promise `

`(feedIds: number[], pythMessageHex: string) => Promise `

`(feedIds: number[], pythMessageHex: string, precedingIxs?: TransactionInstruction[] | undefined, overrideCustomIxIndex?: number | undefined) => Promise `

`(feeds: PublicKey[], recentSlothash?: Slothash | undefined, numSignatures?: number | undefined) => Promise `

`(feed: PublicKey, recentSlothash?: Slothash | undefined, numSignatures?: number | undefined) => Promise `

`(feed: PublicKey, recentSlothash?: Slothash | undefined, numSignatures?: number | undefined) => Promise `

`any`

`(subAccountId: number, txParams?: TxParams | undefined) => Promise `

`(subAccountId: number, depositToTradeArgs?: { isMakingNewAccount: boolean; depositMarketIndex: number; orderMarketIndex: number; } | undefined, overrides?: { user?: User; signingAuthority?: PublicKey; } | undefined) => Promise<...>`

`(user: PublicKey, userAccount?: UserAccount | undefined, txParams?: TxParams | undefined) => Promise `

`(user: PublicKey, userAccount?: UserAccount | undefined, maintenance?: boolean | undefined) => Promise `

`() => Promise `

`() => Promise `

`(subAccountId: number, protectedOrders: boolean, authority?: PublicKey | undefined, txParams?: TxParams | undefined) => Promise `

`(subAccountId: number, protectedOrders: boolean, authority?: PublicKey | undefined) => Promise `

`(spotMarketIndex: number) => Promise `

`(spotMarketIndex: number, txParams?: TxParams | undefined) => Promise `

`(marketIndex: number, oraclePrice: BN, oracleSequenceId: BN) => Promise `

`(marketIndex: number, oraclePrice: BN, oracleSequenceId: BN) => Promise `

`(marketIndex: number, ammSpreadAdjustment: number) => Promise `

`(marketIndex: number, ammSpreadAdjustment: number) => TransactionInstruction`

`(lpPoolId: number) => Promise `

`(lpPoolId: number) => Promise `

`() => Promise `

`(lpPoolId: number, constituents: PublicKey[], txParams?: TxParams | undefined) => Promise `

`(lpPoolId: number, constituents: PublicKey[]) => Promise `

`(lpPool: LPPoolAccount, spotMarketIndexOfConstituents: number[], txParams?: TxParams | undefined) => Promise `

`(lpPool: LPPoolAccount, spotMarketIndexOfConstituents: number[]) => Promise `

`(perpMarketIndexes: number[], txParams?: TxParams | undefined) => Promise `

`(perpMarketIndexes: number[]) => Promise `

`(constituent: ConstituentAccount) => Promise `

`(constituent: ConstituentAccount) => Promise `

`(inMarketIndex: number, outMarketIndex: number, inAmount: BN, minOutAmount: BN, lpPool: PublicKey, userAuthority: PublicKey, txParams?: TxParams | undefined) => Promise<...>`

`(inMarketIndex: number, outMarketIndex: number, inAmount: BN, minOutAmount: BN, lpPool: PublicKey, userAuthority: PublicKey) => Promise `

`(inMarketIndex: number, outMarketIndex: number, inAmount: BN, inTargetWeight: BN, outTargetWeight: BN, lpPool: PublicKey, constituentTargetBase: PublicKey, constituentInTokenAccount: PublicKey, constituentOutTokenAccount: PublicKey, inConstituent: PublicKey, outConstituent: PublicKey, txParams?: TxParams | undefined...`

`(inMarketIndex: number, outMarketIndex: number, inAmount: BN, inTargetWeight: BN, outTargetWeight: BN, lpPool: PublicKey, constituentTargetBase: PublicKey, constituentInTokenAccount: PublicKey, constituentOutTokenAccount: PublicKey, inConstituent: PublicKey, outConstituent: PublicKey) => Promise<...>`

`(lpPool: LPPoolAccount) => Promise `

`(lpPool: LPPoolAccount, txParams?: TxParams | undefined) => Promise `

`({ inMarketIndex, inAmount, minMintAmount, lpPool, txParams, }: { inMarketIndex: number; inAmount: BN; minMintAmount: BN; lpPool: LPPoolAccount; txParams?: TxParams; }) => Promise `

`({ inMarketIndex, inAmount, minMintAmount, lpPool, }: { inMarketIndex: number; inAmount: BN; minMintAmount: BN; lpPool: LPPoolAccount; }) => Promise `

`({ inMarketIndex, inAmount, lpPool, txParams, }: { inMarketIndex: number; inAmount: BN; lpPool: LPPoolAccount; txParams?: TxParams; }) => Promise `

`({ inMarketIndex, inAmount, lpPool, }: { inMarketIndex: number; inAmount: BN; lpPool: LPPoolAccount; }) => Promise `

`({ outMarketIndex, lpToBurn, minAmountOut, lpPool, txParams, }: { outMarketIndex: number; lpToBurn: BN; minAmountOut: BN; lpPool: LPPoolAccount; txParams?: TxParams; }) => Promise `

`({ outMarketIndex, lpToBurn, minAmountOut, lpPool, }: { outMarketIndex: number; lpToBurn: BN; minAmountOut: BN; lpPool: LPPoolAccount; }) => Promise `

`({ outMarketIndex, lpToBurn, lpPool, txParams, }: { outMarketIndex: number; lpToBurn: BN; lpPool: LPPoolAccount; txParams?: TxParams; }) => Promise `

`({ outMarketIndex, lpToBurn, lpPool, }: { outMarketIndex: number; lpToBurn: BN; lpPool: LPPoolAccount; }) => Promise `

`({ inMarketIndex, inAmount, minMintAmount, lpPool, }: { inMarketIndex: number; inAmount: BN; minMintAmount: BN; lpPool: LPPoolAccount; }, constituentMap: ConstituentMap, includeUpdateConstituentOracleInfo?: boolean | undefined, view?: boolean | undefined) => Promise<...>`

`({ outMarketIndex, lpToBurn, minAmountOut, lpPool, }: { outMarketIndex: number; lpToBurn: BN; minAmountOut: BN; lpPool: LPPoolAccount; }, constituentMap: ConstituentMap, includeUpdateConstituentOracleInfo?: boolean | undefined, view?: boolean | undefined) => Promise<...>`

`(lpPool: LPPoolAccount, constituentMap: ConstituentMap, includeUpdateConstituentOracleInfo?: boolean | undefined) => Promise `

`(perpMarketIndexes: number[], lpPool: LPPoolAccount, constituentMap: ConstituentMap, includeUpdateConstituentOracleInfo?: boolean | undefined) => Promise<...>`

`(lpPool: LPPoolAccount, constituentMap: ConstituentMap, inMarketIndex: number, outMarketIndex: number, inAmount: BN, minOutAmount: BN, userAuthority: PublicKey) => Promise<...>`

`(lpPoolId: number, perpMarketIndexes: number[]) => Promise `

`(lpPoolId: number, perpMarketIndexes: number[]) => Promise `

`(lpPoolId: number, marketIndexes: number[]) => Promise `

`any`

Below here are the transaction sending functions

`any`

`any`

`(tx: VersionedTransaction | Transaction, additionalSigners?: Signer[] | undefined, opts?: ConfirmOptions | undefined, preSigned?: boolean | undefined) => Promise<...>`

Send a transaction.

`(instructions: TransactionInstruction | TransactionInstruction[], txParams?: TxParams | undefined, txVersion?: TransactionVersion | undefined, lookupTables?: AddressLookupTableAccount[] | undefined, forceVersionedTransaction?: boolean | undefined, recentBlockhash?: Readonly<...> | undefined, optionalIxs?: Transactio...`

`(instructions: (TransactionInstruction | TransactionInstruction[])[], txParams?: TxParams | undefined, txVersion?: TransactionVersion | undefined, lookupTables?: AddressLookupTableAccount[] | undefined, forceVersionedTransaction?: boolean | undefined) => Promise<...>`

`(instructionsMap: Record, txParams?: TxParams | undefined, txVersion?: TransactionVersion | undefined, lookupTables?: AddressLookupTableAccount[] | undefined, forceVersionedTransaction?: boolean | undefined) => Promise<...>`

`(instructionsMap: Record, txParams?: TxParams | undefined, txVersion?: TransactionVersion | undefined, lookupTables?: AddressLookupTableAccount[] | undefined, forceVersionedTransaction?: boolean | undefined) => Promise<...>`

`(orderParams: OptionalOrderParams, subAccountId: number) => boolean`

| Property | Type | Required |
| --- | --- | --- |
| `connection` | Yes |
| `wallet` | Yes |
| `program` | Yes |
| `provider` | Yes |
| `env` | Yes |
| `opts` | No |
| `useHotWalletAdmin` | No |
| `users` | Yes |
| `userStats` | No |
| `activeSubAccountId` | Yes |
| `userAccountSubscriptionConfig` | Yes |
| `userStatsAccountSubscriptionConfig` | Yes |
| `accountSubscriber` | Yes |
| `eventEmitter` | Yes |
| `metricsEventEmitter` | Yes |
| `_isSubscribed` | Yes |
| `txSender` | Yes |
| `perpMarketLastSlotCache` | Yes |
| `spotMarketLastSlotCache` | Yes |
| `mustIncludePerpMarketIndexes` | Yes |
| `mustIncludeSpotMarketIndexes` | Yes |
| `authority` | Yes |
| `marketLookupTable` | Yes |
| `lookupTableAccount` | Yes |
| `marketLookupTables` | Yes |
| `lookupTableAccounts` | Yes |
| `includeDelegates` | No |
| `authoritySubAccountMap` | No |
| `skipLoadUsers` | No |
| `txVersion` | Yes |
| `txParams` | Yes |
| `enableMetricsEvents` | No |
| `txHandler` | Yes |
| `receiverProgram` | No |
| `wormholeProgram` | No |
| `sbOnDemandProgramdId` | Yes |
| `sbOnDemandProgram` | No |
| `sbProgramFeedConfigs` | No |
| `isSubscribed` | Yes |
| `getPrePlaceOrderIxs` | Yes |
| `getUserMapKey` | Yes |
| `createUser` | Yes |
| `subscribe` | Yes |
| `subscribeUsers` | Yes |
| `fetchAccounts` | Yes |
| `unsubscribe` | Yes |
| `unsubscribeUsers` | Yes |
| `statePublicKey` | No |
| `getStatePublicKey` | Yes |
| `signerPublicKey` | No |
| `getSignerPublicKey` | Yes |
| `getStateAccount` | Yes |
| `forceGetStateAccount` | Yes |
| `getPerpMarketAccount` | Yes |
| `forceGetPerpMarketAccount` | Yes |
| `getPerpMarketAccounts` | Yes |
| `getSpotMarketAccount` | Yes |
| `forceGetSpotMarketAccount` | Yes |
| `getSpotMarketAccounts` | Yes |
| `getQuoteSpotMarketAccount` | Yes |
| `getOraclePriceDataAndSlot` | Yes |
| `getSerumV3FulfillmentConfig` | Yes |
| `getSerumV3FulfillmentConfigs` | Yes |
| `getPhoenixV1FulfillmentConfig` | Yes |
| `getPhoenixV1FulfillmentConfigs` | Yes |
| `getOpenbookV2FulfillmentConfig` | Yes |
| `getOpenbookV2FulfillmentConfigs` | Yes |
| `fetchMarketLookupTableAccount` | Yes |
| `fetchAllLookupTableAccounts` | Yes |
| `getTxVersionForNewWallet` | Yes |
| `updateWallet` | Yes |
| `emulateAccount` | Yes |
| `switchActiveUser` | Yes |
| `addUser` | Yes |
| `addAndSubscribeToUsers` | Yes |
| `getInitializeUserAccountIxs` | Yes |
| `initializeUserAccount` | Yes |
| `getInitializeUserStatsIx` | Yes |
| `initializeSignedMsgUserOrders` | Yes |
| `getInitializeSignedMsgUserOrdersAccountIx` | Yes |
| `resizeSignedMsgUserOrders` | Yes |
| `getResizeSignedMsgUserOrdersInstruction` | Yes |
| `initializeSignedMsgWsDelegatesAccount` | Yes |
| `getInitializeSignedMsgWsDelegatesAccountIx` | Yes |
| `initializeRevenueShare` | Yes |
| `getInitializeRevenueShareIx` | Yes |
| `initializeRevenueShareEscrow` | Yes |
| `getInitializeRevenueShareEscrowIx` | Yes |
| `migrateReferrer` | Yes |
| `getMigrateReferrerIx` | Yes |
| `resizeRevenueShareEscrowOrders` | Yes |
| `getResizeRevenueShareEscrowOrdersIx` | Yes |
| `changeApprovedBuilder` | Yes |
| `getChangeApprovedBuilderIx` | Yes |
| `addSignedMsgWsDelegate` | Yes |
| `getAddSignedMsgWsDelegateIx` | Yes |
| `removeSignedMsgWsDelegate` | Yes |
| `getRemoveSignedMsgWsDelegateIx` | Yes |
| `initializeFuelOverflow` | Yes |
| `getInitializeFuelOverflowIx` | Yes |
| `sweepFuel` | Yes |
| `getSweepFuelIx` | Yes |
| `getInitializeUserInstructions` | Yes |
| `getNextSubAccountId` | Yes |
| `initializeReferrerName` | Yes |
| `updateUserName` | Yes |
| `updateUserCustomMarginRatio` | Yes |
| `getUpdateUserCustomMarginRatioIx` | Yes |
| `getUpdateUserPerpPositionCustomMarginRatioIx` | Yes |
| `updateUserPerpPositionCustomMarginRatio` | Yes |
| `getUpdateUserMarginTradingEnabledIx` | Yes |
| `updateUserMarginTradingEnabled` | Yes |
| `getUpdateUserDelegateIx` | Yes |
| `updateUserDelegate` | Yes |
| `updateUserAdvancedLp` | Yes |
| `getUpdateAdvancedDlpIx` | Yes |
| `updateUserReduceOnly` | Yes |
| `getUpdateUserReduceOnlyIx` | Yes |
| `updateUserPoolId` | Yes |
| `getUpdateUserPoolIdIx` | Yes |
| `fetchAllUserAccounts` | Yes |
| `getUserAccountsForDelegate` | Yes |
| `getUserAccountsAndAddressesForAuthority` | Yes |
| `getUserAccountsForAuthority` | Yes |
| `getReferredUserStatsAccountsByReferrer` | Yes |
| `getReferrerNameAccountsForAuthority` | Yes |
| `deleteUser` | Yes |
| `getUserDeletionIx` | Yes |
| `forceDeleteUser` | Yes |
| `getForceDeleteUserIx` | Yes |
| `deleteSignedMsgUserOrders` | Yes |
| `getSignedMsgUserOrdersDeletionIx` | Yes |
| `isSignedMsgUserOrdersAccountInitialized` | Yes |
| `reclaimRent` | Yes |
| `getReclaimRentIx` | Yes |
| `getUser` | Yes |
| `hasUser` | Yes |
| `getUsers` | Yes |
| `getUserStats` | Yes |
| `fetchReferrerNameAccount` | Yes |
| `userStatsAccountPublicKey` | Yes |
| `getUserStatsAccountPublicKey` | Yes |
| `getUserAccountPublicKey` | Yes |
| `getUserAccount` | Yes |
| `forceGetUserAccount` | Yes |
| `getUserAccountAndSlot` | Yes |
| `getSpotPosition` | Yes |
| `getQuoteAssetTokenAmount` | Yes |
| `getIsolatedPerpPositionTokenAmount` | Yes |
| `getTokenAmount` | Yes |
| `convertToSpotPrecision` | Yes |
| `convertToPerpPrecision` | Yes |
| `convertToPricePrecision` | Yes |
| `mustIncludeMarketsInIx` | Yes |
| `getRemainingAccounts` | Yes |
| `addPerpMarketToRemainingAccountMaps` | Yes |
| `addSpotMarketToRemainingAccountMaps` | Yes |
| `addBuilderToRemainingAccounts` | Yes |
| `getRemainingAccountMapsForUsers` | Yes |
| `getOrder` | Yes |
| `getOrderByUserId` | Yes |
| `getAssociatedTokenAccount` | Yes |
| `createAssociatedTokenAccountIdempotentInstruction` | Yes |
| `getDepositTxnIx` | Yes |
| `buildSwiftDepositTx` | Yes |
| `createDepositTxn` | Yes |
| `deposit` | Yes |
| `getDepositInstruction` | Yes |
| `checkIfAccountExists` | Yes |
| `getWrappedSolAccountCreationIxs` | Yes |
| `getTokenProgramForSpotMarket` | Yes |
| `isToken2022` | Yes |
| `isTransferHook` | Yes |
| `addTokenMintToRemainingAccounts` | Yes |
| `addExtraAccountMetasToRemainingAccounts` | Yes |
| `getAssociatedTokenAccountCreationIx` | Yes |
| `createInitializeUserAccountAndDepositCollateralIxs` | Yes |
| `createInitializeUserAccountAndDepositCollateral` | Yes |
| `initializeUserAccountAndDepositCollateral` | Yes |
| `initializeUserAccountForDevnet` | Yes |
| `getWithdrawalIxs` | Yes |
| `withdraw` | Yes |
| `withdrawAllDustPositions` | Yes |
| `getWithdrawIx` | Yes |
| `transferDeposit` | Yes |
| `getTransferDepositIx` | Yes |
| `transferPools` | Yes |
| `getTransferPoolsIx` | Yes |
| `transferPerpPosition` | Yes |
| `getTransferPerpPositionIx` | Yes |
| `depositIntoIsolatedPerpPosition` | Yes |
| `getDepositIntoIsolatedPerpPositionIx` | Yes |
| `transferIsolatedPerpPositionDeposit` | Yes |
| `getTransferIsolatedPerpPositionDepositIx` | Yes |
| `withdrawFromIsolatedPerpPosition` | Yes |
| `getWithdrawFromIsolatedPerpPositionIxsBundle` | Yes |
| `getWithdrawFromIsolatedPerpPositionIx` | Yes |
| `updateSpotMarketCumulativeInterest` | Yes |
| `updateSpotMarketCumulativeInterestIx` | Yes |
| `settleLP` | Yes |
| `settleLPIx` | Yes |
| `removePerpLpShares` | Yes |
| `removePerpLpSharesInExpiringMarket` | Yes |
| `getRemovePerpLpSharesInExpiringMarket` | Yes |
| `getRemovePerpLpSharesIx` | Yes |
| `addPerpLpShares` | Yes |
| `getAddPerpLpSharesIx` | Yes |
| `getQuoteValuePerLpShare` | Yes |
| `openPosition` | Yes |
| `sendSignedTx` | Yes |
| `prepareMarketOrderTxs` | Yes |
| `sendMarketOrderAndGetSignedFillTx` | Yes |
| `placePerpOrder` | Yes |
| `getPlacePerpOrderIx` | Yes |
| `updateAMMs` | Yes |
| `getUpdateAMMsIx` | Yes |
| `settleExpiredMarket` | Yes |
| `getSettleExpiredMarketIx` | Yes |
| `settleExpiredMarketPoolsToRevenuePool` | Yes |
| `getSettleExpiredMarketPoolsToRevenuePoolIx` | Yes |
| `cancelOrder` | Yes |
| `getCancelOrderIx` | Yes |
| `cancelOrderByUserId` | Yes |
| `getCancelOrderByUserIdIx` | Yes |
| `cancelOrdersByIds` | Yes |
| `getCancelOrdersByIdsIx` | Yes |
| `cancelOrders` | Yes |
| `getCancelOrdersIx` | Yes |
| `cancelAndPlaceOrders` | Yes |
| `placeOrders` | Yes |
| `preparePlaceOrdersTx` | Yes |
| `getPlaceOrdersIx` | Yes |
| `getPlaceOrdersAndSetPositionMaxLevIx` | Yes |
| `fillPerpOrder` | Yes |
| `getFillPerpOrderIx` | Yes |
| `getRevertFillIx` | Yes |
| `placeSpotOrder` | Yes |
| `preparePlaceSpotOrderTx` | Yes |
| `getPlaceSpotOrderIx` | Yes |
| `fillSpotOrder` | Yes |
| `getFillSpotOrderIx` | Yes |
| `addSpotFulfillmentAccounts` | Yes |
| `addSerumRemainingAccounts` | Yes |
| `addPhoenixRemainingAccounts` | Yes |
| `addOpenbookRemainingAccounts` | Yes |
| `swap` | Yes |
| `getTitanSwapIx` | Yes |
| `getJupiterSwapIxV6` | Yes |
| `getSwapIx` | Yes |
| `getSwapIxV2` | Yes |
| `stakeForMSOL` | Yes |
| `getStakeForMSOLIx` | Yes |
| `triggerOrder` | Yes |
| `getTriggerOrderIx` | Yes |
| `forceCancelOrders` | Yes |
| `getForceCancelOrdersIx` | Yes |
| `updateUserIdle` | Yes |
| `getUpdateUserIdleIx` | Yes |
| `logUserBalances` | Yes |
| `getLogUserBalancesIx` | Yes |
| `updateUserFuelBonus` | Yes |
| `getUpdateUserFuelBonusIx` | Yes |
| `updateUserStatsReferrerStatus` | Yes |
| `getUpdateUserStatsReferrerStatusIx` | Yes |
| `updateUserOpenOrdersCount` | Yes |
| `getUpdateUserOpenOrdersCountIx` | Yes |
| `placeAndTakePerpOrder` | Yes |
| `preparePlaceAndTakePerpOrderWithAdditionalOrders` | Yes |
| `placeAndTakePerpWithAdditionalOrders` | Yes |
| `getPlaceAndTakePerpOrderIx` | Yes |
| `placeAndMakePerpOrder` | Yes |
| `getPlaceAndMakePerpOrderIx` | Yes |
| `signSignedMsgOrderParamsMessage` | Yes |
| `buildDepositAndPlaceSignedMsgOrderRequest` | Yes |
| `encodeSignedMsgOrderParamsMessage` | Yes |
| `decodeSignedMsgOrderParamsMessage` | Yes |
| `signMessage` | Yes |
| `placeSignedMsgTakerOrder` | Yes |
| `getPlaceSignedMsgTakerPerpOrderIxs` | Yes |
| `placeAndMakeSignedMsgPerpOrder` | Yes |
| `getPlaceAndMakeSignedMsgPerpOrderIxs` | Yes |
| `preparePlaceAndTakeSpotOrder` | Yes |
| `placeAndTakeSpotOrder` | Yes |
| `getPlaceAndTakeSpotOrderIx` | Yes |
| `placeAndMakeSpotOrder` | Yes |
| `getPlaceAndMakeSpotOrderIx` | Yes |
| `closePosition` | Yes |
| `modifyPerpOrder` | Yes |
| `modifyPerpOrderByUserOrderId` | Yes |
| `modifyOrder` | Yes |
| `getModifyOrderIx` | Yes |
| `modifyOrderByUserOrderId` | Yes |
| `getModifyOrderByUserIdIx` | Yes |
| `settlePNLs` | Yes |
| `getSettlePNLsIxs` | Yes |
| `settlePNL` | Yes |
| `settlePNLIx` | Yes |
| `settleMultiplePNLs` | Yes |
| `settleMultiplePNLsMultipleTxs` | Yes |
| `settleMultiplePNLsIx` | Yes |
| `getSetUserStatusToBeingLiquidatedIx` | Yes |
| `setUserStatusToBeingLiquidated` | Yes |
| `liquidatePerp` | Yes |
| `getLiquidatePerpIx` | Yes |
| `liquidatePerpWithFill` | Yes |
| `getLiquidatePerpWithFillIx` | Yes |
| `liquidateSpot` | Yes |
| `getLiquidateSpotIx` | Yes |
| `getJupiterLiquidateSpotWithSwapIxV6` | Yes |
| `getLiquidateSpotWithSwapIx` | Yes |
| `getInsuranceFundSwapIx` | Yes |
| `liquidateBorrowForPerpPnl` | Yes |
| `getLiquidateBorrowForPerpPnlIx` | Yes |
| `liquidatePerpPnlForDeposit` | Yes |
| `getLiquidatePerpPnlForDepositIx` | Yes |
| `resolvePerpBankruptcy` | Yes |
| `getResolvePerpBankruptcyIx` | Yes |
| `resolveSpotBankruptcy` | Yes |
| `getResolveSpotBankruptcyIx` | Yes |
| `updateFundingRate` | Yes |
| `getUpdateFundingRateIx` | Yes |
| `updatePrelaunchOracle` | Yes |
| `getUpdatePrelaunchOracleIx` | Yes |
| `updatePerpBidAskTwap` | Yes |
| `getUpdatePerpBidAskTwapIx` | Yes |
| `settleFundingPayment` | Yes |
| `getSettleFundingPaymentIx` | Yes |
| `triggerEvent` | Yes |
| `getOracleDataForPerpMarket` | Yes |
| `getMMOracleDataForPerpMarket` | Yes |
| `getOracleDataForSpotMarket` | Yes |
| `initializeInsuranceFundStake` | Yes |
| `getInitializeInsuranceFundStakeIx` | Yes |
| `getAddInsuranceFundStakeIx` | Yes |
| `addInsuranceFundStake` | Yes |
| `getAddInsuranceFundStakeIxs` | Yes |
| `requestRemoveInsuranceFundStake` | Yes |
| `cancelRequestRemoveInsuranceFundStake` | Yes |
| `removeInsuranceFundStake` | Yes |
| `updateUserQuoteAssetInsuranceStake` | Yes |
| `getUpdateUserQuoteAssetInsuranceStakeIx` | Yes |
| `updateUserGovTokenInsuranceStake` | Yes |
| `getUpdateUserGovTokenInsuranceStakeIx` | Yes |
| `settleRevenueToInsuranceFund` | Yes |
| `getSettleRevenueToInsuranceFundIx` | Yes |
| `resolvePerpPnlDeficit` | Yes |
| `getResolvePerpPnlDeficitIx` | Yes |
| `getDepositIntoSpotMarketRevenuePoolIx` | Yes |
| `depositIntoSpotMarketRevenuePool` | Yes |
| `getPerpMarketExtendedInfo` | Yes |
| `getMarketFees` | Yes |
| `getMarketIndexAndType` | Yes |
| `getReceiverProgram` | Yes |
| `getSwitchboardOnDemandProgram` | Yes |
| `postPythPullOracleUpdateAtomic` | Yes |
| `postMultiPythPullOracleUpdatesAtomic` | Yes |
| `getPostPythPullOracleUpdateAtomicIxs` | Yes |
| `getSinglePostPythPullOracleAtomicIx` | Yes |
| `updatePythPullOracle` | Yes |
| `getUpdatePythPullOracleIxs` | Yes |
| `postPythLazerOracleUpdate` | Yes |
| `getPostPythLazerOracleUpdateIxs` | Yes |
| `getPostManySwitchboardOnDemandUpdatesAtomicIxs` | Yes |
| `getPostSwitchboardOnDemandUpdateAtomicIx` | Yes |
| `postSwitchboardOnDemandUpdate` | Yes |
| `getBuildEncodedVaaIxs` | Yes |
| `enableUserHighLeverageMode` | Yes |
| `getEnableHighLeverageModeIx` | Yes |
| `disableUserHighLeverageMode` | Yes |
| `getDisableHighLeverageModeIx` | Yes |
| `fetchHighLeverageModeConfig` | Yes |
| `fetchProtectedMakerModeConfig` | Yes |
| `updateUserProtectedMakerOrders` | Yes |
| `getUpdateUserProtectedMakerOrdersIx` | Yes |
| `getPauseSpotMarketDepositWithdrawIx` | Yes |
| `pauseSpotMarketDepositWithdraw` | Yes |
| `updateMmOracleNative` | Yes |
| `getUpdateMmOracleNativeIx` | Yes |
| `updateAmmSpreadAdjustmentNative` | Yes |
| `getUpdateAmmSpreadAdjustmentNativeIx` | Yes |
| `getLpPoolAccount` | Yes |
| `getConstituentTargetBaseAccount` | Yes |
| `getAmmCache` | Yes |
| `updateLpConstituentTargetBase` | Yes |
| `getUpdateLpConstituentTargetBaseIx` | Yes |
| `updateLpPoolAum` | Yes |
| `getUpdateLpPoolAumIxs` | Yes |
| `updateAmmCache` | Yes |
| `getUpdateAmmCacheIx` | Yes |
| `updateConstituentOracleInfo` | Yes |
| `getUpdateConstituentOracleInfoIx` | Yes |
| `lpPoolSwap` | Yes |
| `getLpPoolSwapIx` | Yes |
| `viewLpPoolSwapFees` | Yes |
| `getViewLpPoolSwapFeesIx` | Yes |
| `getCreateLpPoolTokenAccountIx` | Yes |
| `createLpPoolTokenAccount` | Yes |
| `lpPoolAddLiquidity` | Yes |
| `getLpPoolAddLiquidityIx` | Yes |
| `viewLpPoolAddLiquidityFees` | Yes |
| `getViewLpPoolAddLiquidityFeesIx` | Yes |
| `lpPoolRemoveLiquidity` | Yes |
| `getLpPoolRemoveLiquidityIx` | Yes |
| `viewLpPoolRemoveLiquidityFees` | Yes |
| `getViewLpPoolRemoveLiquidityFeesIx` | Yes |
| `getAllLpPoolAddLiquidityIxs` | Yes |
| `getAllLpPoolRemoveLiquidityIxs` | Yes |
| `getAllUpdateLpPoolAumIxs` | Yes |
| `getAllUpdateConstituentTargetBaseIxs` | Yes |
| `getAllLpPoolSwapIxs` | Yes |
| `settlePerpToLpPool` | Yes |
| `getSettlePerpToLpPoolIx` | Yes |
| `getAllSettlePerpToLpPoolIxs` | Yes |
| `handleSignedTransaction` | Yes |
| `handlePreSignedTransaction` | Yes |
| `isVersionedTransaction` | Yes |
| `sendTransaction` | Yes |
| `buildTransaction` | Yes |
| `buildBulkTransactions` | Yes |
| `buildTransactionsMap` | Yes |
| `buildAndSignTransactionsMap` | Yes |
| `isOrderIncreasingPosition` | Yes |

## Step 2: Get oracle price

Read the current oracle price to calculate your bid/ask spread.

TypeScript

```
import { PRICE_PRECISION, convertToNumber } from "@drift-labs/sdk";
 
const marketIndex = 0; // SOL-PERP
const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);
const oraclePrice = convertToNumber(oracle.price, PRICE_PRECISION);
 
console.log(`Oracle price: $${oraclePrice}`);
```

`Method DriftClient.getOracleDataForPerpMarket` Reference ↗

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketIndex` | Yes |

| Returns |
| --- |
| `OraclePriceData` |

## Step 3: Place two-sided quotes

Place a bid (buy) below oracle and an ask (sell) above oracle. Using`PostOnlyParams.MUST_POST_ONLY` ensures your orders never cross and you always earn maker rebates.

TypeScript

```
import {
  PRICE_PRECISION,
  convertToNumber,
  MarketType,
  OrderType,
  PositionDirection,
  PostOnlyParams
} from "@drift-labs/sdk";
 
const marketIndex = 0; // SOL-PERP
const spread = 0.5; // $0.50 spread on each side
const size = 0.1; // 0.1 SOL per order
 
// Fetch oracle price for spread calculation
const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);
const oraclePrice = convertToNumber(oracle.price, PRICE_PRECISION);
 
const bidPrice = oraclePrice - spread;
const askPrice = oraclePrice + spread;
 
await driftClient.placeOrders([
  {
    orderType: OrderType.LIMIT,
    marketType: MarketType.PERP,
    marketIndex,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(size),
    price: driftClient.convertToPricePrecision(bidPrice),
    postOnly: PostOnlyParams.MUST_POST_ONLY,
  },
  {
    orderType: OrderType.LIMIT,
    marketType: MarketType.PERP,
    marketIndex,
    direction: PositionDirection.SHORT,
    baseAssetAmount: driftClient.convertToPerpPrecision(size),
    price: driftClient.convertToPricePrecision(askPrice),
    postOnly: PostOnlyParams.MUST_POST_ONLY,
  },
]);
 
console.log(`Placed bid @ $${bidPrice}, ask @ $${askPrice}`);
```

`Method DriftClient.placeOrders` Reference ↗

`OrderParams[]`

`TxParams`

`number`

`TransactionInstruction[]`

`any`

| Parameter | Type | Required |
| --- | --- | --- |
| `params` | Yes |
| `txParams` | No |
| `subAccountId` | No |
| `optionalIxs` | No |
| `isolatedPositionDepositAmount` | No |

| Returns |
| --- |
| `Promise ` |

## Step 4: Monitor and update

Check for fills and cancel/replace orders when the oracle moves. This complete example runs a loop that refreshes quotes every 10 seconds.

TypeScript

```
import {
  PRICE_PRECISION,
  BASE_PRECISION,
  convertToNumber,
  MarketType,
  OrderType,
  PositionDirection,
  PostOnlyParams,
} from "@drift-labs/sdk";
 
const marketIndex = 0;
const spread = 0.5;
const size = 0.1;
 
setInterval(async () => {
  try {
    // Check current position
    const user = driftClient.getUser();
    const position = user.getPerpPosition(marketIndex);
    if (position) {
      const posSize = convertToNumber(position.baseAssetAmount, BASE_PRECISION);
      console.log(`Current position: ${posSize} SOL`);
    }
 
    // Cancel all existing orders for this market
    await driftClient.cancelOrders(MarketType.PERP, marketIndex);
 
    // Re-fetch oracle price
    const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);
    const oraclePrice = convertToNumber(oracle.price, PRICE_PRECISION);
 
    const bidPrice = oraclePrice - spread;
    const askPrice = oraclePrice + spread;
 
    // Place fresh two-sided quotes
    await driftClient.placeOrders([
      {
        orderType: OrderType.LIMIT,
        marketType: MarketType.PERP,
        marketIndex,
        direction: PositionDirection.LONG,
        baseAssetAmount: driftClient.convertToPerpPrecision(size),
        price: driftClient.convertToPricePrecision(bidPrice),
        postOnly: PostOnlyParams.MUST_POST_ONLY,
      },
      {
        orderType: OrderType.LIMIT,
        marketType: MarketType.PERP,
        marketIndex,
        direction: PositionDirection.SHORT,
        baseAssetAmount: driftClient.convertToPerpPrecision(size),
        price: driftClient.convertToPricePrecision(askPrice),
        postOnly: PostOnlyParams.MUST_POST_ONLY,
      },
    ]);
 
    console.log(`Updated quotes: bid $${bidPrice.toFixed(2)} / ask $${askPrice.toFixed(2)}`);
  } catch (err) {
    console.error("Error updating quotes:", err);
  }
}, 10_000); // Update every 10 seconds
```

`Method DriftClient.cancelOrders` Reference ↗

`MarketType`

`number`

`PositionDirection`

`TxParams`

`number`

| Parameter | Type | Required |
| --- | --- | --- |
| `marketType` | No |
| `marketIndex` | No |
| `direction` | No |
| `txParams` | No |
| `subAccountId` | No |

| Returns |
| --- |
| `Promise ` |

Tip: This cancel-and-replace approach sends ~2 transactions every 10 seconds. For production, consider oracle offset orders which float with the oracle automatically and require only ~30 txs/day.

## Next steps

This basic example gets you started, but production market makers need:

- Oracle offset orders: orders that automatically track oracle price, drastically reducing transactions (DLOB MM)
- Inventory management: adjust spread based on position size (DLOB MM)
- Risk controls: position limits, health checks, emergency cancel (Bot Architecture)
- JIT participation: compete in auctions for better fills (JIT-only MM)
- Efficient subscriptions: WebSocket or gRPC for lower latency (Bot Architecture)
- Multiple markets: quote across markets simultaneously

## Common pitfalls

- Forgetting`PostOnlyParams`: without it, your “maker” orders can cross the spread and execute as taker, paying fees instead of earning rebates
- Using`PRICE_PRECISION` wrong: oracle prices are in`PRICE_PRECISION`(1e6), base amounts in`BASE_PRECISION`(1e9). Mixing them up causes orders at wildly wrong prices
- Not initializing user account: first-time users must call`driftClient.initializeUserAccount()` before placing orders. The SDK will throw`User account not found` otherwise
- 32-order limit: each Drift subaccount supports a maximum of 32 open orders. Cancel stale orders or use multiple subaccounts for multi-market strategies

For production patterns and best practices, see:

- DLOB MM- comprehensive quoting strategies including oracle offset orders
- Bot Architecture- subscription loops, throttling, priority fees
- keeper-bots-v2 FloatingPerpMaker- production reference for oracle offset quoting

Last updated on February 27, 2026

Market Makers DLOB MM
