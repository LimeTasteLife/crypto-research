# Maintaining the Peg

Source: https://docs.asterdex.com/usdf-stablecoin/overview/maintaining-the-peg

USDF maintains its 1:1 peg with the US Dollar through multiple mechanisms: rigid redemption, arbitrage opportunities, and delta-neutral positioning. Together, these ensure price stability and minimize deviation from the intended value.

### 1. Rigid Redemption & Arbitrage Opportunities

#### How Redemption Works

USDF maintains a strict 1:1 redemption mechanism with USDT. You can redeem your USDF at any time for the equivalent value in USDT, ensuring a direct 1:1 correlation.

Example: If you hold 100 USDF, you can redeem it for 100 USDT.

The peg stays stable because the system guarantees there's always an equal amount of underlying assets (such as USDT) available for redemption. This creates confidence in the token's value.

#### Arbitrage Opportunities

When the price of USDF deviates slightly from its 1:1 peg on liquidity pools or exchanges, market participants can profit by exploiting the discrepancy. This arbitrage activity naturally stabilizes the peg by bringing prices back into alignment.

Example: USDF Overvalued

Suppose USDF is trading at 1.02 USDT in a liquidity pool like PancakeSwap:

1. Redeem 100 USDF at the fixed 1:1 rate → Get 100 USDT
2. Swap the 100 USDT on PancakeSwap → Get 102 USDT worth of USDF
3. Profit: 2% arbitrage gain

Example: USDF Undervalued

If USDF trades at 0.98 USDT:

1. Purchase USDF at the discounted rate
2. Redeem at the fixed 1:1 rate for USDT
3. Capture the arbitrage profit when prices revert to peg

Arbitrage doesn't just benefit traders–it actively stabilizes price by reducing further deviation from the peg.

### 2. Delta-Neutral Positions

Beyond redemption, delta-neutral strategies provide additional price stability. By balancing long and short positions in underlying assets, the delta-neutral approach:

Stabilizes Price

Manages volatility of underlying assets (like USDT) to keep USDF's value consistently near 1:1 with the US Dollar, even during market fluctuations.

Generates Consistent Yield

Allows fee generation through liquidity mechanisms while minimizing exposure to volatile assets.

### 3. Key Takeaways

#### 1:1 Redemption

USDF can always be redeemed at a fixed 1:1 rate for USDT, ensuring price stability and providing holders with a capital preservation mechanism.

#### Arbitrage Opportunities

Market inefficiencies create natural profit opportunities that simultaneously stabilize the peg by eliminating price discrepancies.

#### Delta-Neutral Hedging

Balanced long and short positions protect against volatility and maintain the 1:1 peg even during uncertain markets.

Together, these mechanisms ensure USDF remains stable and trustworthy as a value store within the Aster ecosystem.
