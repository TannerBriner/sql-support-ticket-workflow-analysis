-- Schema for the raw tickets table.
-- Loaded from data/support_tickets.csv by scripts/load_db.py
-- SQLite has no native DATETIME type; timestamps are stored as ISO-8601
-- text (e.g. '2025-06-01 07:35:00') so SQLite's built-in date/time
-- functions (datetime(), julianday(), strftime()) work directly on them.

DROP TABLE IF EXISTS tickets;

CREATE TABLE tickets (
    ticket_id               TEXT PRIMARY KEY,
    created_at              TEXT NOT NULL,   -- ISO-8601 datetime
    resolved_at             TEXT,            -- NULL if not yet resolved
    channel                 TEXT,
    category                TEXT,
    subcategory             TEXT,
    priority                TEXT,            -- Low / Medium / High / Critical
    status                  TEXT,            -- Open / In Progress / Resolved / Closed / Escalated
    sentiment               TEXT,
    product                 TEXT,
    customer_plan           TEXT,
    region                  TEXT,
    language                TEXT,
    assigned_agent          TEXT,
    message                 TEXT,
    resolution_note         TEXT,
    resolution_time_hrs     REAL,            -- pre-computed, hrs from created to resolved
    csat_score              REAL,
    first_response_time_hrs REAL,
    reopened                INTEGER,         -- 0/1
    escalated               INTEGER,         -- 0/1
    num_interactions        INTEGER,
    customer_tenure_days    INTEGER
);

CREATE INDEX idx_tickets_category ON tickets(category);
CREATE INDEX idx_tickets_priority ON tickets(priority);
CREATE INDEX idx_tickets_status ON tickets(status);
CREATE INDEX idx_tickets_created_at ON tickets(created_at);
