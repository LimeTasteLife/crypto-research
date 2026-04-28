# Multi-Asset Margin | Lighter Docs

URL: https://docs.lighter.xyz/trading/multi-asset-margin

# Multi-Asset Margin

Multi-Asset Margin enables users to use non-USDC assets as margin for trading. Users deposit supported assets (e.g. ETH) into their margin balance, and the value of these assets — discounted by a haircut — counts toward the account's total margin. This allows users to trade perpetual futures and spot markets using their existing holdings without first converting to USDC.

Multi-Asset Margin offers convenience when it comes to margin usage. That said, as we add ETH as the first asset to be used for this feature, and as we roll out more assets with time, we want to be conscious in our approach with conservative user and global supply limits, which can be found within this section.

Multi-Asset Margin is available exclusively to accounts with Unified Trading Accounts enabled.

> USDC spot trading with non-USDC collateral isn't included at launch—coming soon. At release, Multi-Asset Margin supports perpetual futures only, and we'll share updates ahead of each new rollout.

> When no non-USDC margin assets are held, Multi-Asset Margin accounts behave identically to standard cross-margin accounts. All existing margin calculations remain unchanged.

---

#### How It Works

1. A user deposits a supported asset (e.g. ETH) into their margin balance.
2. The asset's value, discounted by LTV, is added to the account's Total Account Value.
3. The account can use this value to open perpetual futures positions, execute spot trades, or both.
4. A single health check monitors the account continuously using the Total Account Liquidation Threshold.
5. If the account's health falls below the Maintenance Margin Requirement, liquidation is triggered — for both perp positions and spot margin assets in a unified flow.

Example Use Cases

- Basis trade: A user deposits ETH as margin and opens a short ETH perpetual position. The spot ETH and the short perp offset each other, creating a delta-neutral position that earns funding.
- Leveraged spot: A user deposits ETH, and uses the additional margin to buy more ETH on the spot market — effectively creating a leveraged long.

---

### Margin Assets

Each margin-enabled asset is configured with the following parameters:

| Parameter | Description |
| --- | --- |
| LTV | Loan-to-Value ratio. Determines how much of the asset's value counts toward Total Account Value. |
| LT | Liquidation Threshold. Determines how much of the asset's value counts toward Total Account Liquidation Threshold. Always greater than or equal to LTV. |
| LF | Liquidation Factor. Determines the minimum value the user receives per unit of collateral during liquidation. Always greater than or equal to LT. |
| Liquidation Fee | Maximum fee paid when spot collateral is seized during liquidation. Capped so that the user always receives at least the LF discounted value. |
| User Supply Cap | Maximum amount a single user can hold as margin (in asset units). |
| Global Supply Cap | Maximum total amount held as margin across all users. |

---

### Total Account Value

Total Account Value (TAV) represents the risk-adjusted value of the entire account. It extends the existing Total Account Value by including non-USDC margin assets discounted by their LTV:

$$
\text{TAV}(\text{USDC}) = \text{PortfolioBalance}(\text{USDC}) + \sum_{j} \text{LTV}_j \times \text{MarginBalance}_j \times \text{IndexPrice}_j
$$

Where Portfolio Balance is the USDC value of the account including unrealized PnL on perpetual positions, as defined in the pnl-and-total-account-value section.

Total Account Value is used for all risk checks when opening new positions or placing orders.

### Total Account Liquidation Threshold

Total Account Liquidation Threshold (TALT) represents the account's value under the less conservative LT discount. It is used to determine when the account enters liquidation:

$$
\text{TALT}(\text{USDC}) = \text{PortfolioBalance}(\text{USDC}) + \sum_{j} \text{LT}_j \times \text{MarginBalance}_j \times \text{IndexPrice}_j
$$

$$
\text{TALT} \geq \text{TAV}
$$

---

### Health Checks

Multi-Asset Margin accounts use a single unified health check that covers both perpetual positions and spot margin assets. The margin requirements IMR, MMR, and CMR remain unchanged from the existing contract specifications.

$$
\begin{aligned}
\textbf{Healthy:} \quad & \text{TAV} \geq \text{IMR} \\
\textbf{Pre-Liquidation:} \quad & \text{TALT} \geq \text{MMR} \quad \text{and} \quad \text{TAV} < \text{IMR} \\
\textbf{Partial Liquidation:} \quad & \text{TALT} < \text{MMR} \quad \text{and} \quad \text{TALT} \geq \text{CMR} \\
\textbf{Full Liquidation:} \quad & \text{TALT} < \text{CMR}
\end{aligned}
$$

In pre-liquidation, only operations that improve the account's health ratio and reduce position size are permitted. When TALT falls below MMR, both perpetual positions and spot margin assets become eligible for liquidation in a unified flow.

> When no non-USDC margin assets are held, TAV and TALT both reduce to Portfolio Balance (USDC). The health check becomes identical to the existing cross-margin system.

---

### Liquidation

$$
(\text{TALT} < \text{MMR})
$$

#### Perp Zero Price

The perp zero price is modified to account for the value of non-USDC margin assets, properly maintaining the health ratio as an invariant.

$$
\text{ZeroPrice}_i(\text{long}) = \text{markPrice}_i \times \left(1 - \frac{M_i \times \text{TALT}}{\text{MMR}}\right) \\
\text{ZeroPrice}_i(\text{short}) = \text{markPrice}_i \times \left(1 + \frac{M_i \times \text{TALT}}{\text{MMR}}\right)
$$

This ensures that executing a perp trade at the zero price preserves the account's health ratio. When no non-USDC margin assets are held, TALV reduces to Portfolio Balance and the formulas are identical to the standard zero price.

#### Spot Zero Price

When partially liquidating a spot margin asset, the exchange sends an Immediate-or-Cancel (IoC) order to the spot order book on behalf of the user. The zero price for a spot asset is:

$$
\text{SpotZeroPrice}_j = \text{IndexPrice}_j \times \text{LF}_j
$$

The liquidation fee is collected up to the configured amount, with the constraint that the user receives at least the LF-discounted value in USDC for each unit of collateral sold. This ensures that liquidation execution is always at least as favorable as the LF price.
