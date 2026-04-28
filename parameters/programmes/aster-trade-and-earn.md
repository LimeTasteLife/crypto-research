---
type: parameter
programme: [[entities/programme/aster-trade-and-earn]]
parameter: outcomes
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster Trade & Earn programme outcomes

## Current (as of 2026-04-28)

**Programme thesis.** Trade & Earn pays additional yield for using Aster's yield-bearing assets (USDF, asBNB) as perp trading collateral via Multi-Asset Mode — collateral continues earning passive yield while being used as trading margin (no opportunity cost separation)[^aster-docs-2026-04-28-program-trade-and-earn].

**Multi-Asset Mode collateral ratios**[^aster-docs-2026-04-28-program-trade-and-earn]:

| Asset | Collateral value ratio |
|---|---|
| USDF | **99.99%** |
| asBNB | **95%** |

Multi-Asset Mode must be enabled in Settings before USDF or asBNB can be used as collateral[^aster-docs-2026-04-28-program-trade-and-earn].

**Eligibility.** Trader must be active **≥ 2 days/week** with **weekly volume ≥ 50,000 USD** (raised on **2025-11-20**)[^aster-docs-2026-04-28-program-trade-and-earn].

**Reward streams.** USDF rewards have two streams[^aster-docs-2026-04-28-program-trade-and-earn]:

1. **Deposit Rewards** — holders with > 1 USDF in their trading account earn rewards calculated hourly off a holdings snapshot, distributed proportionally.
2. **Trading Rewards** — gated on volume threshold + USDF holdings, capped at **100,000 USDF per account** (cap effective **2025-09-04**).

asBNB yield comes from **BNB Launchpools** (auto-reflected in exchange rate), **HODLer airdrops** (manual claim), and **Megadrops** (manual claim)[^aster-docs-2026-04-28-program-trade-and-earn].

**Reward cycle.** Reward weeks run **Thursday → following Wednesday**; payouts distributed in **USDF directly to the user's Futures account within 7 business days**[^aster-docs-2026-04-28-program-trade-and-earn].

**USDF backing.** USDF is fully backed and redeemable 1:1 with USDT[^aster-docs-2026-04-28-program-trade-and-earn]. Users can swap USDT or BNB / slisBNB to USDF or asBNB inside the trading account UI[^aster-docs-2026-04-28-program-trade-and-earn].

**Anti-abuse.** Wash trading, market manipulation, and bulk-account creation for bonus farming all trigger disqualification[^aster-docs-2026-04-28-program-trade-and-earn]. The combination of trade-volume threshold + collateral cap creates measurable wash-trading exposure (volume gating + reward cap incentivize cross-account farming) — acknowledged via the exclusion clauses[^aster-docs-2026-04-28-program-trade-and-earn].

**Discretion and disclaimers.** All program rules may be amended or cancelled at Aster's discretion[^aster-docs-2026-04-28-program-trade-and-earn]. Aster disclaims liability for trading losses and frames Trade & Earn output as not financial advice[^aster-docs-2026-04-28-program-trade-and-earn].

## Time series

| effective | weekly volume requirement | USDF reward cap (per account) | asset cycle | source |
|---|---|---|---|---|
| 2025-09-04 | (prior threshold) | **100,000 USDF cap introduced** | Thu → Wed; payout ≤ 7 business days | [^aster-docs-2026-04-28-program-trade-and-earn] |
| 2025-11-20 | **raised to 50,000 USD/week** | 100,000 USDF | Thu → Wed; payout ≤ 7 business days | [^aster-docs-2026-04-28-program-trade-and-earn] |
| 2026-04-28 | 50,000 USD/week (≥2 days/wk) | 100,000 USDF | Thu → Wed; payout ≤ 7 business days | [^aster-docs-2026-04-28-program-trade-and-earn] |

## Tiering rules / formulae

- Eligibility gate: `active_days_per_week ≥ 2` AND `weekly_volume ≥ 50,000 USD`.
- Effective USDF reward basis: `min(holdings, 100,000 USDF)` per account.
- Collateral haircut: `usable_collateral = balance_USDF × 0.9999 + balance_asBNB × 0.95`.

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-program-trade-and-earn]: [[sources/aster-docs-2026-04-28-program-trade-and-earn]]
