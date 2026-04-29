---
type: parameter
entity: [[drift]]
parameter: insurance-fund
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift insurance fund

## Current (as of 2026-04-28)

**Multi-asset structure.** Separate pools for USDC, BTC, ETH, and SOL; each pool covers only same-denomination liabilities[^drift-docs-2026-04-28-protocol-insurance-fund]. USDC pool collects exchange fees from spot+perp trading and supports liquidations from perp trading; SOL/BTC/ETH pools backstop borrow-lend losses for those assets[^drift-docs-2026-04-28-protocol-insurance-fund].

**Funding sources.** Stakers (anyone can stake the corresponding asset) and protocol via premiums collected from liquidation, trading, and borrow fees[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**Coverage scope.** Spot markets covered in full; perpetual markets covered up to a per-market limit[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine][^drift-docs-2026-04-28-protocol-insurance-fund].

**Isolated Insurance Funds.** Assigned to highly volatile markets, separate from the standard fund; funded exclusively by premiums collected for that market; users in an isolated-IF market do not have access to the standard IF for losses beyond the limited fund[^drift-docs-2026-04-28-protocol-insurance-fund].

**Drift Safety Module (DSM).** Fully on-chain automated bad-debt cover system layered above the standard IF[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]. Users stake DRIFT into a DSM pool; if deficit arises, staked DRIFT is automatically used as backstop[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]. Risk is asset-isolated: staking DRIFT covers bad debt in DRIFT pairs ONLY[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]. Slashing is the symmetric risk to receiving safety incentives[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]. DSM safety incentive parameters are determined by successfully-passed DAO governance proposals[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]. DSM bankruptcy risk is compensated by the Revenue Pool[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

**IF Staking yield.** Stakers earn a proportionate share of the Revenue Pool every hour: `staker_share = total_staked_amount / total_insurance_fund`[^drift-docs-2026-04-28-protocol-insurance-fund-staking]. Revenue Pool funded by borrow fees, spot exchange fees, perp exchange fees, and liquidation fees[^drift-docs-2026-04-28-protocol-insurance-fund-staking]. Each hourly settlement split between IF Stakers and protocol-owned IF portion[^drift-docs-2026-04-28-protocol-insurance-fund-staking].

**Unstaking rules.** 13-day cooldown; staked amount earns no rewards during cooldown[^drift-docs-2026-04-28-protocol-insurance-fund-staking]. Cannot unstake while spot market utilization (or 1hr utilization TWAP) is above 80%[^drift-docs-2026-04-28-protocol-insurance-fund-staking]. Only one pending unstake request per vault at a time; cancelling and resubmitting restarts the 13-day clock[^drift-docs-2026-04-28-protocol-insurance-fund-staking]. All earned rewards compound the staked amount[^drift-docs-2026-04-28-protocol-insurance-fund-staking].

**Perp bankruptcy waterfall.** External Insurance Fund (USDC) covers debt up to per-market limit -> vAMM lifetime profit (internal insurance) covers remainder -> socialized loss pro rata by base amount across open positions[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]. Lenders: pro rata by token amount[^drift-docs-2026-04-28-protocol-insurance-fund].

## Time series

| effective | assets | unstake cooldown | utilization gate | staker yield formula | source |
|---|---|---|---|---|---|
| 2026-04-28 | USDC, BTC, ETH, SOL + isolated per-market | 13 days | 80% utilization | staked / total_IF (hourly) | [^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-insurance-fund-staking] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-insurance-fund]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund]]
[^drift-docs-2026-04-28-protocol-insurance-fund-staking]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund-staking]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]: [[sources/drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]]
