-- Question: Is ticket volume trending up (workflow needs to scale) or
-- flat/seasonal (workflow needs to get more efficient, not just bigger)?
-- Uses a window function to show month-over-month change alongside the
-- raw count.

SELECT
    created_month,
    COUNT(*) AS n_created,
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY created_month) AS mom_change
FROM tickets_clean
GROUP BY created_month
ORDER BY created_month;
