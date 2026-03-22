/**
 * Extract TikZ diagrams from ALL LID TeX files, render to PNG, emit manifest.
 *
 * Usage:
 *   node scripts/extract-lid-tikz-images.mjs                      # full render
 *   node scripts/extract-lid-tikz-images.mjs --dry-run             # inventory only (still writes manifest)
 *   node scripts/extract-lid-tikz-images.mjs --generate-sql        # emit UPDATE migration from manifest
 *   node scripts/extract-lid-tikz-images.mjs --generate-cleanup-sql # strip TikZ from prompts migration
 *
 * Requires (for rendering): pdflatex (TeX Live), ImageMagick (convert)
 */

import * as fs from 'fs';
import * as path from 'path';
import { execSync } from 'child_process';
import os from 'os';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, '..');
const TEX_DIR = path.join(ROOT, 'Docs for me', 'sat-ecosystem', 'sat_question_bank_maths');
const OUT_DIR = path.join(ROOT, 'output', 'math', 'lid');
const MANIFEST_PATH = path.join(ROOT, 'output', 'lid-images.manifest.json');

const DRY_RUN = process.argv.includes('--dry-run');
const GENERATE_SQL = process.argv.includes('--generate-sql');
const GENERATE_CLEANUP = process.argv.includes('--generate-cleanup-sql');

const STANDALONE_PREAMBLE = `\\documentclass[border=10pt]{standalone}
\\usepackage{graphicx}
\\usepackage{upgreek}
\\usepackage{gensymb}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{xcolor}
\\usepackage{tikz}
\\usepackage{pgfplots}
\\pgfplotsset{compat=1.18}
\\usetikzlibrary{arrows,arrows.meta,calc,patterns,decorations.markings,shapes}
`;

/* ── Question-boundary parser (same regex as generate-sat-lid-practice-sql.mjs) ── */

function parseBlocks(raw) {
  const blocks = [];
  const qRegex =
    /%(?:Q:\s*| Question )(\d+)[^\n]*\n([\s\S]*?)(?=%(?:Q:\s*| Question )\d+|% ---|--- PART|$)/g;
  let m;
  while ((m = qRegex.exec(raw)) !== null) {
    blocks.push({ n: parseInt(m[1], 10), body: m[2] });
  }
  return blocks;
}

/* ── Helpers ── */

function resolveLidNumber(fileName) {
  const m = fileName.match(/(?:sat_)?lid_(\d+)\.tex$/);
  return m ? parseInt(m[1], 10) : null;
}

function bankItemId(lidNum, qNum) {
  return `sat_lid_${String(lidNum).padStart(3, '0')}_${qNum}`;
}

function figureSuffix(idx) {
  if (idx <= 1) return '';
  return '_' + String.fromCharCode(96 + idx); // 2→_b, 3→_c
}

/* ── Scan a single TeX file for figures ── */

function scanFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf-8');
  const fileName = path.basename(filePath);
  const lidNum = resolveLidNumber(fileName);
  if (lidNum === null) return [];

  const blocks = parseBlocks(content);
  const entries = [];

  for (const block of blocks) {
    const { n, body } = block;
    const bid = bankItemId(lidNum, n);
    let figIdx = 0;

    const tikzRegex = /\\begin\{tikzpicture\}[\s\S]*?\\end\{tikzpicture\}/g;
    let match;
    while ((match = tikzRegex.exec(body)) !== null) {
      figIdx++;
      const suffix = figureSuffix(figIdx);
      entries.push({
        bank_item_id: `${bid}${suffix}`,
        texFile: fileName,
        questionNumber: n,
        lidNumber: lidNum,
        figureKind: 'tikz',
        tikzContent: match[0],
        objectPath: `math/lid/${bid}${suffix}.png`,
      });
    }

    // Standalone \includegraphics (outside tikzpicture blocks)
    const bodyNoTikz = body.replace(/\\begin\{tikzpicture\}[\s\S]*?\\end\{tikzpicture\}/g, '');
    const igRegex = /\\includegraphics(?:\[[^\]]*\])?\{([^}]+)\}/g;
    let igMatch;
    while ((igMatch = igRegex.exec(bodyNoTikz)) !== null) {
      figIdx++;
      const suffix = figureSuffix(figIdx);
      entries.push({
        bank_item_id: `${bid}${suffix}`,
        texFile: fileName,
        questionNumber: n,
        lidNumber: lidNum,
        figureKind: 'includegraphics',
        externalFile: igMatch[1],
        objectPath: `math/lid/${bid}${suffix}.png`,
      });
    }
  }

  return entries;
}

/* ── Render a TikZ entry to PNG via pdflatex + convert ── */

function renderTikzToPng(entry, tmpDir) {
  const texContent = `${STANDALONE_PREAMBLE}
\\begin{document}
${entry.tikzContent}
\\end{document}
`;
  const safeName = entry.bank_item_id;
  const texPath = path.join(tmpDir, `${safeName}.tex`);
  const pdfPath = path.join(tmpDir, `${safeName}.pdf`);
  const pngPath = path.join(OUT_DIR, `${safeName}.png`);

  fs.writeFileSync(texPath, texContent, 'utf-8');

  try {
    execSync(
      `pdflatex -interaction=nonstopmode -output-directory="${tmpDir}" "${texPath}"`,
      { stdio: 'pipe', timeout: 30_000 }
    );
  } catch {
    const logPath = path.join(tmpDir, `${safeName}.log`);
    if (fs.existsSync(logPath)) {
      const log = fs.readFileSync(logPath, 'utf-8');
      const errorLines = log.split('\n').filter((l) => l.startsWith('!')).slice(0, 3);
      console.error(`    pdflatex FAILED ${safeName}: ${errorLines.join(' | ') || 'see log'}`);
    } else {
      console.error(`    pdflatex FAILED ${safeName}`);
    }
    return false;
  }

  if (!fs.existsSync(pdfPath)) {
    console.error(`    No PDF produced for ${safeName}`);
    return false;
  }

  try {
    execSync(
      `convert -density 300 "${pdfPath}" -quality 100 -background white -flatten "${pngPath}"`,
      { stdio: 'pipe', timeout: 30_000 }
    );
  } catch (err) {
    console.error(`    convert FAILED ${safeName}: ${err}`);
    return false;
  }

  return fs.existsSync(pngPath);
}

/* ── --generate-sql: read manifest, emit UPDATE migration ── */

function loadSupabaseUrl() {
  const envLocal = path.join(ROOT, '.env.local');
  const vars = {};
  if (fs.existsSync(envLocal)) {
    for (const line of fs.readFileSync(envLocal, 'utf-8').split('\n')) {
      const m = line.match(/^([A-Z_]+)=(.+)$/);
      if (m) vars[m[1]] = m[2].trim().replace(/^["']|["']$/g, '');
    }
  }
  const merged = { ...vars, ...process.env };
  const e = (merged.NEXT_PUBLIC_ENVIRONMENT || '').toLowerCase();
  const isProd = e === 'prod' || e === 'production' || (!e && process.env.NODE_ENV === 'production');
  const url = isProd
    ? (merged.NEXT_PUBLIC_SUPABASE_URL_PROD || merged.NEXT_PUBLIC_SUPABASE_URL)
    : (merged.NEXT_PUBLIC_SUPABASE_URL_DEV || merged.NEXT_PUBLIC_SUPABASE_URL);
  if (url) console.log(`Using ${isProd ? 'prod' : 'dev'} Supabase: ${url}`);
  return url || null;
}

function generateSql() {
  if (!fs.existsSync(MANIFEST_PATH)) {
    console.error('Manifest not found at', MANIFEST_PATH);
    console.error('Run without --generate-sql first to create it.');
    process.exit(1);
  }

  const manifest = JSON.parse(fs.readFileSync(MANIFEST_PATH, 'utf-8'));
  const supabaseUrl = loadSupabaseUrl();
  if (!supabaseUrl) {
    console.error('NEXT_PUBLIC_SUPABASE_URL not set. Export it or add to .env.local');
    process.exit(1);
  }

  const base = `${supabaseUrl.replace(/\/$/, '')}/storage/v1/object/public/sat-question-images`;

  let sql = `-- Auto-generated: set image_url for LID practice questions with diagrams\n`;
  sql += `-- Source: lid-images.manifest.json (${manifest.length} entries)\n\n`;

  let count = 0;
  for (const entry of manifest) {
    const url = `${base}/${entry.objectPath}`;
    sql += `UPDATE public.sat_questions\n`;
    sql += `  SET image_url = '${url}'\n`;
    sql += `  WHERE bank_item_id = '${entry.bank_item_id}';\n\n`;
    count++;
  }

  const outPath = path.join(
    ROOT, 'supabase', 'migrations', 'sat',
    '20260320300000_set_lid_image_urls.sql'
  );
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, sql, 'utf-8');
  console.log(`Wrote ${outPath} (${count} UPDATE statements)`);
}

/* ── --generate-cleanup-sql: strip TikZ from prompts where image_url is set ── */

function generateCleanupSql() {
  if (!fs.existsSync(MANIFEST_PATH)) {
    console.error('Manifest not found at', MANIFEST_PATH);
    console.error('Run without flags first to create it.');
    process.exit(1);
  }

  const manifest = JSON.parse(fs.readFileSync(MANIFEST_PATH, 'utf-8'));
  const bids = [...new Set(manifest.map((e) => e.bank_item_id))];

  let sql = `-- Auto-generated: strip TikZ diagram code from prompts after image_url is linked\n`;
  sql += `-- Applies to ${bids.length} bank_item_ids from lid-images.manifest.json\n`;
  sql += `-- Safe to re-run: no-op if TikZ already stripped.\n\n`;

  // Stored prompts use esc() which doubles backslashes: \begin → \\begin in the DB.
  // Standard string literals (standard_conforming_strings=on): no escape processing.
  // Regex: \\\\ matches two literal backslashes, \{ matches literal {, \s matches whitespace.
  sql += `UPDATE public.sat_questions\n`;
  sql += `SET prompt = trim(regexp_replace(\n`;
  sql += `  regexp_replace(\n`;
  sql += `    prompt,\n`;
  sql += `    '\\\\\\\\begin\\{center\\}\\s*\\\\\\\\begin\\{tikzpicture\\}(\\[[^]]*\\])?[\\s\\S]*?\\\\\\\\end\\{tikzpicture\\}\\s*\\\\\\\\end\\{center\\}',\n`;
  sql += `    '[See diagram]',\n`;
  sql += `    'gs'\n`;
  sql += `  ),\n`;
  sql += `  '\\\\\\\\begin\\{tikzpicture\\}(\\[[^]]*\\])?[\\s\\S]*?\\\\\\\\end\\{tikzpicture\\}',\n`;
  sql += `  '[See diagram]',\n`;
  sql += `  'gs'\n`;
  sql += `))\n`;
  sql += `WHERE image_url IS NOT NULL\n`;
  sql += `  AND prompt LIKE '%tikzpicture%';\n`;

  const outPath = path.join(
    ROOT, 'supabase', 'migrations', 'sat',
    '20260320310000_strip_tikz_from_prompts.sql'
  );
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, sql, 'utf-8');
  console.log(`Wrote ${outPath}`);
}

/* ── Main: inventory + optional render ── */

function main() {
  if (GENERATE_SQL) {
    generateSql();
    return;
  }

  if (GENERATE_CLEANUP) {
    generateCleanupSql();
    return;
  }

  console.log(`Mode: ${DRY_RUN ? 'DRY RUN (inventory only)' : 'LIVE (render PNGs)'}`);
  console.log(`Source: ${TEX_DIR}\n`);

  const texFiles = fs.readdirSync(TEX_DIR)
    .filter((f) => f.endsWith('.tex'))
    .sort();
  console.log(`Found ${texFiles.length} .tex files\n`);

  let allEntries = [];

  for (const file of texFiles) {
    const entries = scanFile(path.join(TEX_DIR, file));
    const tikzCount = entries.filter((e) => e.figureKind === 'tikz').length;
    const igCount = entries.filter((e) => e.figureKind === 'includegraphics').length;

    if (entries.length > 0) {
      console.log(`  ${file}: ${tikzCount} tikz, ${igCount} includegraphics`);
      for (const e of entries) {
        const note = e.figureKind === 'includegraphics' ? ` [external: ${e.externalFile}]` : '';
        console.log(`    -> ${e.objectPath} (Q${e.questionNumber})${note}`);
      }
    } else {
      console.log(`  ${file}: no figures`);
    }
    allEntries = allEntries.concat(entries);
  }

  const tikzTotal = allEntries.filter((e) => e.figureKind === 'tikz').length;
  const igTotal = allEntries.filter((e) => e.figureKind === 'includegraphics').length;
  console.log(`\nTotal: ${tikzTotal} tikz diagrams, ${igTotal} includegraphics references`);

  // Write manifest (always — even in dry-run)
  fs.mkdirSync(path.dirname(MANIFEST_PATH), { recursive: true });
  const manifestData = allEntries.map((e) => ({
    bank_item_id: e.bank_item_id,
    texFile: e.texFile,
    questionNumber: e.questionNumber,
    lidNumber: e.lidNumber,
    figureKind: e.figureKind,
    objectPath: e.objectPath,
    ...(e.externalFile ? { externalFile: e.externalFile } : {}),
  }));
  fs.writeFileSync(MANIFEST_PATH, JSON.stringify(manifestData, null, 2), 'utf-8');
  console.log(`Manifest written: ${MANIFEST_PATH}`);

  if (DRY_RUN) {
    console.log('\nDRY RUN — skipping rendering.');
    return;
  }

  // Render tikz diagrams only
  const tikzEntries = allEntries.filter((e) => e.figureKind === 'tikz');
  if (tikzEntries.length === 0) {
    console.log('\nNo TikZ diagrams to render.');
    return;
  }

  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), 'lid-tikz-'));
  console.log(`\nTemp directory: ${tmpDir}`);
  fs.mkdirSync(OUT_DIR, { recursive: true });

  let success = 0;
  let failed = 0;
  const failures = [];

  for (const entry of tikzEntries) {
    process.stdout.write(`  Rendering ${entry.bank_item_id}...`);
    if (renderTikzToPng(entry, tmpDir)) {
      console.log(' OK');
      success++;
    } else {
      console.log(' FAILED');
      failed++;
      failures.push(entry.bank_item_id);
    }
  }

  console.log(`\n══════════════════ RESULTS ══════════════════`);
  console.log(`  TikZ success: ${success}`);
  console.log(`  TikZ failed:  ${failed}`);
  if (igTotal > 0) console.log(`  includegraphics (manual): ${igTotal}`);
  console.log(`  Output dir: ${OUT_DIR}`);
  console.log(`  Manifest:   ${MANIFEST_PATH}`);
  if (failures.length > 0) {
    console.log(`\n  Failed IDs:`);
    for (const id of failures) console.log(`    - ${id}`);
  }
  console.log(`═════════════════════════════════════════════`);

  try {
    fs.rmSync(tmpDir, { recursive: true });
  } catch {
    console.log(`Note: temp dir not cleaned up: ${tmpDir}`);
  }
}

main();
