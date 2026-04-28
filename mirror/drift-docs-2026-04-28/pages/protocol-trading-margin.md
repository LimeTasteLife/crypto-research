# Margin Requirements – Drift Protocol
URL: https://docs.drift.trade/protocol/trading/margin

# Margin Requirements

Below is a table for initial and maintenance margin requirements for each market. Pulled directly from the protocol's on-chain state.

These values include:

- Initial Margin Ratio (`marginRatioInitial`)
- Maintenance Margin Ratio (`marginRatioMaintenance`)
- IMF Factor, (`imfFactor`) affects leverage at higher notional sizes

Data below is updated every hour from `PerpMarketAccount`.

### Perpetual Markets

(Loaded dynamically — see Drift UI / on-chain PerpMarketAccount data for current values.)

### High Leverage Mode Markets

If a user has High Leverage Mode turned on, Taker trading fees for all perp markets will be 2x the bottom fee tier.

(Loaded dynamically.)

Last updated on February 27, 2026
