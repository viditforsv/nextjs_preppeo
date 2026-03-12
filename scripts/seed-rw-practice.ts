import * as fs from 'fs';
import * as path from 'path';

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

interface ParsedQuestion {
  prompt: string;
  options: { id: string; text: string }[];
  correctAnswer: string;
  explanation: string;
  domain: string;
  difficulty: string;
}

function normalize(s: string): string {
  return s.replace(/\r/g, ' ').replace(/\s+/g, ' ').trim();
}

function escapeSQL(s: string): string {
  return s.replace(/'/g, "''");
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
    if (!domain || !difficulty) continue;

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
    });
  }

  return questions;
}

function extractSeededPrompts(seedSqlPath: string): Set<string> {
  const sql = fs.readFileSync(seedSqlPath, 'utf-8');
  const prompts = new Set<string>();
  // Extract first 60 chars of each prompt for matching
  const regex = /'mcq', 'rw', '([^']{60})/g;
  let match;
  while ((match = regex.exec(sql)) !== null) {
    prompts.add(match[1].replace(/''/g, "'"));
  }
  return prompts;
}

// ── Main ────────────────────────────────────────────────────────────

const tsvPath = path.join(__dirname, '..', 'Docs for me', 'sat-ecosystem', 'sat_question_bank_verbal', 'question_bank_sat_verbal.tsv');
const seedPath = path.join(__dirname, '..', 'supabase', 'migrations', '20260312200000_seed_rw_set1_set2_set3.sql');
const outPath = path.join(__dirname, '..', 'supabase', 'migrations', '20260312400000_seed_rw_practice_questions.sql');

console.log('Parsing TSV...');
const allQuestions = parseTSV(tsvPath);
console.log(`Total parsed: ${allQuestions.length}`);

console.log('Reading already-seeded prompts...');
const seeded = extractSeededPrompts(seedPath);
console.log(`Already seeded: ${seeded.size} prompt prefixes`);

const practiceQuestions = allQuestions.filter(
  (q) => !seeded.has(q.prompt.substring(0, 60))
);
console.log(`Practice-only questions: ${practiceQuestions.length}`);

// Generate SQL
const lines: string[] = [
  '-- Auto-generated: R&W practice questions (not used in test sets)',
  '-- module_number=0, set_number=0 marks these as practice-only',
  '',
  'INSERT INTO sat_questions (type, section, prompt, options, correct_answer, explanation, domain, difficulty_tier, module_number, set_number)',
  'VALUES',
];

const values: string[] = [];
for (const q of practiceQuestions) {
  const optionsJson = JSON.stringify(q.options);
  values.push(
    `  ('mcq', 'rw', '${escapeSQL(q.prompt)}', '${escapeSQL(optionsJson)}'::jsonb, '${escapeSQL(q.correctAnswer)}', '${escapeSQL(q.explanation)}', '${q.domain}', '${q.difficulty}', 0, 0)`
  );
}

lines.push(values.join(',\n') + ';');

// Summary by domain/difficulty
const domains = [...new Set(practiceQuestions.map((q) => q.domain))];
for (const d of domains) {
  const dqs = practiceQuestions.filter((q) => q.domain === d);
  const easy = dqs.filter((q) => q.difficulty === 'easy').length;
  const med = dqs.filter((q) => q.difficulty === 'medium').length;
  const hard = dqs.filter((q) => q.difficulty === 'hard').length;
  lines.push('');
  lines.push(`-- ${d}: easy=${easy}, medium=${med}, hard=${hard}, total=${dqs.length}`);
}

lines.push('');
lines.push(`-- Total practice rows: ${practiceQuestions.length}`);

const sql = lines.join('\n') + '\n';
fs.writeFileSync(outPath, sql);
console.log(`Written to ${outPath}`);
console.log('Done!');
