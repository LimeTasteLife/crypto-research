---
type: entity
subtype: token
name: HYPE
status: live
launched: 2024-Q4
sources_count: 2
last_reviewed: 2026-04-28
disputed: false
---

# HYPE

> Hyperliquid's native token. Used for validator staking, trading-fee discounts, governance attribution, and as the deflationary endpoint of the Assistance Fund.

## Snapshot
- Network: [[entities/network/hyperliquid-l1]]
- Operator: Hyperliquid Foundation
- Issuance: emissions reserve fund + initial airdrop (specifics not in docs)
- Permanent supply sink: [[concepts/tokenomics/buyback]] burns via Assistance Fund

## Asset profile
- volatility class: high
- holder distribution: unknown (not in primary docs)
- narrative class: infra (L1 native gas / governance / fee discount)
- supply unlock: post-airdrop emissions go to staking rewards reserve; full schedule not in primary docs[^hl-docs-2026-04-27-hypercore-staking]
- parent ecosystem: [[entities/network/hyperliquid-l1]]

## Mechanism

**Staking.** HYPE staking happens within HyperCore; HYPE moves between spot and staking accounts[^hl-docs-2026-04-27-hypercore-staking]. Spot-to-staking transfers are instant; staking-to-spot transfers go through a 7-day unstaking queue with a maximum of 5 pending withdrawals per address[^hl-docs-2026-04-27-hypercore-staking].

**Reward formula.** Staking reward rate is inversely proportional to the square root of total HYPE staked, an Ethereum-inspired formula[^hl-docs-2026-04-27-hypercore-staking]. At 400M total HYPE staked, the yearly reward rate is approximately 2.37%[^hl-docs-2026-04-27-hypercore-staking]. Rewards come from the future emissions reserve[^hl-docs-2026-04-27-hypercore-staking]. See [[parameters/hyperliquid/staking-rewards]] for distribution cadence.

**Fee discount.** Staked HYPE qualifies the staker for one of six trading-fee discount tiers (Wood at >10 HYPE through Diamond at >500k HYPE)[^hl-docs-2026-04-27-trading-fees]. See [[parameters/hyperliquid/fee-schedule]] for the discount ladder.

**Assistance Fund buyback-and-burn.** All trading fees flow to community recipients (HLP, the Assistance Fund, deployers); the team takes nothing[^hl-docs-2026-04-27-trading-fees]. The Assistance Fund automatically converts trading fees into HYPE on-chain as part of L1 execution and burns it, permanently removing tokens from circulating and total supply[^hl-docs-2026-04-27-trading-fees]. This makes HYPE deflationary in proportion to trading volume.

## Relations
- [[entities/token/hype]] **runs_on** [[entities/network/hyperliquid-l1]][^hl-docs-2026-04-27-hypercore-staking]
- [[entities/perpdex/hyperliquid]] **distributes_to** [[entities/token/hype]] via Assistance Fund[^hl-docs-2026-04-27-trading-fees]
- [[entities/token/hype]] **applies_to** [[concepts/tokenomics/buyback]] (burn endpoint)[^hl-docs-2026-04-27-trading-fees]
- [[entities/token/hype]] **applies_to** [[parameters/hyperliquid/fee-schedule]] (staking discount input)[^hl-docs-2026-04-27-trading-fees]

## Parameters
- [[parameters/hyperliquid/staking-rewards]] — sqrt(stake) yield formula, daily distribution
- [[parameters/hyperliquid/validator-requirements]] — 10k HYPE self-delegation
- [[parameters/hyperliquid/fee-schedule]] — staking-tier discounts

## Open questions
- What is the total HYPE supply and full unlock/emissions schedule?
- What is the holder distribution (top-N concentration)?
- What fraction of fees has been auto-burned to date, and at what cadence?

## Disputed claims
None.

## Related
[[entities/network/hyperliquid-l1]] · [[entities/perpdex/hyperliquid]] · [[concepts/tokenomics/buyback]] · [[concepts/tokenomics/emission-schedule]]

## Sources
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
