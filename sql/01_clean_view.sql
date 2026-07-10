-- tickets_clean: adds derived fields used by every downstream query.
--
-- ASSUMPTION (documented, since the dataset has no explicit SLA target
-- column): SLA targets are assigned by priority using common industry
-- defaults. This is our assumption, not a field in the source data —
-- called out here and in the README so it's not mistaken for given fact.
--   Critical -> 4 hours
--   High     -> 24 hours
--   Medium   -> 72 hours
--   Low      -> 120 hours

DROP VIEW IF EXISTS tickets_clean;

CREATE VIEW tickets_clean AS
SELECT
    t.*,
    (resolved_at IS NOT NULL)                          AS is_resolved,
    CASE priority
        WHEN 'Critical' THEN 4
        WHEN 'High'     THEN 24
        WHEN 'Medium'   THEN 72
        WHEN 'Low'      THEN 120
    END                                                 AS sla_target_hrs,
    CASE
        WHEN resolved_at IS NOT NULL
             AND resolution_time_hrs > CASE priority
                    WHEN 'Critical' THEN 4
                    WHEN 'High'     THEN 24
                    WHEN 'Medium'   THEN 72
                    WHEN 'Low'      THEN 120
                 END
        THEN 1 ELSE 0
    END                                                 AS sla_breached,
    strftime('%Y-%m', created_at)                       AS created_month
FROM tickets t;
