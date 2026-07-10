# Support Ticket Workflow Diagnostics

This project analyzes a support ticket dataset with SQL to answer the
questions a workflow consultant would ask: where does the process stall,
which SLA tiers are actually failing, and is the backlog concentrated in
the tickets that matter most? It showcases business-oriented SQL analysis
(window functions, CTEs, derived views) applied to a workflow-diagnosis
problem — not just query syntax, but turning query output into a
prioritized, numbers-backed recommendation.

**Tech:** SQLite · SQL (window functions, CTEs, views) · Python (load script only)

## Problem

Support/ticket-style workflows (customer service, IT helpdesk, or — by
analogy — a content/campaign approval pipeline) all share the same failure
modes: work piles up in one stage, urgent items don't actually move faster
than routine ones, and issues get closed before they're really fixed. This
project diagnoses those failure modes in a ticket dataset by answering:

1. Where in the workflow does resolution take longest, and does that
   correlate with urgency (priority)?
2. Which priority tiers are breaching their service targets, and by how
   much?
3. How large is the current backlog, and is it concentrated in
   high-priority work (bad) or routine work (less bad)?
4. Which categories have the worst "first-contact resolution" quality —
   i.e., get escalated or reopened rather than closed cleanly?
5. Is ticket volume growing (a scaling problem) or flat (an efficiency
   problem)?

## Data

- Source: Kaggle, synthetic customer support ticket dataset (2,000 rows,
  Jan 2024 - Jun 2025). See `data/README.md` for the full evaluation of why
  this dataset was chosen over two other candidates that lacked usable
  timestamps.
- Key fields: `created_at`, `resolved_at`, `status`, `category`, `priority`,
  `escalated`, `reopened`, `resolution_time_hrs`.

## Approach

1. Loaded the CSV into SQLite via `scripts/load_db.py` against the schema
   in `sql/00_schema.sql`.
2. Built a `tickets_clean` view (`sql/01_clean_view.sql`) adding an
   `is_resolved` flag and an **assumed** SLA target by priority (Critical
   4h / High 24h / Medium 72h / Low 120h — documented as an assumption
   since the raw data has no SLA column) and a derived `sla_breached` flag.
3. Wrote five diagnostic queries (`sql/02` - `sql/06`), one per business
   question above, using window functions (`LAG`) and aggregate CTEs
   throughout.
4. Turned raw query output into findings with a "so what" — see
   `results/findings.md`.

## Results

- **Critical-priority tickets breach SLA 90.7% of the time** despite
  resolving fastest in absolute terms (9.0 hrs avg) — the 4-hour target is
  mismatched to actual process speed, not a simple "too slow" problem.
- Overall SLA breach rate: **39.6%** across all resolved tickets.
- High-priority tickets meet their *average* target (23.8 vs 24 hrs) but
  still breach **48.4%** of the time — a heavy-tail distribution problem
  hidden by the average.
- Backlog (549 tickets, 27.5% of all tickets) skews toward Medium/Low
  priority (70.5% combined) rather than Critical (7.8%) — urgent work
  isn't the piece getting stuck.
- Account Access has the highest reopen rate (11.2%) — a signal tickets
  are being closed before they're actually resolved, distinct from
  Billing's higher escalation rate (7.0%).

Full numbers and the resulting prioritized recommendation in
`results/findings.md`.

## What I'd do next

- Pull in agent-level data to see if the SLA breach pattern concentrates
  on specific agents/teams vs. being systemic
- Model a realistic queueing/staffing scenario to test whether the fix is
  process redesign or added capacity
- If this were a live system: instrument the *actual* SLA targets instead
  of assuming them, and track breach rate as an ongoing metric, not a
  one-time analysis

## How to run this

```bash
git clone <repo-url>
cd sql-support-ticket-workflow-analysis
pip install pandas
python scripts/load_db.py          # builds tickets.db from data/support_tickets.csv
sqlite3 tickets.db < sql/02_cycle_time_by_category_priority.sql
# ...or open tickets.db in any SQLite client and run sql/02 - sql/06 directly
```

## Repo structure

```
data/         — source CSV + README documenting provenance and caveats
sql/          — schema, view, and 5 diagnostic queries (numbered, run in order)
scripts/      — load_db.py, rebuilds tickets.db from the CSV
results/      — findings.md, the write-up of what the queries found
```

`tickets.db` is a generated artifact (not committed — see `.gitignore`);
regenerate it locally with `scripts/load_db.py`.
