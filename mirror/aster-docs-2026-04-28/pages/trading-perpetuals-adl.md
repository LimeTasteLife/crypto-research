# Auto-Deleveraging (ADL)

Source: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/auto-deleveraging-adl

Auto-Deleveraging (ADL) is a risk management mechanism that activates during extreme market conditions, used only when other protective systems – like liquidation and the insurance fund – cannot cover losses in time.

Auto-Deleveraging (ADL) is a risk management mechanism that activates during extreme market conditions, used only when other protective systems — like liquidation and the insurance fund — cannot cover losses in time.

### How ADL Works

When a position is liquidated but the execution price is worse than the bankruptcy price, the system absorbs the remaining loss. However, if the liquidation can't be completed before the Mark Price hits the bankruptcy price, ADL is triggered. This forcibly reduces the size of opposite-side positions held by other traders, starting with those who are most profitable and most highly leveraged.

### How ADL Priority is Determined

The system uses a ranking based on a trader's profit and leverage:

| Metric | Formula |
| --- | --- |
| PnL percent | max(0, Unrealized profit) ÷ max(1, Wallet balance) |
| Margin ratio | If (Wallet balance + Unrealized profit) ≤ 0:→ margin ratio = 0If (Wallet balance + Unrealized profit) > 0:→ Margin ratio = Maintenance margin ÷ (Wallet balance + Unrealized profit) |
| Leverage PnL | PnL percent × Margin ratio |
| Leverage PnL quantile | User's leverage PnL rank ÷ Total number of users |

The higher your leverage PnL quantile, the higher your ADL risk.

### ADL Risk Indicator

The LeveragePnLQuantile bar shows your risk of being auto-deleveraged:

- 4 bars = high ADL risk
- Fewer bars = lower ADL risk

In Aster Pro, the LeveragePnLQuantile bar shows your risk of being auto-deleveraged:

- 4 bars = high ADL risk
- Fewer bars = lower ADL risk

This position is showing 1 of 4 bars - there is a low ADL risk

### How to Reduce ADL Risk

- Lower your leverage
- Close and reopen your position to reset your priority in the ADL queue

### What Happens If You're ADL'd

Your position is partially or fully reduced without warning. You can re-enter the market at any time afterward.

#### Additional notes

- The bankruptcy price might fall outside the current trading range, making it harder to fully close your position before losses exceed your margin
- ADL mostly affects traders with high leverage and large unrealized profits
