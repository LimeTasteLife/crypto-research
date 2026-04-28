---
type: parameter
entity: [[aster]]
parameter: mm-rebate-tiers
unit: bps
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster MM rebate tiers

## Current (as of 2026-04-28)

**Three preferential tiers** gate on rolling 14-day volume or maker-share metrics, with negative maker fees (rebates) and discounted taker fees that scale with tier[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program].

| Tier | Threshold (rolling 14d) | Taker (bps) | Maker (bps) |
|---|---|---|---|
| MM1 | ≥ $150M volume **or** Maker Volume ≥ 0.25% | 2.3 | −0.25 |
| MM2 | ≥ $300M volume **or** Maker Volume ≥ 0.5% | 2.0 | −0.35 |
| MM3 | ≥ $600M volume **or** Maker Volume ≥ 1% | 1.6 | −0.5 |

[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]

**Rebate display vs settlement.** Maker rebates display as `0` in the trading UI but are calculated and disbursed **hourly**, visible in transaction history under Aster Perpetual[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program].

**Quoting standard (≥70% of UTC trading day).** A pair counts toward MM volume only if all of these hold for ≥ 70% of the UTC day (00:00–23:59 UTC)[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]:

- Bid and Offer sizes both ≥ pair-specific minimum.
- Bid-Offer spread ≤ pair-specific cap.
- Orders remain live ≥ 0.5 seconds at a time.

**Spread cap formula:** `spread = (OfferAtMin − BidAtMin) / avg(OfferAtMin, BidAtMin)`[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program].

**Pair-specific spread caps and minimum sizes** (sample)[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]:

| Pair | Spread cap | Min size (contracts) |
|---|---|---|
| BTCUSDT | 0.10% | 2 |
| ETHUSDT | 0.10% | 60 |
| SOLUSDT | 0.10% | 1,000 |
| ASTERUSDT | 0.25% | 30,000 |
| HYPEUSDT | 0.25% | 800 |
| Other crypto perps (default) | 0.25% | varies per pair |
| Equity perps (AAPL/TSLA/NVDA/AMZN/META/GOOG/MSFT) | 1.00% | varies per pair |

**Disqualification.** If qualifying percentage on a pair is < 70%, that pair's volume is excluded from effective maker volume, and that pair does not qualify for preferential fees the next day[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program].

**Onboarding.** Applicants must show ≥ **$100M USD monthly futures volume** (any platform). Aster contacts within three working days; approved applicants are IP-whitelisted and configured starting from MM1[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program].

**Discretion.** Aster reserves the right to modify, suspend, or terminate the program at any time; participation does not constitute a binding agreement; Aster retains full discretion in interpretation[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program].

## Time series

| effective | MM1 (tkr/mkr) | MM2 (tkr/mkr) | MM3 (tkr/mkr) | quoting standard | source |
|---|---|---|---|---|---|
| 2026-04-28 | 2.3 / −0.25 bps | 2.0 / −0.35 bps | 1.6 / −0.5 bps | ≥70% UTC-day; ≥0.5s order-live; pair-specific spread/min size | [^aster-docs-2026-04-28-trading-perpetuals-market-maker-program] |

## Tiering rules / formulae

- Tier qualification: `volume_14d ≥ T_v` OR `maker_share_14d ≥ T_m` per tier table.
- Spread test: `(offer − bid) / avg(offer, bid) ≤ cap_pair`.
- Day qualification: `qualifying_seconds_per_day / 86400 ≥ 0.70`.

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]: [[sources/aster-docs-2026-04-28-trading-perpetuals-market-maker-program]]
