# Borrow Interest Rate – Drift Protocol
URL: https://docs.drift.trade/protocol/borrow-lend/borrow-interest-rate

# Borrow Interest Rate

Drift's lending pools use a borrow interest rate model inspired by Aave. Each spot market defines:

- A minimum rate `R_min`
- An optimal rate `R_opt` at a target utilization `U*`
- A maximum rate `R_max` at full utilization

The borrow interest rate is a function of utilization (U), or how much capital in the pool is currently lent out.

### Utilization Rate and Liquidity

- If U is high -> there is abundant capital within the system and the protocol users are given incentives in the form of low-interest rates to encourage borrowing
- If U is low -> capital within the system is scarce and the protocol will increase interest rates to incentivise more capital supply and repayment of debt.

### Multi-Kink Interest Rate Model

To balance capital efficiency with liquidity protection, Drift uses a multi-kink model. This allows linear rates up to the optimal utilization point, and then introduces increasingly steeper rate hikes as utilization increases, especially in the 85-100% range.

This design allows for more aggressive max utilization rates while not adding too much rate volatility near optimal rate.

### Formula

The interest rate function is defined piecewise:

U* = optimalUtilization / SPOT_MARKET_UTILIZATION_PRECISION
ΔR = R_max - R_opt

R(U) = max{R_min, R_raw(U)}

R_raw(U) = R_opt * (U / U*)            if U <= U*
R_raw(U) = R_opt + ΔR * (50/1000) * (U - U*) / (0.85 - U*)    if U* < U <= 0.85
(further kinks for 0.85 < U <= 1.0 produce steeper rate hikes)

Last updated on February 27, 2026
