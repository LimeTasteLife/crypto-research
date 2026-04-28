# Funding Rate Rebates | Lighter Docs

URL: https://docs.lighter.xyz/trading/funding/funding-rate-rebates

# Funding Rate Rebates

The Funding Rate Rebates program enables traders to receive up to a 15% rebate on funding payments incurred on positions paying funding. This program applies to all markets listed on Lighter. The position receiving funding remains unaffected by this program.

### How it works

Funding Fee Rebates are based on two components: having a Premium Account and staking. Premium Account traders automatically receive a 6% discount per hourly funding. A trader can earn an additional 9% discount through staking, for a total discount of 15%. The staking bonus scales with the amount of LIT staked and is capped at 9% when staking 50,000 LIT.

While funding rates remain market-driven, the rebate benefit a trader receives will not exceed the rebate benefit given in case the funding rate would be equal to the interest rate component.

Examples:

Assume the following:

- BTC position value: $1,000
- Discount percentage: 15%
- Interest rate component: 0.01%

The funding amount eligible for rebate is calculated as:

> min(Funding Rate, Interest Rate Component) × Position Value

The rebate is then:

> Eligible Funding × Discount Percentage

Rewards scale based on the amount of LIT staked. The scaling is controlled by an exponent parameter, currently set to 1, meaning rewards increase linearly up to the 50,000 LIT cap. This parameter may be adjusted in the future to refine the reward curve.

#### Sub Accounts and Staked LIT

Effective staked LIT is calculated on a consolidated basis. Staking across the main account and all associated sub-accounts is aggregated, and funding rate rebates are applied accordingly, subject to the 10% annualized cap.

#### Rebates Distribution

Rebates are distributed daily at 00:00 UTC as an L2 transfer to the trader's account from the Lighter Rebates Fund (`0xc4535ceeA637b3B1bcdf5932603A4DbC00Ad2772`). The Funding History section displays all paid and pending rebates. A payment will be processed only if the amount exceeds $1.
