# Liquidity Partner Program | Lighter Docs

URL: https://docs.lighter.xyz/liquidity-partner-program

# Liquidity Partner Program

Note: Fees for Premium accounts on RWAs will resume on Wednesday April 15 at 2:30PM UTC.

This program will distribute rewards to market makers who provide tight, deep liquidity on the Lighter order books. Rewards are allocated through randomized snapshots of the order book. The amount of rewards to be distributed each week will be announced in advance.

#### Eligibility

- Participants must maintain an active Premium account.
- Only resting orders present on the order book at the time of each snapshot are eligible.

### How it Works

There is a single global reward pool shared across all eligible assets. Each asset is assigned a weight that determines its share of the pool.

Asset Tiers are visible in the spreadsheet shared below (Weekly Cadence).

Assets are categorized into tiers based on their liquidity profile. Highly liquid or strategic assets have the tightest spread requirements but the largest eligible book sizes. Less liquid assets have wider allowed spreads but the smallest eligible sizes.

Spread requirements widen during low-activity periods to reflect liquidity conditions.

Within each tier, assets may be assigned different weights to control their relative share of the reward pool.

#### Spread Levels

Each asset tier and time period defines three cumulative spread levels. These represent the maximum eligible liquidity within that spread distance from the NBBO/BBO.

These are cumulative — if the total eligible size is $300,000 at ≤15 bps, that includes the first $150,000 within 15 bps of BBO on each side. The book is walked outward, so the tightest liquidity fills first.

#### Snapshots

Order book snapshots are taken at randomized intervals, approximately every minute. At each snapshot, we evaluate every eligible asset's order book to determine reward allocation.

For each asset at each snapshot, the order book is walked from the inside out (starting at the best bid and best ask):

1. Orders are evaluated by price level, starting closest to the BBO (best bid/offer).
2. Eligible liquidity is accumulated on each side (bids and asks separately) up to the applicable size cap for the tightest qualifying spread level.
3. Tie-breaking: When multiple orders rest at the same price, the oldest order (earliest timestamp) receives priority.
4. Symmetry: Half of rewards will be allocated to resting bids, and half to resting asks.

#### Unused Rewards

If an asset's order book has less eligible liquidity at the time of a snapshot, the unallocated portion of that asset's reward share will not be distributed or reallocated.

An example:

- $50k of liquidity within 5 bps is eligible for rewards
- only $25k of liquidity is within 5 bps at the time of a snapshot
- only 50% of the maximum reward for this asset & snapshot will be distributed.

#### Weekly Cadence

Each week, by 17:00 UTC on Monday, Lighter will publish updated asset tiers, reward weights, and the total incentives pool in the spreadsheet below. A new sheet (within the spreadsheet) will be added each week to enable program partners to track changes over time. Updates are set by the team.

https://docs.google.com/spreadsheets/d/1JMZMEtdVU6_BAGGrEucHPBxDprbXdbWFq9MkJ-5Jqko/edit?gid=376627164#gid=376627164
