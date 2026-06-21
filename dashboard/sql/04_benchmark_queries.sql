-- =====================================================
-- ULK Performance Dashboard — Benchmark Queries
-- Run these to capture proof for your report
-- =====================================================

-- \c ulk_academic

\timing on

-- =====================================================
-- TEST 1: Search by EMAIL
-- =====================================================

-- WITHOUT INDEX (sequential scan)
EXPLAIN ANALYZE
SELECT * FROM students_no_index
WHERE email = 'student2500000@ulk.ac.rw';

-- WITH INDEX (index scan)
EXPLAIN ANALYZE
SELECT * FROM students_indexed
WHERE email = 'student2500000@ulk.ac.rw';

-- =====================================================
-- TEST 2: Search by REGISTRATION NUMBER
-- =====================================================

-- WITHOUT INDEX
EXPLAIN ANALYZE
SELECT * FROM students_no_index
WHERE reg_number = 'ULK00002500000';

-- WITH INDEX
EXPLAIN ANALYZE
SELECT * FROM students_indexed
WHERE reg_number = 'ULK00002500000';

-- =====================================================
-- TEST 3: Search by DEPARTMENT (returns many rows)
-- =====================================================

-- WITHOUT INDEX
EXPLAIN ANALYZE
SELECT COUNT(*) FROM students_no_index
WHERE department = 'Computer Science';

-- WITH INDEX
EXPLAIN ANALYZE
SELECT COUNT(*) FROM students_indexed
WHERE department = 'Computer Science';

-- =====================================================
-- Table size comparison
-- =====================================================
SELECT
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS total_size,
    pg_size_pretty(pg_relation_size(relid)) AS table_size,
    pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) AS index_size
FROM pg_catalog.pg_statio_user_tables
WHERE relname IN ('students_indexed', 'students_no_index');

\timing off
