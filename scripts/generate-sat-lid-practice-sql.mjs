/**
 * TeX bank → sat_questions practice seed (module_number=0, set_number=0).
 *
 * Usage:
 *   node scripts/generate-sat-lid-practice-sql.mjs --lid=2
 *   node scripts/generate-sat-lid-practice-sql.mjs --lid=1 --bank-ddl --out supabase/migrations/sat/20260320120000_seed_sat_lid_001_practice_sat_questions.sql
 */
import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');

const DIFF_MAP = { easy: 'easy', medium: 'medium', hard: 'hard' };

const UNIT_TO_DOMAIN = {
  'algebra': 'algebra',
  'advanced math': 'advanced-math',
  'problem-solving & data analysis': 'problem-solving',
  'one-variable data': 'problem-solving',
  'two-variable data': 'problem-solving',
  'probability': 'problem-solving',
  'inference': 'problem-solving',
  'geometry & trigonometry': 'geometry-trig',
  'lines & angles': 'geometry-trig',
  'triangles': 'geometry-trig',
  'area & volume': 'geometry-trig',
  'circles': 'geometry-trig',
  'trigonometry': 'geometry-trig',
};

function parseArgs() {
  const a = process.argv.slice(2);
  let lid = null;
  let out = null;
  let bankDdl = false;
  let domainOverride = null;
  let generateBackfill = false;
  for (const x of a) {
    if (x.startsWith('--lid=')) lid = x.slice(6);
    else if (x.startsWith('--out=')) out = x.slice(6);
    else if (x === '--bank-ddl') bankDdl = true;
    else if (x.startsWith('--domain=')) domainOverride = x.slice(9);
    else if (x === '--generate-backfill') generateBackfill = true;
  }
  if (generateBackfill) return { generateBackfill: true };
  if (!lid) {
    console.error('Usage: node scripts/generate-sat-lid-practice-sql.mjs --lid=NNN [--out=path] [--bank-ddl] [--domain=override]');
    console.error('       node scripts/generate-sat-lid-practice-sql.mjs --generate-backfill');
    process.exit(1);
  }
  const n = parseInt(String(lid), 10);
  if (Number.isNaN(n) || n < 1) {
    console.error('Invalid --lid');
    process.exit(1);
  }
  const slug = String(n).padStart(3, '0');
  if (!out) {
    const ts =
      n === 1
        ? '20260320120000'
        : `202603201${String(30000 + (n - 2)).padStart(5, '0')}`;
    out = path.join(
      root,
      'supabase',
      'migrations',
      'sat',
      `${ts}_seed_sat_lid_${slug}_practice_sat_questions.sql`
    );
  }
  return { n, slug, out, bankDdl, domainOverride, generateBackfill: false };
}

function esc(s) {
  return s.replace(/\\/g, '\\\\').replace(/'/g, "''");
}

function stripTexNoise(s) {
  return s
    .replace(/\r/g, '')
    .replace(/\\\[10pt\]/g, '\n')
    .replace(/\\\\/g, '\n')
    .replace(/\\\$/g, '')
    .replace(/\\leq/g, '≤')
    .replace(/\\geq/g, '≥')
    .replace(/\\%/g, '%')
    .replace(/\\textit\{([^}]*)\}/g, '$1')
    .replace(/\\Rightarrow/g, '→')
    .replace(/\s+/g, ' ')
    .trim();
}

function texToPlainExpl(tex) {
  let t = tex
    .replace(/\r/g, '')
    .replace(/\\\$/g, '')
    .replace(/\\vspace\{[^}]*\}\s*/g, '')
    .replace(/\\\[10pt\]/g, '\n\n')
    .replace(/\\\\(\s*\[10pt\])?/g, '\n')
    .replace(/\n\\\n/g, '\n')
    .replace(/^\s*\\\s*$/gm, '')
    .replace(/\$([^$]+)\$/g, '$$$1$$')
    .replace(/\\leq/g, '≤')
    .replace(/\\geq/g, '≥')
    .replace(/\\%/g, '%')
    .replace(/\\textit\{([^}]*)\}/g, '$1')
    .replace(/\\implies/g, '→')
    .replace(/\\Rightarrow/g, '→')
    .replace(/\\frac\{([^}]*)\}\{([^}]*)\}/g, '($1)/($2)')
    .replace(/\\div /g, '÷ ')
    .replace(/\\times/g, '×')
    .trim();
  const lines = t.split('\n').map((l) => l.trim()).filter((l) => l && l !== '\\');
  return lines.join('\n\n').trim();
}

function extractHeaderMeta(raw) {
  // TeX headers use either single-brace `\textbf{Unit:}` or double-brace `\textbf{{Unit:}}`
  // Value runs until the closing `}` of the \normalsize wrapper
  const unitM = raw.match(/\\textbf\{+Unit:\}+\s*([^}]+)/);
  const chapterM = raw.match(/\\textbf\{+Chapter:\}+\s*([^}]+)/);
  const topicM = raw.match(/\\textbf\{+Topic:\}+\s*([^}]+)/);

  const clean = (s) => s ? s.replace(/\\&/g, '&').replace(/\s+/g, ' ').trim() : null;
  const unit = clean(unitM?.[1]);
  const chapter = clean(chapterM?.[1]);
  const topic = clean(topicM?.[1]);

  const domain = unit ? UNIT_TO_DOMAIN[unit.toLowerCase()] ?? null : null;

  const noteParts = [];
  if (chapter) noteParts.push(`Chapter: ${chapter}`);
  if (topic) noteParts.push(`Topic: ${topic}`);
  const note = noteParts.length ? noteParts.join(' | ') : null;

  return { unit, chapter, topic, domain, note };
}

function parseBlocks(raw) {
  const blocks = [];
  // `%Q: 26`, `%Q: 26 (note)`, or `% Question 26` (see sat_lid_011.tex)
  const qRegex =
    /%(?:Q:\s*| Question )(\d+)[^\n]*\n([\s\S]*?)(?=%(?:Q:\s*| Question )\d+|% ---|--- PART|$)/g;
  let m;
  while ((m = qRegex.exec(raw)) !== null) {
    blocks.push({ n: parseInt(m[1], 10), body: m[2] });
  }
  return blocks;
}

function parseQuestion(block, slug) {
  const { n, body } = block;
  const diffLine = body.match(/Difficulty:\s*(\w+)/i);
  const typeLine = body.match(/Question Type:\s*([^\n|]+)/i);
  if (!diffLine || !typeLine) throw new Error(`Q${n}: missing meta`);
  const difficulty = DIFF_MAP[diffLine[1].toLowerCase()];
  if (!difficulty) throw new Error(`Q${n}: bad difficulty ${diffLine[1]}`);
  const typeStr = typeLine[1].trim().toLowerCase();
  const isMcq = typeStr.includes('multiple') || typeStr === 'mcq';
  const isSpr = typeStr.includes('numeric') || typeStr === 'spr';
  if (!isMcq && !isSpr) throw new Error(`Q${n}: unknown type ${typeLine[1]}`);

  const qm = body.match(/\\question\s*([\s\S]*?)(?=\\begin\{solution\}|$)/);
  if (!qm) throw new Error(`Q${n}: no question body`);
  let qText = qm[1].trim();
  const tasksStart = qText.indexOf('\\begin{tasks}');
  if (tasksStart >= 0) qText = qText.slice(0, tasksStart).trim();
  qText = stripTexNoise(qText);

  const solM = body.match(/\\begin\{solution\}([\s\S]*?)\\end\{solution\}/);
  if (!solM) throw new Error(`Q${n}: no solution`);
  const sol = solM[1];
  const ansM = sol.match(/Answer:\s*\\colorbox\{[^}]*\}\{([^}]*)\}/);
  if (!ansM) throw new Error(`Q${n}: no answer marker`);
  const letterOrVal = ansM[1].trim();

  const type = isMcq ? 'mcq' : 'spr';
  let options = null;
  let correct = '';
  const tasksM = body.match(/\\begin\{tasks\}\(\d+\)([\s\S]*?)\\end\{tasks\}/);

  if (type === 'mcq') {
    if (!tasksM) throw new Error(`Q${n}: MCQ without tasks`);
    const inner = tasksM[1].replace(/^\s+/, '');
    const parts = inner.split(/\\task\b/).filter((p) => p.trim());
    const tasks = parts.map((p) => p.trim());
    if (tasks.length < 2) throw new Error(`Q${n}: need ≥2 tasks, got ${tasks.length}`);
    const nOpts = Math.min(tasks.length, 4);
    const texts = tasks.slice(0, nOpts).map((t) => stripTexNoise(t));
    const letters = ['a', 'b', 'c', 'd'].slice(0, nOpts);
    options = texts.map((text, i) => ({ id: letters[i], text }));
    let idx = letters.indexOf(letterOrVal.toLowerCase());
    if (idx < 0) {
      // Answer is a value, not a letter — match against option texts
      const cleanAnswer = stripTexNoise(letterOrVal);
      idx = texts.findIndex((t) => t === cleanAnswer);
    }
    if (idx < 0) throw new Error(`Q${n}: bad answer "${letterOrVal}" for options [${texts.join(', ')}]`);
    correct = letters[idx];
  } else {
    options = null;
    correct = letterOrVal.replace(/\s/g, '');
  }

  const explanation = texToPlainExpl(sol.replace(/Answer:\s*\\colorbox\{[^}]*\}\{[^}]*\}[\s\S]*$/m, '').trim());

  return {
    n,
    type,
    prompt: qText,
    options,
    correct_answer: correct,
    explanation: explanation || 'See worked steps in lesson materials.',
    difficulty_tier: difficulty,
    bank_item_id: `sat_lid_${slug}_${n}`,
  };
}

const bankDir = path.join(root, 'Docs for me', 'sat-ecosystem', 'sat_question_bank_maths');

function resolveTexPath(slug) {
  const texLid = path.join(bankDir, `lid_${slug}.tex`);
  const texSatLid = path.join(bankDir, `sat_lid_${slug}.tex`);
  if (fs.existsSync(texLid)) return texLid;
  if (fs.existsSync(texSatLid)) return texSatLid;
  return null;
}

function generateBackfill() {
  let sql = `-- Backfill domain, chapter, subtopic for all LID practice questions\n\n`;
  const texFiles = fs.readdirSync(bankDir).filter((f) => f.endsWith('.tex')).sort();
  let count = 0;

  for (const file of texFiles) {
    const m = file.match(/(?:sat_)?lid_(\d+)\.tex$/);
    if (!m) continue;
    const lidNum = parseInt(m[1], 10);
    const slug = String(lidNum).padStart(3, '0');
    const raw = fs.readFileSync(path.join(bankDir, file), 'utf8');
    const meta = extractHeaderMeta(raw);
    if (!meta.domain) continue;

    const ch = meta.chapter ? `'${esc(meta.chapter)}'` : 'NULL';
    const st = meta.topic ? `'${esc(meta.topic)}'` : 'NULL';
    sql += `UPDATE public.sat_questions SET domain = '${meta.domain}', chapter = ${ch}, subtopic = ${st}\n`;
    sql += `  WHERE bank_item_id LIKE 'sat_lid_${slug}_%';\n\n`;
    count++;
  }

  const outPath = path.join(root, 'supabase', 'migrations', 'sat', '20260320410000_backfill_domain_chapter_subtopic.sql');
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, sql, 'utf8');
  console.log(`Wrote ${outPath} (${count} LIDs)`);
}

const args = parseArgs();

if (args.generateBackfill) {
  generateBackfill();
} else {
  const { slug, out, bankDdl, domainOverride } = args;
  const texPath = resolveTexPath(slug);
  if (!texPath) {
    console.error('Missing TeX file for LID', slug);
    process.exit(1);
  }

  const raw = fs.readFileSync(texPath, 'utf8');
  const meta = extractHeaderMeta(raw);
  const domain = domainOverride ?? meta.domain ?? 'algebra';
  const chapter = meta.chapter ?? null;
  const subtopic = meta.topic ?? null;

  const blocks = parseBlocks(raw);
  const parsed = blocks.map((b) => parseQuestion(b, slug)).sort((a, b) => a.n - b.n);

  const ddl = bankDdl
    ? `ALTER TABLE public.sat_questions ADD COLUMN IF NOT EXISTS bank_item_id TEXT;
-- One stable id per bank row; multiple NULLs still allowed for legacy rows.
CREATE UNIQUE INDEX IF NOT EXISTS sat_questions_bank_item_id_unique
  ON public.sat_questions (bank_item_id);

`
    : '';

  const header = `-- Practice-mode math from lid_${slug}.tex (sat_lid_${slug})
-- ${meta.note ?? 'domain from SAT Quant bank header'}
-- sat_questions: section=math, domain=${domain}, bank_item_id=sat_lid_${slug}_N, practice module/set 0.

${ddl}INSERT INTO public.sat_questions (
  type,
  section,
  prompt,
  options,
  correct_answer,
  explanation,
  domain,
  difficulty_tier,
  module_number,
  set_number,
  bank_item_id,
  chapter,
  subtopic
)
VALUES
`;

  const chapterVal = chapter ? `'${esc(chapter)}'` : 'NULL';
  const subtopicVal = subtopic ? `'${esc(subtopic)}'` : 'NULL';

  const values = parsed.map((q) => {
    const opts = q.type === 'mcq' ? `'${esc(JSON.stringify(q.options))}'::jsonb` : 'NULL';
    const bid = `'${esc(q.bank_item_id)}'`;
    return `  (
  '${q.type}',
  'math',
  '${esc(q.prompt)}',
  ${opts},
  '${esc(q.correct_answer)}',
  '${esc(q.explanation)}',
  '${domain}',
  '${q.difficulty_tier}',
  0,
  0,
  ${bid},
  ${chapterVal},
  ${subtopicVal}
)`;
  });

  const sql = header + values.join(',\n') + `\nON CONFLICT (bank_item_id) DO NOTHING;\n`;

  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, sql, 'utf8');
  console.log(`Wrote ${out} rows: ${parsed.length} (domain=${domain}, chapter=${chapter}, subtopic=${subtopic})`);
}
