-- Question: Where does the ticket workflow take the longest, and does that
-- line up with urgency (priority)? A slow "Low" priority ticket matters
-- less than a slow "Critical" one.

-- 2a. Average resolution time by category
SELECT
    category,
    COUNT(*)                              AS n_resolved,
    ROUND(AVG(resolution_time_hrs), 1)     AS avg_resolution_hrs
FROM tickets_clean
WHERE is_resolved = 1
GROUP BY category
ORDER BY avg_resolution_hrs DESC;

-- 2b. Average resolution time AND SLA breach rate by priority
-- (the more important cut — see 03_sla_breach_analysis.sql for why)
SELECT
    priority,
    COUNT(*)                              AS n_resolved,
    ROUND(AVG(resolution_time_hrs), 1)     AS avg_resolution_hrs,
    ROUND(AVG(sla_breached) * 100, 1)      AS sla_breach_pct
FROM tickets_clean
WHERE is_resolved = 1
GROUP BY priority
ORDER BY
    CASE priority
        WHEN 'Critical' THEN 1
        WHEN 'High'     THEN 2
        WHEN 'Medium'   THEN 3
        WHEN 'Low'      THEN 4
    END;
