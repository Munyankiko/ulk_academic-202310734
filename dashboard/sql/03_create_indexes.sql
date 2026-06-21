-- =====================================================
-- ULK Performance Dashboard — Create Indexes
-- Run this AFTER populating data, so you can test
-- "before index" performance first if you want
-- =====================================================

-- \c ulk_academic

\timing on

-- Create indexes ONLY on students_indexed table
-- (students_no_index intentionally has NO indexes besides primary key)

CREATE INDEX idx_indexed_email ON students_indexed(email);
CREATE INDEX idx_indexed_regnumber ON students_indexed(reg_number);
CREATE INDEX idx_indexed_department ON students_indexed(department);

SELECT 'Indexes created on students_indexed' AS status;

-- Verify indexes
SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename IN ('students_indexed', 'students_no_index')
ORDER BY tablename;

\timing off
