
import os
import psycopg2
from psycopg2 import sql
from dotenv import load_dotenv

# Load environment variables from .env if present
load_dotenv()

DB_HOST = os.getenv("PGHOST", "localhost")
DB_PORT = int(os.getenv("PGPORT", "5432"))
DB_USER = os.getenv("PGUSER", "postgres")
DB_PASSWORD = os.getenv("PGPASSWORD", "postgres")
DB_NAME = os.getenv("PGDATABASE", "practicas_pyton")

def run(stmt, params=None):
    print(f"\n-- executing:\n{stmt}")
    with conn.cursor() as cur:
        cur.execute(stmt, params)

def run_safe(stmt):
    try:
        run(stmt)
    except Exception as e:
        print(f"(ignoring) {e}")

if __name__ == "__main__":
    conn = psycopg2.connect(
        host=DB_HOST, port=DB_PORT, user=DB_USER, password=DB_PASSWORD, dbname=DB_NAME
    )
    conn.autocommit = True

    print("Connected to PostgreSQL as", DB_USER, "on", DB_HOST, "db:", DB_NAME)

    # Clean start (idempotent)
    run_safe("DROP TABLE IF EXISTS logs CASCADE;")
    run_safe("DROP TABLE IF EXISTS books CASCADE;")
    run_safe("DROP TABLE IF EXISTS authors CASCADE;")

    # Create 2 tables
    run("""
        CREATE TABLE authors (
            author_id SERIAL PRIMARY KEY,
            full_name TEXT NOT NULL
        );
    """)

    run("""
        CREATE TABLE books (
            book_id SERIAL PRIMARY KEY,
            title TEXT NOT NULL,
            author_id INTEGER NOT NULL REFERENCES authors(author_id),
            price NUMERIC(10,2) DEFAULT 0
        );
    """)

    # Third table to later drop
    run("""
        CREATE TABLE logs (
            id SERIAL PRIMARY KEY,
            message TEXT
        );
    """)

    # Add new columns
    run("ALTER TABLE authors ADD COLUMN IF NOT EXISTS email TEXT;");
    run("ALTER TABLE books ADD COLUMN IF NOT EXISTS published_year INT;");

    # Rename column
    run("ALTER TABLE authors RENAME COLUMN full_name TO name;");

    # Delete (drop) a column (create temp first for clarity)
    run_safe("ALTER TABLE books ADD COLUMN temp_col TEXT;");
    run("ALTER TABLE books DROP COLUMN IF EXISTS temp_col;");

    # Add CHECK constraints
    run("ALTER TABLE books ADD CONSTRAINT chk_price_nonneg CHECK (price >= 0);");
    run_safe("ALTER TABLE books ADD CONSTRAINT chk_year CHECK (published_year IS NULL OR published_year BETWEEN 1450 AND EXTRACT(YEAR FROM CURRENT_DATE)::INT + 1);");

    # Drop a table
    run("DROP TABLE IF EXISTS logs;");

    # Sample data
    run("INSERT INTO authors(name, email) VALUES ('Ada Lovelace','ada@example.com'), ('Isaac Asimov','asimov@example.com');");
    run("INSERT INTO books(title, author_id, price, published_year) VALUES ('Foundation', 2, 15.99, 1951);");

    print("\nDDL demo completado. Revisa las tablas 'authors' y 'books'.")
    conn.close()
