# JIT Maker Bot – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/keeper-bots/jit-maker-bot

# JIT Maker Bot

This tutorial shows how to run a JIT Maker bot in Typescript from the keeper-bots-v2 repo. A similar Python example is in keepyrs.

WARNING: This bot requires collateral to run.

## Running the bot

### 1. Clone the repository

```
git clone https://github.com/drift-labs/keeper-bots-v2.git
```

### 2. Prepare a keypair and drift account

### 3. Prepare the config file

`jit-maker-config.yaml` is a good starting point:

- `global.endpoint`: RPC endpoint
- `global.keeperPrivateKey`: bot private key (or env var)
- `botConfigs.jitMaker.aggressivenessBps`: e.g., 30 = bid 30bps above best bid, sell 30bps below best ask
- `botConfigs.jitMaker.marketType`: `perp` or `spot`
- `botConfigs.jitMaker.marketIndexes`: list of markets
- `botConfigs.jitMaker.subaccounts`: subaccount per marketIndex (1:1 mapping)

```yaml
botConfigs:
  jitMaker:
    marketType: perp
    marketIndexes:
      - 0
      - 1
    subaccounts:
      - 0
      - 1
```

### 4. Run

```
yarn run dev --config-file=jit-maker-config.yaml
```

## Technical Explanation

### Strategy overview

Uses JitterShotgun strategy and the jit-proxy program. JitterShotgun continuously sends transactions to fill orders as soon as it sees one that crosses. `jit-proxy` is permissionless/stateless and does last-mile checks on-chain to ensure the fill is within desired bid/ask price and doesn't exceed min/max positions.

### JIT-able orders

Orders with `auctionDuration > 0` may be filled by jit makers at any time. The bot uses `programSubscribe` RPC method to find users with new orders meeting this criteria.

### Future optimizations

- Multi-market and spot+perp simultaneously
- Asymmetric bid/ask offsets
- Improved JitterShotgun strategy (time/tx-count aware)

## Troubleshooting

### Resubscribing log messages

Normal. Drift SDK restarts WebSocket connection after timeout. Common for less active markets.

### Order does not cross params yet, retrying

Common with shotgun strategy. The error decoded shows: jit fill attempt details, slot, auction duration/slots-left, taker order details (Oracle/auction offsets), and why the program rejected (e.g., `AskNotCrossed` because taker price below worst ask).

Last updated on February 27, 2026
