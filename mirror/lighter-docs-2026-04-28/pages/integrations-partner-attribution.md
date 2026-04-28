# Partner Attribution | Lighter Docs

URL: https://docs.lighter.xyz/integrations/partner-attribution

# Partner Attribution

The Partner Attribution Program allows third-party integrators to build on top of Lighter and offer its trading infrastructure through their own frontend. Integrators can configure trading fees for users accessing Lighter through their interface, within global limits set by Lighter.

#### Integrator Fees

Integrators may configure fees for both spot and perpetual markets.

Global limits set by Lighter:

- Perpetual markets: up to 10 bps
- Spot markets: up to 1%
- Minimum fee increment: 0.01 bps

#### User Approval

Before fees can be applied, the user must sign a message approving the integrator's fee configuration.

This approval:

- authorizes the integrator to charge the configured fees
- includes an expiry period (if integrator decides to include one)
- can be revoked by the user at any time

The approval has signature requirements depend on whether the integrator and user share the same L1 account.

- Different L1 accounts: L1 approval + L2 confirmation
- Same L1 account: L2 confirmation only

#### Begin your Integration:

API Docs: https://apidocs.lighter.xyz/docs/partner-integration

Python SDK: https://pypi.org/project/lighter-sdk/
