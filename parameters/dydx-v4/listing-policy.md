---
type: parameter
entity: [[dydx]]
parameter: listing-policy
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 listing-policy

## Current (as of 2026-04-28)
- Instant Market Listings (permissionless): deposit 10,000 USDC into new asset's MegaVault sub-vault; no governance vote required[^dydx-community-2026-04-28-dydx-features-instant-market-listings]
- Funds locked for 2,592,000 dYdX blocks (~30 days at 1s avg block time, actual may be longer)[^dydx-community-2026-04-28-dydx-features-instant-market-listings]
- [[entities/actor/skip-protocol]] is the dYdX-elected Market Map Updater maintaining the on-chain `launchable` asset set; coverage spans most assets from Base, Ethereum, Solana, and CEXs[^dydx-community-2026-04-28-dydx-features-instant-market-listings]
- 10k USDC and 30-day lock-up are governance-adjustable parameters[^dydx-community-2026-04-28-dydx-features-instant-market-listings]
- Deposited funds NOT principal-protected (they sit in MegaVault and bear MM trading risk)[^dydx-community-2026-04-28-dydx-features-instant-market-listings]
- US/Canada users explicitly prohibited[^dydx-community-2026-04-28-dydx-features-instant-market-listings]
- Governance-listed markets follow 4-message path: `MsgCreateOracle -> MsgCreatePerpetual -> MsgCreatePerpetualClobPair -> MsgDelayMessage` (scheduling `MsgSetClobPairStatus`)[^dydx-docs-2026-04-28-concepts-trading-governance]
- Recommended isolated-to-cross upgrade criteria: >=2 oracle sources each >$1M USD volume, >=2 sources >$150K depth within 2% of mid, >=4 total oracle sources, >=30 days historical data[^dydx-community-2026-04-28-modules-governance-markets]

## Time series

| effective | listing_mode | deposit_usd | lock_blocks | source |
|---|---|---|---|---|
| 2026-04-28 (snapshot) | permissionless IML + governance 4-msg | 10,000 | 2,592,000 (~30d) | [^dydx-community-2026-04-28-dydx-features-instant-market-listings][^dydx-docs-2026-04-28-concepts-trading-governance] |

## Tiering rules / formulae
- Isolated-to-cross upgrade criteria are recommended, not enforced by protocol code[^dydx-community-2026-04-28-modules-governance-markets]

## Disputed values
None.

## Sources
[^dydx-community-2026-04-28-dydx-features-instant-market-listings]: [[sources/dydx-community-2026-04-28-dydx-features-instant-market-listings]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-community-2026-04-28-modules-governance-markets]: [[sources/dydx-community-2026-04-28-modules-governance-markets]]
