/**
 * Two-way sync: local questions.tsv files ↔ Google Sheet (one tab per chapter)
 *
 * Usage:
 *   node scripts/cbse10-science-sheets-sync.mjs --pull   # Sheet tabs → TSV files
 *   node scripts/cbse10-science-sheets-sync.mjs --push   # TSV files → Sheet tabs
 *
 * Options:
 *   --sheet-id=<id>    Spreadsheet ID (default: hardcoded below)
 *   --dry-run          Print what would happen without writing
 *
 * Each chapter folder maps 1:1 to a sheet tab of the same name.
 * Folders scanned (all except cbse10-science-question-images):
 *   01_chemical-reactions-and-equations … 16_sustainable-management, _mixed
 */

import * as fs from 'fs';
import * as path from 'path';
import { parse } from 'csv-parse/sync';
import { stringify } from 'csv-stringify/sync';
import { google } from 'googleapis';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

const DEFAULT_SPREADSHEET_ID = '1mKBQr9AKyH3EAnyaPtIaVZ4gNzApezlRR1nA_Fm7Kes';
const TSV_BASE = path.join(ROOT, 'Docs for me/latex_with_rijay/cbse_10_science');
const SKIP_FOLDERS = new Set(['cbse10-science-question-images']);

const HEADERS = [
  'bank_item_id', 'type', 'domain', 'difficulty_tier', 'chapter', 'subtopic',
  'prompt', 'option_a', 'option_b', 'option_c', 'option_d',
  'correct_answer', 'explanation', 'image_url',
  'is_pyq', 'pyq_year', 'correct_answer_b',
];

// Ordered list of chapter folders (determines tab order)
const CHAPTER_FOLDERS = [
  '01_chemical-reactions-and-equations',
  '02_acids-bases-and-salts',
  '03_metals-and-non-metals',
  '04_carbon-and-its-compounds',
  '05_periodic-classification',
  '06_life-processes',
  '07_control-and-coordination',
  '08_how-do-organisms-reproduce',
  '09_heredity-and-evolution',
  '10_light-reflection-and-refraction',
  '11_human-eye',
  '12_electricity',
  '13_magnetic-effects',
  '14_sources-of-energy',
  '15_our-environment',
  '16_sustainable-management',
  '_mixed',
];

function parseArgs() {
  const argv = process.argv.slice(2);
  const mode = argv.includes('--pull') ? 'pull' : argv.includes('--push') ? 'push' : null;
  const dryRun = argv.includes('--dry-run');
  let spreadsheetId = DEFAULT_SPREADSHEET_ID;
  for (const a of argv) {
    if (a.startsWith('--sheet-id=')) spreadsheetId = a.slice(11);
  }
  if (!mode) {
    console.error('Usage: node scripts/cbse10-science-sheets-sync.mjs --pull | --push [--dry-run] [--sheet-id=<id>]');
    process.exit(1);
  }
  return { mode, dryRun, spreadsheetId };
}

async function authenticate() {
  const candidates = [
    path.join(ROOT, 'credentials.json'),
    path.join(ROOT, 'google-service-account-key.json'),
  ];
  const keyPath = candidates.find(p => fs.existsSync(p));
  const credentials = process.env.GOOGLE_SERVICE_ACCOUNT_JSON
    ? JSON.parse(process.env.GOOGLE_SERVICE_ACCOUNT_JSON)
    : JSON.parse(fs.readFileSync(keyPath, 'utf-8'));
  const auth = new google.auth.GoogleAuth({
    credentials,
    scopes: ['https://www.googleapis.com/auth/spreadsheets'],
  });
  return google.sheets({ version: 'v4', auth });
}

// ── Helpers ──────────────────────────────────

function readTsv(filePath) {
  if (!fs.existsSync(filePath)) return [];
  const raw = fs.readFileSync(filePath, 'utf-8');
  try {
    const rows = parse(raw, {
      delimiter: '\t',
      columns: h => h.map(c => String(c).replace(/^\ufeff/, '').trim()),
      skip_empty_lines: true,
      trim: false,
      relax_column_count: true,
    });
    return rows.filter(r => String(r.bank_item_id ?? '').trim());
  } catch (e) {
    console.error(`  ⚠️  Parse error in ${filePath}: ${e.message}`);
    return [];
  }
}

function writeTsv(filePath, rows) {
  const lines = [HEADERS.join('\t')];
  for (const row of rows) {
    const line = stringify([HEADERS.map(h => row[h] ?? '')], { delimiter: '\t', quoted: false }).trimEnd();
    lines.push(line);
  }
  fs.writeFileSync(filePath, lines.join('\n') + '\n', 'utf-8');
}

async function getExistingTabs(sheets, spreadsheetId) {
  const meta = await sheets.spreadsheets.get({ spreadsheetId });
  return new Set(meta.data.sheets.map(s => s.properties.title));
}

async function ensureTab(sheets, spreadsheetId, tab, existingTabs) {
  if (existingTabs.has(tab)) return;
  await sheets.spreadsheets.batchUpdate({
    spreadsheetId,
    requestBody: { requests: [{ addSheet: { properties: { title: tab } } }] },
  });
  existingTabs.add(tab);
  console.log(`   + Created tab: ${tab}`);
}

async function readTabRows(sheets, spreadsheetId, tab) {
  try {
    const res = await sheets.spreadsheets.values.get({
      spreadsheetId,
      range: `${tab}!A1:Q10000`,
    });
    const values = res.data.values ?? [];
    if (values.length < 2) return [];
    const [headerRow, ...dataRows] = values;
    return dataRows.map(row => {
      const obj = {};
      for (let i = 0; i < headerRow.length; i++) obj[headerRow[i]] = row[i] ?? '';
      return obj;
    }).filter(r => String(r.bank_item_id ?? '').trim());
  } catch {
    return [];
  }
}

async function writeTab(sheets, spreadsheetId, tab, rows, dryRun) {
  if (dryRun) {
    console.log(`   [dry-run] ${tab}  ← ${rows.length} rows`);
    return;
  }
  const values = [HEADERS, ...rows.map(row => HEADERS.map(h => row[h] ?? ''))];
  await sheets.spreadsheets.values.clear({ spreadsheetId, range: `${tab}!A1:Q10000` });
  await sheets.spreadsheets.values.update({
    spreadsheetId,
    range: `${tab}!A1`,
    valueInputOption: 'RAW',
    requestBody: { values },
  });
}

// ── PULL: Sheet tabs → TSV files ─────────────

async function pull(sheets, spreadsheetId, dryRun) {
  console.log(`\n⬇️  PULL: Google Sheet tabs → local TSV files\n`);

  let totalRows = 0;
  for (const folder of CHAPTER_FOLDERS) {
    const tsv = path.join(TSV_BASE, folder, 'questions.tsv');
    if (!fs.existsSync(path.join(TSV_BASE, folder))) {
      console.warn(`  ⚠️  Folder not found, skipping: ${folder}`);
      continue;
    }
    const rows = await readTabRows(sheets, spreadsheetId, folder);
    console.log(`   ${folder}  ← ${rows.length} rows`);
    if (!dryRun) writeTsv(tsv, rows);
    totalRows += rows.length;
  }

  if (dryRun) console.log('\n  [dry-run] No files written.');
  console.log(`\n✅ Pull complete. ${totalRows} total rows written across ${CHAPTER_FOLDERS.length} files.`);
}

// ── PUSH: TSV files → Sheet tabs ─────────────

async function push(sheets, spreadsheetId, dryRun) {
  console.log(`\n⬆️  PUSH: local TSV files → Google Sheet tabs\n`);

  const existingTabs = await getExistingTabs(sheets, spreadsheetId);
  let totalRows = 0;

  for (const folder of CHAPTER_FOLDERS) {
    const tsv = path.join(TSV_BASE, folder, 'questions.tsv');
    const rows = readTsv(tsv);
    console.log(`   ${folder}  → ${rows.length} rows`);
    if (!dryRun) await ensureTab(sheets, spreadsheetId, folder, existingTabs);
    await writeTab(sheets, spreadsheetId, folder, rows, dryRun);
    totalRows += rows.length;
  }

  if (dryRun) console.log('\n  [dry-run] No sheet updated.');
  else console.log(`\n✅ Push complete. ${totalRows} total rows written across ${CHAPTER_FOLDERS.length} tabs.`);
}

// ── Main ─────────────────────────────────────

const { mode, dryRun, spreadsheetId } = parseArgs();
console.log(`🔐 Authenticating...`);
const sheets = await authenticate();
console.log(`   ✅ Authenticated\n`);

if (mode === 'pull') await pull(sheets, spreadsheetId, dryRun);
else await push(sheets, spreadsheetId, dryRun);
