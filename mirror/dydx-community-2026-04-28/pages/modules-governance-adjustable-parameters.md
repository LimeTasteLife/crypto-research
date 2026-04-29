# Governance Adjustable Parameters

Source: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters

This documentation is divided into the following subsections:

- Trading Stats: trading statistics look-back window.
- Fee Tiers: tiers of fees and discounts for each trader on dYdX Chain, based on their taker and maker volume.
- Trading Core: core aspects of trading, namely insurance fund and liquidations config. The insurance fund acts as the first backstop to maintain systemic solvency when an account has a negative balance. The liquidations config defines the mechanism to close an account's position when it falls below the margin requirements.
- Markets: Prices module (x/prices) parameters on dYdX Chain as well as the liquidity tier of each market based on standardized risk parameters.
- Perpetual: Perpetual module (x/perpetuals) parameters on dYdX Chain, such as funding rate and epoch information.
- Clob: Clob module (x/clob) that configures the order creation, placement, and cancellations on dYdX Chain.
- Updating A Live Market: the message required to update a live market on dYdX Chain.
- Safety: safety parameters on dYdX Chain, namely the spam mitigation that is related to order creation and cancellation using the Clob module.
