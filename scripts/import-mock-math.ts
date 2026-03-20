/**
 * Import SAT mock math questions from .tex files into the sat_questions table.
 *
 * Usage: npx tsx scripts/import-mock-math.ts [--dry-run]
 *
 * Reads .tex files from Docs for me/sat-ecosystem/sat_question_bank_maths_mocks/,
 * parses questions, maps images, assigns to sets/modules per the rubric, and
 * replaces existing Set 1 math questions in the database.
 */

import fs from 'fs';
import path from 'path';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: path.resolve(__dirname, '../.env.local') });

const DRY_RUN = process.argv.includes('--dry-run');

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;

const TEX_DIR = path.resolve(__dirname, '../Docs for me/sat-ecosystem/sat_question_bank_maths_mocks');
const IMG_DIR = path.join(TEX_DIR, 'images');

// ── Domain mapping ──────────────────────────────────────────────────────────

const DOMAIN_MAP: Record<string, string> = {
  alg: 'algebra',
  am: 'advanced-math',
  geo: 'geometry-trig',
  psda: 'problem-solving',
};

const DIFFICULTY_MAP: Record<string, string> = {
  easy: 'easy',
  med: 'medium',
  medium: 'medium',
  hard: 'hard',
};

// ── Rubric: per-module question distribution ────────────────────────────────

// Each entry = [domain, difficulty, count]
type ModuleTemplate = { moduleNumber: number; needs: [string, string, number][] };

// Module 1: 22 Qs — 5 Easy, 12 Medium, 5 Hard — Alg:8, AM:7, PSDA:3, Geo:4
const MODULE_1: ModuleTemplate = {
  moduleNumber: 1,
  needs: [
    ['algebra', 'easy', 2], ['advanced-math', 'easy', 1], ['problem-solving', 'easy', 1], ['geometry-trig', 'easy', 1],
    ['algebra', 'medium', 4], ['advanced-math', 'medium', 4], ['problem-solving', 'medium', 2], ['geometry-trig', 'medium', 2],
    ['algebra', 'hard', 2], ['advanced-math', 'hard', 2], ['geometry-trig', 'hard', 1],
  ],
};

// Module 2 Easy: 22 Qs — 10 Easy, 10 Medium, 2 Hard — Alg:8, AM:8, PSDA:3, Geo:3
const MODULE_2E: ModuleTemplate = {
  moduleNumber: 2,
  needs: [
    ['algebra', 'easy', 3], ['advanced-math', 'easy', 3], ['problem-solving', 'easy', 2], ['geometry-trig', 'easy', 2],
    ['algebra', 'medium', 3], ['advanced-math', 'medium', 3], ['problem-solving', 'medium', 2], ['geometry-trig', 'medium', 2],
    ['algebra', 'hard', 1], ['advanced-math', 'hard', 1],
  ],
};

// Module 2 Hard: 22 Qs — 2 Easy, 10 Medium, 10 Hard — Alg:8, AM:8, PSDA:3, Geo:3
const MODULE_2H: ModuleTemplate = {
  moduleNumber: 2,
  needs: [
    ['algebra', 'easy', 1], ['advanced-math', 'easy', 1],
    ['algebra', 'medium', 3], ['advanced-math', 'medium', 3], ['problem-solving', 'medium', 2], ['geometry-trig', 'medium', 2],
    ['algebra', 'hard', 2], ['advanced-math', 'hard', 3], ['problem-solving', 'hard', 1], ['geometry-trig', 'hard', 2],
    ['advanced-math', 'hard', 1], ['algebra', 'hard', 1],
  ],
};

// ── Question type ───────────────────────────────────────────────────────────

interface ParsedQuestion {
  prompt: string;
  type: 'mcq' | 'spr';
  options: { id: string; text: string }[] | null;
  correctAnswer: string;
  explanation: string;
  domain: string;
  difficulty: string;
  imageUrls: string[];
  sourceFile: string;
  questionIndex: number;
  hasDiagram: boolean;
  diagramOrder: number; // 1-based: which diagram in the file (0 = no diagram)
}

// ── LaTeX cleanup ───────────────────────────────────────────────────────────

function cleanLatex(text: string): string {
  return text
    .replace(/\\vspace\{[^}]*\}/g, '')
    .replace(/\\hspace\{[^}]*\}/g, '')
    .replace(/\\begin\{center\}/g, '')
    .replace(/\\end\{center\}/g, '')
    .replace(/\\noindent/g, '')
    .replace(/\\colorbox\{yellow!100\}\{[^}]*\}/g, '')
    // Only strip \\ that are standalone line breaks (end of line or followed by space/newline)
    // Preserve \\ inside math environments (e.g. \\frac is actually \frac in the file)
    .replace(/\\\\[\t ]*$/gm, '')
    .replace(/\\\\(?=\s*\n)/g, '')
    .replace(/^\s*Answer:\s*$/gm, '')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function stripTikz(text: string): string {
  return text.replace(/\\begin\{tikzpicture\}[\s\S]*?\\end\{tikzpicture\}/g, '[See diagram]');
}

function cleanPrompt(text: string): string {
  let cleaned = stripTikz(text);
  cleaned = cleanLatex(cleaned);
  cleaned = cleaned.replace(/^\s*%.*$/gm, '');
  cleaned = cleaned.replace(/\n{3,}/g, '\n\n').trim();
  return cleaned;
}

function cleanOption(text: string): string {
  return text
    .replace(/\\vspace\{[^}]*\}/g, '')
    .replace(/\\hspace\{[^}]*\}/g, '')
    .replace(/\\\\[\t ]*$/gm, '')
    .trim();
}

function cleanExplanation(text: string): string {
  let cleaned = stripTikz(text);
  cleaned = cleanLatex(cleaned);
  cleaned = cleaned.replace(/^\s*%.*$/gm, '');
  // Strip the "Answer: X" line from explanations since we extract correctAnswer separately
  cleaned = cleaned.replace(/^\s*Answer:\s*$/gm, '');
  cleaned = cleaned.replace(/\n{3,}/g, '\n\n').trim();
  return cleaned;
}

// ── Parser ──────────────────────────────────────────────────────────────────

function parseTexFile(filePath: string): ParsedQuestion[] {
  const content = fs.readFileSync(filePath, 'utf-8');
  const fileName = path.basename(filePath, '.tex');

  // Extract domain and difficulty from filename
  // Format: {domainCode}_sat_{difficulty}_{type}_{count}
  const parts = fileName.split('_');
  const domainCode = parts[0];
  const difficultyRaw = parts[2];
  const typeRaw = parts[3]; // mcq or spr

  const domain = DOMAIN_MAP[domainCode];
  const difficulty = DIFFICULTY_MAP[difficultyRaw];
  const qType: 'mcq' | 'spr' = typeRaw === 'spr' ? 'spr' : 'mcq';

  if (!domain || !difficulty) {
    console.warn(`Skipping ${fileName}: unknown domain=${domainCode} or difficulty=${difficultyRaw}`);
    return [];
  }

  // Extract the questions section
  const questionsMatch = content.match(/\\begin\{questions\}([\s\S]*?)\\end\{questions\}/);
  if (!questionsMatch) {
    console.warn(`No questions block found in ${fileName}`);
    return [];
  }

  const questionsBlock = questionsMatch[1];

  // Split on \question
  const questionChunks = questionsBlock.split(/\\question\s*\n/).slice(1);

  const results: ParsedQuestion[] = [];
  let diagramCounter = 0;

  for (let i = 0; i < questionChunks.length; i++) {
    const chunk = questionChunks[i];

    // Detect diagrams BEFORE stripping
    const solStart = chunk.indexOf('\\begin{solution}');
    const promptPart = solStart >= 0 ? chunk.substring(0, solStart) : chunk;
    const hasDiagramInPrompt = /\\begin\{tikzpicture\}/.test(promptPart) ||
                               /\\includegraphics/.test(promptPart);
    // Count diagrams anywhere in the chunk (prompt OR solution) for image numbering
    const hasDiagramAnywhere = /\\begin\{tikzpicture\}/.test(chunk) ||
                               /\\includegraphics/.test(chunk);
    const hasDiagram = hasDiagramInPrompt;
    const diagramOrder = hasDiagramAnywhere ? ++diagramCounter : 0;

    // Extract solution
    const solMatch = chunk.match(/\\begin\{solution\}([\s\S]*?)\\end\{solution\}/);
    const solutionRaw = solMatch ? solMatch[1] : '';

    // Extract correct answer
    let correctAnswer = '';
    const answerMatch = solutionRaw.match(/\\colorbox\{yellow!100\}\{([^}]+)\}/);
    if (answerMatch) {
      const ans = answerMatch[1].trim();
      if (/^[A-D]$/.test(ans)) {
        correctAnswer = ans.toLowerCase();
      } else {
        correctAnswer = ans;
      }
    }

    // Extract prompt and options
    let prompt = '';
    let options: { id: string; text: string }[] | null = null;

    if (qType === 'mcq') {
      const tasksMatch = chunk.match(/\\begin\{tasks\}[\s\S]*?\\end\{tasks\}/);
      if (tasksMatch) {
        const beforeTasks = chunk.substring(0, chunk.indexOf('\\begin{tasks}'));
        prompt = cleanPrompt(beforeTasks);

        const tasksBlock = tasksMatch[0];
        const taskItems = tasksBlock.split(/\\task\s+/).slice(1);
        const optionIds = ['a', 'b', 'c', 'd'];
        options = taskItems.map((t, idx) => ({
          id: optionIds[idx] || `opt${idx}`,
          text: cleanOption(t.replace(/\\end\{tasks\}.*$/s, '').trim()),
        }));
      } else {
        const beforeSol = chunk.substring(0, chunk.indexOf('\\begin{solution}'));
        prompt = cleanPrompt(beforeSol);
      }
    } else {
      const beforeSol = chunk.substring(0, chunk.indexOf('\\begin{solution}'));
      prompt = cleanPrompt(beforeSol);
    }

    const explanation = cleanExplanation(solutionRaw);

    if (!prompt || !correctAnswer) {
      console.warn(`Skipping question ${i + 1} in ${fileName}: empty prompt or answer`);
      continue;
    }

    results.push({
      prompt,
      type: qType,
      options,
      correctAnswer,
      explanation,
      domain,
      difficulty,
      imageUrls: [],
      sourceFile: fileName,
      questionIndex: i + 1,
      hasDiagram,
      diagramOrder,
    });
  }

  return results;
}

// ── Image mapping ───────────────────────────────────────────────────────────

function mapImagesToQuestions(questions: ParsedQuestion[]): string[] {
  const unmatchedImages: string[] = [];
  if (!fs.existsSync(IMG_DIR)) return unmatchedImages;

  const imageFiles = fs.readdirSync(IMG_DIR).filter(f => f.endsWith('.png'));

  for (const imgFile of imageFiles) {
    const nameNoExt = imgFile.replace(/\.png(\.png)?$/, '');
    let matched = false;

    // Pattern NEW (preferred): {sourceFile}_q{questionIndex}[_{subIndex}]
    //   e.g. alg_sat_easy_mcq_018_q3.png, geo_sat_med_mcq_018_q1_2.png
    const newMatch = nameNoExt.match(/^(.+)_q(\d+)(?:_(\d+))?$/);
    if (newMatch) {
      const [, srcFile, qNumStr] = newMatch;
      const qNum = parseInt(qNumStr, 10);
      const q = questions.find(
        (q) => q.sourceFile === srcFile && q.questionIndex === qNum
      );
      if (q) {
        q.imageUrls.push(imgFile);
        matched = true;
      }
    }

    if (!matched) {
      // Pattern A (legacy): {dom}_sat_{diff}_{count}_image_{type}_{qnum}
      let match = nameNoExt.match(/^([a-z]+)_sat_([a-z]+)_(\d+)_image_([a-z]+)_(\d+)$/);
      let sourceFile = '';
      let qIndex = 0;

      if (match) {
        const [, dom, diff, count, type, qNum] = match;
        sourceFile = `${dom}_sat_${diff}_${type}_${count}`;
        qIndex = parseInt(qNum, 10);
      } else {
        // Pattern B (legacy): {dom}_sat_{diff}_{type}_{count}_image_{qnum}
        match = nameNoExt.match(/^([a-z]+)_sat_([a-z]+)_([a-z]+)_(\d+)_image_(\d+)$/);
        if (match) {
          const [, dom, diff, type, count, qNum] = match;
          sourceFile = `${dom}_sat_${diff}_${type}_${count}`;
          qIndex = parseInt(qNum, 10);
        }
      }

      if (sourceFile && qIndex) {
        const q = questions.find(
          (q) => q.sourceFile === sourceFile && q.diagramOrder === qIndex
        );
        if (q) {
          q.imageUrls.push(imgFile);
          matched = true;
        }
      }
    }

    if (!matched) {
      unmatchedImages.push(imgFile);
    }
  }

  return unmatchedImages;
}

// ── Module assignment ───────────────────────────────────────────────────────

interface AssignedQuestion extends ParsedQuestion {
  setNumber: number;
  moduleNumber: number;
  difficultyPath: string; // 'easy'|'medium'|'hard' for module 1, 'easy'|'hard' for module 2
}

function assignToSets(questions: ParsedQuestion[]): AssignedQuestion[] {
  // Build pools: domain|difficulty -> questions[] (type-agnostic)
  const pools: Record<string, ParsedQuestion[]> = {};
  for (const q of questions) {
    const key = `${q.domain}|${q.difficulty}`;
    if (!pools[key]) pools[key] = [];
    pools[key].push(q);
  }

  // Sort each pool deterministically for reproducible assignment
  for (const key of Object.keys(pools)) {
    pools[key] = pools[key].sort((a, b) => {
      if (a.sourceFile !== b.sourceFile) return a.sourceFile.localeCompare(b.sourceFile);
      return a.questionIndex - b.questionIndex;
    });
  }

  const assigned: AssignedQuestion[] = [];
  const used = new Set<string>();

  function draw(domain: string, difficulty: string): ParsedQuestion | null {
    const key = `${domain}|${difficulty}`;
    const pool = pools[key] || [];
    for (const q of pool) {
      const id = `${q.sourceFile}_${q.questionIndex}`;
      if (!used.has(id)) {
        used.add(id);
        return q;
      }
    }
    return null;
  }

  function fillModule(tmpl: ModuleTemplate, setNumber: number, difficultyPath: string): void {
    for (const [domain, difficulty, count] of tmpl.needs) {
      for (let i = 0; i < count; i++) {
        const q = draw(domain, difficulty);
        if (q) {
          assigned.push({ ...q, setNumber, moduleNumber: tmpl.moduleNumber, difficultyPath });
        } else {
          const fallback = Object.keys(pools)
            .filter((k) => k.endsWith(`|${difficulty}`))
            .map((k) => pools[k])
            .flat()
            .find((q) => !used.has(`${q.sourceFile}_${q.questionIndex}`));
          if (fallback) {
            used.add(`${fallback.sourceFile}_${fallback.questionIndex}`);
            assigned.push({ ...fallback, setNumber, moduleNumber: tmpl.moduleNumber, difficultyPath });
          } else {
            console.warn(`  Set ${setNumber}, Mod ${tmpl.moduleNumber}: no ${domain}/${difficulty} left`);
          }
        }
      }
    }
  }

  for (let set = 1; set <= 3; set++) {
    console.log(`\nAssigning Set ${set}...`);
    // Module 1: difficulty_tier = individual question difficulty (pass 'individual' as marker)
    fillModule(MODULE_1, set, 'individual');
    // Module 2 Easy path: all questions get difficulty_tier='easy'
    fillModule(MODULE_2E, set, 'easy');
    // Module 2 Hard path: all questions get difficulty_tier='hard'
    fillModule(MODULE_2H, set, 'hard');
  }

  return assigned;
}

// ── Database import ─────────────────────────────────────────────────────────

async function importToDatabase(questions: AssignedQuestion[]): Promise<void> {
  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

  // Delete existing math questions for sets we're replacing
  const setsToReplace = [...new Set(questions.map((q) => q.setNumber))];
  console.log(`\nDeleting existing math questions for sets: ${setsToReplace.join(', ')}...`);

  if (!DRY_RUN) {
    for (const setNum of setsToReplace) {
      const { error } = await supabase
        .from('sat_questions')
        .delete()
        .eq('section', 'math')
        .eq('set_number', setNum);
      if (error) {
        console.error(`Error deleting set ${setNum}:`, error.message);
        return;
      }
    }
  }

  // Upload images and get URLs
  console.log('\nUploading images...');
  const imageUrlMap: Record<string, string> = {};

  for (const q of questions) {
    for (const imgFile of q.imageUrls) {
      if (imageUrlMap[imgFile]) continue;
      const imgPath = path.join(IMG_DIR, imgFile);
      if (!fs.existsSync(imgPath)) {
        console.warn(`Image not found: ${imgPath}`);
        continue;
      }

      if (DRY_RUN) {
        imageUrlMap[imgFile] = `https://placeholder/${imgFile}`;
        continue;
      }

      const fileData = fs.readFileSync(imgPath);
      const storagePath = `mock-math/${imgFile.replace('.png.png', '.png')}`;

      const { error: uploadError } = await supabase.storage
        .from('sat-question-images')
        .upload(storagePath, fileData, {
          contentType: 'image/png',
          upsert: true,
        });

      if (uploadError) {
        console.warn(`Upload failed for ${imgFile}: ${uploadError.message}`);
        continue;
      }

      const { data: urlData } = supabase.storage
        .from('sat-question-images')
        .getPublicUrl(storagePath);

      imageUrlMap[imgFile] = urlData.publicUrl;
      process.stdout.write('.');
    }
  }
  console.log(`\n${Object.keys(imageUrlMap).length} images uploaded.`);

  // Insert questions in batches
  console.log(`\nInserting ${questions.length} questions...`);

  const rows = questions.map((q) => ({
    type: q.type,
    prompt: q.prompt,
    options: q.options ?? null,
    correct_answer: q.correctAnswer,
    explanation: q.explanation,
    domain: q.domain,
    // Module 1: use individual question difficulty; Module 2: use path ('easy'/'hard')
    difficulty_tier: q.difficultyPath === 'individual' ? q.difficulty : q.difficultyPath,
    module_number: q.moduleNumber,
    set_number: q.setNumber,
    section: 'math',
    image_url: q.imageUrls.length > 0 ? imageUrlMap[q.imageUrls[0]] || null : null,
    is_active: true,
  }));

  if (DRY_RUN) {
    console.log('DRY RUN — skipping insert. Sample rows:');
    for (const r of rows.slice(0, 3)) {
      console.log(JSON.stringify(r, null, 2));
    }
    return;
  }

  const BATCH = 50;
  for (let i = 0; i < rows.length; i += BATCH) {
    const batch = rows.slice(i, i + BATCH);
    const { error } = await supabase.from('sat_questions').insert(batch);
    if (error) {
      console.error(`Insert error at batch ${i / BATCH + 1}:`, error.message);
      return;
    }
    process.stdout.write(`  batch ${i / BATCH + 1} (${batch.length} rows)\n`);
  }

  // Update total_sets in exam_types
  const maxSet = Math.max(...questions.map((q) => q.setNumber));
  const { error: updateError } = await supabase
    .from('exam_types')
    .update({ total_sets: maxSet })
    .eq('id', 'sat');

  if (updateError) {
    console.warn(`Failed to update exam_types.total_sets: ${updateError.message}`);
  } else {
    console.log(`Updated SAT total_sets to ${maxSet}`);
  }
}

// ── Main ────────────────────────────────────────────────────────────────────

async function main() {
  console.log(`Mode: ${DRY_RUN ? 'DRY RUN' : 'LIVE'}`);
  console.log(`Source: ${TEX_DIR}`);

  // 1. Parse all .tex files
  const texFiles = fs.readdirSync(TEX_DIR).filter((f) => f.endsWith('.tex'));
  console.log(`\nFound ${texFiles.length} .tex files`);

  let allQuestions: ParsedQuestion[] = [];
  for (const file of texFiles) {
    const parsed = parseTexFile(path.join(TEX_DIR, file));
    console.log(`  ${file}: ${parsed.length} questions`);
    allQuestions = allQuestions.concat(parsed);
  }
  console.log(`\nTotal parsed: ${allQuestions.length} questions`);

  // 2. Map images
  const unmatchedImages = mapImagesToQuestions(allQuestions);
  const withImages = allQuestions.filter((q) => q.imageUrls.length > 0);
  console.log(`Questions with images: ${withImages.length}`);

  // ── Validation report ──────────────────────────────────────────────────
  console.log('\n══════════════════ VALIDATION REPORT ══════════════════');

  if (unmatchedImages.length > 0) {
    console.log(`\n⚠ Unmatched images (${unmatchedImages.length}):`);
    for (const img of unmatchedImages) console.log(`  - ${img}`);
  } else {
    console.log('\n✓ All images matched to questions.');
  }

  const diagramNoImage = allQuestions.filter(
    (q) => q.prompt.includes('[See diagram]') && q.imageUrls.length === 0
  );
  if (diagramNoImage.length > 0) {
    console.log(`\n⚠ Questions with [See diagram] but NO image (${diagramNoImage.length}):`);
    for (const q of diagramNoImage) {
      console.log(`  - ${q.sourceFile} Q${q.questionIndex}: ${q.prompt.substring(0, 60)}...`);
    }
  } else {
    console.log('✓ All [See diagram] questions have images.');
  }

  const noAnswer = allQuestions.filter((q) => !q.correctAnswer);
  if (noAnswer.length > 0) {
    console.log(`\n⚠ Questions with no correct answer (${noAnswer.length}):`);
    for (const q of noAnswer) console.log(`  - ${q.sourceFile} Q${q.questionIndex}`);
  }

  const noPrompt = allQuestions.filter((q) => !q.prompt.trim());
  if (noPrompt.length > 0) {
    console.log(`\n⚠ Questions with empty prompt (${noPrompt.length}):`);
    for (const q of noPrompt) console.log(`  - ${q.sourceFile} Q${q.questionIndex}`);
  }

  const mcqNoOptions = allQuestions.filter((q) => q.type === 'mcq' && (!q.options || q.options.length < 2));
  if (mcqNoOptions.length > 0) {
    console.log(`\n⚠ MCQ questions with missing/too-few options (${mcqNoOptions.length}):`);
    for (const q of mcqNoOptions) console.log(`  - ${q.sourceFile} Q${q.questionIndex}`);
  }

  if (!noAnswer.length && !noPrompt.length && !mcqNoOptions.length) {
    console.log('✓ All questions have prompts, answers, and options.');
  }

  console.log('══════════════════════════════════════════════════════\n');

  // Print pool summary
  const poolSummary: Record<string, number> = {};
  for (const q of allQuestions) {
    const key = `${q.domain}/${q.difficulty}/${q.type}`;
    poolSummary[key] = (poolSummary[key] || 0) + 1;
  }
  console.log('\nQuestion pool:');
  for (const [key, count] of Object.entries(poolSummary).sort()) {
    console.log(`  ${key}: ${count}`);
  }

  // 3. Assign to sets/modules
  const assigned = assignToSets(allQuestions);
  console.log(`\nTotal assigned: ${assigned.length}`);

  // Print assignment summary
  const summary: Record<string, number> = {};
  for (const q of assigned) {
    const key = `Set${q.setNumber}_Mod${q.moduleNumber}`;
    summary[key] = (summary[key] || 0) + 1;
  }
  console.log('\nAssignment summary:');
  for (const [key, count] of Object.entries(summary).sort()) {
    console.log(`  ${key}: ${count}`);
  }

  // 4. Import to DB
  await importToDatabase(assigned);

  console.log('\nDone!');
}

main().catch(console.error);
