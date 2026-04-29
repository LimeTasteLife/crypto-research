# Insurance Fund & ADL

The Insurance Fund steps in when a trader's account goes underwater (losses exceed collateral), making sure bad debts don't spill over to other users.

## How the Insurance Fund grows

The Insurance Fund earns money by collecting a portion of liquidation fees. Whenever a trader gets liquidated and still has enough margin to cover the fees, part flows into the Insurance Fund.

## What happens to positions that can't be liquidated normally?

If remaining margin is too low to cover the minimum liquidator fee:
1. All positions and remaining USDC balance are transferred to the Insurance Fund.
2. Liquidators can then claim those positions from the Insurance Fund at a discount.

## Key parameters

- `min_insurance_fund_margin_ratio`: Maintenance margin ratio for the IF. If the fund drops to this level, it signals trouble.
- `min_margin_ratio_solvency`: Absolute floor before IF is considered insolvent.

## ADL (Auto-Deleveraging)

ADL is the last resort. Triggered when ALL three conditions are true:
1. Liquidators don't take over liquidated positions
2. No liquidators claim those positions on the Insurance Fund for some time
3. The Insurance Fund Margin Ratio falls below `min_insurance_fund_margin_ratio`

When ADL activates, Orderly selects traders with the most profit and the most leverage. Their positions are used to offset the Insurance Fund's positions, market by market.

## Per-Builder Insurance Fund isolation (Permissionless Listing)

For permissionlessly listed markets, each Builder has a dedicated Insurance Fund separate from Orderly's platform IF. Minimum balance: $50,000 per active symbol. If IF depleted, ADL is scoped to that specific market only. No other markets or users affected.
