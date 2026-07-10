-- Question: Which priority tier is actually failing its SLA, and by how
-- much? This is the key finding of the project — see README.
--
-- Note: sla_target_hrs is our documented assumption (Critical=4h,
-- High=24h, Medium=72h, Low=120h), defined in 01_clean_view.sql, since the
-- dataset has no explicit SLA column.

-- 3a. Overall breach rate
SELECT
    ROUND(AVG(sla_breached) * 100, 1) AS overall_breach_pct
FROM tickets_clean
WHERE is_resolved = 1;

-- 3b. Breach rate and average overshoot by priority
SELECT
    priority,
    sla_target_hrs,
    COUNT(*)                                                        AS n_resolved,
    ROUND(AVG(resolution_time_hrs), 1)                              AS avg_resolution_hrs,
    ROUND(AVG(sla_breached) * 100, 1)                               AS breach_pct,
    ROUND(AVG(CASE WHEN sla_breached = 1
                   THEN resolution_time_hrs - sla_target_hrs END), 1) AS avg_overshoot_hrs_when_breached
FROM tickets_clean
WHERE is_resolved = 1
GROUP BY priority, sla_target_hrs
ORDER BY breach_pct DESC;
