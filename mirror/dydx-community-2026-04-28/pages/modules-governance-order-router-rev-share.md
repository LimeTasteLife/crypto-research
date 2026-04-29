# Order Router Rev Share (Governance)

Source: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/order-router-rev-share

Order Router Rev Share enables third-party order routers to direct orders to dYdX and earn a portion of the trading fees (maker and taker).

For detailed technical specifications, including integration steps, see [Order Router Rev Share docs](https://docs.dydx.xyz/interaction/integration/integration-revshare).

## Governance

Below is the example JSON for the Order Router Rev Share. To enable an Order Router Rev Share, the interested party must submit a governance proposal and obtain approval from the dYdX community. The steps are generally in line with the Proposal Lifecycle.

```json
{
  "messages": [
    {
      "@type": "/dydxprotocol.revshare.MsgSetOrderRouterRevShare",
      "authority": "dydx10d07y265gmmuvt4z0w9aw880jnsr700jnmapky",
      "order_router_rev_share": {
        "address": "{Insert}",
        "share_ppm": 500000
      }
    }
  ],
  "deposit": "2000000000000000000000adydx",
  "metadata": "",
  "title": "Add order router rev share for {Insert}",
  "summary": "Add order router rev share for {Insert}"
}
```
