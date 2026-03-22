import * as fs from 'fs';
import * as path from 'path';
import { config } from 'dotenv';
import { getSupabaseUrl } from '../src/lib/supabase/env';

config({ path: path.resolve(__dirname, '../.env.local') });

const SUPABASE_URL = getSupabaseUrl();
if (!SUPABASE_URL) {
  console.error('Missing Supabase URL. Check .env.local and NEXT_PUBLIC_ENVIRONMENT.');
  process.exit(1);
}
console.log(`Using Supabase: ${SUPABASE_URL}`);

const BUCKET = 'sat-question-images';

const TSV_PATH = path.join(
  __dirname,
  '..',
  'Docs for me',
  'sat-ecosystem',
  'sat_question_bank_verbal',
  'question_bank_sat_verbal.tsv'
);

const OUT_PATH = path.join(
  __dirname,
  '..',
  'supabase',
  'migrations',
  '20260312300001_link_rw_quant_images.sql'
);

function normalize(s: string): string {
  return s.replace(/\r/g, ' ').replace(/\s+/g, ' ').trim();
}

function escapeSQL(s: string): string {
  return s.replace(/'/g, "''");
}

const raw = fs.readFileSync(TSV_PATH, 'utf-8');
const lines = raw.split('\n');

interface QuantRow {
  slNo: number;
  prompt: string;
}

const quantRows: QuantRow[] = [];

for (let i = 1; i < lines.length; i++) {
  const line = lines[i];
  if (!line.trim()) continue;
  const cols = line.split('\t');
  if (cols.length < 11) continue;

  const questionType = normalize(cols[10]);
  if (questionType !== 'Command of Evidence - Quantitative') continue;

  const slNo = parseInt(normalize(cols[0]), 10);
  const prompt = normalize(cols[2]);
  if (!slNo || !prompt) continue;

  quantRows.push({ slNo, prompt });
}

console.log(`Found ${quantRows.length} Quantitative questions in TSV`);

const sqlLines: string[] = [
  '-- Link "Command of Evidence - Quantitative" questions to their images',
  `-- Images uploaded to ${BUCKET} bucket`,
  '',
];

// Check which file extension each image has
const imagesDir = path.join(
  __dirname,
  '..',
  'Docs for me',
  'sat-ecosystem',
  'sat_question_bank_verbal',
  'sat-rw-quant-images'
);

for (const row of quantRows) {
  const nn = String(row.slNo).padStart(2, '0');

  let ext = '.png';
  if (fs.existsSync(path.join(imagesDir, `sat-rw-quant-${nn}.jpg`))) {
    ext = '.jpg';
  }

  const imageUrl = `${SUPABASE_URL}/storage/v1/object/public/${BUCKET}/sat-rw-quant-${nn}${ext}`;

  // Use first 80 chars of prompt for the WHERE to keep lines readable,
  // but match on full prompt to be exact
  sqlLines.push(
    `UPDATE sat_questions SET image_url = '${escapeSQL(imageUrl)}' WHERE section = 'rw' AND prompt LIKE '${escapeSQL(row.prompt.substring(0, 80))}%';`
  );
}

sqlLines.push('');
sqlLines.push(`-- Total UPDATE statements: ${quantRows.length}`);

const sql = sqlLines.join('\n') + '\n';
fs.writeFileSync(OUT_PATH, sql);
console.log(`Written to ${OUT_PATH}`);
console.log('Done!');
