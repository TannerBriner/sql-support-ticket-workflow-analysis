-- Question: Which ticket categories have the worst "first-contact
-- resolution" quality — i.e. get escalated or reopened rather than
-- resolved cleanly the first time? High rates here point to a training,
-- documentation, or process gap, not a speed problem.

SELECT
    category,
    COUNT(*)                              AS n,
    ROUND(AVG(escalated) * 100, 1)        AS escalation_pct,
    ROUND(AVG(reopened) * 100, 1)         AS reopen_pct
FROM tickets_clean
GROUP BY category
ORDER BY escalation_pct DESC;
