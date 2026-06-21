// routes/api.js
const express = require('express');
const router = express.Router();
const pool = require('../db');

// Helper: map UI table key -> real table name
const TABLES = {
  indexed: 'students_indexed',
  noindex: 'students_no_index'
};

function getTable(key) {
  const t = TABLES[key];
  if (!t) throw new Error('Invalid table key');
  return t;
}

// =====================================================
// GET /api/stats — total record counts for both tables
// =====================================================
router.get('/stats', async (req, res) => {
  try {
    const [indexedCount, noIndexCount, indexedSize, noIndexSize] = await Promise.all([
      pool.query('SELECT COUNT(*) FROM students_indexed'),
      pool.query('SELECT COUNT(*) FROM students_no_index'),
      pool.query(`SELECT pg_size_pretty(pg_total_relation_size('students_indexed')) AS size`),
      pool.query(`SELECT pg_size_pretty(pg_total_relation_size('students_no_index')) AS size`)
    ]);

    const indexList = await pool.query(`
      SELECT indexname FROM pg_indexes
      WHERE tablename = 'students_indexed' AND indexname != 'students_indexed_pkey'
    `);

    res.json({
      indexed: {
        total: parseInt(indexedCount.rows[0].count, 10),
        size: indexedSize.rows[0].size,
        indexCount: indexList.rows.length
      },
      noindex: {
        total: parseInt(noIndexCount.rows[0].count, 10),
        size: noIndexSize.rows[0].size,
        indexCount: 0
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// =====================================================
// GET /api/search?table=indexed|noindex&field=email|reg_number|full_name&q=value
// Runs EXPLAIN ANALYZE and returns timing + plan + results
// =====================================================
router.get('/search', async (req, res) => {
  const { table, field, q } = req.query;
  const allowedFields = ['email', 'reg_number', 'full_name', 'department', 'id'];

  if (!TABLES[table]) return res.status(400).json({ error: 'Invalid table' });
  if (!allowedFields.includes(field)) return res.status(400).json({ error: 'Invalid field' });
  if (!q) return res.status(400).json({ error: 'Missing search query' });

  const tableName = getTable(table);

  try {
    let whereClause;
    let params = [];

    if (field === 'id') {
      whereClause = `id = $1`;
      params = [parseInt(q, 10)];
    } else if (field === 'full_name' || field === 'department') {
      whereClause = `${field} ILIKE $1`;
      params = [`%${q}%`];
    } else {
      whereClause = `${field} = $1`;
      params = [q];
    }

    // Run EXPLAIN ANALYZE to capture real execution plan + timing
    const explainSql = `EXPLAIN (ANALYZE, FORMAT JSON) SELECT * FROM ${tableName} WHERE ${whereClause} LIMIT 50`;
    const explainResult = await pool.query(explainSql, params);
    const plan = explainResult.rows[0]['QUERY PLAN'][0];

    // Get actual data (separately, so JSON explain doesn't block row return)
    const dataSql = `SELECT * FROM ${tableName} WHERE ${whereClause} LIMIT 50`;
    const dataResult = await pool.query(dataSql, params);

    res.json({
      table: tableName,
      executionTimeMs: plan['Execution Time'],
      planningTimeMs: plan['Planning Time'],
      nodeType: plan['Plan']['Node Type'],
      rowsReturned: dataResult.rows.length,
      rows: dataResult.rows,
      rawPlan: plan
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// =====================================================
// GET /api/compare — runs the SAME search on BOTH tables
// for side-by-side performance comparison
// =====================================================
router.get('/compare', async (req, res) => {
  const { field, q } = req.query;
  const allowedFields = ['email', 'reg_number', 'full_name', 'department', 'id'];

  if (!allowedFields.includes(field)) return res.status(400).json({ error: 'Invalid field' });
  if (!q) return res.status(400).json({ error: 'Missing search query' });

  try {
    let whereClause;
    let params = [];

    if (field === 'id') {
      whereClause = `id = $1`;
      params = [parseInt(q, 10)];
    } else if (field === 'full_name' || field === 'department') {
      whereClause = `${field} ILIKE $1`;
      params = [`%${q}%`];
    } else {
      whereClause = `${field} = $1`;
      params = [q];
    }

    const runExplain = async (tableName) => {
      const sql = `EXPLAIN (ANALYZE, FORMAT JSON) SELECT * FROM ${tableName} WHERE ${whereClause} LIMIT 50`;
      const result = await pool.query(sql, params);
      const plan = result.rows[0]['QUERY PLAN'][0];
      return {
        table: tableName,
        executionTimeMs: plan['Execution Time'],
        planningTimeMs: plan['Planning Time'],
        nodeType: plan['Plan']['Node Type'],
        rowsExamined: plan['Plan']['Actual Rows'] || 0
      };
    };

    const [noIndexResult, indexedResult] = await Promise.all([
      runExplain('students_no_index'),
      runExplain('students_indexed')
    ]);

    const speedup = noIndexResult.executionTimeMs / indexedResult.executionTimeMs;

    res.json({
      noindex: noIndexResult,
      indexed: indexedResult,
      speedupFactor: speedup.toFixed(2)
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// =====================================================
// PUT /api/record — UPDATE operation
// =====================================================
router.put('/record', async (req, res) => {
  const { table, id, full_name, email, department, gpa } = req.body;
  if (!TABLES[table]) return res.status(400).json({ error: 'Invalid table' });
  if (!id) return res.status(400).json({ error: 'Missing id' });

  const tableName = getTable(table);

  try {
    const result = await pool.query(
      `UPDATE ${tableName}
       SET full_name = COALESCE($1, full_name),
           email = COALESCE($2, email),
           department = COALESCE($3, department),
           gpa = COALESCE($4, gpa)
       WHERE id = $5
       RETURNING *`,
      [full_name, email, department, gpa, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Record not found' });
    }

    res.json({ message: 'Record updated', record: result.rows[0] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// =====================================================
// DELETE /api/record — DELETE operation
// =====================================================
router.delete('/record', async (req, res) => {
  const { table, id } = req.body;
  if (!TABLES[table]) return res.status(400).json({ error: 'Invalid table' });
  if (!id) return res.status(400).json({ error: 'Missing id' });

  const tableName = getTable(table);

  try {
    const result = await pool.query(
      `DELETE FROM ${tableName} WHERE id = $1 RETURNING id`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Record not found' });
    }

    res.json({ message: 'Record deleted', id: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
