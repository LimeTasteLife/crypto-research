# Best Practices

Best practices when interacting with the Uniswap Protocol Fee system.

## Calldata Nonce

The nonce mechanism prevents front-running attacks, where a successful front-run would cause the victim to burn a substantial amount of UNI in exchange for little to no assets. The nonce mechanism ensures sequencing, so if two competing transactions use the same nonce, only one will succeed.

**IMPORTANT:** Integrating contracts should NEVER read the nonce at the time of the transaction (vulnerable to front-running). Instead, the caller is responsible for reading the Firepit.nonce() offchain, associating it with releasable assets, and passing it as a calldata parameter.

## Collect Uniswap v3 Fees

In the Uniswap Protocol Fee system, Uniswap v3 fees must be collected to the AssetSink before they are eligible for release. Integrators should check and collect Uniswap v3 fees before calling Firepit.release(), to ensure the maximum assets are released.

Collection is available via IV3FeeController.collect().

## UNI Approvals

The Uniswap Protocol Fee system allows for an updatable Firepit.threshold(). While the system does not intend to maliciously front-run release() calls, max-approving UNI allowances may lead to an unexpectedly higher burn of UNI. The risk only appears if the thresholdSetter increases the threshold while there is a pending release() call.

Integrators can avoid this risk by:
- performing balance checks before and after calling release()
- approving only the amount of UNI they intend to burn
- only holding an amount of UNI they are willing to burn

## Payable Contracts

Because the Uniswap Protocol Fee system can release native tokens (Ether), recipients of the tokens should be payable.

## Pricing Uniswap v2 ERC-20 Tokens

Uniswap v2 protocol fees are automatically "pushed" to the AssetSink contract, but are represented as ERC-20 LP tokens. These represent a combination of token0 and token1.

To compute the underlying amount:
```
(LP Token Balance / LP Token Total Supply) * Pool Reserves
```

Integrators should perform additional validation (pool price, slippage checks) to not misrepresent the LP token's underlying token amounts.
