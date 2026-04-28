# Oracle Integration
URL: https://mintlify.com/drift-labs/protocol-v2/guides/oracle-integration

# Oracle Integration

```typescript
const oracleData = driftClient.getOracleDataForPerpMarket(marketIndex);
console.log(oracleData.price.toString());     // raw BN
console.log(oracleData.confidence.toString());

// Always check validity
if (!oracleData.hasSufficientNumberOfDataPoints) {
  // Skip; oracle invalid
  return;
}

// MM oracle data (preferred for market makers; includes isValid + slot)
const mmData = driftClient.getMMOracleDataForPerpMarket(marketIndex);
if (!mmData.isValid) return;
```

## Pull oracles (Pyth Pull / Pyth Lazer)

Pull oracles require submitting a price update in the same transaction as your trade. The SDK handles this transparently when configured properly:

```typescript
const driftClient = new DriftClient({
  connection, wallet,
  oracleInfos: [
    { publicKey: pythPullOraclePda, source: OracleSource.PYTH_PULL },
  ],
});
```

## Spread on oracle for margin

For long: `marginPrice = oraclePrice - offset`
For short: `marginPrice = oraclePrice + offset`
`offset = min(maxSpread * oraclePrice, confidence + baseSpread * oraclePrice)`

This conservative pricing is built into User margin calculations.
