# Get Started

In the current version of the Uniswap Protocol Fee system, searchers can permissionlessly capture value from the system by receiving assets valued greater than the UNI tokens provided to the system.

The simplest way to interact with the system is calling Firepit.release() from a wallet.

It is possible to interact with the Firepit contract via a custom smart contract to enable:
- UNI token flash loans
- Uniswap v2 LP Token redemptions
- Uniswap v3 Fee collection
- slippage / balance checks

## Steps

1. **Acquire a sufficient amount of UNI.** The Firepit contract requires integrators to hold a minimum amount of UNI to call release(). Participants can view the threshold by calling Firepit.threshold().

2. **Approve the Firepit to spend UNI.** Because the Firepit contract transfers UNI to address(0xdead), integrating addresses must first approve the contract to spend their UNI.

3. **Read the Nonce.** The Firepit contract uses a nonce as a safety mechanism to avoid malicious front-running. The value provided to release(...) must be equal to the value in contract storage.

4. **Call Firepit.release().** Once the value of the assets exceeds the value of the UNI tokens, integrators should call Firepit.release() with the nonce, assets array, and recipient address.
