---
type: entity
subtype: network
name: Solana
status: live
launched: 2020-Q1
sources_count: 2
last_reviewed: 2026-04-28
disputed: false
---

# Solana

> High-throughput L1 blockchain with ~400ms slot times; hosts Drift Protocol as a native Solana program.

## Snapshot
- Consensus: Proof-of-Stake with Tower BFT + Proof-of-History
- Slot time: ~400ms[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions]
- VM: Solana BPF (SBF)

## Mechanism

Solana is referenced in the Drift wiki as the single-chain deployment target for Drift Protocol[^drift-docs-2026-04-28-index][^drift-developers-docs-2026-04-28-developers-concepts-account-model]. Drift's account model (State, PerpMarketAccount, SpotMarketAccount, UserAccount, UserStatsAccount) is implemented as a native Solana program[^drift-developers-docs-2026-04-28-developers-concepts-account-model]. JIT auction timing (10 slots ~ 5s) is derived from Solana's ~400ms slot cadence[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions].

## Relations
- [[entities/perpdex/drift]] **runs_on** [[entities/network/solana]][^drift-docs-2026-04-28-index]

## Open questions
- Solana network-level details (validator count, stake distribution, MEV landscape) are out of scope for this snapshot.

## Disputed claims
None.

## Related
[[entities/perpdex/drift]]

## Sources
[^drift-docs-2026-04-28-index]: [[sources/drift-docs-2026-04-28-index]]
[^drift-developers-docs-2026-04-28-developers-concepts-account-model]: [[sources/drift-developers-docs-2026-04-28-developers-concepts-account-model]]
[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions]]
