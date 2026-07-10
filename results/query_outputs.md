# Query Outputs

Actual results from each query in `sql/`, so the findings in
[`findings.md`](findings.md) can be verified without cloning the repo or
running anything. Each section links to the query that produced it.

## `sql/02_cycle_time_by_category_priority.sql`

**2a. Average resolution time by category**

| Category | Resolved tickets | Avg resolution (hrs) |
|---|---|---|
| Delivery / Shipping | 137 | 68.7 |
| Feature Request | 168 | 61.7 |
| General Inquiry | 88 | 59.8 |
| Complaint | 70 | 58.9 |
| Billing | 327 | 58.4 |
| Account Access | 224 | 57.4 |
| Refund / Return | 136 | 56.9 |
| Technical Issue | 301 | 54.9 |

**2b. Resolution time and SLA breach rate by priority**

| Priority | Resolved tickets | Avg resolution (hrs) | SLA breach % |
|---|---|---|---|
| Critical | 108 | 9.0 | 90.7% |
| High | 339 | 23.8 | 48.4% |
| Medium | 560 | 52.8 | 23.9% |
| Low | 444 | 105.4 | 40.3% |

## `sql/03_sla_breach_analysis.sql`

**3a. Overall SLA breach rate:** 39.6%

**3b. Breach rate and average overshoot by priority**

| Priority | SLA target (hrs) | Resolved tickets | Avg resolution (hrs) | Breach % | Avg overshoot when breached (hrs) |
|---|---|---|---|---|---|
| Critical | 4 | 108 | 9.0 | 90.7% | 5.6 |
| High | 24 | 339 | 23.8 | 48.4% | 7.8 |
| Low | 120 | 444 | 105.4 | 40.3% | 29.8 |
| Medium | 72 | 560 | 52.8 | 23.9% | 8.9 |

## `sql/04_backlog_snapshot.sql`

**4a. Unresolved tickets by status**

| Status | Count |
|---|---|
| In Progress | 306 |
| Open | 243 |

**4b. Unresolved tickets by priority**

| Priority | Unresolved | % of backlog |
|---|---|---|
| Critical | 43 | 7.8% |
| High | 119 | 21.7% |
| Medium | 220 | 40.1% |
| Low | 167 | 30.4% |

## `sql/05_escalation_reopen_by_category.sql`

| Category | Tickets | Escalation % | Reopen % |
|---|---|---|---|
| Billing | 443 | 7.0% | 7.9% |
| Refund / Return | 176 | 6.3% | 8.5% |
| Complaint | 97 | 6.2% | 5.2% |
| Account Access | 295 | 6.1% | 11.2% |
| Feature Request | 245 | 5.3% | 7.8% |
| Delivery / Shipping | 198 | 5.1% | 8.1% |
| Technical Issue | 419 | 4.8% | 8.6% |
| General Inquiry | 127 | 4.7% | 4.7% |

## `sql/06_monthly_volume_trend.sql`

| Month | Created | Month-over-month change |
|---|---|---|
| 2024-01 | 118 | — |
| 2024-02 | 128 | +10 |
| 2024-03 | 122 | -6 |
| 2024-04 | 102 | -20 |
| 2024-05 | 145 | +43 |
| 2024-06 | 117 | -28 |
| 2024-07 | 94 | -23 |
| 2024-08 | 107 | +13 |
| 2024-09 | 102 | -5 |
| 2024-10 | 112 | +10 |
| 2024-11 | 114 | +2 |
| 2024-12 | 99 | -15 |
| 2025-01 | 106 | +7 |
| 2025-02 | 114 | +8 |
| 2025-03 | 107 | -7 |
| 2025-04 | 103 | -4 |
| 2025-05 | 104 | +1 |
| 2025-06 | 106 | +2 |
