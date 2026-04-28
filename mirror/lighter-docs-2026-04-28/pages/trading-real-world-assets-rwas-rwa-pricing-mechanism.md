# RWA Pricing Mechanism | Lighter Docs

URL: https://docs.lighter.xyz/trading/real-world-assets-rwas/rwa-pricing-mechanism

# RWA Pricing Mechanism

RWA pricing is derived from two primary sources: external oracle feeds (e.g., Chainlink, Pyth, Stork, and other exchanges) and internal pricing.

- The index price is calculated according to the pricing methodology defined below.
- The only change is that the `cexPrices` component is replaced with the pricing methodology defined below.

### Pricing Transition

External oracle feeds are the primary price source. When oracle data becomes stale, the pricing mechanism gradually shifts from oracle-based pricing to internal pricing. As soon as an external price is available, the internal price is going to instantly converge to it.

Weights are normalized across sources. On each tick where an external price is not available:

1. Apply exponential decay to the oracle source
2. Allocate the remaining weight to the internal source

#### Reweighing Formula (stale oracle prices):

$$
w_{\text{oracle}}(t) = w_{\text{oracle}}(t - 1) \cdot e^{-\frac{\Delta t}{\tau_{\text{oracle}}}}
$$

$$
w_{\text{internal}}(t) = 1 - w_{\text{internal}}(t)
$$

Where:

- Δt: time elapsed since the last update
- τ_active: source-specific time constant

#### Time Constants

The time constant varies by price type (index vs. mark).

Note that the transition from internal to external is instant.

---

### Internal Pricing

Internal pricing is derived from order book impact prices, smoothed using a time-weighted Exponential Moving Average (EMA).

#### Time-Weighted EMA

$$
EMA_t = \alpha \cdot P_t + (1 - \alpha) \cdot EMA_{t-1}
$$

$$
\alpha = 1 - e^{- \Delta t / \tau}
$$

- Pₜ — current impact price
- τ — smoothing time constant
- Δt — time since last update

---

### Index Price

For index price we set:

- τ = 1 hours

The internal index price is capped relative to the last oracle price and the leverage of the market:

- Indexᵢₙₜₑᵣₙₐₗ ∈ [ P_oracle · (1 − 1/L*0.75 + 0.5%), P_oracle · (1 + 1/L*0.75 − 0.5%) ] Where L is leverage.

---

### Mark Price Component

For mark price we set:

- τ = 8 minutes

The mark price is capped relative to the last oracle price and the leverage of the market:

- Markᵢₙₜₑᵣₙₐₗ ∈ [ P_oracle · (1 − 1/L*0.75), P_oracle · (1 + 1/L*0.75) ]

A simulation:

---

### Non-USD* Quoted Perpetual Contracts

Korean equities: Contracts are settled in USDC, while the reference price of the underlying is quoted in KRW. The contract tracks the performance of the underlying asset in KRW, but each full contract is priced and settled in USDC. In practice, this means you pay the displayed contract price in USDC, even though the market follows the underlying's KRW price movements.
