# State Account - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/program/state/state-account

# State Account

> Global state account in Drift Protocol

The State account stores global protocol configuration and parameters.

## Account Structure

The State account is defined in `programs/drift/src/state/state.rs`.

### Key Fields

Protocol admin public key

Global exchange status (active, paused, etc.)

Oracle validation parameters

## Oracle Guard Rails

- `slotsBeforeStaleForAmm`: Slots before oracle is stale
- `confidenceIntervalMaxPercentDivergence`: Max confidence as % of price
- `priceDivergence`: Mark/oracle divergence limits

Number of users with accounts

Total number of sub-accounts

Perpetual market fee configuration

Spot market fee configuration

Maximum fee for initializing a user account

## Fee Structure

```rust
pub struct FeeStructure {
    pub fee_tiers: [FeeTier; 10],
    pub filler_reward_structure: OrderFillerRewardStructure,
    pub referrer_reward_epoch_upper_bound: u64,
    pub flat_filler_fee: u64,
}

```

Fee tiers are based on 30-day trading volume.

## Access via SDK

```typescript
import { DriftClient } from '@drift-labs/sdk';

const state = driftClient.getStateAccount();
console.log('Exchange status:', state.exchangeStatus);
console.log('Oracle guard rails:', state.oracleGuardRails);

```

## DriftClient API

Access state via SDK

## Program Architecture

Architecture overview
