# Swaps (Jupiter) – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/swaps

# Swaps (Jupiter)

You can route spot swaps using Jupiter directly from your Drift account. The SDK fetches a Jupiter quote, builds the swap transaction, and routes it so the input and output tokens flow through your Drift spot balances.

To perform spot swaps, initialize a `JupiterClient` with your RPC connection:

```typescript
import { Connection } from "@solana/web3.js";
import { JupiterClient } from "@drift-labs/sdk";

const connection = new Connection("<RPC_URL>", "confirmed");
const jupiterClient = new JupiterClient({ connection });
```

Before executing a swap, preview the expected output and route with `getQuote()`:

```typescript
const quote = await jupiterClient.getQuote({
  inputMint: "<INPUT_MINT>",
  outputMint: "<OUTPUT_MINT>",
  amount: "<AMOUNT_IN_BASE_UNITS>",
});
```

Execute the swap through Drift:

```typescript
const txSig = await driftClient.swap({
  jupiterClient,
  inMarketIndex: 0,  // e.g. USDC
  outMarketIndex: 1, // e.g. SOL
  amount: driftClient.convertToSpotPrecision(0, 10), // 10 USDC
  slippageBps: 50,         // 0.5% max slippage
  onlyDirectRoutes: false, // allow multi-hop routes
});
```

Parameters:

| Parameter | Description | Default |
| --- | --- | --- |
| `jupiterClient` | Instance of JupiterClient for fetching quotes | required |
| `inMarketIndex` | Drift spot market index for the input token | required |
| `outMarketIndex` | Drift spot market index for the output token | required |
| `amount` | Amount to swap as a BN in spot market precision | required |
| `slippageBps` | Maximum allowed slippage in basis points | 50 |
| `onlyDirectRoutes` | If true, restricts to direct token pairs only | false |
| `computeUnits` | Override for compute budget | optional |
| `prioritizationFeeMicroLamports` | Priority fee in micro-lamports | optional |

Last updated on February 27, 2026
