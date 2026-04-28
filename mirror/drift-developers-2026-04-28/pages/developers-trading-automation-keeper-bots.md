# Keeper Bots – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/keeper-bots

# Keeper Bots

Keeper bots keep Drift operational by performing automated actions as off-chain agents. Keepers are rewarded depending on the duties they perform.

| Bot Type | Difficulty | Capital Required |
| --- | --- | --- |
| Matching Bot | Basic | No |
| Order Trigger | Basic | No |
| Liquidator | Advanced | Yes |
| JIT Maker Bot | Advanced | Yes |

All bots require some SOL for rent and transaction fees. Reference implementations live in keeper-bots-v2.

### Clone the repo and choose a branch

| Branch | Cluster |
| --- | --- |
| master | devnet |
| mainnet-beta | mainnet-beta |

```
git clone https://github.com/drift-labs/keeper-bots-v2 -b mainnet-beta
```

### Configure environment + YAML config

```
cp .env.example .env
```

Required env vars:
- `KEEPER_PRIVATE_KEY`: keypair array or path to `keypair.json`
- `ENDPOINT`: RPC endpoint
- `ENV`: `devnet` or `mainnet-beta`

YAML config: `global.endpoint`, `global.keeperPrivateKey`, `enabledBots` + `botConfigs`.

### Initialize a Drift user (if needed)

```
yarn run dev --init-user
```

### Deposit collateral (if needed)

Required for liquidators and JIT makers:

```
yarn run dev --force-deposit 10000
```

### Run the bots

```
yarn run dev --config-file=example.config.yaml
```

Last updated on February 27, 2026
