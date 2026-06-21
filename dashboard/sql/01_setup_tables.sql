-- =====================================================
-- ULK Performance Dashboard — Database Setup
-- Creates TWO identical tables: one indexed, one not
-- Both will be populated with 5,000,000 records
-- =====================================================

-- Connect to ulk_academic database first:
-- \c ulk_academic

-- Drop tables if they exist (clean start)
DROP TABLE IF EXISTS students_no_index;
DROP TABLE IF EXISTS students_indexed;

-- =====================================================
-- TABLE 1: students_no_index (NO INDEX on search columns)
-- =====================================================
CREATE TABLE students_no_index (
    id          BIGINT PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100),
    department  VARCHAR(50),
    reg_number  VARCHAR(20),
    gpa         NUMERIC(3,2),
    created_at  TIMESTAMP DEFAULT NOW()
);

-- =====================================================
-- TABLE 2: students_indexed (WILL HAVE INDEX on email/reg_number)
-- =====================================================
CREATE TABLE students_indexed (
    id          BIGINT PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100),
    department  VARCHAR(50),
    reg_number  VARCHAR(20),
    gpa         NUMERIC(3,2),
    created_at  TIMESTAMP DEFAULT NOW()
);

SELECT 'Tables created successfully' AS status;
