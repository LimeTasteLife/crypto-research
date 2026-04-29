---
type: source
id: uniswap-v4-protocol-fee-2026-04-29-overview
title: Protocol Fee Overview
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/protocol-fee/overview
mirror_snapshot: uniswap-v4-protocol-fee-2026-04-29
mirror_page: pages/overview.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Protocol Fee Overview

## TL;DR
The Uniswap Protocol Fee system collects fees from all protocol versions (v2, v3, v4, UniswapX, Unichain) through version-specific Fee Adapter contracts, routing them to a per-chain immutable TokenJar. Releasers define how collected assets are released — the primary releaser (Firepit) burns UNI in exchange for collected tokens. Governance can update which Releaser a TokenJar uses and adjust Fee Adapter configuration, but core contracts (TokenJar) are immutable. Real-world mechanics: when top N assets in TokenJar exceed ~100 UNI value, anyone can call Firepit.release() to burn 100 UNI and withdraw those assets.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Fees from v2, v3, v4, UniswapX, and Unichain flow through Fee Adapter contracts to a single per-chain TokenJar | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c2 | TokenJar is an immutable contract; only the active Releaser can withdraw from it | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c3 | Firepit Releaser burns UNI in return for collected fee assets | [[concepts/tokenomics/buyback]] | - |
| #c4 | Governance can update which Releaser a TokenJar uses and adjust Fee Adapter configuration | [[parameters/uniswap-v4/governance-params]] | - |
| #c5 | When top N assets in TokenJar exceed ~100 UNI in value, anyone can call Firepit.release() to burn 100 UNI and withdraw those assets | [[parameters/uniswap-v4/protocol-fee-config]] | - |

## Conflicts raised
None.
