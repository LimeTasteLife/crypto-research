---
type: parameter
entity: [[aster]]
parameter: funding-config
unit: percent / hours
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster funding config

## Current (as of 2026-04-28)

**Formula.** Aster uses a Binance-style funding rate: `F = [P + clamp(interest_rate − P, −0.05%, 0.05%)] / (8/N)`, where `P` is the average premium index over the funding window, `interest_rate` defaults to **0.01%** (BNBUSDT is the documented exception at **0%**), and `N` is the funding interval in hours[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Intervals.** Default funding interval is **8 hours**. Some pairs run shorter — e.g., **ASTERUSDT runs at 4h**[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Sampling.** Premium index is computed every **5 seconds** using impact-bid / impact-ask prices against an Impact Margin Notional sized to each contract's max-leverage initial margin: `IMN = Impact Margin Amount / Initial Margin Rate at Max Leverage`[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]. Impact bid/ask prices use the order book level where cumulative quote notional first exceeds IMN[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]. Contract multiplier is usually 1[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Premium index definition.** `Premium = [max(0, Impact bid − Index) − max(0, Index − Impact ask)] / Index`[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Aggregation.** For interval > 1h, average premium index `P` is volume-weighted across samples: `P = (1·P_1 + 2·P_2 + ... + n·P_n) / (1+2+...+n)`. For 1h interval, simple average is used[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Timing deviation.** A **15-second** offset exists between actual time and when funding is charged — a position opened at 16:00:05 UTC may still be charged for that interval[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Discretion.** Aster reserves the right to adjust funding rate floor, cap, and interval during extreme market volatility[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Settlement.** Funding amount = `Position size × Mark price × Funding rate`. Funding fees deduct from Perps Account balance; if insufficient, fees come from position margin and impact liquidation price[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]. Aster does not collect or pay funding — it is peer-to-peer between longs and shorts[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

## Time series

| effective | default interest | clamp range | default interval | exceptions | source |
|---|---|---|---|---|---|
| 2026-04-28 | 0.01% | ±0.05% | 8h | BNBUSDT 0% interest; ASTERUSDT 4h interval | [^aster-docs-2026-04-28-trading-perpetuals-funding-rate] |

## Tiering rules / formulae

**Funding rate:** `F = [P + clamp(interest − P, −0.05%, 0.05%)] / (8/N)`[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**Premium index:** `P_t = [max(0, ImpactBid − Index) − max(0, Index − ImpactAsk)] / Index`, sampled every 5s[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

**IMN-weighted impact bid:** `IMN / [(IMN − Multiplier × Σ p_(x-1) × q_(x-1)) / p_x + Multiplier × Σ q_(x-1)]`[^aster-docs-2026-04-28-trading-perpetuals-funding-rate].

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]: [[sources/aster-docs-2026-04-28-trading-perpetuals-funding-rate]]
