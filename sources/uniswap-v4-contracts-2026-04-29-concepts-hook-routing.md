---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-hook-routing
title: Integrated Routing with UniswapX
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://developers.uniswap.org/docs/protocols/v4/concepts/hook-routing
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-hook-routing.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Integrated Routing with UniswapX

## TL;DR
Hook builders can get immediate access to flow from the Uniswap Interface by running a UniswapX filler for their hooked pools. Process: (1) subscribe to UniswapX RFQ system and submit fillable bids, (2) listen to public feed for won/open orders, (3) execute against hooked pools. Hook allowlisting requires an application form. Broader hook routing via the standard routing system will ramp up progressively.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Hook builders can get immediate flow from Uniswap Interface by running a UniswapX filler for hooked pools | [[entities/dex/uniswap-v4]] | - |
| #c2 | UniswapX filler integration requires subscribing to RFQ system, listening to public order feed, and executing against hooked pools | [[entities/dex/uniswap-v4]] | - |
| #c3 | Hook allowlisting requires an application form; current allowlisted hooks are publicly listed | [[parameters/uniswap-v4/governance-params]] | - |

## Conflicts raised
None.
