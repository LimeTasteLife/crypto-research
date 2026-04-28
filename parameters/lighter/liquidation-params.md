---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: liquidation-params
unit: percent / flag
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter liquidation params

## Current (as of 2026-04-28)

**Three-tier margin schedule.** Each market defines three margin requirement levels with strict ordering C_i < M_i < I_i (Close-Out < Maintenance < Initial)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Across markets, `M_i ≈ 0.6·I_i` and `C_i ≈ 0.4·I_i` are typical ratios[^lighter-docs-2026-04-28-trading-contract-specifications].

**5-state waterfall.**
1. **Healthy** (TAV ≥ all requirements) — full trading permitted[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].
2. **Pre-Liquidation** (TAV < IMR, ≥ MMR) — only operations that do not decrease the TAV/MMR ratio and do not increase any position size are permitted[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].
3. **Partial Liquidation** (TAV < MMR, ≥ CMR) — open orders cancelled; IoC limit orders sent at zero price for full position amounts one by one; stops when TAV recovers above MMR[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. If a fill executes at a better price than zero price, up to a **1% liquidation fee** on the overshoot is routed to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].
4. **Full Liquidation** (TAV < CMR) — LLP takes over positions in ascending unrealized-PnL order, only if LLP stays above its own IMR after the takeover[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].
5. **ADL** (LLP undercapitalized) — bankrupt-account positions matched against opposite-side accounts ranked by leverage and unrealized PnL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Zero-price formulas.**
- `zero_price (long) = markPrice · (1 − M_i · TAV / MMR)`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]
- `zero_price (short) = markPrice · (1 + M_i · TAV / MMR)`[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]

A trade at zero price preserves the TAV/MMR ratio[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Prelaunch carve-out.** Prelaunch markets have no liquidation fee[^lighter-docs-2026-04-28-trading-prelaunch-markets]. The prelaunch flow is: between MMR and CMR an exchange-issued IoC at zero fee closes the position; below CMR the user is directly ADL'd bypassing LLP-takeover[^lighter-docs-2026-04-28-trading-prelaunch-markets].

**Isolated-mode.** Isolated positions follow the same waterfall but use AllocatedMargin instead of cross collateral[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**LLP strategy isolation.** When a strategy's allocated collateral is depleted, only that strategy's markets enter ADL — other strategies are unaffected[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

## Time series

| effective | max liq fee (partial) | prelaunch liq fee | zero-price formula | ADL trigger | source |
|---|---|---|---|---|---|
| 2026-04-28 | 1% on partial-liq overshoot → LLP | 0% | markPrice·(1 ± M_i·TAV/MMR) | LLP below own IMR | [^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^lighter-docs-2026-04-28-trading-prelaunch-markets] |

## Tiering rules / formulae

Leverage tiers and corresponding (IMR, MMR, CMR) triples are documented in [[parameters/lighter/margin-tiers]].

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
