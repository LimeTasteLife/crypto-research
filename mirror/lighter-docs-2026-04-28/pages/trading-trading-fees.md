# Trading Fees | Lighter Docs

URL: https://docs.lighter.xyz/trading/trading-fees

# Trading Fees

For both perpetual futures and spot markets, Lighter currently charges no maker or taker fees for Standard Accounts, allowing all participants to trade across all markets free of charge. Premium Accounts are subject to maker and taker fees, with the option to receive fee discounts by staking LIT.

### Account Types

#### Standard Account (Default) — Trade for free.

- Fees: 0 maker / 0 taker
- Taker latency: 300ms
- Maker latency: 200ms
- Cancel latency: 200ms

#### Premium Accounts (Opt-In) — Subject to Staking-based Fee Tiers

For Premium Accounts, all order cancelations & Post Only order placements not subject to any additional latency. For this account type, please consider the volume quota program.

| Staked LIT | Maker/Taker Fee Discount | Maker Fee | Taker Fee | Taker Latency | Latency Improvement |
| --- | --- | --- | --- | --- | --- |
| 0 | | 0.0040% | 0.0280% | 200 ms | |
| 1,000 | 2.5% | 0.0039% | 0.0273% | 195 ms | 2.5% |
| 3,000 | 5% | 0.0038% | 0.0266% | 190 ms | 5% |
| 10,000 | 10% | 0.0036% | 0.0252% | 180 ms | 10% |
| 30,000 | 15% | 0.0034% | 0.0238% | 170 ms | 15% |
| 100,000 | 20% | 0.0032% | 0.0224% | 160 ms | 20% |
| 300,000 | 25% | 0.0030% | 0.0210% | 150 ms | 25% |
| 500,000 | 30% | 0.0028% | 0.0196% | 140 ms | 30% |

---

### Fee Discounts for Premium Accounts via Staking

All Premium Account fees and latency will be eligible for staking discounts. Staking discounts will be applied at the L1 address level, where the total staked LIT is calculated as the combined stake across the main account and all associated sub-accounts.

As a result, the main account and its sub-accounts will share the same staking tier, determined by the aggregated LIT stake.

#### Rate Limits Considerations

We recognize that many participants distribute trading activity across multiple addresses due to operational or rate-limit considerations. To avoid disrupting existing workflows, rate limits will be adjusted to allow users to consolidate activity through sub-accounts without any downside.

In addition, participants may provide a list of addresses to the Lighter team, enabling all associated accounts to share a single tier based on the total staked LIT across those addresses. We also plan to introduce in-app wallet linking for fee-discount purposes soon.
