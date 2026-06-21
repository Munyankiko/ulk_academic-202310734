# ULK Performance Dashboard
### Indexed vs. Non-Indexed Database Comparison — 5,000,000 Records

Built for: **Advanced Database Management — Assignment (Due June 22)**
Stack: **Node.js + Express + PostgreSQL + vanilla JS**

---

## What this does

- Creates two identical tables in your existing `ulk_academic` database:
  - `students_indexed` — has B-tree indexes on `email`, `reg_number`, `department`
  - `students_no_index` — has NO indexes besides the primary key
- Populates **5,000,000 records into each** using fast set-based SQL (`generate_series`), not row-by-row inserts
- A web dashboard that:
  - Shows total record counts for both tables live
  - Lets you search either table and see the real `EXPLAIN ANALYZE` execution time
  - Has a **"Race the query"** panel that runs the same search on both tables side-by-side and shows the speedup factor
  - Supports **Update** and **Delete** directly on search results

---

## Step 1 — Install Node.js (if not installed)

Download from: https://nodejs.org (LTS version)

Verify:
```bash
node -v
npm -v
```

---

## Step 2 — Install project dependencies

Open CMD in the project folder:
```bash
cd ulk_dashboard
npm install
```

---

## Step 3 — Configure database connection

Edit the `.env` file with your real PostgreSQL password:
```
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=your_real_password
PGDATABASE=ulk_academic
```

---

## Step 4 — Create tables (psql)

```bash
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d ulk_academic -f sql\01_setup_tables.sql
```

---

## Step 5 — Populate 5,000,000 records into EACH table

> ⚠️ This inserts 10,000,000 rows total. Takes roughly 2-6 minutes depending on your machine. This is normal — set-based generation is the fast way to do it (row-by-row INSERT would take hours).

```bash
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d ulk_academic -f sql\02_populate_5million.sql
```

---

## Step 6 — Create indexes (ONLY on students_indexed)

```bash
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d ulk_academic -f sql\03_create_indexes.sql
```

---

## Step 7 — (Optional) Run benchmark queries directly in psql for your report

```bash
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d ulk_academic -f sql\04_benchmark_queries.sql
```

This gives you `EXPLAIN ANALYZE` output you can paste straight into your report.

---

## Step 8 — Start the dashboard

```bash
npm start
```

Then open your browser:
```
http://localhost:3000
```

---

## Using the Dashboard

### Stats row
Shows live total record count for both tables (should read 5,000,000 each) plus table size and index count.

### "Race the query" panel
Pick a field (e.g. `email`), type a value like `student2500000@ulk.ac.rw`, click **Run comparison**. It queries BOTH tables at the same time using `EXPLAIN ANALYZE` and shows:
- Execution time for each (animated bar)
- The scan type used (`Seq Scan` vs `Index Scan` / `Bitmap Heap Scan`)
- The speedup factor (e.g. "38× faster with the index")

### Search & manage panel
Pick a table, a field, and a value, then **Search**. Results show in a table with **Edit** and **Delete** buttons per row — these run real `UPDATE` / `DELETE` SQL against PostgreSQL.

---

## Good test values

Since data was generated as `student1` to `student5000000`:

| Field | Example value |
|---|---|
| email | `student2500000@ulk.ac.rw` |
| reg_number | `ULK00002500000` |
| id | `2500000` |
| full_name | `Student 100` |
| department | `Computer Science` |

---

## Project structure

```
ulk_dashboard/
├── server.js              ← Express entry point
├── db.js                  ← PostgreSQL connection pool
├── package.json
├── .env                   ← DB credentials (edit this)
├── routes/
│   └── api.js              ← stats / search / compare / update / delete endpoints
├── public/
│   ├── index.html
│   ├── style.css
│   └── app.js
└── sql/
    ├── 01_setup_tables.sql
    ├── 02_populate_5million.sql
    ├── 03_create_indexes.sql
    └── 04_benchmark_queries.sql
```

---

## Why this proves the performance difference

- `students_no_index` forces PostgreSQL to do a **Sequential Scan** (or Parallel Seq Scan) across up to 5,000,000 rows for every search.
- `students_indexed` lets PostgreSQL use a **B-tree Index Scan / Bitmap Index Scan**, jumping almost directly to the matching row(s).
- At 5,000,000 rows the gap is dramatic — typically **tens to hundreds of times faster** with the index, much larger than the ~2.5× seen on the 300K-row employees dataset in Assignment 2.
