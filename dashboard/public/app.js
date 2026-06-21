// app.js — ULK Performance Dashboard frontend logic
const API = '/api';

const els = {
  connStatus: document.getElementById('connStatus'),
  connText: document.getElementById('connText'),
  statIndexedTotal: document.getElementById('statIndexedTotal'),
  statIndexedSize: document.getElementById('statIndexedSize'),
  statIndexedIdx: document.getElementById('statIndexedIdx'),
  statNoIndexTotal: document.getElementById('statNoIndexTotal'),
  statNoIndexSize: document.getElementById('statNoIndexSize'),

  compareForm: document.getElementById('compareForm'),
  compareField: document.getElementById('compareField'),
  compareQuery: document.getElementById('compareQuery'),
  raceTrack: document.getElementById('raceTrack'),
  raceNoIndexTime: document.getElementById('raceNoIndexTime'),
  raceNoIndexBar: document.getElementById('raceNoIndexBar'),
  raceNoIndexMeta: document.getElementById('raceNoIndexMeta'),
  raceIndexedTime: document.getElementById('raceIndexedTime'),
  raceIndexedBar: document.getElementById('raceIndexedBar'),
  raceIndexedMeta: document.getElementById('raceIndexedMeta'),
  speedupBanner: document.getElementById('speedupBanner'),
  speedupNumber: document.getElementById('speedupNumber'),

  searchForm: document.getElementById('searchForm'),
  searchTable: document.getElementById('searchTable'),
  searchField: document.getElementById('searchField'),
  searchQuery: document.getElementById('searchQuery'),
  searchMeta: document.getElementById('searchMeta'),
  resultsBody: document.getElementById('resultsBody'),

  editOverlay: document.getElementById('editOverlay'),
  editId: document.getElementById('editId'),
  editTable: document.getElementById('editTable'),
  editFullName: document.getElementById('editFullName'),
  editEmail: document.getElementById('editEmail'),
  editDepartment: document.getElementById('editDepartment'),
  editGpa: document.getElementById('editGpa'),
  editCancel: document.getElementById('editCancel'),
  editSave: document.getElementById('editSave'),

  toast: document.getElementById('toast'),
};

function showToast(msg, type = '') {
  els.toast.textContent = msg;
  els.toast.className = 'toast ' + type;
  els.toast.hidden = false;
  setTimeout(() => { els.toast.hidden = true; }, 3200);
}

// ===================== STATS =====================
async function loadStats() {
  try {
    const res = await fetch(`${API}/stats`);
    if (!res.ok) throw new Error('stats fetch failed');
    const data = await res.json();

    els.statIndexedTotal.textContent = data.indexed.total.toLocaleString();
    els.statIndexedSize.textContent = data.indexed.size;
    els.statIndexedIdx.textContent = `${data.indexed.indexCount} indexes`;

    els.statNoIndexTotal.textContent = data.noindex.total.toLocaleString();
    els.statNoIndexSize.textContent = data.noindex.size;

    els.connStatus.className = 'status-dot ok';
    els.connText.textContent = 'Connected to ulk_academic';
  } catch (err) {
    els.connStatus.className = 'status-dot err';
    els.connText.textContent = 'Database not reachable';
    console.error(err);
  }
}

// ===================== COMPARE / RACE =====================
els.compareForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  const field = els.compareField.value;
  const q = els.compareQuery.value.trim();
  if (!q) return showToast('Enter a value to search for', 'error');

  els.raceTrack.hidden = false;
  els.speedupBanner.hidden = true;
  els.raceNoIndexBar.style.width = '0%';
  els.raceIndexedBar.style.width = '0%';
  els.raceNoIndexTime.textContent = '…';
  els.raceIndexedTime.textContent = '…';
  els.raceNoIndexMeta.textContent = 'Running…';
  els.raceIndexedMeta.textContent = 'Running…';

  try {
    const res = await fetch(`${API}/compare?field=${encodeURIComponent(field)}&q=${encodeURIComponent(q)}`);
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'Compare failed');

    const maxTime = Math.max(data.noindex.executionTimeMs, data.indexed.executionTimeMs, 0.001);

    els.raceNoIndexTime.textContent = `${data.noindex.executionTimeMs.toFixed(3)} ms`;
    els.raceIndexedTime.textContent = `${data.indexed.executionTimeMs.toFixed(3)} ms`;

    requestAnimationFrame(() => {
      els.raceNoIndexBar.style.width = `${(data.noindex.executionTimeMs / maxTime) * 100}%`;
      els.raceIndexedBar.style.width = `${(data.indexed.executionTimeMs / maxTime) * 100}%`;
    });

    els.raceNoIndexMeta.textContent = `${data.noindex.nodeType} · planning ${data.noindex.planningTimeMs.toFixed(3)} ms`;
    els.raceIndexedMeta.textContent = `${data.indexed.nodeType} · planning ${data.indexed.planningTimeMs.toFixed(3)} ms`;

    els.speedupNumber.textContent = `${data.speedupFactor}×`;
    els.speedupBanner.hidden = false;
  } catch (err) {
    showToast(err.message, 'error');
    els.raceTrack.hidden = true;
  }
});

// ===================== SEARCH / MANAGE =====================
els.searchForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  const table = els.searchTable.value;
  const field = els.searchField.value;
  const q = els.searchQuery.value.trim();
  if (!q) return showToast('Enter a value to search for', 'error');

  els.searchMeta.textContent = 'Searching…';

  try {
    const res = await fetch(`${API}/search?table=${table}&field=${field}&q=${encodeURIComponent(q)}`);
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'Search failed');

    els.searchMeta.textContent =
      `${data.rowsReturned} row(s) · ${data.nodeType} · ${data.executionTimeMs.toFixed(3)} ms execution`;

    renderResults(data.rows, table);
  } catch (err) {
    showToast(err.message, 'error');
    els.searchMeta.textContent = '';
  }
});

function renderResults(rows, table) {
  if (!rows || rows.length === 0) {
    els.resultsBody.innerHTML = `<tr class="empty-row"><td colspan="7">No records found.</td></tr>`;
    return;
  }

  els.resultsBody.innerHTML = rows.map(r => `
    <tr>
      <td>${r.id}</td>
      <td>${escapeHtml(r.full_name)}</td>
      <td>${escapeHtml(r.email)}</td>
      <td>${escapeHtml(r.department)}</td>
      <td>${escapeHtml(r.reg_number)}</td>
      <td>${r.gpa}</td>
      <td>
        <button class="btn-small" data-action="edit" data-id="${r.id}" data-table="${table}">Edit</button>
        <button class="btn-small danger" data-action="delete" data-id="${r.id}" data-table="${table}">Delete</button>
      </td>
    </tr>
  `).join('');

  // attach row data for edit
  rows.forEach(r => { rowCache[`${table}-${r.id}`] = r; });
}

const rowCache = {};

function escapeHtml(str) {
  if (str === null || str === undefined) return '';
  return String(str).replace(/[&<>"']/g, c => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  }[c]));
}

// ===================== EDIT / DELETE handlers =====================
els.resultsBody.addEventListener('click', (e) => {
  const btn = e.target.closest('button');
  if (!btn) return;
  const id = btn.dataset.id;
  const table = btn.dataset.table;
  const action = btn.dataset.action;

  if (action === 'edit') openEditModal(table, id);
  if (action === 'delete') deleteRecord(table, id);
});

function openEditModal(table, id) {
  const row = rowCache[`${table}-${id}`];
  if (!row) return;

  els.editId.textContent = `#${id}`;
  els.editTable.value = table;
  els.editFullName.value = row.full_name;
  els.editEmail.value = row.email;
  els.editDepartment.value = row.department;
  els.editGpa.value = row.gpa;
  els.editOverlay.dataset.id = id;
  els.editOverlay.hidden = false;
}

els.editCancel.addEventListener('click', () => { els.editOverlay.hidden = true; });

els.editSave.addEventListener('click', async () => {
  const id = els.editOverlay.dataset.id;
  const table = els.editTable.value;

  try {
    const res = await fetch(`${API}/record`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        table, id,
        full_name: els.editFullName.value,
        email: els.editEmail.value,
        department: els.editDepartment.value,
        gpa: parseFloat(els.editGpa.value)
      })
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'Update failed');

    showToast('Record updated', 'success');
    els.editOverlay.hidden = true;
    els.searchForm.requestSubmit();
  } catch (err) {
    showToast(err.message, 'error');
  }
});

async function deleteRecord(table, id) {
  if (!confirm(`Delete record #${id} from ${table === 'indexed' ? 'students_indexed' : 'students_no_index'}?`)) return;

  try {
    const res = await fetch(`${API}/record`, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ table, id })
    });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'Delete failed');

    showToast(`Record #${id} deleted`, 'success');
    els.searchForm.requestSubmit();
    loadStats();
  } catch (err) {
    showToast(err.message, 'error');
  }
}

// ===================== INIT =====================
loadStats();
setInterval(loadStats, 15000);
