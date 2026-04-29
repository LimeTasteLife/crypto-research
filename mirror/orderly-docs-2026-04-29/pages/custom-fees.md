# Custom Fee Structure

The Custom Trading Fee System allows builders to tailor fee structures for their users beyond Orderly's standard fees.

## Overview

| | Base Fee | Custom Fee |
|---|---|---|
| Who receives | Orderly (100%) | Builder (100%) |
| Taker | 3 bps | Set by builder |
| Maker | 0 bps | Set by builder |

The base fee is subject to change according to the builder staking programme.

## Fee rate rules

- Fee rate is total charged to user (Orderly base fee + custom fee).
- Cannot be less than the Orderly base fee.
- All users assigned default fee rate unless overridden by builder.

## Builder Rebate Distribution

Builders receive daily rebates in their fee wallet, calculated after deducting any referral rebates.
