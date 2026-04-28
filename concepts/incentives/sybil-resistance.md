---
type: concept
domain: incentives
name: Sybil resistance
last_reviewed: 2026-04-28
disputed: false
---

# Sybil resistance

## Definition

Sybil resistance in the context of on-chain incentive programs refers to the mechanisms a venue uses to limit the advantage a single user gains by operating multiple accounts (a "sybil attack")[^lighter-docs-2026-04-28-points-program-retail][^aster-docs-2026-04-28-program-trade-and-earn]. A pure sybil attack allows one economic actor to claim N times the share of a fixed-pool reward by splitting activity across N wallets. Resistance can be achieved structurally (caps that prevent per-account rewards from scaling super-linearly), behaviorally (detection that identifies correlated wallet activity), or technically (identity binding that links wallets to verified identities)[^lighter-docs-2026-04-28-points-program-retail].

## Mechanism

Sybil resistance systems operate across three approaches (often combined):

1. **Structural caps**: per-account limits on the metric that earns rewards (e.g., per-account USDF holdings cap), so splitting rewards across N accounts yields the same total as one account up to the cap[^aster-docs-2026-04-28-program-trade-and-earn].

2. **Explicit multi-account tolerance with threshold**: a declared maximum number of accounts per user below which no penalty is applied, above which accounts are flagged[^lighter-docs-2026-04-28-points-program-retail]. This approach tolerates the known practice of multi-account usage (common for MMs and sophisticated traders) while creating a detection boundary.

3. **Behavioral detection**: statistical or machine-learning analysis of correlated wallet behavior (similar funding sources, correlated trade timing, IP address clustering, on-chain graph analysis)[^lighter-docs-2026-04-28-points-program-retail]. Details are typically intentionally undisclosed to prevent gaming of the detection boundary.

## Variants in the wild

| venue | program | approach | multi-account threshold | detection method | penalty |
|---|---|---|---|---|---|
| [[entities/perpdex/lighter]] | [[entities/programme/lighter-points-program]] Retail track | explicit threshold + behavioral detection | ≤10 accounts per user tolerated without penalty; above threshold → flagged[^lighter-docs-2026-04-28-points-program-retail] | mixed automated + semi-automated; specific metrics intentionally undisclosed[^lighter-docs-2026-04-28-points-program-retail] | disqualification; Discord announcement of enforcement[^lighter-docs-2026-04-28-points-program-retail] |
| [[entities/perpdex/aster]] | Trade & Earn | structural cap + behavioral detection | not stated; per-account USDF cap at 100,000 USDF limits splitting incentive[^aster-docs-2026-04-28-program-trade-and-earn] | bulk account creation for bonus farming triggers disqualification[^aster-docs-2026-04-28-program-trade-and-earn] | program disqualification[^aster-docs-2026-04-28-program-trade-and-earn] |

(Hyperliquid row: HL Points sybil-resistance approach not yet surfaced at this granularity from primary docs — to be filled on next HL points-specific ingest pass.)

## Edge cases
- **Tolerance threshold creates a signaling problem.** Lighter's 10-account tolerance means a user operating 10 accounts earns up to 10× the single-account share — tolerance is not resistance. The program tolerates known multi-account use by professional participants (MMs) while attempting to detect coordination beyond the threshold[^lighter-docs-2026-04-28-points-program-retail].
- **Undisclosed boundary defense.** Publishing the detection threshold (e.g., "accounts sharing IP address X or correlated trade patterns") enables coordinated evasion. Lighter explicitly withholds anti-farming metrics "to prevent gaming"[^lighter-docs-2026-04-28-points-program-retail] — trading off transparency for resistance effectiveness.
- **Per-account cap vs. consolidated cap.** Aster caps USDF holdings per account at 100,000 USDF[^aster-docs-2026-04-28-program-trade-and-earn]; without consolidated-account detection, this is defeatable by creating accounts at the cap. This is a structural approach that relies on bulk-account-creation detection to close the loop.

## Disputed claims
None.

## Related
[[concepts/incentives/anti-abuse]] · [[concepts/incentives/points-program]] · [[entities/programme/lighter-points-program]] · [[parameters/lighter/points-rules]]

## Sources
[^lighter-docs-2026-04-28-points-program-retail]: [[sources/lighter-docs-2026-04-28-points-program-retail]]
[^lighter-docs-2026-04-28-points-program]: [[sources/lighter-docs-2026-04-28-points-program]]
[^aster-docs-2026-04-28-program-trade-and-earn]: [[sources/aster-docs-2026-04-28-program-trade-and-earn]]
