import * as fs from 'fs';
import * as path from 'path';

// ── Domain mapping ─────────────────────────────────────────────────

const DOMAIN_MAP: Record<string, string> = {
  'Boundaries': 'standard-english',
  'Grammar': 'standard-english',
  'Transitions': 'expression-of-ideas',
  'Rhetorical Synthesis': 'expression-of-ideas',
  'Text Structure': 'craft-structure',
  'Words in Context': 'craft-structure',
  'Part to Whole Purpose': 'craft-structure',
  'Main Purpose': 'craft-structure',
  'Inference': 'information-ideas',
  'Details': 'information-ideas',
  'Details - Inference': 'information-ideas',
  'Central Idea': 'information-ideas',
  'Cross Text Connection': 'information-ideas',
  'Command of Evidence - Scientific': 'information-ideas',
  'Command of Evidence - Textual': 'information-ideas',
  'Command of Evidence - Quantitative': 'information-ideas',
};

const DIFFICULTY_MAP: Record<string, string> = {
  'Easy': 'easy',
  'Medium': 'medium',
  'Hard': 'hard',
};

// ── Types ──────────────────────────────────────────────────────────

interface ParsedQuestion {
  prompt: string;
  options: { id: string; text: string }[];
  correctAnswer: string;
  explanation: string;
  domain: string;
  difficulty: string;
  questionType: string;
}

interface AssignedQuestion extends ParsedQuestion {
  setNumber: number;
  moduleNumber: number;
}

// ── Parse TSV ──────────────────────────────────────────────────────

function normalize(s: string): string {
  return s.replace(/\r/g, ' ').replace(/\s+/g, ' ').trim();
}

function parseTSV(filePath: string): ParsedQuestion[] {
  const raw = fs.readFileSync(filePath, 'utf-8');
  const lines = raw.split('\n');
  const questions: ParsedQuestion[] = [];

  for (let i = 1; i < lines.length; i++) {
    const line = lines[i];
    if (!line.trim()) continue;

    const cols = line.split('\t');
    if (cols.length < 11) continue;

    const slNo = normalize(cols[0]);
    if (!/^\d+$/.test(slNo)) continue;

    const prompt = normalize(cols[2]);
    const choiceA = normalize(cols[3]);
    const choiceB = normalize(cols[4]);
    const choiceC = normalize(cols[5]);
    const choiceD = normalize(cols[6]);
    const correctRaw = normalize(cols[7]);
    const explanation = normalize(cols[8]);
    const difficultyRaw = normalize(cols[9]);
    const questionType = normalize(cols[10]);

    if (!prompt || !correctRaw || !difficultyRaw || !questionType) continue;

    const domain = DOMAIN_MAP[questionType];
    const difficulty = DIFFICULTY_MAP[difficultyRaw];
    if (!domain || !difficulty) {
      console.warn(`Skipping row ${i + 1}: unknown type="${questionType}" or difficulty="${difficultyRaw}"`);
      continue;
    }

    const stripPrefix = (s: string) => s.replace(/^[A-D]\)\s*/, '');

    questions.push({
      prompt,
      options: [
        { id: 'A', text: stripPrefix(choiceA) },
        { id: 'B', text: stripPrefix(choiceB) },
        { id: 'C', text: stripPrefix(choiceC) },
        { id: 'D', text: stripPrefix(choiceD) },
      ],
      correctAnswer: correctRaw.charAt(0).toUpperCase(),
      explanation,
      domain,
      difficulty,
      questionType,
    });
  }

  return questions;
}

// ── Distribute into sets ───────────────────────────────────────────

function distributeIntoSets(questions: ParsedQuestion[], setCount: number): AssignedQuestion[] {
  const grouped: Record<string, Record<string, ParsedQuestion[]>> = {};
  for (const q of questions) {
    if (!grouped[q.domain]) grouped[q.domain] = {};
    if (!grouped[q.domain][q.difficulty]) grouped[q.domain][q.difficulty] = [];
    grouped[q.domain][q.difficulty].push(q);
  }

  // Shuffle each bucket
  for (const domain of Object.values(grouped)) {
    for (const arr of Object.values(domain)) {
      for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [arr[i], arr[j]] = [arr[j], arr[i]];
      }
    }
  }

  const domains = Object.keys(grouped);
  const assigned: AssignedQuestion[] = [];

  function take(domain: string, difficulty: string): ParsedQuestion | null {
    const arr = grouped[domain]?.[difficulty];
    if (!arr || arr.length === 0) return null;
    return arr.shift()!;
  }

  function takeAny(difficulties: string[]): ParsedQuestion | null {
    for (const diff of difficulties) {
      for (const dom of domains) {
        const q = take(dom, diff);
        if (q) return q;
      }
    }
    return null;
  }

  function takeFromDomain(domain: string, difficulties: string[]): ParsedQuestion | null {
    for (const diff of difficulties) {
      const q = take(domain, diff);
      if (q) return q;
    }
    return null;
  }

  for (let s = 1; s <= setCount; s++) {
    // Module 1: 27 mixed questions — ~7 per domain, balanced difficulty
    const m1: ParsedQuestion[] = [];
    const perDomainM1 = Math.floor(27 / domains.length);
    const extraM1 = 27 - perDomainM1 * domains.length;

    for (let di = 0; di < domains.length; di++) {
      const count = perDomainM1 + (di < extraM1 ? 1 : 0);
      const perDiff = Math.floor(count / 3);
      const extraDiff = count - perDiff * 3;

      for (let d = 0; d < perDiff; d++) {
        const q = takeFromDomain(domains[di], ['easy']);
        if (q) m1.push(q);
      }
      for (let d = 0; d < perDiff; d++) {
        const q = takeFromDomain(domains[di], ['medium']);
        if (q) m1.push(q);
      }
      for (let d = 0; d < perDiff + extraDiff; d++) {
        const q = takeFromDomain(domains[di], ['hard', 'medium', 'easy']);
        if (q) m1.push(q);
      }
    }
    // Fill any shortfall
    while (m1.length < 27) {
      const q = takeAny(['medium', 'easy', 'hard']);
      if (!q) break;
      m1.push(q);
    }
    for (const q of m1) {
      assigned.push({ ...q, setNumber: s, moduleNumber: 1 });
    }

    // Module 2 Easy: 27 easy/medium questions
    const m2e: ParsedQuestion[] = [];
    while (m2e.length < 27) {
      const q = takeAny(['easy', 'medium']);
      if (!q) break;
      m2e.push(q);
    }
    for (const q of m2e) {
      assigned.push({ ...q, setNumber: s, moduleNumber: 2, difficulty: q.difficulty === 'hard' ? 'medium' : q.difficulty });
    }

    // Module 2 Hard: 27 medium/hard questions
    const m2h: ParsedQuestion[] = [];
    while (m2h.length < 27) {
      const q = takeAny(['hard', 'medium']);
      if (!q) break;
      m2h.push(q);
    }
    for (const q of m2h) {
      assigned.push({ ...q, setNumber: s, moduleNumber: 2 });
    }
  }

  return assigned;
}

// ── Generate SQL ───────────────────────────────────────────────────

function escapeSQL(s: string): string {
  return s.replace(/'/g, "''");
}

function generateSQL(questions: AssignedQuestion[]): string {
  const lines: string[] = [
    '-- Auto-generated: R&W question seed (3 sets)',
    '-- Source: Docs for me/sat-ecosystem/sat_question_bank_verbal/question_bank_sat_verbal.tsv',
    '',
    'INSERT INTO sat_questions (type, section, prompt, options, correct_answer, explanation, domain, difficulty_tier, module_number, set_number)',
    'VALUES',
  ];

  const values: string[] = [];

  for (const q of questions) {
    const optionsJson = JSON.stringify(q.options);
    values.push(
      `  ('mcq', 'rw', '${escapeSQL(q.prompt)}', '${escapeSQL(optionsJson)}'::jsonb, '${escapeSQL(q.correctAnswer)}', '${escapeSQL(q.explanation)}', '${q.domain}', '${q.difficulty}', ${q.moduleNumber}, ${q.setNumber})`
    );
  }

  lines.push(values.join(',\n') + ';');

  // Summary comment
  const sets = new Set(questions.map((q) => q.setNumber));
  for (const s of sets) {
    const setQs = questions.filter((q) => q.setNumber === s);
    const m1 = setQs.filter((q) => q.moduleNumber === 1);
    const m2e = setQs.filter((q) => q.moduleNumber === 2 && (q.difficulty === 'easy' || q.difficulty === 'medium'));
    const m2h = setQs.filter((q) => q.moduleNumber === 2 && q.difficulty === 'hard');
    const m2med = setQs.filter((q) => q.moduleNumber === 2 && q.difficulty === 'medium');
    lines.push('');
    lines.push(`-- Set ${s}: M1=${m1.length}, M2 total=${setQs.length - m1.length}`);
  }

  lines.push('');
  lines.push(`-- Total rows: ${questions.length}`);

  return lines.join('\n') + '\n';
}

// ── Main ───────────────────────────────────────────────────────────

const tsvPath = path.join(__dirname, '..', 'Docs for me', 'sat-ecosystem', 'sat_question_bank_verbal', 'question_bank_sat_verbal.tsv');
const outPath = path.join(__dirname, '..', 'supabase', 'migrations', '20260312200000_seed_rw_set1_set2_set3.sql');

console.log('Parsing TSV...');
const allQuestions = parseTSV(tsvPath);
console.log(`Parsed ${allQuestions.length} questions`);

console.log('Distributing into 3 sets...');
const assigned = distributeIntoSets(allQuestions, 3);
console.log(`Assigned ${assigned.length} questions`);

// Summary
for (let s = 1; s <= 3; s++) {
  const setQs = assigned.filter((q) => q.setNumber === s);
  const m1 = setQs.filter((q) => q.moduleNumber === 1).length;
  const m2 = setQs.filter((q) => q.moduleNumber === 2).length;
  console.log(`  Set ${s}: M1=${m1}, M2=${m2}, total=${setQs.length}`);
}

console.log('Generating SQL...');
const sql = generateSQL(assigned);
fs.writeFileSync(outPath, sql);
console.log(`Written to ${outPath}`);
console.log('Done!');
