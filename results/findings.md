# Findings

Query results this doc is built from live in `sql/02` through `sql/06`.
Full numbers in the tables below; headline takeaways first.

## Headline

**Critical-priority tickets breach SLA 90.7% of the time — not because
they're handled slowly, but because the target is unrealistic relative to
actual process speed.** Critical tickets resolve fastest of any tier in
absolute terms (9.0 hrs avg) but against a 4-hour target, that's still a
breach nearly every time, averaging 5.6 hours over target. This is a target
-vs-process mismatch, not (only) a speed problem: the fix is either
tightening the actual response process for Critical tickets or setting a
more realistic SLA tier — and knowing which is the useful output of a
workflow diagnosis like this.

Overall SLA breach rate across all resolved tickets: **39.6%.**

## Cycle time by priority

| Priority | Target (hrs, assumed) | Avg resolution (hrs) | SLA breach rate |
|---|---|---|---|
| Critical | 4 | 9.0 | 90.7% |
| High | 24 | 23.8 | 48.4% |
| Medium | 72 | 52.8 | 23.9% |
| Low | 120 | 105.4 | 40.3% |

Two things stand out beyond the Critical-tier headline: High-priority
tickets resolve just under target on average (23.8 vs 24 hrs) yet still
breach SLA 48.4% of the time — meaning the *average* is fine but the
*distribution* has a heavy tail dragging almost half of tickets over. Low
priority also breaches 40.3% of the time despite a generous 120-hour
window, suggesting low-priority tickets get deprioritized past even a loose
target once the queue is under pressure.

## Backlog snapshot

549 of 2,000 tickets (27.5%) are currently unresolved — 306 "In Progress,"
243 "Open." Of that backlog, Medium priority makes up 40.1% and Low 30.4%,
while Critical is only 7.8% — so the backlog is not concentrated in urgent
tickets, which is the good version of this finding: whatever's causing
slow-downs isn't currently stranding the highest-stakes tickets.

## Escalation / reopen quality by category

Billing has both the highest escalation rate (7.0%) and is tied for the
largest ticket volume (443, second only to nothing — it's the top
category). Account Access has the highest reopen rate (11.2%) despite
mid-pack volume (295) — a signal that Account Access issues are being
closed before they're actually fixed, more than a Billing-style capacity
problem.

## Volume trend

No sustained month-over-month growth trend — volume is roughly flat/
seasonal (100-145 tickets/month) across the 18-month window, with a peak in
May 2024 (145). This is a "fix the process, not just add headcount" signal:
the problem is efficiency, not scale.

## So what (the consulting takeaway)

If this were a live workflow, the prioritized recommendation would be:
1. Re-calibrate the Critical SLA target (or investigate why even fast
   resolutions don't clear a 4-hour bar) — highest breach rate, highest
   stakes.
2. Investigate the tail on High-priority tickets — the average looks fine,
   hiding a distribution problem.
3. Audit Account Access resolution quality — high reopen rate points to
   tickets marked resolved prematurely.
