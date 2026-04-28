# Trading Automation – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation

# Trading Automation

Trading Automation covers both trading workflows (SDK-first integrations) and bots (automation and keepers).

- Keeper bots: protocol maintenance (matching, triggers, liquidations).
- Trading bots: profit-seeking strategies (e.g., JIT market making).

The reference implementation for keeper bots lives in keeper-bots-v2.

### Pick your path

Trading workflows (SDK-first):
- Trading Workflows page

Keeper bots (protocol-critical):

| Bot Type | Difficulty | Capital Required | Tutorial |
| --- | --- | --- | --- |
| Matching Bot | Basic | No | Order Matching Bot |
| Order Trigger | Basic | No | Order Trigger Bot |
| Liquidator | Advanced | Yes | Liquidation Bot |

Trading bots (strategy-driven):

| Bot Type | Difficulty | Capital Required | Tutorial |
| --- | --- | --- | --- |
| JIT Maker Bot | Advanced | Yes | JIT Maker Bot |

### Prepare environment + wallet

All bots require a funded wallet for fees, and some require collateral. Use a bot wallet setup.

### Configure the bot

`keeper-bots-v2` uses YAML config. At minimum:
- `global.endpoint` (RPC URL)
- `global.keeperPrivateKey` (keypair or env var)
- `enabledBots` + corresponding `botConfigs`

### Initialize a Drift user (if needed)

```
yarn run dev --init-user
```

### Run

```
yarn run dev --config-file=example.config.yaml
```

Last updated on February 27, 2026
