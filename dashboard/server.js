// server.js — ULK Performance Dashboard
const express = require('express');
const cors = require('cors');
const path = require('path');
const apiRoutes = require('./routes/api');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/api', apiRoutes);

app.listen(PORT, () => {
  console.log(`\n  ULK Performance Dashboard running`);
  console.log(`  → http://localhost:${PORT}\n`);
});
