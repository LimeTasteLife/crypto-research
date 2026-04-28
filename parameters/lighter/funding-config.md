---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: funding-config
unit: percent / hours
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter funding config

## Current (as of 2026-04-28)

**Formula.** Lighter computes the funding rate as:
`F = clamp(InterestRate + premium + clamp(−premium, −SmallClamp, +SmallClamp), −BigClamp, +BigClamp) / 8`[^lighter-docs-2026-04-28-trading-funding].

Default `InterestRate = 0.01%`, `SmallClamp = ±0.05%`, `BigClamp = ±4%`[^lighter-docs-2026-04-28-trading-funding]. The division by 8 spreads the 1-hour figure over an 8-hour equivalent, aligning Lighter with the CEX 8h convention[^lighter-docs-2026-04-28-trading-funding].

**Settlement cadence.** Funding payments occur at each hour mark — every 60 minutes[^lighter-docs-2026-04-28-trading-funding]. Default funding period is 1 hour per market; new market deployments may configure a different period[^lighter-docs-2026-04-28-trading-contract-specifications].

**Peer-to-peer.** Funding payments are fully peer-to-peer with no fees taken by the exchange[^lighter-docs-2026-04-28-trading-funding]. When funding rate is positive, longs pay shorts; when negative, shorts pay longs[^lighter-docs-2026-04-28-trading-funding].

**Sampling.** Each market's premium is sampled once per minute at a random time within that minute[^lighter-docs-2026-04-28-trading-funding]. Per-minute premium formula:
`premium_t = (max(0, ImpactBid_t − index_t) − max(0, index_t − ImpactAsk_t)) / index_t`[^lighter-docs-2026-04-28-trading-funding].

**Aggregation.** The 1-hour premium is the time-weighted average of the 60 per-minute premiums in the last hour[^lighter-docs-2026-04-28-trading-funding].

**Per-account payment.** `funding_{i,j} = (−1) × position_{i,j} × mark_j × fundingRate_j`[^lighter-docs-2026-04-28-trading-funding].

## Time series

| effective | interest rate | small clamp | big clamp | pay cadence | sampling | source |
|---|---|---|---|---|---|---|
| 2026-04-28 | 0.01% | ±0.05% | ±4% | hourly | random once/min | [^lighter-docs-2026-04-28-trading-funding] |

## Tiering rules / formulae

**Funding rate:**
`F = clamp(InterestRate + premium + clamp(−premium, −SmallClamp, +SmallClamp), −BigClamp, +BigClamp) / 8`[^lighter-docs-2026-04-28-trading-funding]

**Per-minute premium:**
`premium_t = (max(0, ImpactBid_t − index_t) − max(0, index_t − ImpactAsk_t)) / index_t`[^lighter-docs-2026-04-28-trading-funding]

**1h premium:** time-weighted average of 60 per-minute samples[^lighter-docs-2026-04-28-trading-funding].

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-trading-funding]: [[sources/lighter-docs-2026-04-28-trading-funding]]
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
