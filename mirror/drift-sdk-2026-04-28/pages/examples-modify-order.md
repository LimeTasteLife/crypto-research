# Modify Order
URL: https://mintlify.com/drift-labs/protocol-v2/examples/modify-order

# Modify Order

```typescript
// By order id
await driftClient.modifyOrder({
  orderId,
  newBaseAmount: driftClient.convertToPerpPrecision(2),
  newLimitPrice: driftClient.convertToPricePrecision(101.5),
});

// By user-defined order id
await driftClient.modifyOrderByUserOrderId({
  userOrderId,
  newBaseAmount: driftClient.convertToPerpPrecision(2),
});
```

Pass `null` to clear a field. Use `policy: ModifyOrderPolicy.MustModify` to make the transaction fail if the order cannot be modified, or `ExcludePreviousFill` to ignore fills in the same slot.
