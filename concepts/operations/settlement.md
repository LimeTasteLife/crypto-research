---
type: concept
domain: operations
name: Settlement
last_reviewed: 2026-04-28
disputed: false
---

# Settlement

## Definition
Settlement is the finality stage at which a trade, transfer, or bridging event becomes irrevocable on the venue's books. Settlement guarantees depend on the venue's consensus model (probabilistic vs deterministic) and on the bridge architecture for asset deposits and withdrawals.

## Mechanism on Hyperliquid

**On-chain trade finality.** HyperCore order/cancel/trade/liquidation events have **one-block finality** inherited from HyperBFT — the BFT consensus deterministically commits the block, so trade outcomes are not subject to reorg[^hl-docs-2026-04-27-hyperliquid-docs].

**Clearinghouse role.** The perps clearinghouse manages per-address margin state (balance + positions), and the spot clearinghouse manages per-address spot user state (token balances + holds)[^hl-docs-2026-04-27-hypercore-clearinghouse]. Both are part of HyperCore execution state.

**Bridge settlement.** USDC moves between Hyperliquid and [[entities/network/arbitrum]] via a validator-signed bridge[^hl-docs-2026-04-27-hypercore-bridge]:
- **Deposits** credit when more than 2/3 of stake-weighted validators sign[^hl-docs-2026-04-27-hypercore-bridge].
- **Withdrawals** are deducted immediately from L1 balance; validators sign as separate transactions; ≥2/3 signing power is required to send the EVM finalization tx[^hl-docs-2026-04-27-hypercore-bridge].
- A **dispute period** exists between withdrawal request and finalization; the bridge can be **locked** during this window via cold-wallet 2/3 validator signatures to halt malicious withdrawals[^hl-docs-2026-04-27-hypercore-bridge].
- Bridge audit by Zellic, with public reports[^hl-docs-2026-04-27-hypercore-bridge].

## Variants in the wild

| venue | trade finality | bridge model | dispute window |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | one-block BFT[^hl-docs-2026-04-27-hyperliquid-docs] | validator-multisig (≥2/3 stake-weighted)[^hl-docs-2026-04-27-hypercore-bridge] | yes; cold-wallet 2/3 lock[^hl-docs-2026-04-27-hypercore-bridge] |
| [[entities/perpdex/aster]] | Aster Chain L1 with 50ms block latency target; explicit block-finality semantics not surfaced (primary docs)[^aster-docs-2026-04-28-overview-what-is-aster] | multi-chain Treasury contracts on BNB Chain / Ethereum / Solana / Arbitrum; ALP mintable on BNB Chain and Arbitrum; bridge architecture (signer set, threshold, dispute model) not surfaced (primary docs); audit page lists no L1 / matching-engine / bridge audit — only Vault/Earn/asBNB/asUSDF/USDF/asCAKE contracts dated 2024[^aster-docs-2026-04-28-overview-smart-contracts][^aster-docs-2026-04-28-overview-audit-reports] | not surfaced (primary docs) — no documented withdrawal dispute window or emergency-pause authority across the four-network Treasury surface[^aster-docs-2026-04-28-overview-smart-contracts] |
| [[entities/perpdex/orderly]] | Orderly L2 (chainID 291) settlement chain; trade finality semantics not surfaced[^orderly-docs-2026-04-29-addresses] | unified Vault address across 17 EVM chains + Solana; deposit/withdrawal via smart contract rails; multi-collateral on Ethereum (USDC/USDT/YUSD/WBTC/USD1)[^orderly-docs-2026-04-29-addresses] | not surfaced (primary docs) — no documented dispute window or emergency-pause authority[^orderly-docs-2026-04-29-addresses] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Edge cases
- The cold-wallet bridge-lock procedure is the venue's emergency stop for fraudulent withdrawals, but it requires social coordination among validators — operational risk if validators are unreachable.

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/hyperliquid]] · [[concepts/operations/sequencer]] · [[parameters/hyperliquid/validator-requirements]]

## Sources
[^hl-docs-2026-04-27-hyperliquid-docs]: [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
[^hl-docs-2026-04-27-hypercore-clearinghouse]: [[sources/hl-docs-2026-04-27-hypercore-clearinghouse]]
[^hl-docs-2026-04-27-hypercore-bridge]: [[sources/hl-docs-2026-04-27-hypercore-bridge]]
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
[^aster-docs-2026-04-28-overview-smart-contracts]: [[sources/aster-docs-2026-04-28-overview-smart-contracts]]
[^aster-docs-2026-04-28-overview-audit-reports]: [[sources/aster-docs-2026-04-28-overview-audit-reports]]
[^orderly-docs-2026-04-29-addresses]: [[sources/orderly-docs-2026-04-29-addresses]]
