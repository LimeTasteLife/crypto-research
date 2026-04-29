# Protocol Fee Overview

Fees from protocol versions (v2, v3, v4, UniswapX, Unichain) flow into a single onchain collector on each network. From there, specialized contracts handle how those assets are released or transformed (for example, burning UNI).

## Flow of Assets

**Fee Sources:** Each protocol component that generates fees (v2, v3, v4, UniswapX, Unichain, and others) routes those fees through an associated Fee Adapter contract. Adapters define how and when fees are collected and send them to the TokenJar on the same chain.

**TokenJar:** Each chain has one immutable contract called the TokenJar. All fee sources send tokens here. It's the unified collection point for raw tokens.

**Releasers:** Releasers define how tokens in the TokenJar are accessed. The simplest version burns UNI in exchange for the collected tokens. Other Releasers could handle cross-chain conversions or alternative value flows.

**Governance Control:** Governance can update which Releaser a TokenJar uses or adjust configuration on Fee Adapters, but the core contracts themselves are immutable.

## Components

### TokenJar
Immutable contract that receives all tokens from fee sources on a given chain. Only the active Releaser can withdraw from it.

### Fee Adapters
Adapters that connect specific protocol versions or products to the TokenJar. They define how and when fees are collected.

### Releasers
Contracts that convert collected fees into protocol value according to defined logic. Examples include the Firepit Releaser, which burns UNI in return for assets.

## Real-World Example

When the top N assets in the TokenJar are worth slightly more than 100 UNI, anyone is incentivized to use the Firepit.release() contract to:
1. Burn 100 UNI
2. Withdraw the top N assets, valued at slightly more than 100 UNI
