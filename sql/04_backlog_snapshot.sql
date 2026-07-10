-- Question: How big is the current backlog, and is it weighted toward
-- urgent tickets (bad) or routine ones (less bad)?

-- 4a. Unresolved tickets by status
SELECT status, COUNT(*) AS n
FROM tickets_clean
WHERE is_resolved = 0
GROUP BY status
ORDER BY n DESC;

-- 4b. Unresolved tickets by priority — the concerning cut: how many
-- Critical/High tickets are still sitting open or in progress
SELECT
    priority,
    COUNT(*)                                                       AS n_unresolved,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM tickets_clean
                               WHERE is_resolved = 0), 1)          AS pct_of_backlog
FROM tickets_clean
WHERE is_resolved = 0
GROUP BY priority
ORDER BY
    CASE priority
        WHEN 'Critical' THEN 1
        WHEN 'High'     THEN 2
        WHEN 'Medium'   THEN 3
        WHEN 'Low'      THEN 4
    END;
