# How Staking Works

Source: https://docs.asterdex.com/aster-chain/staking/how-staking-works

### Creating a Staking Position

To participate in staking:

1. Connect your wallet and navigate to the staking page
2. Select a validator and click Stake button
3. Enter the amount of $ASTER to stake
4. Choose a lock period
5. Confirm the transaction

Once confirmed, the staking position becomes active and begins earning rewards in future Epochs.

### Rewards Pool per Epoch

Emissions per Epoch at launch:

- Base Rewards pool: 150,000 $ASTER
- Loyalty Rewards pool: 300,000 $ASTER

#### Base APY

Base APY is the foundational reward layer tied to validator performance. Each validator receives a share of the Base APY pool proportional to the transactions it processes.

Validator reward calculation:

Validator Share = Validator Transactions ÷ Total Network Transactions

Validator Reward = Base APY Pool × Validator Share

Example:

If the Base APY pool is 100 $ASTER and a validator processes 40% of network transactions:

Validator Reward = 100 × 40% = 40 ASTER

#### Your Share of Base APY

After the validator receives its reward, users earn proportionally based on their stake within that validator.

User Base Reward Formula:

User Reward = Validator Reward × (User Stake ÷ Total Validator Stake) × (1 − Validator Commission)

Example:

| Parameter | Value |
| --- | --- |
| Validator Reward | 40 |
| Total Validator Stake | 10,000,000 $ASTER |
| User Stake | 500,000 $ASTER |
| Commission | 10% |

User stake ratio = 500,000 ÷ 10,000,000 = 5%

After commission = 5% × (1 − 10%) = 4.5%

User reward = 40 × 4.5% = 1.8 ASTER

#### Loyalty Rewards

Loyalty Rewards are designed to reward long-term commitment. The longer you lock, the more you earn.

Reward weight is determined using veASTER and a Trading Volume Boost.

Power formula:

Power = veASTER × Boost

Where:

veASTER = Locked Amount × Time Weight

Time Weight = Remaining Lock Duration ÷ Maximum Lock Duration

Maximum lock duration = 208 weeks (approximately 4 years)

---

### Trading Volume Boost

Your reward weight can be boosted based on your personal trading volume within each Epoch.

| Your Epoch Trading Volume | Boost |
| --- | --- |
| > 500K | 1.05 |
| > 50M | 1.15 |
| > 200M | 1.25 |

---

### Loyalty Rewards Distribution

Loyalty Rewards are distributed proportionally based on Power share.

User Weekly Reward:

User Reward = Weekly Loyalty Pool × (User Power ÷ Total Network Power)

Example:

| Parameter | Value |
| --- | --- |
| Weekly Loyalty Pool | 100,000 $ASTER |
| Total Network Power | 1,000,000 |
| User Power | 5,000 |

User share = 5,000 ÷ 1,000,000 = 0.5%

User reward = 100,000 × 0.5% = 500 $ASTER

---

### Epoch Settlement

Rewards are calculated and distributed using weekly Epoch cycles. Each Epoch runs Monday through Sunday. A snapshot of staking data is taken at Monday 00:00 UTC.

| Event | Timing |
| --- | --- |
| Epoch Start | Monday 00:00 UTC |
| Snapshot | Monday 00:00 UTC |
| Settlement | Sunday 00:00 UTC |

Operations that take effect in the next Epoch include:

- New stake deposits
- Additional stake top-ups
- Lock extensions
- Redeem requests
