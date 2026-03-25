/**
 * Author CBSE 10 Science questions in a spreadsheet → migration-ready SQL.
 *
 * Use TSV (tab-separated): commas in questions/math do not split columns.
 * Save as UTF-8 from Excel / Google Sheets ("Download → TSV").
 *
 * Columns (header row required, exact names):
 *   bank_item_id, type, domain, difficulty_tier, chapter, subtopic,
 *   prompt, option_a, option_b, option_c, option_d,
 *   correct_answer, explanation, image_url,
 *   is_pyq, pyq_year, correct_answer_b
 *
 * Rules:
 *   - type: mcq | spr
 *   - domain: slug (see DOMAINS in script)
 *   - difficulty_tier: easy | medium | hard
 *   - MCQ: fill option_a..option_d; correct_answer is a | b | c | d (lowercase)
 *   - SPR: leave option_a..option_d empty; correct_answer is the full expected string
 *   - Two-input SPR: fill correct_answer_b with the second expected value
 *   - is_pyq: true | false (default false); pyq_year: e.g. 2016
 *   - Use literal \n inside a cell for newlines in prompt/explanation/options (optional)
 *   - Empty subtopic / image_url / pyq_year / correct_answer_b → NULL in SQL
 *
 * Usage:
 *   node scripts/cbse10-science-tsv-to-sql.mjs path/to/questions.tsv > out.sql
 *   node scripts/cbse10-science-tsv-to-sql.mjs path/to/questions.tsv --out=supabase/migrations/cbse10-science/20260325120000_seed_custom.sql
 */
import * as fs from 'fs';
import * as path from 'path';
import { parse } from 'csv-parse/sync';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const DOMAINS = new Set([
  'chemical-reactions',
  'acids-bases-salts',
  'metals-non-metals',
  'carbon-compounds',
  'life-processes',
  'control-coordination',
  'reproduction',
  'heredity-evolution',
  'light',
  'human-eye',
  'electricity',
  'magnetic-effects',
  'our-environment',
]);

const HEADERS = [
  'bank_item_id',
  'type',
  'domain',
  'difficulty_tier',
  'chapter',
  'subtopic',
  'prompt',
  'option_a',
  'option_b',
  'option_c',
  'option_d',
  'correct_answer',
  'explanation',
  'image_url',
  'is_pyq',
  'pyq_year',
  'correct_answer_b',
];

function esc(s) {
  return String(s).replace(/\\/g, '\\\\').replace(/'/g, "''");
}

function unescapeCell(s) {
  return String(s ?? '')
    .replace(/\r\n/g, '\n')
    .replace(/\\n/g, '\n');
}

function sqlStr(s) {
  const t = unescapeCell(s).trim();
  if (!t) return 'NULL';
  return `'${esc(t)}'`;
}

function sqlStrKeepNull(s) {
  if (s === undefined || s === null || String(s).trim() === '') return 'NULL';
  return `'${esc(unescapeCell(s))}'`;
}

function buildOptions(row) {
  const ids = ['a', 'b', 'c', 'd'];
  const keys = ['option_a', 'option_b', 'option_c', 'option_d'];
  const out = [];
  for (let i = 0; i < keys.length; i++) {
    const text = unescapeCell(row[keys[i]]).trim();
    if (text) out.push({ id: ids[i], text });
  }
  return out;
}

function parseArgs() {
  const argv = process.argv.slice(2).filter((x) => x !== '--');
  let outPath = null;
  const files = [];
  for (const x of argv) {
    if (x.startsWith('--out=')) outPath = x.slice(6);
    else if (!x.startsWith('--')) files.push(x);
  }
  if (files.length !== 1) {
    console.error(
      'Usage: node scripts/cbse10-science-tsv-to-sql.mjs <file.tsv> [--out=path.sql]'
    );
    process.exit(1);
  }
  return { inPath: files[0], outPath };
}

function rowSql(row, lineHint) {
  const bid = unescapeCell(row.bank_item_id).trim();
  if (!bid) {
    console.error(`Skipping row (missing bank_item_id) near line ${lineHint}`);
    return null;
  }

  const type = unescapeCell(row.type).trim().toLowerCase();
  if (type !== 'mcq' && type !== 'spr') {
    throw new Error(`${bid}: type must be mcq or spr, got "${row.type}"`);
  }

  const domain = unescapeCell(row.domain).trim();
  if (!DOMAINS.has(domain)) {
    throw new Error(`${bid}: invalid domain "${domain}"`);
  }

  const tier = unescapeCell(row.difficulty_tier).trim().toLowerCase();
  if (!['easy', 'medium', 'hard'].includes(tier)) {
    throw new Error(`${bid}: difficulty_tier must be easy|medium|hard`);
  }

  const chapter = unescapeCell(row.chapter).trim();
  if (!chapter) throw new Error(`${bid}: chapter is required`);

  const prompt = unescapeCell(row.prompt).trim();
  if (!prompt) throw new Error(`${bid}: prompt is required`);

  const explanation = unescapeCell(row.explanation ?? '').trim();
  if (!explanation) throw new Error(`${bid}: explanation should be non-empty for minimal QC`);

  const correct = unescapeCell(row.correct_answer).trim();
  if (!correct) throw new Error(`${bid}: correct_answer is required`);

  let optionsSql = 'NULL';
  if (type === 'mcq') {
    const opts = buildOptions(row);
    if (opts.length !== 4) {
      throw new Error(
        `${bid}: MCQ needs exactly 4 non-empty option_a..option_d (got ${opts.length})`
      );
    }
    const letter = correct.toLowerCase();
    if (!['a', 'b', 'c', 'd'].includes(letter)) {
      throw new Error(`${bid}: MCQ correct_answer must be a, b, c, or d`);
    }
    if (!opts.some((o) => o.id === letter)) {
      throw new Error(`${bid}: correct_answer "${letter}" does not match options`);
    }
    optionsSql = `'${esc(JSON.stringify(opts))}'::jsonb`;
  } else {
    const hasAny = HEADERS.slice(7, 11).some((k) => unescapeCell(row[k]).trim());
    if (hasAny) {
      throw new Error(`${bid}: SPR rows must leave option_a..option_d empty`);
    }
  }

  const subtopic = sqlStrKeepNull(row.subtopic);
  const image = sqlStrKeepNull(row.image_url);

  const isPyqRaw = unescapeCell(row.is_pyq ?? '').trim().toLowerCase();
  const isPyq = isPyqRaw === 'true' ? 'true' : 'false';
  const pyqYear = sqlStrKeepNull(row.pyq_year);
  const correctAnswerB = sqlStrKeepNull(row.correct_answer_b);

  return (
    `  (\n` +
    `    '${type}',\n` +
    `    '${esc(prompt)}',\n` +
    `    ${optionsSql},\n` +
    `    '${esc(type === 'mcq' ? correct.toLowerCase() : correct)}',\n` +
    `    '${esc(explanation)}',\n` +
    `    '${domain}',\n` +
    `    '${tier}',\n` +
    `    '${esc(chapter)}',\n` +
    `    ${subtopic === 'NULL' ? 'NULL' : subtopic},\n` +
    `    '${esc(bid)}',\n` +
    `    ${image === 'NULL' ? 'NULL' : image},\n` +
    `    false,\n` +
    `    ${isPyq},\n` +
    `    ${pyqYear === 'NULL' ? 'NULL' : pyqYear},\n` +
    `    ${correctAnswerB === 'NULL' ? 'NULL' : correctAnswerB}\n` +
    `  )`
  );
}

function main() {
  const { inPath, outPath } = parseArgs();
  const abs = path.isAbsolute(inPath) ? inPath : path.join(process.cwd(), inPath);
  if (!fs.existsSync(abs)) {
    console.error(`File not found: ${abs}`);
    process.exit(1);
  }

  const raw = fs.readFileSync(abs, 'utf8');
  let rows;
  try {
    rows = parse(raw, {
      delimiter: '\t',
      columns: (header) => {
        const h = header.map((c) => String(c).replace(/^\ufeff/, '').trim());
        const missing = HEADERS.filter((x) => !h.includes(x));
        if (missing.length) {
          throw new Error(`Missing columns: ${missing.join(', ')}. Found: ${h.join(', ')}`);
        }
        return h;
      },
      skip_empty_lines: true,
      trim: false,
      relax_column_count: true,
    });
  } catch (e) {
    console.error(e.message || e);
    process.exit(1);
  }

  const blocks = [];
  for (let i = 0; i < rows.length; i++) {
    try {
      const sql = rowSql(rows[i], i + 2);
      if (sql) blocks.push(sql);
    } catch (e) {
      console.error(e.message || e);
      process.exit(1);
    }
  }

  if (blocks.length === 0) {
    console.error('No data rows after header.');
    process.exit(1);
  }

  const out =
    `-- CBSE 10 Science — generated from TSV (${path.basename(abs)})\n` +
    `-- Rows: ${blocks.length}\n\n` +
    `INSERT INTO cbse10_science_questions (\n` +
    `  type, prompt, options, correct_answer, explanation,\n` +
    `  domain, difficulty_tier, chapter, subtopic,\n` +
    `  bank_item_id, image_url, qc_done,\n` +
    `  is_pyq, pyq_year, correct_answer_b\n` +
    `)\n` +
    `VALUES\n` +
    `${blocks.join(',\n')}\n` +
    `ON CONFLICT (bank_item_id) DO UPDATE SET\n` +
    `  type              = EXCLUDED.type,\n` +
    `  prompt            = EXCLUDED.prompt,\n` +
    `  options           = EXCLUDED.options,\n` +
    `  correct_answer    = EXCLUDED.correct_answer,\n` +
    `  explanation       = EXCLUDED.explanation,\n` +
    `  domain            = EXCLUDED.domain,\n` +
    `  difficulty_tier   = EXCLUDED.difficulty_tier,\n` +
    `  chapter           = EXCLUDED.chapter,\n` +
    `  subtopic          = EXCLUDED.subtopic,\n` +
    `  image_url         = EXCLUDED.image_url,\n` +
    `  is_pyq            = EXCLUDED.is_pyq,\n` +
    `  pyq_year          = EXCLUDED.pyq_year,\n` +
    `  correct_answer_b  = EXCLUDED.correct_answer_b;\n`;

  if (outPath) {
    const outAbs = path.isAbsolute(outPath) ? outPath : path.join(process.cwd(), outPath);
    fs.mkdirSync(path.dirname(outAbs), { recursive: true });
    fs.writeFileSync(outAbs, out, 'utf8');
    console.error(`Wrote ${outAbs}`);
  } else {
    process.stdout.write(out);
  }
}

main();
