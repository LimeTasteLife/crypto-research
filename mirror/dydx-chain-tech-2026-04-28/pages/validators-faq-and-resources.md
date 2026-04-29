# FAQ & Resources (Validators)

Source: https://docs.dydx.community/dydx-chain-technical-docs/validators/faq-and-resources

## General Validator FAQ

Managed by dYdX Foundation: https://www.dydx.foundation/validators/faqs-resources

## Validator Network FAQ

There is no minimum stake. The active validators are the top 60 validators with the highest total stake (where total stake = self-bonded stake + delegators stake).

Refer to the document on how to set up a full node. Instructions for self-delegation are available in the section "Preparing DYDX for self-delegation".

To register your validator logo: Make a PR with your logo as `validatoraddress.png` at https://github.com/cosmostation/chainlist/tree/main/chain/dydx/moniker.

A non-validating full node will not participate in proposing blocks but still validates the chain data.

The empty Prepare/PrepareProposal flag just sets an empty Prepare/PrepareProposal for the application. All nodes run ProcessProposal, but full nodes do not participate in voting.

Snapshots: see example instructions including backing up and recovering priv_validator_state.json.

## Extended Validator FAQ

- Validators can use snapshot.
- It's a public P2P network.
- It's not a validator if it is not in the active set (max 60). It works like a full node in that case.
- The active validator set is limited to 60.
- Mainnet validators list at https://www.mintscan.io/visualization/validators. Most if not all validators are professional firms in the business of staking/validating, not trading.
- Geographic distribution: https://observatory-staging-g4ywd.ondigitalocean.app/dydx/countries
- Validators usually don't expose RPC endpoints for orders to be submitted to.
- MEV detection: there is a subtle bug with the price discrepancy calculation; no authentic MEV detected so far. Nodes should respect cancels as soon as they receive them; if not, that is treated as MEV.
- Staking rewards: distributed each block to the block proposer. Expected return depends on both fees and dYdX staked. Staking APY at https://www.mintscan.io/dydx.
- You can use locked DYDX to stake to validators.
- gRPC: only works with the gRPC endpoint. Port 9090 is the gRPC port and 26657 is for validator (unless you run a validator or full node, you don't use 26657).
