---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: llp
unit: USDC-notional
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter LLP (Lighter Liquidity Pool / insurance fund)

## Current

The **Lighter Liquidity Pool (LLP)** is Lighter's protocol-owned vault that simultaneously acts as a market-maker, the primary backstop counterparty for liquidations, and the insurance fund of last resort before [[concepts/risk/adl-waterfall|ADL]][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Composition snapshot as of 2026-04-28:

- **Single account, multi-strategy.** LLP funds are held within a **single account** that acts as the counterparty to all LLP trading and liquidations[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Internally, collateral is allocated across distinct strategy buckets — example split per docs: **Crypto Perpetuals · FX · Equities/RWAs**[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Each market is assigned to exactly one strategy[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Strategies are **not** separate accounts but behave like segregated collateral shards: risk and losses are isolated at the strategy level[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Exact market-to-strategy mappings are communicated separately and are not in the public docs page[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].
- **LLP scope.** Crypto perps + FX + RWAs (commodities, equities, fixed income; tradeable 24/7)[^lighter-docs-2026-04-28-trading-real-world-assets-rwas].
- **Out-of-scope: prelaunch markets.** LLP has **no exposure** to prelaunch markets and does **not** act as MM there[^lighter-docs-2026-04-28-trading-prelaunch-markets]. Prelaunch liquidity is supplied by **XLP** (Experimental Liquidity Provider), a pool separate from LLP[^lighter-docs-2026-04-28-trading-prelaunch-markets]. XLP acts solely as an LP and has no special role in the prelaunch liquidation flow[^lighter-docs-2026-04-28-trading-prelaunch-markets].
- **Insurance-fund role.** LLP is the residual counterparty when ordinary book liquidation fails: during Full Liquidation (TAV < CMR), LLP takes over the user's positions in **ascending order of unrealized PnL** — but **only** if doing so keeps LLP's own TAV above its own IMR[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Positions that would push LLP below its IMR are skipped and routed directly to ADL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Under the existing LLP structure, **ADL events are fully backstopped by LLP — LPs absorb the residual risk**[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].
- **Liquidation-fee inflows.** When a partial-liquidation IoC fills better than the zero price, **up to 1%** of the overshoot above maintenance margin is taken as a liquidation fee and routed to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Prelaunch markets are exempt (zero liquidation fee)[^lighter-docs-2026-04-28-trading-prelaunch-markets].
- **Eligibility.** LLP deposit access is exclusive to LIT stakers: **for every 1 LIT staked, participants may deposit up to 10 USDC into the LLP**[^lighter-docs-2026-04-28-about-lighter-lit-utility]. Unstaking LIT (and therefore reducing LLP capacity) is subject to a 3-day lockup[^lighter-docs-2026-04-28-about-lighter-lit-utility].

## Time series

| effective | scope-change / event | source |
|---|---|---|
| pre-2026-04-28 (RWA scope migration) | XLP previously the primary liquidity provider for RWA markets; LLP did not cover RWAs | [^lighter-docs-2026-04-28-trading-real-world-assets-rwas] |
| 2026-04-28 (snapshot) | **LLP scope expanded to RWAs** — LLP "now manages liquidity and handles liquidations for RWA markets," superseding XLP for RWAs[^lighter-docs-2026-04-28-trading-real-world-assets-rwas]. RWA perp markets now subject to standard liquidation fees, consistent with all other markets, since LLP is now the primary protocol LP for RWAs | [^lighter-docs-2026-04-28-trading-real-world-assets-rwas][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] |
| 2026-04-28 (snapshot) | XLP scope reduced — XLP retains prelaunch markets only (no longer covers RWAs)[^lighter-docs-2026-04-28-trading-prelaunch-markets][^lighter-docs-2026-04-28-trading-real-world-assets-rwas] | [^lighter-docs-2026-04-28-trading-prelaunch-markets][^lighter-docs-2026-04-28-trading-real-world-assets-rwas] |
| 2026-04-15 14:30 UTC | Premium-account fees on RWA markets resumed — restoring the standard liquidation-fee inflow channel to LLP for RWAs | [^lighter-docs-2026-04-28-liquidity-partner-program] |

(Pre-RWA-migration LLP balance and per-strategy collateral sizes are not surfaced in primary docs — see [[entities/perpdex/lighter]]#frame-coverage gap A6/PIII.)

## Tiering rules / formulae

**Strategy-shard accounting.** Treat LLP as a single account `LLP` with internal balance sheet partitioned across strategies `s ∈ {Crypto Perps, FX, Equities-RWAs, …}`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]:

```
LLP_TAV         = Σ_s strategy_collateral[s] + Σ_s strategy_unrealized_PnL[s]
LLP_IMR         = Σ_s strategy_IMR[s]                           # IMR computed per the markets in that strategy

# Strategy-isolated loss bound:
strategy_max_loss[s] ≤ strategy_collateral[s]                   # depleting one strategy does NOT touch the others
```

[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]

**Strategy depletion → ADL.** If strategy `s`'s allocated collateral is fully depleted (e.g. a $1M strategy taking a $1M loss), only that strategy is subject to ADL — other strategies remain unaffected[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. ADL counterparty selection on the depleted strategy ranks users on the opposite side of the bankrupt position by leverage and unrealized PnL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]; ADL execution price cannot be worse than the position's zero price[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Allocation rules — what flows in.**
- **Liquidation-fee carve.** Up to 1% of the overshoot above maintenance margin on partial-liquidation IoC fills routes to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Prelaunch is exempt (zero liquidation fee, no LLP inflow there)[^lighter-docs-2026-04-28-trading-prelaunch-markets].
- **MM PnL.** As the protocol-MM, LLP's quoting PnL accrues to LLP itself.
- **Backstop residual.** When LLP absorbs a Full-Liquidation position, the residual collateral of the underwater account stays with LLP (as in any backstop liquidation in this state).

**Eligibility — LIT-staking gate (1:10 capacity ratio).**
- Per docs: **1 LIT staked → 10 USDC LLP deposit capacity**[^lighter-docs-2026-04-28-about-lighter-lit-utility].
- LIT unstaking carries a **3-day lockup**[^lighter-docs-2026-04-28-about-lighter-lit-utility] — so LLP capacity is sticky on the way out, intentionally creating an exit-friction floor to keep LLP solvency-buffer stable.
- LLP access is **exclusive** to LIT stakers — non-stakers cannot deposit into LLP regardless of USDC balance[^lighter-docs-2026-04-28-about-lighter-lit-utility].

**Points-share-redistribution rule.** When LLP qualifies for market-maker points under the [[entities/programme/lighter-points-program]] (LLP is treated as an MM under the same rules), the points it would earn are **not** allocated to LLP — instead the remaining points are scaled so the total weekly MM pool stays at 50,000 points[^lighter-docs-2026-04-28-points-program-market-makers]. In effect: **LLP-as-MM points are silently redistributed pro-rata to other (external) MM participants**[^lighter-docs-2026-04-28-points-program-market-makers]. This avoids a protocol-owned MM cannibalizing third-party MM rewards while keeping the snapshot scoring rule symmetric.

**LLP vs XLP scope partition (post-2026-04-28).**

| pool | scope | LP role | liquidation backstop role | liquidation fee on filled overshoot |
|---|---|---|---|---|
| **LLP** | crypto perps · FX · RWAs[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^lighter-docs-2026-04-28-trading-real-world-assets-rwas] | protocol-MM (treated as an MM under points-program rules)[^lighter-docs-2026-04-28-points-program-market-makers] | yes — Full-Liquidation takeover counterparty (gated by LLP IMR self-protection)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | up to 1% (routed to LLP)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] |
| **XLP** | prelaunch markets only[^lighter-docs-2026-04-28-trading-prelaunch-markets] | LP only (no special role in liquidation flow)[^lighter-docs-2026-04-28-trading-prelaunch-markets] | no (prelaunch goes directly to ADL on TAV < CMR)[^lighter-docs-2026-04-28-trading-prelaunch-markets] | 0 (prelaunch carve-out)[^lighter-docs-2026-04-28-trading-prelaunch-markets] |

## Disputed values
None at this ingest. (See [[entities/perpdex/lighter]]#frame-coverage A6/PIII gap: per-strategy collateral sizes and IF coverage ratio (allocated-collateral vs max-OI × stress slippage × gap%) are not published in primary docs and remain a documented gap.)

## Sources
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^lighter-docs-2026-04-28-trading-real-world-assets-rwas]: [[sources/lighter-docs-2026-04-28-trading-real-world-assets-rwas]]
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
[^lighter-docs-2026-04-28-trading-public-pools]: [[sources/lighter-docs-2026-04-28-trading-public-pools]]
[^lighter-docs-2026-04-28-points-program-market-makers]: [[sources/lighter-docs-2026-04-28-points-program-market-makers]]
[^lighter-docs-2026-04-28-about-lighter-lit-utility]: [[sources/lighter-docs-2026-04-28-about-lighter-lit-utility]]
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
