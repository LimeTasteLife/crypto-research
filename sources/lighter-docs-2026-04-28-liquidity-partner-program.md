---
type: source
id: lighter-docs-2026-04-28-liquidity-partner-program
title: Liquidity Partner Program
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/liquidity-partner-program
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/liquidity-partner-program.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidity Partner Program

## TL;DR
Lighter pays a weekly reward pool to market makers providing tight, deep resting liquidity, evaluated via randomized order-book snapshots roughly every minute. Eligibility requires a Premium account; only resting orders count. Assets are tiered by liquidity profile (highly liquid → tightest spread but largest eligible book; less liquid → wider spreads but smaller sizes), with cumulative spread levels per tier. Half of rewards go to bids, half to asks; oldest order at a price wins ties. Unfilled liquidity does not roll over. The team publishes weekly tiers, weights, and pool size by 17:00 UTC every Monday in a public Google Sheet. Page also notes RWA Premium fees resume 2026-04-15 14:30 UTC.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Liquidity Partner Program distributes rewards to market makers providing tight, deep liquidity on Lighter order books. | [[entities/programme/lighter-liquidity-partner-program]], [[entities/perpdex/lighter]] | A4-PI |
| #c2 | Rewards are allocated through randomized snapshots of the order book. | [[entities/programme/lighter-liquidity-partner-program]] | A4-PI |
| #c3 | The weekly reward distribution amount is announced in advance. | [[entities/programme/lighter-liquidity-partner-program]] | A3-PV |
| #c4 | Eligibility requires maintaining an active Premium account. | [[entities/programme/lighter-liquidity-partner-program]] | A4-PV |
| #c5 | Only resting orders present on the order book at the time of each snapshot are eligible. | [[entities/programme/lighter-liquidity-partner-program]] | A4-PI |
| #c6 | A single global reward pool is shared across all eligible assets, with each asset assigned a weight that determines its share. | [[parameters/lighter/lp-program-tiers]] | A4-PIV |
| #c7 | Assets are categorized into tiers based on liquidity profile: highly liquid/strategic assets get tightest spread requirements but largest eligible book sizes; less liquid assets get wider allowed spreads but smaller eligible sizes. | [[parameters/lighter/lp-program-tiers]] | A4-PI |
| #c8 | Spread requirements widen during low-activity periods to reflect liquidity conditions. | [[parameters/lighter/lp-program-tiers]] | A4-PI |
| #c9 | Each asset tier and time period defines three cumulative spread levels representing maximum eligible liquidity within that spread distance from BBO. | [[parameters/lighter/lp-program-tiers]] | A4-PI |
| #c10 | Spread levels are cumulative — e.g. $300,000 eligible at ≤15 bps includes the first $150,000 within 15 bps of BBO on each side. | [[parameters/lighter/lp-program-tiers]] | A4-PI |
| #c11 | At each snapshot the order book is walked from the inside out, starting at best bid/ask, accumulating eligible liquidity per side up to the size cap for the tightest qualifying spread level. | [[entities/programme/lighter-liquidity-partner-program]] | A4-PI |
| #c12 | Tie-breaking at the same price level uses earliest-timestamp priority (oldest order wins). | [[entities/programme/lighter-liquidity-partner-program]] | A4-PI |
| #c13 | Half of the rewards are allocated to resting bids and half to resting asks (50/50 symmetry). | [[entities/programme/lighter-liquidity-partner-program]] | A4-PI |
| #c14 | Order book snapshots are taken at randomized intervals, approximately every minute. | [[entities/programme/lighter-liquidity-partner-program]] | A4-PI |
| #c15 | If an asset's order book has less eligible liquidity than its allocation, the unallocated portion is not redistributed. | [[entities/programme/lighter-liquidity-partner-program]] | A4-PIV |
| #c16 | Each Monday by 17:00 UTC, Lighter publishes updated asset tiers, reward weights, and total incentives pool in a public Google spreadsheet. | [[parameters/lighter/lp-program-tiers]] | A3-PV, A7-PI |
| #c17 | Weekly updates are set by the Lighter team (discretionary). | [[parameters/lighter/lp-program-tiers]] | A7-PI |
| #c18 | Premium-account fees on RWA markets are scheduled to resume 2026-04-15 at 14:30 UTC. | [[parameters/lighter/fee-schedule]] | A2-PII |

## Conflicts raised
