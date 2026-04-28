# Market Maker program

Source: https://docs.asterdex.com/trading/perpetuals/market-maker-program

Aster will update the market maker fee structure to ensure the liquidity for perpetual pairs.

## MM Preferential Fees

| Tier | Criteria (Rolling 14 days) | Taker Fee (bps) | Maker Fee (bps) |
| --- | --- | --- | --- |
| MM 1 | >= $150M or Maker Vol >= 0.25% | 2.3 | -0.25 |
| MM 2 | >= $300M or Maker Vol >= 0.5% | 2.0 | -0.35 |
| MM3 | >= $600M or Maker Vol >= 1% | 1.6 | -0.5 |

For market maker rebates, the trading interface will display your applicable Taker fee rate (determined by your volume tier or marker volume percentage) and a Maker fee of "0". Please note that our system calculates and disburses Maker rebates every hour based on the published fee schedule. These rebates can be tracked in the transaction history under Aster Perpetual.

A maker's volume for a given trading pair is counted as effective only if the following two conditions are met:

A. Quoting Standards:

- Bid and Offer sizes meet or exceed the minimum size requirement for the pairs
- Bid-Offer Spread is within the allowed limit (e.g., ≤0.1% for BTC/ETH/SOL, ≤0.25% for other pairs).
- Orders remain live in the orderbook for at least 0.5 seconds at a time.

B. Qualifying Percentage for that Pair on the Day (from 00:00 to 23:59 UTC):

- The pair is only counted if the MM maintains these standards for ≥70% of that trading day.
- If [Qualifying %] < 70%, that pair's volume is excluded from the MM's effective maker volume.

Kindly refer to 5. Quoting Qualification Details for supported pairs.

Quoting Qualification Details and Pair Type

Note: If a pair's [Qualifying Percentage] < 70%, this pair does not qualify for preferential fees on the next day. Preferential fees will only be awarded to qualified pairs.

In order to qualify for a particular pair in a day, MMs must satisfy the following conditions simultaneously at least 70% of the day (0:00 UTC to 23:59 UTC):

- Total Bids shown > Cumulative Minimum Size;
- Total Offers shown > Cumulative Minimum Size;
- Orders must be outstanding in the order book for at least 0.5 seconds;
- The Bid/Offer spread is calculated as ([Offer price at Minimum Size] - [Bid price at Minimum Size]) / { ([Offer price at Minimum Size] + [Bid price at Minimum Size]) /2 } < [Required Bid/Offer spread].

### Quoting Qualification Pair Table (excerpt)

| Pair | Bid/Offer Spread | Min Size | Type |
| --- | --- | --- | --- |
| BTCUSDT | 0.10% | 2 | Not Applicable |
| ETHUSDT | 0.10% | 60 | Not Applicable |
| SOLUSDT | 0.10% | 1,000 | Not Applicable |
| XRPUSDT | 0.25% | 20,000 | N |
| TRXUSDT | 0.25% | 100,000 | N |
| BNBUSDT | 0.25% | 50 | H |
| LINKUSDT | 0.25% | 2,500 | N |
| DOGEUSDT | 0.25% | 150,000 | N |
| SUIUSDT | 0.25% | 5,000 | N |
| 1000SHIBUSDT | 0.25% | 1,000,000 | N |
| LISTAUSDT | 0.25% | 60,000 | H |
| ADAUSDT | 0.25% | 40,000 | N |
| AVAXUSDT | 0.25% | 1,200 | N |
| LTCUSDT | 0.25% | 300 | N |
| NEARUSDT | 0.25% | 8,000 | H |
| ATOMUSDT | 0.25% | 6,000 | N |
| CAKEUSDT | 0.25% | 13,000 | H |
| APEUSDT | 0.25% | 35,000 | N |
| ETCUSDT | 0.25% | 1,200 | N |
| AAVEUSDT | 0.25% | 80 | N |
| DYDXUSDT | 0.25% | 30,000 | N |
| CRVUSDT | 0.25% | 50,000 | N |
| BCHUSDT | 0.25% | 100 | N |
| UNIUSDT | 0.25% | 6,000 | H |
| OPUSDT | 0.25% | 40,000 | N |
| APTUSDT | 0.25% | 4,000 | N |
| ARBUSDT | 0.25% | 50,000 | N |
| INJUSDT | 0.25% | 2,500 | N |
| 1000PEPEUSDT | 0.25% | 300,000 | N |
| WLDUSDT | 0.25% | 25,000 | N |
| SEIUSDT | 0.25% | 100,000 | N |
| 1000FLOKIUSDT | 0.25% | 200,000 | N |
| TONUSDT | 0.25% | 8,000 | N |
| 1000BONKUSDT | 0.25% | 1,500,000 | N |
| TRUMPUSDT | 0.25% | 2,000 | N |
| FARTCOINUSDT | 0.25% | 15,000 | N |
| BUSDT | 0.25% | 25,000 | H |
| ENAUSDT | 0.25% | 75,000 | N |
| MOODENGUSDT | 0.25% | 120,000 | N |
| DOTUSDT | 0.25% | 5,500 | N |
| XLMUSDT | 0.25% | 100,000 | N |
| PYTHUSDT | 0.25% | 200,000 | N |
| AAPLUSDT | 1.00% | 55 | N |
| TSLAUSDT | 1.00% | 50 | N |
| NVADUSDT | 1.00% | 80 | N |
| AMZNUSDT | 1.00% | 55 | N |
| METAUSDT | 1.00% | 25 | N |
| GOOGUSDT | 1.00% | 80 | N |
| MSFTUSDT | 1.00% | 30 | N |
| ASTERUSDT | 0.25% | 30,000 | H |
| HYPEUSDT | 0.25% | 800 | H |

(Full table includes 250+ pairs spanning crypto perps, equity perps, and commodity perps. Spread tier 0.10% applies to BTC/ETH/SOL only; 0.25% for other crypto and most perps; 1.00% for equity-style pairs like AAPLUSDT/TSLAUSDT.)

### Application Process

Apply via this form – the Aster team will contact you within three working days.

Requirements:

- Minimum 100M USD monthly futures cumulative trading volume (on Aster or other trading platforms).
- If eligible, Aster will whitelist your IPs and configure fees for your MM account, starting from Tier 1.

#### Disclaimer

Aster reserves the right to modify, suspend, or terminate the Market Maker Reward Program at any time, including but not limited to changes in eligibility criteria, reward allocation methodology, token distribution schedules, and qualifying requirements. All participants are responsible for reviewing the most up-to-date program terms published by Aster. Participation in the program does not constitute a binding agreement, and Aster retains full discretion in the interpretation and enforcement of program rules.
