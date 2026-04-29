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
| [[entities/perpdex/orderly]] | per-market 1h/4h/8h[^orderly-docs-2026-04-29-funding-rate] | 15-second Impact Bid/Ask (1,000 USDC at max lev)[^orderly-docs-2026-04-29-funding-rate] | per-market Cap/Floor: BTC/ETH ±0.30%, SOL ±0.375%, most alts ±2.00%, RWA ±0.30%; Orderly may adjust in extreme conditions[^orderly-docs-2026-04-29-funding-rate] | piecewise linear 3-slope (1x / 2x / 4x) then clamp; 0.01% IR for most markets[^orderly-docs-2026-04-29-funding-rate] | peer-to-peer; no protocol charge[^orderly-docs-2026-04-29-funding-rate] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Disputed claims
None.

## Related
[[concepts/market-microstructure/oracle-spec]] · [[concepts/market-microstructure/mark-price-formula]] · [[parameters/hyperliquid/funding-config]]

## Sources
[^hl-docs-2026-04-27-trading-funding]: [[sources/hl-docs-2026-04-27-trading-funding]]
[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]: [[sources/aster-docs-2026-04-28-trading-perpetuals-funding-rate]]
[^orderly-docs-2026-04-29-funding-rate]: [[sources/orderly-docs-2026-04-29-funding-rate]]
