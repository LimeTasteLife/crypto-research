# Futures Contract Price Rolling Mechanism | Lighter Docs

URL: https://docs.lighter.xyz/trading/real-world-assets-rwas/futures-contract-price-rolling-mechanism

# Futures Contract Price Rolling Mechanism

Some markets (WTI, NATGAS, BRENTOIL) use futures contracts as their underlying prices. To handle contract expirations, prices are gradually transitioned from the current month's contract to the next month's contract between the 5th and 10th business day.

Each day at 5:30 PM ET for WTI and NATGAS and at 7:00 PM ET for BRENTOIL, 20% of the price shifts from the current month to the next month. This means the price moves progressively, starting at 100% current month and ending at 100% next month over the five-day window.

Note: the underlying markets for WTI and NATGAS are closed between 5:00 PM ET and 6:00 PM ET, while for BRENTOIL they are closed between 6:00 PM ET and 8:00 PM ET (11PM London time - 1AM London time).

#### WTI & NATGAS roll schedule

| Date | Time | Front-Month | Next-Month |
| --- | --- | --- | --- |
| 2026-04-07 | 5:30 PM ET | 100% | 0% |
| 2026-04-08 | 5:30 PM ET | 80% | 20% |
| 2026-04-09 | 5:30 PM ET | 60% | 40% |
| 2026-04-10 | 5:30 PM ET | 40% | 60% |
| 2026-04-13 | 5:30 PM ET | 20% | 80% |
| 2026-04-14 | 5:30 PM ET | 0% | 100% |

#### BRENTOIL roll schedule

| Date | Time | Front-Month | Next-Month |
| --- | --- | --- | --- |
| 2026-04-07 | 7:00PM ET | 100% | 0% |
| 2026-04-08 | 7:00PM ET | 80% | 20% |
| 2026-04-09 | 7:00PM ET | 60% | 40% |
| 2026-04-10 | 7:00PM ET | 40% | 60% |
| 2026-04-13 | 7:00PM ET | 20% | 80% |
| 2026-04-14 | 7:00PM ET | 0% | 100% |
