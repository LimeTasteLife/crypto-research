# Staking Information

Staking $ORDER earns you VALOR, which represents your share of the Orderly protocol treasury. Rather than paying stakers with inflationary token emissions, Orderly distributes real yield funded by 30% of protocol net revenue (primarily trading fees).

## How VALOR works

Key parameters:
- Hard cap: 1 billion VALOR
- Emission: 100% linearly emitted to stakers over 200 epochs (5M VALOR per epoch)
- Non-transferable: VALOR is a measure of staking position, not a tradable token
- Deflationary: VALOR is permanently burned when redeemed for treasury assets

Treasury share formula:

```
TreasuryShare_staker = (AvailableValorBalance_staker / ValorCirculatingSupply) * TotalProtocolTreasuryValue
```

VALOR circulating supply = Total VALOR emitted to date - VALOR burned from redemption.

## New system (effective 4 November 2025)

- Treasury pool receives 30% of Orderly's net fees daily, settled via ORDER buyback at end of each epoch.
- ~4.13 VALOR distributed every second, proportional to staked share.
- VALOR can be redeemed for esORDER.
- esORDER claimed after 7-day waiting period, auto-staked.

## Staking mechanics

- 7-day unstaking period. During unstaking, no VALOR accrual.
- One active unstaking request at a time. New request merges and resets timer.
- Can cancel unstaking, which restakes the full amount.
- Omnichain: stake on one chain, claim on another.

## APR calculation

Trailing 7-day average daily returns, annualized.
Daily returns = 30% of protocol daily net revenue / USD equivalent of total staked $ORDER and esORDER.

Staking not allowed for locked team or investor tokens.
