"""
Builds tickets.db from data/support_tickets.csv using the schema and view
defined in sql/00_schema.sql and sql/01_clean_view.sql.

Usage:
    python scripts/load_db.py
"""
import sqlite3
import pandas as pd
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DB_PATH = ROOT / "tickets.db"
CSV_PATH = ROOT / "data" / "support_tickets.csv"
SCHEMA_SQL = ROOT / "sql" / "00_schema.sql"
VIEW_SQL = ROOT / "sql" / "01_clean_view.sql"

COLUMNS = [
    "ticket_id", "created_at", "resolved_at", "channel", "category",
    "subcategory", "priority", "status", "sentiment", "product",
    "customer_plan", "region", "language", "assigned_agent", "message",
    "resolution_note", "resolution_time_hrs", "csat_score",
    "first_response_time_hrs", "reopened", "escalated", "num_interactions",
    "customer_tenure_days",
]


def main():
    if DB_PATH.exists():
        DB_PATH.unlink()

    conn = sqlite3.connect(DB_PATH)
    conn.executescript(SCHEMA_SQL.read_text())

    df = pd.read_csv(CSV_PATH)
    df["reopened"] = df["reopened"].astype(bool).astype(int)
    df["escalated"] = df["escalated"].astype(bool).astype(int)
    df = df[COLUMNS]

    df.to_sql("tickets", conn, if_exists="append", index=False)
    conn.executescript(VIEW_SQL.read_text())
    conn.commit()

    count = conn.execute("SELECT COUNT(*) FROM tickets").fetchone()[0]
    print(f"Loaded {count} rows into {DB_PATH}")
    conn.close()


if __name__ == "__main__":
    main()
