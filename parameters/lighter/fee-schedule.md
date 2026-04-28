---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: fee-schedule
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter fee schedule

## Current (as of 2026-04-15)

Lighter operates a **two-track** fee model gated by account type[^lighter-docs-2026-04-28-trading-trading-fees]:

- **Standard Account (default).** Zero maker / zero taker on **both** perpetuals and spot, across all Lighter markets[^lighter-docs-2026-04-28-trading-trading-fees]. Trades through a deliberately throttled latency stack: **300 ms taker / 200 ms maker / 200 ms cancel**[^lighter-docs-2026-04-28-trading-trading-fees]. The latency throttle is the implicit price of zero-fee — retail can trade for free, but cannot run an MM strategy here.
- **Premium Account (opt-in).** Pays maker/taker fees, but unlocks lower latency (especially zero added latency on cancels and Post-Only placements) — the surface MMs actually optimize for[^lighter-docs-2026-04-28-trading-trading-fees]. Base tier (0 LIT staked): **0.0040% maker / 0.0280% taker / 200 ms taker latency**[^lighter-docs-2026-04-28-trading-trading-fees]. Top tier (500,000 LIT staked): **0.0028% maker / 0.0196% taker / 140 ms taker latency** — capped at 30% fee discount and 30% latency improvement[^lighter-docs-2026-04-28-trading-trading-fees].

**Liquidation-fee carve-outs.** Standard liquidation fee is up to 1% on the overshoot above maintenance margin (routed to LLP) when a partial-liquidation IoC fills better than the zero price[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. **Prelaunch markets carry a zero liquidation fee**[^lighter-docs-2026-04-28-trading-prelaunch-markets]. **RWA Premium fees are live on Lighter as of 2026-04-15 14:30 UTC**[^lighter-docs-2026-04-28-liquidity-partner-program] — they had been temporarily suspended.

**Integrator-fee envelope (Partner Attribution).** Third-party integrators may configure a user fee within Lighter-set global caps: **perpetual cap ≤ 10 bps, spot cap ≤ 1%, minimum increment 0.01 bps**[^lighter-docs-2026-04-28-integrations-partner-attribution]. The integrator fee stacks **on top of** the user's chosen Standard/Premium tier and applies only after the user signs an explicit on-chain approval (which can be expiring and is user-revocable)[^lighter-docs-2026-04-28-integrations-partner-attribution].

## Time series

| effective | track | maker | taker | taker latency | maker/cancel latency | discount source | source |
|---|---|---|---|---|---|---|---|
| pre-2026-04-15 | RWA Premium | suspended | suspended | — | — | RWA Premium fees not charged during the suspension window | [^lighter-docs-2026-04-28-liquidity-partner-program] |
| 2026-04-15 14:30 UTC | RWA Premium | 0.0040% (base) → 0.0028% (top tier) | 0.0280% (base) → 0.0196% (top tier) | 200 → 140 ms | 0 ms added | LIT-staking 8-tier ladder (see Tiering rules) | [^lighter-docs-2026-04-28-liquidity-partner-program][^lighter-docs-2026-04-28-trading-trading-fees] |
| 2026-04-28 (snapshot) | Standard | 0.0000% | 0.0000% | 300 ms | 200 / 200 ms | — (latency-fee tradeoff replaces fee discount) | [^lighter-docs-2026-04-28-trading-trading-fees] |
| 2026-04-28 (snapshot) | Premium (perp + spot, all non-RWA + post-resume RWA) | 0.0040% (base) → 0.0028% (top tier) | 0.0280% (base) → 0.0196% (top tier) | 200 → 140 ms | 0 ms added | LIT-staking 8-tier ladder; LIT Fee Credits paid shortcut | [^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits] |
| 2026-04-28 (snapshot) | Liquidation fee (standard) | n/a | up to 1% on overshoot above maintenance margin, routed to LLP | n/a | n/a | (no discount; flat ceiling) | [^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] |
| 2026-04-28 (snapshot) | Liquidation fee (prelaunch) | n/a | 0 | n/a | n/a | prelaunch carve-out (XLP-LP, no LLP exposure) | [^lighter-docs-2026-04-28-trading-prelaunch-markets] |
| 2026-04-28 (snapshot) | Integrator fee (Partner Attribution) | n/a | up to 10 bps perp / 1% spot | n/a | n/a | global cap; user-signed approval required | [^lighter-docs-2026-04-28-integrations-partner-attribution] |

(Earlier rows — historical Premium fee changes prior to the RWA suspension, Standard-account tier introductions, integrator-fee-cap revisions — not surfaced in this source set; will be appended on subsequent ingest if surfaced.)

## Tiering rules / formulae

**Premium Account 8-tier LIT-staking ladder** (verbatim from docs)[^lighter-docs-2026-04-28-trading-trading-fees]:

| tier | LIT staked | discount | maker | taker | taker latency | latency improvement |
|---|---|---|---|---|---|---|
| 1 | 0 | 0% | 0.0040% | 0.0280% | 200 ms | 0% |
| 2 | 1,000 | 2.5% | 0.0039% | 0.0273% | 195 ms | 2.5% |
| 3 | 3,000 | 5% | 0.0038% | 0.0266% | 190 ms | 5% |
| 4 | 10,000 | 10% | 0.0036% | 0.0252% | 180 ms | 10% |
| 5 | 30,000 | 15% | 0.0034% | 0.0238% | 170 ms | 15% |
| 6 | 100,000 | 20% | 0.0032% | 0.0224% | 160 ms | 20% |
| 7 | 300,000 | 25% | 0.0030% | 0.0210% | 150 ms | 25% |
| 8 | 500,000 | 30% | 0.0028% | 0.0196% | 140 ms | 30% |

[^lighter-docs-2026-04-28-trading-trading-fees]

The ladder is **flat** (one global ladder, not per-asset) — a tier set by total LIT staked applies to every Premium-account fee on every Lighter market[^lighter-docs-2026-04-28-trading-trading-fees]. Both fee discount **and** latency improvement scale together; you cannot pick "lower fees but slower latency" or vice-versa[^lighter-docs-2026-04-28-trading-trading-fees].

**Tier aggregation rule (L1-address + sub-accounts).** LIT-staking discounts are applied at the **L1 address level**, with total staked LIT calculated as the combined stake across the main account and all associated sub-accounts[^lighter-docs-2026-04-28-trading-trading-fees]. The main account and its sub-accounts therefore share **one** staking tier determined by aggregated LIT stake[^lighter-docs-2026-04-28-trading-trading-fees]. Lighter rate limits will be adjusted to allow users to consolidate trading activity through sub-accounts without downside[^lighter-docs-2026-04-28-trading-trading-fees]. There are two registration channels: today, participants may submit a list of addresses to the Lighter team to share a single staking tier[^lighter-docs-2026-04-28-trading-trading-fees]; an in-app wallet linker for fee-discount purposes is **planned**[^lighter-docs-2026-04-28-trading-trading-fees].

**LIT Fee Credits — paid shortcut to a higher tier.**[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits] Instead of staking the full amount required for a higher discount tier, users buy time-bounded "credits" that count toward a chosen fee/latency tier. Concrete example from docs: 100,000 LIT staked + 200,000 LIT-equivalent in Fee Credits qualifies the user for the **next** staking tier[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]. Activation requires acquiring LIT, navigating to the Staking page → LIT Fee Credits, choosing credit amount and duration, and confirming via L1 signature with upfront LIT payment[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]. **100% of Fee Credits proceeds are streamed to LIT stakers as daily rewards across the credit duration**[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits] — a direct user-pays-staker yield routing on top of the trading-fee-funded buyback channel.

**Stack ordering — staking discount × LIT Fee Credits × integrator fee.** The composition rule, normalized from the cited sources:

```
effective_user_fee = max(0, base_premium_fee × (1 − staking_discount[tier]))   # Premium tier discount
                   + integrator_fee                                            # Partner Attribution markup, ≤ caps

where tier = lookup_tier(staked_LIT + LIT_Fee_Credits_LIT_equivalent)          # credits boost tier; do NOT stack as additional discount
```

[^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits][^lighter-docs-2026-04-28-integrations-partner-attribution]

Two stack-discipline points worth flagging:

1. **LIT Fee Credits do not stack as a *second* discount on top of the staking-discount.** They act as a tier-elevator: their LIT-equivalent value is added to the user's staked-LIT total for the purpose of *tier lookup*, then the resulting tier's single discount is applied. Per docs example: 100k staked + 200k credits = 300,000-equivalent → tier 7 (25% discount), not "tier 6 stacked with credits on top".[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]
2. **Integrator fee is additive on top of the post-discount Premium fee** — the integrator markup is gated only by the global caps (≤ 10 bps perp / ≤ 1% spot), not by the user's staking tier[^lighter-docs-2026-04-28-integrations-partner-attribution].

**Standard-vs-Premium latency-fee tradeoff.** Standard pays no fee but eats a 300/200/200 ms latency floor[^lighter-docs-2026-04-28-trading-trading-fees]. Premium pays the fee table above but cancels and Post-Only placements have **zero added latency**[^lighter-docs-2026-04-28-trading-trading-fees] — the latency edge an MM actually monetizes. The choice is binary: a single account is one or the other, gated by the user-set Premium toggle.

**LIT staking utility composition (for context — not part of the fee math itself).** LIT stakers earn APR (currently bootstrapped via company funds and pre-TGE revenue)[^lighter-docs-2026-04-28-about-lighter-lit-utility]; LIT used to fund staking rewards is bought from address `0x5E52363E65C99fefC0E356F0DC6c37b75bf8FC91`[^lighter-docs-2026-04-28-about-lighter-lit-utility]. LIT buybacks funded by trading-fee revenue are executed as **daily 24h TWAPs** with shorter timeframes possible[^lighter-docs-2026-04-28-about-lighter-lit-utility]. Unstaking is subject to a 3-day lockup[^lighter-docs-2026-04-28-about-lighter-lit-utility].

## Disputed values
None at this ingest. (See [[entities/perpdex/lighter]]#disputed for the LIT buyback target-address question, which is tokenomics-adjacent rather than fee-schedule-internal.)

## Sources
[^lighter-docs-2026-04-28-trading-trading-fees]: [[sources/lighter-docs-2026-04-28-trading-trading-fees]]
[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]: [[sources/lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]]
[^lighter-docs-2026-04-28-about-lighter-lit-utility]: [[sources/lighter-docs-2026-04-28-about-lighter-lit-utility]]
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
[^lighter-docs-2026-04-28-integrations-partner-attribution]: [[sources/lighter-docs-2026-04-28-integrations-partner-attribution]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
