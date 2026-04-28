---
type: parameter
programme: [[entities/programme/aster-referral]]
parameter: outcomes
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster Referral programme outcomes

## Current (as of 2026-04-28)

**Default rate.** **10%** commission on referee trading fees, configurably split between referrer and referee — e.g., 5%/5% as a fee discount[^aster-docs-2026-04-28-program-referral]. Referrers can adjust the split at their discretion[^aster-docs-2026-04-28-program-referral].

**Affiliate upgrade path.** High-volume traders can apply for an upgraded commission rate via an application form; approved affiliates receive **20% from referred VIP 1 users** and **10% from referred VIP 2+ users**[^aster-docs-2026-04-28-program-referral].

**Settlement and asset.** Rebates accrue **in real time** and credit to the referrer's Aster account by the **next day**; rates are calculated daily at **00:00 UTC** and updated at **09:00 UTC**[^aster-docs-2026-04-28-program-referral]. Rewards are paid out **in the same asset** the referee used to pay trading fees[^aster-docs-2026-04-28-program-referral]. Referral page statistics carry a **1–2 hour display delay**[^aster-docs-2026-04-28-program-referral].

**Validity window.** Referral relationships are valid for **365 days by default**, extendable at Aster's discretion[^aster-docs-2026-04-28-program-referral]. Only new users who sign up via the referral link are eligible to be counted; there is no upper bound on the number of users a single referrer can invite[^aster-docs-2026-04-28-program-referral].

**Exclusions** (excluded from commission calculations)[^aster-docs-2026-04-28-program-referral]:

- Liquidation fees.
- Self-trade volume.
- Zero-fee trade volume.

**Anti-abuse.** Self-referrals (inviting oneself via multiple accounts) result in **revocation of all rewards** if detected[^aster-docs-2026-04-28-program-referral]. Custom referral codes deemed offensive, misleading, or harmful may result in removal from the program[^aster-docs-2026-04-28-program-referral].

**Discretion.** Aster reserves the right to **modify rates, rules, or cancel** the referral program at any time[^aster-docs-2026-04-28-program-referral]. Referrers are responsible for understanding the legal implications of promoting leveraged trading in their region[^aster-docs-2026-04-28-program-referral].

## Time series

| effective | default rate | VIP1 affiliate rate | VIP2+ affiliate rate | validity | rate calc / update | source |
|---|---|---|---|---|---|---|
| 2026-04-28 | 10% | 20% | 10% | 365 days (extendable) | 00:00 UTC calc / 09:00 UTC update | [^aster-docs-2026-04-28-program-referral] |

## Tiering rules / formulae

- Default commission = `referee_trading_fee × 0.10`, splittable between referrer and referee.
- Affiliate commission = `referee_trading_fee × {0.20 if VIP1; 0.10 if VIP2+}` (after application approval).
- Eligible volume = `referee_trading_fee_volume − liquidation_fees − self_trades − zero_fee_volume`.

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-program-referral]: [[sources/aster-docs-2026-04-28-program-referral]]
