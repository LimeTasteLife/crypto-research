# Decentralized Orderbook

Source: https://docs.drift.trade/protocol/about-v3/decentralized-orderbook

## Overview

Drift's decentralised orderbook is powered by our network of Keeper Bots.

The Keeper Bots match open orders with various on-chain liquidity mechanisms once they cross or their trigger condition is met. These scenarios include:

Taker auction against Taker auction;

Taker/Maker limit orders against Taker auction;

Maker limit orders against Taker limit orders;

Taker/Maker orders against the Drift's AMM.

Note:

Two post-only maker orders cannot be crossed.

Maker orders that fill against the AMM are not eligible for rebate reward.

Limit orders can be filled by market orders that go through the JIT auction.

Keepers earn rewards that incentivise:

providing the best execution for takers (relative to the oracle price) and;

following First-Come-First-Serve execution ordering

While a robust Keepers network improves throughput/usability, the protocol's core functionality is not crunched upon it. Existing trading bots (JIT makers and resting order takers) implicitly fulfil the role of Keepers.

### Build Philosophy

The decentralised orderbook is designed with two core values in mind:

decentralisation; and

computational efficiency.

Decentralisation is achieved through our network of hybrid off-chain Keepers that anyone can build and run, similar to liquidator bots.

Computational efficiency is achieved by leaving the order-filling logic, the part that requires the most computational power, off-chain, and filling them on-chain upon a trigger.

Hence, Drift's unique limit order system is a hybrid system that uses a combination off-chain Keepers and on-chain settlement.

Last updated on February 27, 2026
