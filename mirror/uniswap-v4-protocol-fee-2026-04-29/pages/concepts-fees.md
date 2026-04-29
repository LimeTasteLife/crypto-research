# Protocol Fee Configuration

Protocol fees are a portion of swap fees routed to protocol-controlled collection contracts instead of LPs. They are distinct from LP swap fees and are governance-configurable.

## Swap Fees and Protocol Fees

- **Swap fee:** charged on every trade and distributed to LPs based on active liquidity.
- **Protocol fee:** a portion of the swap fee redirected to protocol fee collection contracts.

In the current rollout, protocol fees are active on all Uniswap v2 pools and selected Uniswap v3 pools. Additional adapter flows can be enabled through governance.

## Fee Split Table

| Version | Fee tier | LP fee | Protocol fee |
|---------|----------|--------|--------------|
| v2 | All pools | 0.25% | 0.05% |
| v3 | 0.01% | 0.0075% | 0.0025% |
| v3 | 0.05% | 0.0375% | 0.0125% |
| v3 | 0.30% | 0.25% | 0.05% |
| v3 | 1.00% | 0.8334% | 0.1666% |

## How Configuration Is Enabled

- **Uniswap v2:** protocol fees are enabled or disabled globally by setting `feeTo` on the v2 factory through governance. When enabled, the protocol fee rate is fixed in pair contracts at 1/6 of the swap fee (0.05% of the 0.30% total).
- **Uniswap v3:** protocol fee configuration is applied to selected pools via governance-controlled configuration flows.
- **Uniswap v4 adapters:** part of the broader protocol-fees architecture and can be enabled through governance.

## Collection and Conversion

Collected protocol fees accumulate in onchain collection contracts. Participants can submit `release` transactions with their signer to burn a required UNI amount and claim configured assets based on current contract state.
