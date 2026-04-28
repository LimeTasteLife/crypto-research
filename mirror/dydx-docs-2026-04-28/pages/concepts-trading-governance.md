# Governance Functionalities

Source: https://docs.dydx.xyz/concepts/trading/governance

Below is a current list of all module parameters that `x/gov` has the ability to update directly.

## Trading Stats & Fees

### Stats Module

The Stats Module tracks user maker and taker volumes over a period of time (aka look-back window). This is currently set to 30 days. The maker and taker volume info is used to place users in corresponding fee-tiers. Governance has the ability to update the params of the Stats Module, which defines the look-back window (measured in seconds).

### FeeTiers Module

Governance has the ability to update fee tiers.

## Trading Core

### Insurance Fund

Governance has the ability to send funds from the Protocol's Insurance Fund. Funds can be sent to individual accounts, or other modules. Note: any account has the ability to send assets to the Insurance Fund.

### Liquidations Config

Governance has the ability to adjust how liquidations are processed:

- Max Insurance Fund quantums for deleveraging: The maximum number of quote quantums (exclusive) that the insurance fund can have for deleverages to be enabled.
- The maximum liquidation fee, in parts-per-million. 100% of this fee goes to the Insurance Fund.
- The maximum amount of how much a single position can be liquidated within one block.
- The maximum amount of how much a single subaccount can be liquidated within a single block.
- Fillable price config: configuration regarding how the fillable-price spread from the oracle price increases based on the adjusted bankruptcy rating of the subaccount.

### Funding Rate

Governance has the ability to adjust Funding Rate parameters:

- Funding rate clamp factor, premium vote clamp factor, and min number of votes per premium sample.
- Epoch information, which defines the funding interval and premium sampling interval.
- Liquidity Tier, which defines the impact notional value.

## Trading Rewards

### Vest Module

The Vest Module is responsible for determining the rate of tokens that vest from Vester Accounts to other accounts such as a Community Treasury Account and a Rewards Treasury Account. Governance has the ability to create, update, or delete a `VestEntry`.

### Rewards Module

The Rewards Module distributes trading rewards to traders. Governance has the ability to adjust:

- Which account Trading Rewards are funded from
- The token Trading Rewards are funded in
- The market which tracks the oracle price of the token that Trading Rewards are funded in
- `C` which is a protocol constant

## Markets

### Oracles

Governance has the ability to adjust the list of oracles used for each market. Note that this functionality does not include creating / removing an exchange-source supported by the protocol as a whole, which will require a binary upgrade.

### Liquidity Tiers

Liquidity Tiers group markets of similar risk into standardized risk parameters. Liquidity tiers specify the margin requirements needed for each market and should be determined based on the depth of the relative market's spot book as well as the token's market capitalization.

Current Liquidity Tiers include:

| ID | Name | initial margin fraction | maintenance fraction (what fraction MMF is of IMF) | impact notional | maintenance margin fraction (as is) | impact notional (as is) | Lower Cap (USDC Millions) | Upper Cap (USDC Millions) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | Large-Cap | 0.02 | 0.6 | 500 USDC / IM | 0.012 | 25_000 USDC | None | None |
| 1 | Small-Cap | 0.1 | 0.5 | 500 USDC / IM | 0.05 | 5_000 USDC | 20 | 50 |
| 2 | Long-Tail | 0.2 | 0.5 | 500 USDC / IM | 0.1 | 2_500 USDC | 5 | 10 |
| 3 | Safety | 1 | 0.2 | 2500 USDC / IM | 0.2 | 2_500 USDC | 2 | 5 |
| 4 | Isolated | 0.05 | 0.6 | 125 USDC / IM | 0.03 | 2_500 USDC | 0.5 | 1 |
| 5 | Mid-Cap | 0.05 | 0.6 | 250 USDC / IM | 0.03 | 5_000 USDC | 40 | 100 |
| 6 | FX | 0.01 | 0.5 | 25 USDC / IM | 0.0005 | 2_500 USDC | 0.5 | 1 |
| 7 | IML 5x | 0.2 | 0.5 | 25 USDC / IM | 0.1 | 125 USDC | 0.5 | 1 |

Define:
- `Open Notional = Open Interest * Oracle Price`
- `Scaling Factor = (Open Notional - Lower Cap) / (Upper Cap - Lower Cap)`
- `IMF Increase = Scaling Factor * (1 - Base IMF)`

Governance has the ability to create and modify Liquidity Tiers as well as update existing markets' Liquidity Tier placements.

### Updating a Live Market

This functionality allows the community to update parameters of a live market:

- The effective IMF is the base IMF while the Open Notional < Lower Cap, and increases linearly until Open Notional = Upper Cap, at which point the IMF stays at 1.0 (requiring 1:1 collateral for trading)
- Updating a liquidity tier
- Perpetual (`x/perpetuals`), governance-updatable through `MsgUpdatePerpetualFeeParams`
- Market (`x/prices`), governance-updatable through `MsgUpdateMarketParam`
- Clob pair (`x/clob`), governance-updatable through `MsgUpdateClobPair`

### Adding New Markets

A proposal to add a new market should include the following messages (in this particular order):

```
MsgCreateOracle (create objects in x/prices)
MsgCreatePerpetual (create object in x/perpetual)
MsgCreatePerpetualClobPair (create object in x/clob)
MsgDelayMessage (schedule a MsgSetClobPairStatus to enable trading in x/clob)
```

## Safety

### Spam Mitigation

To prevent spam on the orderbook and prevent the blockchain state from getting too large, governance has the ability to adjust:

- How many open orders a subaccount can have based on its equity tier.
- Order placement rate limits.

## Bridge

### Bridge Module

The Bridge Module is responsible for receiving bridged tokens from the Ethereum blockchain. Governance can update Event Parameters, Proposal Parameters, and Safety Parameters (including bridging enable/disable).

## Community Assets

### Community Pool & Treasury

There are two addresses intended for managing funds owned by the community:

1. a Community Pool — recipient of any Community Tax that is implemented via the Distribution Module. The Community Pool is controllable by governance.
2. a Community Treasury — an account controlled by governance and can be funded via any account or module sending tokens to it.
