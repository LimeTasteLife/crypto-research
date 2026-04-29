# Isolated Margin

Orderly supports two margin modes: Cross Margin (default, shares entire account balance) and Isolated Margin (fixed margin per position, capping maximum loss).

## Cross Margin vs. Isolated Margin

| | Cross Margin | Isolated Margin |
|---|---|---|
| Margin pool | All positions share balance | Each position has dedicated margin |
| Risk scope | Loss on one reduces margin for all | Losses capped at assigned margin |
| Liquidation impact | Can trigger account-wide | Only single position liquidated |
| Profit offset | Profitable positions offset losing | No offset between positions |

## Key features

- Both modes work simultaneously — specify margin mode per order.
- Independent leverage per symbol per mode.
- Can hold both Cross and Isolated positions on same symbol simultaneously.
- Risk isolation: liquidation of Isolated position does not touch other positions.

All symbols default to Cross Margin.
