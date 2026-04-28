---
type: parameter
entity: [[hyperliquid]]
parameter: validator-requirements
unit: HYPE / time
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid validator requirements

## Current (as of 2026-04-27)

| field | value |
|---|---|
| self-delegation requirement | 10,000 HYPE locked for 1 year[^hl-docs-2026-04-27-hypercore-staking] |
| under-threshold mode | falling below → undelegate-only mode (no new delegations accepted)[^hl-docs-2026-04-27-hypercore-staking] |
| commission increase rule | only allowed if new commission ≤ 1%[^hl-docs-2026-04-27-hypercore-staking] |
| delegation lockup | 1 day[^hl-docs-2026-04-27-hypercore-staking] |
| staking → spot unstaking queue | 7 days[^hl-docs-2026-04-27-hypercore-staking] |
| max pending unstaking withdrawals | 5 per address[^hl-docs-2026-04-27-hypercore-staking] |
| epoch length | 100,000 consensus rounds (~90 minutes mainnet)[^hl-docs-2026-04-27-hypercore-staking] |
| validator set | static within an epoch[^hl-docs-2026-04-27-hypercore-staking] |
| jailing | quorum vote on inadequate latency / response frequency[^hl-docs-2026-04-27-hypercore-staking] |
| slashing | reserved for provable malice (e.g. double-sign); no automatic slashing yet[^hl-docs-2026-04-27-hypercore-staking] |

## Tiering rules / formulae

Spot-to-staking transfers are instant; staking-to-spot transfers go through the 7-day unstaking queue with the 5-pending-withdrawal cap[^hl-docs-2026-04-27-hypercore-staking]. The 7-day delay applies *after* an unstaking request enters the queue.

A quorum is any validator set holding more than 2/3 of total stake[^hl-docs-2026-04-27-hypercore-staking].

## Time series

| effective  | self-delegation | unstaking | epoch | source |
|------------|------------------|-----------|--------|--------|
| 2026-04-27 | 10k HYPE / 1y | 7d queue, max 5 pending | 100k rounds (~90m) | [^hl-docs-2026-04-27-hypercore-staking] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
