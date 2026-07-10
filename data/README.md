# Data Source

**File:** `support_tickets.csv`
**Source:** Kaggle — synthetic customer support ticket dataset
**Rows:** 2,000 tickets
**Date range:** 2024-01-01 to 2025-06-30

## Why this dataset

Needed a dataset with genuine sequential timestamps (created → resolved) to
support cycle-time and bottleneck analysis. This was the third candidate
evaluated:

1. Multilingual support ticket dataset (28k rows) — rejected, no timestamp
   fields at all (text-classification dataset, not workflow data).
2. Suraj Subramaniam's "Customer Support Ticket Dataset" (8.4k rows) —
   rejected, timestamps were synthetic noise (resolution times sometimes
   preceded first-response times; all clustered around a single day
   regardless of ticket age).
3. This dataset — accepted. `resolved_at` is always after `created_at`,
   `resolution_time_hrs` matches the computed duration between the two
   exactly, and timestamps are spread realistically across an 18-month
   window.

## Caveat

This is a synthetic dataset (sequential `TKT-#####` IDs, generated agent
names), not scraped production data. Good enough to demonstrate SQL/analysis
technique and tell a coherent workflow story — not presented as real-world
support data.

## Columns used

| Column | Type | Notes |
|---|---|---|
| ticket_id | text | primary key |
| created_at / resolved_at | datetime | resolved_at is null for unresolved tickets |
| status | text | Open, In Progress, Resolved, Closed, Escalated |
| category / subcategory | text | e.g. Billing, Technical Issue, Account Access |
| priority | text | Low, Medium, High, Critical |
| channel | text | e.g. email, chat, phone |
| region, customer_plan, product | text | segmentation fields |
| resolution_time_hrs / first_response_time_hrs | float | pre-computed durations |
| escalated / reopened | bool | workflow-quality signals |
| csat_score | float | customer satisfaction, where available |
| num_interactions | int | back-and-forth count before resolution |
