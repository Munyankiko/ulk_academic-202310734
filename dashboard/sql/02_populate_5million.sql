-- =====================================================
-- ULK Performance Dashboard — Populate 5,000,000 Records
-- Uses generate_series for FAST set-based insertion
-- (Row-by-row INSERT would take hours; this takes minutes)
-- =====================================================

-- \c ulk_academic

\timing on

-- =====================================================
-- POPULATE students_no_index (5,000,000 records)
-- =====================================================
INSERT INTO students_no_index (id, full_name, email, department, reg_number, gpa)
SELECT
    i,
    'Student ' || i,
    'student' || i || '@ulk.ac.rw',
    (ARRAY['Computer Science','Information Systems','Business Administration',
           'Accounting','Education Sciences'])[(i % 5) + 1],
    'ULK' || LPAD(i::TEXT, 8, '0'),
    ROUND((2.0 + random() * 2.0)::NUMERIC, 2)
FROM generate_series(1, 5000000) AS i;

SELECT 'students_no_index populated' AS status, COUNT(*) AS total_records
FROM students_no_index;

-- =====================================================
-- POPULATE students_indexed (5,000,000 records — same data)
-- =====================================================
INSERT INTO students_indexed (id, full_name, email, department, reg_number, gpa)
SELECT
    i,
    'Student ' || i,
    'student' || i || '@ulk.ac.rw',
    (ARRAY['Computer Science','Information Systems','Business Administration',
           'Accounting','Education Sciences'])[(i % 5) + 1],
    'ULK' || LPAD(i::TEXT, 8, '0'),
    ROUND((2.0 + random() * 2.0)::NUMERIC, 2)
FROM generate_series(1, 5000000) AS i;

SELECT 'students_indexed populated' AS status, COUNT(*) AS total_records
FROM students_indexed;

\timing off
