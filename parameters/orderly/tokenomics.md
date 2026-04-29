---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: tokenomics
unit: mixed
last_change: 2025-11-04
last_reviewed: 2026-04-28
disputed: false
---

# Orderly tokenomics

## Current (as of 2026-04-29)

### $ORDER token
- Max supply: 1,000,000,000[^orderly-docs-2026-04-29-distribution-and-emission-schedule]
- Format: ERC-20 on Ethereum; OFT on other chains via LayerZero[^orderly-docs-2026-04-29-distribution-and-emission-schedule]
- Five utilities: governance (future), VALOR earning, trading reward boost, MM reward boost, future utilities[^orderly-docs-2026-04-29-overview-of-order]

### Allocation
| category | pct | amount | vesting | source |
|----------|-----|--------|---------|--------|
| Community — Retroactive Airdrop | 13.3% | 133M | Unlocked at TGE | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |
| Community — Ecosystem Incentives | 25% | 250M | 200 epochs (~7yr) | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |
| Community — Builder Rewards | 8.35% | 83.5M | 200 epochs | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |
| Community — Future Product Launches | 8.35% | 83.5M | Locked until usage established | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |
| Strategic Investors | 15% | 150M | 6-month lock + 3.5-year linear | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |
| Team & Advisors | 20% | 200M | 1-year cliff (25%) + 3-year linear | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |
| Foundation | 10% | 100M | 38.5M post-TGE liquidity; 12.575M 2yr marketing; rest reserve | [^orderly-docs-2026-04-29-distribution-and-emission-schedule] |

### VALOR staking system (effective 4 November 2025)
- VALOR: non-transferable, permanently burned on redemption[^orderly-docs-2026-04-29-staking-information]
- Hard cap: 1B; 100% linear emission over 200 epochs (5M VALOR per epoch; ~4.13/second)[^orderly-docs-2026-04-29-staking-information]
- Treasury pool: 30% of net fees daily → ORDER buyback at end of each epoch[^orderly-docs-2026-04-29-staking-information]
- VALOR → esORDER redemption (7-day wait, auto-staked)[^orderly-docs-2026-04-29-staking-information]
- TreasuryShare = (UserValor / ValorCirculating) × TotalTreasuryValue[^orderly-docs-2026-04-29-staking-information]
- 7-day unstaking period, no VALOR accrual during unstaking[^orderly-docs-2026-04-29-staking-information]
- Omnichain: stake on one chain, claim on another[^orderly-docs-2026-04-29-staking-information]
- Locked team/investor tokens cannot be staked[^orderly-docs-2026-04-29-staking-information]
- APR = trailing 7-day avg daily returns (annualized); daily = 30% net revenue / total staked value[^orderly-docs-2026-04-29-staking-information]

### Governance
- Staked $ORDER grants voting rights as governance is formalized[^orderly-docs-2026-04-29-overview-of-order]
- Foundation goal: transfer full control to DAO[^orderly-docs-2026-04-29-distribution-and-emission-schedule]
- Currently: multi-sig governance[^orderly-docs-2026-04-29-security]

## Time series

| effective | parameter | value | source |
|-----------|-----------|-------|--------|
| 2025-11-04 | Staking system | New VALOR system launched | [^orderly-docs-2026-04-29-staking-information] |
| 2026-04-29 | Daily treasury allocation | 30% of net fees | [^orderly-docs-2026-04-29-staking-information] |
| 2026-04-29 | VALOR emission rate | 5M per epoch (14 days) | [^orderly-docs-2026-04-29-staking-information] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-distribution-and-emission-schedule]: [[sources/orderly-docs-2026-04-29-distribution-and-emission-schedule]]
[^orderly-docs-2026-04-29-overview-of-order]: [[sources/orderly-docs-2026-04-29-overview-of-order]]
[^orderly-docs-2026-04-29-staking-information]: [[sources/orderly-docs-2026-04-29-staking-information]]
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
