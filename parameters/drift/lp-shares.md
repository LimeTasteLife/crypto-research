---
type: parameter
entity: [[drift]]
parameter: lp-shares
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift LP shares

## Current (as of 2026-04-28)

**vAMM LP (lpShares).** Users can LP into the vAMM to provide additional collateral; the user's effective position is transferred to the AMM[^drift-docs-2026-04-28-protocol-about-v3][^drift-sdk-docs-2026-04-28-concepts-positions].

**Yield.** LP earns a portion of trading fees and shares AMM PnL (positive or negative)[^drift-docs-2026-04-28-protocol-about-v3][^drift-sdk-docs-2026-04-28-concepts-positions].

**Cooldown.** ~24 hours after add before remove allowed[^drift-sdk-docs-2026-04-28-concepts-positions].

**Backstop AMM Liquidity (BAL).** External passive LP layered onto the v3 vAMM curve as one of three runtime knobs (alongside concentration factor and dynamic spread/peg)[^drift-docs-2026-04-28-protocol-about-v3-drift-amm][^drift-docs-2026-04-28-protocol-about-v3].

**Risk profile.** lpShares LPs bear directional/adverse-selection risk via shared AMM PnL; vAMM widens spread when in debt as inventory-aware adverse-selection signal[^drift-docs-2026-04-28-protocol-about-v3-drift-amm][^drift-sdk-docs-2026-04-28-concepts-positions].

## Time series

| effective | LP type | cooldown | PnL sharing | source |
|---|---|---|---|---|
| 2026-04-28 | vAMM lpShares + BAL | ~24h after add | pro-rata AMM PnL + trading fee share | [^drift-sdk-docs-2026-04-28-concepts-positions][^drift-docs-2026-04-28-protocol-about-v3] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-about-v3]: [[sources/drift-docs-2026-04-28-protocol-about-v3]]
[^drift-docs-2026-04-28-protocol-about-v3-drift-amm]: [[sources/drift-docs-2026-04-28-protocol-about-v3-drift-amm]]
[^drift-sdk-docs-2026-04-28-concepts-positions]: [[sources/drift-sdk-docs-2026-04-28-concepts-positions]]
