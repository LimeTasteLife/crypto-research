---
type: source
id: uniswap-v4-protocol-fee-2026-04-29-guides-getting-started
title: Protocol Fee Get Started
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/protocol-fee/guides/getting-started
mirror_snapshot: uniswap-v4-protocol-fee-2026-04-29
mirror_page: pages/guides-getting-started.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Protocol Fee Get Started

## TL;DR
Searchers can permissionlessly capture value from the protocol fee system by receiving assets valued greater than the UNI tokens they burn. Steps: (1) acquire minimum UNI threshold (viewable via Firepit.threshold()), (2) approve Firepit to spend UNI (it burns to 0xdead), (3) read the nonce (safety mechanism against front-running), (4) call Firepit.release() with nonce, assets array, and recipient. Custom contract integration enables UNI flash loans, v2 LP token redemptions, v3 fee collection, and slippage/balance checks.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Searchers permissionlessly capture value by burning UNI to receive collected fee assets worth more than UNI burned | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c2 | Firepit burns UNI to address(0xdead) — permanent supply reduction | [[concepts/tokenomics/buyback]] | - |
| #c3 | Firepit.threshold() returns the minimum UNI amount required for release | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c4 | Nonce mechanism prevents front-running; must be read off-chain and passed as calldata | [[parameters/uniswap-v4/protocol-fee-config]] | - |

## Conflicts raised
None.
