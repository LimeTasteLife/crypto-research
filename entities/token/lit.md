---
type: entity
subtype: token
name: LIT
status: live
launched: unknown
sources_count: 4
last_reviewed: 2026-04-28
disputed: true
---

# LIT

> Lighter's native token. Used to gate fee discounts and latency improvements on Premium accounts, gate LLP deposit capacity, scale funding-rate rebates, and absorb trading-fee buybacks.

## Snapshot
- Network: settles on Ethereum (LIT staking happens at the L1 address level; sub-accounts share their main account's tier)[^lighter-docs-2026-04-28-trading-trading-fees]
- Operator: Lighter team / Lighter protocol
- Permanent supply sink: LIT buybacks funded by trading-fee revenue, executed as daily 24h TWAPs (with the flexibility to use shorter timeframes depending on market conditions)[^lighter-docs-2026-04-28-about-lighter-lit-utility]
- Buyback target: documented as `0x0000000000000000000000000000000000000000` — see Disputed claims[^lighter-docs-2026-04-28-about-lighter-lit-utility]
- Hosted exchange: [[entities/perpdex/lighter]]

## Utility

**Staking pool.** The LIT Staking Pool aligns long-term participants with Lighter protocol economics[^lighter-docs-2026-04-28-about-lighter-lit-utility]. Staking grants access to platform benefits aligned with how the participant interacts with Lighter[^lighter-docs-2026-04-28-about-lighter-lit-utility]. Unstaking is subject to a 3-day lockup period[^lighter-docs-2026-04-28-about-lighter-lit-utility]. The currently active LIT staking programs are LLP Access and Staking APR[^lighter-docs-2026-04-28-about-lighter-lit-utility].

**LLP access.** The Lighter Liquidity Pool (LLP) is exclusively accessible to LIT stakers; for every 1 LIT staked, participants may deposit up to 10 USDC into the LLP[^lighter-docs-2026-04-28-about-lighter-lit-utility]. See [[parameters/lighter/llp]].

**Staking APR.** Staking participants currently earn APR through staking rewards[^lighter-docs-2026-04-28-about-lighter-lit-utility]. In the short term, Lighter is bootstrapping LIT staking yield using company funds and pre-TGE revenue[^lighter-docs-2026-04-28-about-lighter-lit-utility]. LIT used to fund staking rewards is bought from the address `0x5E52363E65C99fefC0E356F0DC6c37b75bf8FC91`[^lighter-docs-2026-04-28-about-lighter-lit-utility].

**Premium fee discount × latency improvement.** Staking LIT discounts Premium-account maker/taker fees and reduces taker latency on a flat 8-tier ladder: 1k LIT (2.5% / 195 ms) → 3k (5% / 190 ms) → 10k (10% / 180 ms) → 30k (15% / 170 ms) → 100k (20% / 160 ms) → 300k (25% / 150 ms) → 500k (30% / 140 ms)[^lighter-docs-2026-04-28-trading-trading-fees]. Discount applies at the L1 address level: total staked LIT is calculated as the combined stake across the main account and all associated sub-accounts, and the master plus all sub-accounts share the same staking tier[^lighter-docs-2026-04-28-trading-trading-fees]. An address-list registration channel exists today for sharing a tier across multiple addresses; in-app wallet linking for fee-discount purposes is planned[^lighter-docs-2026-04-28-trading-trading-fees]. See [[parameters/lighter/fee-schedule]].

**LIT Fee Credits.** A paid shortcut to higher staking tiers: instead of locking the full staked amount, users buy time-bounded credits that count toward a chosen fee/latency tier (e.g. 100k LIT staked + 200k LIT-equivalent in Fee Credits qualifies for the next staking tier)[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]. Activation requires acquiring LIT, navigating to the Staking page → LIT Fee Credits, choosing credit amount and duration, and confirming via L1 signature with upfront LIT payment[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]. **All proceeds from the LIT Fee Credits program are distributed to LIT stakers**: the upfront LIT payment is streamed as daily rewards over the full duration of the access period[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]. This is direct user-pays-staker yield routing on top of the buyback channel.

**Funding-rate rebate.** Premium-account traders automatically receive a 6% rebate per hourly funding payment; an additional 9% scales linearly with LIT staked (capped at 9% when 50,000 LIT is staked) for a 15% combined cap[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]. Effective staked LIT is calculated on a consolidated basis across the main account and sub-accounts, with a 10% annualized rebate cap[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]. The staking-bonus scaling exponent is currently 1 (linear); the team notes it may be adjusted in the future[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]. See [[parameters/lighter/funding-rate-rebates]].

**Forthcoming benefit-transfer market.** A future feature will allow staking participants who do not use certain staking benefits (such as trading fee discounts) to transfer those benefits to others, with upfront payments distributed to LIT stakers as yield[^lighter-docs-2026-04-28-about-lighter-lit-utility].

## Buyback and supply mechanics

LIT is bought back by the Lighter protocol using trading-fee revenue[^lighter-docs-2026-04-28-about-lighter-lit-utility]. Buybacks execute as daily 24h TWAPs, with the flexibility to use shorter timeframes depending on market conditions[^lighter-docs-2026-04-28-about-lighter-lit-utility]. The treasury account that conducts LIT buybacks is `0x0000000000000000000000000000000000000000` per the docs[^lighter-docs-2026-04-28-about-lighter-lit-utility]. **This is internally inconsistent**: a "treasury account that conducts buybacks" suggests a custody address, but the zero address is the canonical Ethereum burn target. See Disputed claims for cross-reference to [[entities/perpdex/lighter#disputed-claims]].

In addition to the trading-fee-funded buyback, LIT Fee Credits and the future benefit-transfer market route end-user payments back to LIT stakers as daily-streamed yield[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits][^lighter-docs-2026-04-28-about-lighter-lit-utility]. These complement the buyback by providing direct user-pays-staker flows.

## Relations
- [[entities/token/lit]] **runs_on** Ethereum (staking is L1-address-keyed)[^lighter-docs-2026-04-28-trading-trading-fees]
- [[entities/perpdex/lighter]] **distributes_to** [[entities/token/lit]] via daily 24h TWAP buyback funded by trading-fee revenue[^lighter-docs-2026-04-28-about-lighter-lit-utility]
- [[entities/token/lit]] **applies_to** [[parameters/lighter/llp]] (LLP capacity is gated by LIT stake at a 1-LIT-per-10-USDC ratio)[^lighter-docs-2026-04-28-about-lighter-lit-utility]
- [[entities/token/lit]] **applies_to** [[parameters/lighter/fee-schedule]] (Premium tier discount and latency ladder)[^lighter-docs-2026-04-28-trading-trading-fees]
- [[entities/token/lit]] **applies_to** [[parameters/lighter/funding-rate-rebates]] (up to 9% LIT-stake-scaled funding rebate)[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]

## Open questions
- What is the actual on-chain LIT buyback custody address — is `0x0…0` literal (effectively buy-and-burn) or a docs placeholder pending a real custody address?
- What is the LIT total supply, circulating supply, and emission schedule? (Not in primary docs.)
- Is LIT live (TGE complete) or in the pre-TGE bootstrap phase the docs allude to ("bootstrapping LIT staking yield using company funds and pre-TGE revenue")?
- What is the LIT-Fee-Credits exchange rate (LIT-staked-equivalent per LIT spent on credits) and the duration bounds — neither is published on the docs page.
- When will the benefit-transfer market launch, and what is its fee structure?

## Disputed claims

### Disputed claims — LIT buyback target address (zero address vs custody wallet)

This claim is the canonical primary case; see also the cross-reference at [[entities/perpdex/lighter#disputed-claims]].

**Claim A** · confidence: high · recency: 2026-04 · authority: high
  The treasury account that conducts LIT buybacks is `0x0000000000000000000000000000000000000000`[^lighter-docs-2026-04-28-about-lighter-lit-utility].

**Claim B** · confidence: medium · recency: 2026-04 · authority: medium
  By Ethereum convention, sending tokens to `0x0000…0000` is a burn — not a custody operation. A "treasury account that conducts buybacks" usually refers to a custody address that holds the bought tokens; if Lighter's docs literally mean the zero address, then either (i) buybacks are buy-and-burn (not custody), or (ii) the docs page is incorrect / placeholder. The Lighter docs do not explicitly call this a burn; they call it "the treasury account that conducts LIT buybacks", which is internally inconsistent with the address[^lighter-docs-2026-04-28-about-lighter-lit-utility].
  status: unverified

→ Open question: Is the LIT buyback wallet the literal zero address (i.e. effectively buy-and-burn) or is the docs page using a placeholder pending publication of the real custody address?
  Suggested verification: (1) on-chain analysis — query trading-fee-funded LIT buys and check destination address; (2) check Lighter's app/contract repo for a `BuybackTreasury` address constant; (3) ask the Lighter team to confirm the docs page or update it with the real address.

## Related
[[entities/perpdex/lighter]] · [[entities/network/lighter-core]] · [[parameters/lighter/llp]] · [[parameters/lighter/fee-schedule]] · [[parameters/lighter/funding-rate-rebates]] · [[concepts/tokenomics/buyback]] · [[concepts/tokenomics/fee-distribution]]

## Sources
[^lighter-docs-2026-04-28-about-lighter-lit-utility]: [[sources/lighter-docs-2026-04-28-about-lighter-lit-utility]]
[^lighter-docs-2026-04-28-trading-trading-fees]: [[sources/lighter-docs-2026-04-28-trading-trading-fees]]
[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]: [[sources/lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]]
[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]: [[sources/lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]]
