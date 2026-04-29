---
type: concept
domain: fee-model
name: Funding rate
last_reviewed: 2026-04-28
disputed: false
---

# Funding rate

## Definition
Funding rate is the periodic peer-to-peer payment between long and short holders of a perpetual contract that anchors the perp's mark price to its spot reference. Funding is not a fee taken by the venue — it flows between counterparties[^hl-docs-2026-04-27-trading-funding].

The funding rate is typically composed of two parts: a fixed **interest-rate** component (a steady drift paid by longs, mimicking the cost of borrowing the underlying) and a variable **premium** component (a function of how far the mark price drifts from the oracle).

## Mechanism on Hyperliquid

**Composition.**

```
F = average_premium + clamp(interest_rate − premium, −0.0005, 0.0005)
```

[^hl-docs-2026-04-27-trading-funding]

**Interest rate.** Fixed at 0.01% per 8 hours (≈0.00125%/hour, ≈11.6% APR paid to short)[^hl-docs-2026-04-27-trading-funding].

**Premium sampling.** Premium is sampled every 5 seconds and averaged over the hour[^hl-docs-2026-04-27-trading-funding].

**Premium formula** (default perps):

```
premium = impact_price_difference / oracle_price
impact_price_difference uses impact_bid/ask — avg execution price for impact_notional_usd
```

[^hl-docs-2026-04-27-trading-funding]

**HIP-3 formula** (more responsive):

```
premium = 0.5 * (impact_bid_px + impact_ask_px) / oracle_px − 1
```

Plus configurable funding-rate multiplier and interest-rate per HIP-3 deployer[^hl-docs-2026-04-27-trading-funding].

**Cadence and cap.**
- Funding paid every hour, at 1/8 of the 8h-equivalent rate[^hl-docs-2026-04-27-trading-funding].
- Capped at **4%/hour**; cap and interval do not depend on the asset[^hl-docs-2026-04-27-trading-funding].
- Hyperliquid notes the cap is "explicitly less aggressive than CEX counterparts"[^hl-docs-2026-04-27-trading-funding].

**Notional reference.** Funding payment notional uses the **spot oracle price** (not mark price): `payment = position_size * oracle_price * funding_rate`[^hl-docs-2026-04-27-trading-funding].

**No fee on funding.** Funding payments are peer-to-peer; the venue does not collect fees on the payments[^hl-docs-2026-04-27-trading-funding].

## Variants in the wild

| venue | period | sampling | cap | premium formula | notional ref |
|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] (default) | 1h pay; 8h-equivalent rate[^hl-docs-2026-04-27-trading-funding] | 5s; 1h average[^hl-docs-2026-04-27-trading-funding] | 4%/h[^hl-docs-2026-04-27-trading-funding] | impact-price ratio[^hl-docs-2026-04-27-trading-funding] | spot oracle[^hl-docs-2026-04-27-trading-funding] |
| [[entities/perpdex/hyperliquid]] (HIP-3) | configurable[^hl-docs-2026-04-27-trading-funding] | 5s; 1h average[^hl-docs-2026-04-27-trading-funding] | 4%/h[^hl-docs-2026-04-27-trading-funding] | mid-impact ratio[^hl-docs-2026-04-27-trading-funding] | spot oracle[^hl-docs-2026-04-27-trading-funding] |
| [[entities/perpdex/aster]] | 8h pay default (ASTERUSDT 4h)[^aster-docs-2026-04-28-trading-perpetuals-funding-rate] | not surfaced[^aster-docs-2026-04-28-trading-perpetuals-funding-rate] | ±0.05% premium-vs-interest clamp; platform may adjust caps/floors[^aster-docs-2026-04-28-trading-perpetuals-funding-rate] | `F = [P + clamp(interest_rate − P, ±0.05%)] / (8/N)`; default 0.01% interest (BNBUSDT 0%)[^aster-docs-2026-04-28-trading-perpetuals-funding-rate] | peer-to-peer; no protocol charge[^aster-docs-2026-04-28-trading-perpetuals-funding-rate] |
| [[entities/perpdex/lighter]] | 1h pay; /8 CEX-equivalent rate[^lighter-docs-2026-04-28-trading-funding] | random per-minute; 1h TWAP of 60 samples[^lighter-docs-2026-04-28-trading-funding] | ±0.05% small clamp; ±4% big clamp[^lighter-docs-2026-04-28-trading-funding] | 0.01% interest + clamped premium[^lighter-docs-2026-04-28-trading-funding] | peer-to-peer; no protocol charge; up to 15% rebate (LIT-stake-scaled)[^lighter-docs-2026-04-28-trading-funding][^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates] |
| [[drift]] | 1h (capped symmetric)[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates] | EMA span 1h; 20-min update window with hour-extension fallback[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates] | per-tier clamp B+: 0.125% / C: 0.208% / below: 0.4167%; Rebate Pool caps at 2/3 balance[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates] | `1/24 × (mark_twap − oracle_twap) / oracle_twap`[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates] | funding not paid for infrequently-traded markets[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates] |

(Other perpdex venues to be added in subsequent ingest passes.)
| [[entities/perpdex/dydx]] | 60s sample / 3,600s tick[^dydx-docs-2026-04-28-concepts-trading-funding] | 60s median FundingPremiumVote (min 15 votes per sample); 60 samples averaged per tick[^dydx-docs-2026-04-28-concepts-trading-funding] | 8h cap = 600%×(IMF−MMF); funding_rate_clamp 6%, premium_vote_clamp 60%[^dydx-docs-2026-04-28-concepts-trading-funding] | Premium=(max(0,ImpactBid−Index)−max(0,Index−ImpactAsk))/Index; rate=(Premium/8)+IRC; cross IRC=0%, isolated IRC=0.125 bps/h[^dydx-docs-2026-04-28-concepts-trading-funding] | peer-to-peer[^dydx-community-2026-04-28-modules-governance-perpetual] |

## Disputed claims
None.

## Related
[[concepts/market-microstructure/oracle-spec]] · [[concepts/market-microstructure/mark-price-formula]] · [[parameters/hyperliquid/funding-config]]

## Sources
[^hl-docs-2026-04-27-trading-funding]: [[sources/hl-docs-2026-04-27-trading-funding]]
[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]: [[sources/aster-docs-2026-04-28-trading-perpetuals-funding-rate]]
[^lighter-docs-2026-04-28-trading-funding]: [[sources/lighter-docs-2026-04-28-trading-funding]]
[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]: [[sources/lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]]
[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates]: [[sources/drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates]]
[^dydx-docs-2026-04-28-concepts-trading-funding]: [[sources/dydx-docs-2026-04-28-concepts-trading-funding]]
[^dydx-community-2026-04-28-modules-governance-perpetual]: [[sources/dydx-community-2026-04-28-modules-governance-perpetual]]
