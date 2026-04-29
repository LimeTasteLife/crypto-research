# Community Treasury

Source: https://docs.dydx.community/dydx/modules/community-treasury

## Overview

The Community Treasury is a community-controlled module account on dYdX Chain. DYDX will vest to the Community Treasury on a continuous basis until August 3, 2026. Any dYdX community member satisfying the `min_initial_deposit_ratio` can submit a Community Spending proposal to spend DYDX in the Community Treasury.

The Community Treasury was created with the following objectives:

- Develop a best-in-class governance system and incentivize robust governance.
- Develop grant programs to fund community hackathons, analytics dashboards, swag, third-party tools, translations, and other projects.
- Fund programs and initiatives that drive the growth of dYdX.

## Module Accounts

| Name | Address |
| --- | --- |
| `community_treasury` | dydx15ztc7xy42tn2ukkc0qjthkucw9ac63pgp70urn |
| `community_vester` | dydx1wxje320an3karyc6mjw4zghs300dmrjkwn7xtk |

## Community Treasury

Currently, 26.1% of the total token supply of DYDX, which amounts to `261,133,225 $DYDX`, is allocated to the Community Treasury. This allocation is designed to sustainably support contributor grants, community initiatives, liquidity mining, and other assorted programs.

Initially, `5.0%` of the token supply (`50,000,000 $DYDX`) was allocated to the Community Treasury, and 766,703 `$DYDX` vests in the community treasury each epoch. Currently, 3,787,251 `$DYDX` vest in the community treasury because several governance proposals resulted in a 3,020,548 `$DYDX` increase in the amount of `$DYDX` available to the dYdX community each epoch:

- DIP 29 — reduce Liquidity Provider Rewards by 1/3 from Epoch 30-32; remaining allocation of Trading Rewards migrated to dYdX Chain.
- DIP 24 — reduce Liquidity Provider Rewards by 50% (575,342 `$DYDX` per epoch).
- DIP 20 — further reduce trading rewards by 45% (1,294,520 `$DYDX` per epoch).
- DIP 17 — set the rewards for staking $DYDX to 0 (383,562 `$DYDX` per epoch).
- DIP 16 — reduce trading rewards by 25% (958,904 `$DYDX` per epoch).
- DIP 14 — set the rewards for staking USDC to 0 (383,562 `$DYDX` per epoch).

In DIP 29 on dYdX v3, the dYdX community also voted to migrate 40,703,630 vested $DYDX from the Rewards Treasury and 39,788,640 vested $DYDX from the Community Treasury to the dYdX Chain Community Treasury. In addition to the 80,492,270 DYDX from the dYdX v3 Rewards Treasury and Community Treasury, DYDX vests every second from the community_vester to the community_treasury.

## Community Vester

In DIP 2 on the dYdX Chain, the dYdX community voted to credit the dYdX Community Vester with 172,762,268.210688518 unvested DYDX tokens based on the balance of the dYdX v3 Community Treasury Vester and the dYdX v3 Rewards Treasury Vester, less the DYDX that was sent to the dYdX Chain Rewards Vester for Trading Rewards.

## FAQ

Any dYdX community member with enough unstaked DYDX tokens to satisfy the `min_initial_deposit_ratio` may submit a Community Spending proposal on dYdX Chain. A governance vote will be required to spend any DYDX from the Community Treasury.

Based on the `start_time` and `end_time`, DYDX will vest from the Community Vester to the Community Treasury at approximately ~2.04 DYDX per second.
