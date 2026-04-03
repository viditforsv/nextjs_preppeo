#!/usr/bin/env node
/**
 * Generate SAT R&W practice question SQL migrations from Google Sheets.
 *
 * Reads question data from the shared Google Sheet, parses options out of
 * the question text, maps sheet names → DB domains, and writes one SQL
 * migration file per domain into supabase/migrations/sat/.
 *
 * All questions are inserted with qc_done=false so they can be reviewed.
 *
 * Usage:
 *   node scripts/generate-rw-from-sheets.mjs [--dry-run]
 *
 * Requires: credentials.json in project root (Google service account).
 */

import { google } from "googleapis";
import { readFileSync, writeFileSync, existsSync } from "fs";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(__dirname, "..");

// ── Config ──────────────────────────────────────────────────────────────────

const SPREADSHEET_ID = "1MPX_GCvWtecZ2saelOXNm0R4GfWhReR67vdqf_IN9tU";

/** Map sheet name → { domain, subtopic } in sat_questions */
const SHEET_MAP = {
  Boundaries:                   { domain: "standard-english",      subtopic: "Boundaries" },
  "Form, Structure and Sense":  { domain: "standard-english",      subtopic: "Form, Structure and Sense" },
  Transitions:                  { domain: "expression-of-ideas",   subtopic: "Transitions" },
  "Rhetorical Synthesis":       { domain: "expression-of-ideas",   subtopic: "Rhetorical Synthesis" },
  "Text Structure and Purpose": { domain: "craft-structure",       subtopic: "Text Structure and Purpose" },
  "Cross Text Connections":     { domain: "craft-structure",       subtopic: "Cross Text Connections" },
  words:                        { domain: "craft-structure",       subtopic: "Words in Context" },
  Inferences:                   { domain: "information-ideas",     subtopic: "Inferences" },
  Central:                      { domain: "information-ideas",     subtopic: "Central Ideas and Details" },
};

/** Difficulty label in sheet → DB value */
const DIFFICULTY_MAP = {
  easy:   "easy",
  medium: "medium",
  hard:   "hard",
};

const DRY_RUN = process.argv.includes("--dry-run");

// ── Helpers ─────────────────────────────────────────────────────────────────

/**
 * Parse options A–D from the end of the question text.
 * Returns { prompt, options } where prompt is the question text without the
 * option lines, and options is the JSONB-ready array.
 *
 * Handles multiple formats:
 *   "... A. foo B. bar C. baz D. qux"
 *   "... A) foo B) bar C) bar D) qux"
 */
function parseQuestion(raw) {
  if (!raw || typeof raw !== "string") return null;

  // Try to split on A./A) B./B) C./C) D./D)
  // Use a regex that captures the four option texts
  const optRegex = /\b[Aa][.)]\s*([\s\S]*?)\s*\b[Bb][.)]\s*([\s\S]*?)\s*\b[Cc][.)]\s*([\s\S]*?)\s*\b[Dd][.)]\s*([\s\S]*?)$/;
  const match = raw.match(optRegex);

  if (!match) {
    return null; // Could not parse options — flag for review
  }

  const optA = match[1].trim();
  const optB = match[2].trim();
  const optC = match[3].trim();
  const optD = match[4].trim();

  // Prompt is everything before the options
  const promptEnd = raw.indexOf(match[0]);
  let prompt = raw.substring(0, promptEnd).trim();

  // Validate: all 4 options must be non-empty
  if (!optA || !optB || !optC || !optD) return null;

  const options = [
    { id: "a", text: optA },
    { id: "b", text: optB },
    { id: "c", text: optC },
    { id: "d", text: optD },
  ];

  return { prompt, options };
}

/** Escape for SQL string literals: normalize smart quotes then double single quotes */
function sqlEscape(str) {
  if (!str) return "";
  return str
    .replace(/[\u2018\u2019\u02BC]/g, "'")   // smart single quotes → straight
    .replace(/[\u201C\u201D]/g, '"')          // smart double quotes → straight
    .replace(/[\u2013]/g, '-')                // en-dash
    .replace(/[\u2014]/g, '--')               // em-dash
    .replace(/[\u2026]/g, '...')              // ellipsis
    .replace(/'/g, "''");                     // escape single quotes for SQL
}

/** Normalize answer to lowercase a-d */
function normalizeAnswer(raw) {
  if (!raw) return null;
  const letter = raw.trim().toUpperCase();
  if (["A", "B", "C", "D"].includes(letter)) return letter.toLowerCase();
  return null;
}

// ── Main ────────────────────────────────────────────────────────────────────

async function main() {
  // Auth
  const credsPath = resolve(ROOT, "credentials.json");
  if (!existsSync(credsPath)) {
    console.error("credentials.json not found in project root");
    process.exit(1);
  }
  const creds = JSON.parse(readFileSync(credsPath, "utf8"));
  const auth = new google.auth.GoogleAuth({
    credentials: creds,
    scopes: ["https://www.googleapis.com/auth/spreadsheets.readonly"],
  });
  const client = await auth.getClient();
  const sheets = google.sheets({ version: "v4", auth: client });

  // Collect questions grouped by domain
  const byDomain = {}; // domain → [question, ...]
  const problems = []; // questions that couldn't be parsed

  for (const [sheetName, meta] of Object.entries(SHEET_MAP)) {
    console.log(`Reading sheet: ${sheetName}...`);

    let rows;
    try {
      const res = await sheets.spreadsheets.values.get({
        spreadsheetId: SPREADSHEET_ID,
        range: `'${sheetName}'!A:H`,
      });
      rows = res.data.values || [];
    } catch (err) {
      console.error(`  ✗ Failed to read ${sheetName}: ${err.message}`);
      continue;
    }

    // Skip header row
    const header = rows[0];
    const dataRows = rows.slice(1);
    console.log(`  ${dataRows.length} data rows`);

    for (let i = 0; i < dataRows.length; i++) {
      const row = dataRows[i];
      const questionId = (row[0] || "").trim();
      const questionText = (row[1] || "").trim();
      const correctAnswer = (row[2] || "").trim();
      const rationale = (row[3] || "").trim();
      const difficulty = (row[4] || "").trim().toLowerCase();
      // row[5] = Test, row[6] = Domain, row[7] = Skill — we use our own mapping

      // Skip empty rows
      if (!questionText) continue;

      // Parse
      const parsed = parseQuestion(questionText);
      const answer = normalizeAnswer(correctAnswer);
      const diffTier = DIFFICULTY_MAP[difficulty];

      if (!parsed || !answer || !diffTier) {
        problems.push({
          sheet: sheetName,
          row: i + 2, // 1-indexed + header
          questionId,
          reason: !parsed
            ? "Could not parse options A-D"
            : !answer
            ? `Invalid answer: "${correctAnswer}"`
            : `Invalid difficulty: "${difficulty}"`,
        });
        continue;
      }

      if (!byDomain[meta.domain]) byDomain[meta.domain] = [];
      byDomain[meta.domain].push({
        questionId,
        prompt: parsed.prompt,
        options: parsed.options,
        correctAnswer: answer,
        explanation: rationale,
        difficultyTier: diffTier,
        subtopic: meta.subtopic,
        sheet: sheetName,
      });
    }
  }

  // Report
  console.log("\n=== SUMMARY ===");
  let total = 0;
  for (const [domain, qs] of Object.entries(byDomain)) {
    const easy = qs.filter((q) => q.difficultyTier === "easy").length;
    const med = qs.filter((q) => q.difficultyTier === "medium").length;
    const hard = qs.filter((q) => q.difficultyTier === "hard").length;
    console.log(
      `${domain}: ${qs.length} questions (${easy}E / ${med}M / ${hard}H)`
    );
    total += qs.length;
  }
  console.log(`Total parseable: ${total}`);
  console.log(`Problems: ${problems.length}`);

  if (problems.length > 0) {
    console.log("\n=== PROBLEM QUESTIONS ===");
    for (const p of problems.slice(0, 20)) {
      console.log(
        `  ${p.sheet} row ${p.row} (${p.questionId}): ${p.reason}`
      );
    }
    if (problems.length > 20) {
      console.log(`  ... and ${problems.length - 20} more`);
    }
  }

  if (DRY_RUN) {
    console.log("\n[DRY RUN] No files written.");
    return;
  }

  // Generate one SQL migration per domain
  const timestamp = "20260403100000";
  const domainSlug = {
    "standard-english": "standard_english",
    "expression-of-ideas": "expression_of_ideas",
    "craft-structure": "craft_structure",
    "information-ideas": "information_ideas",
  };

  for (const [domain, qs] of Object.entries(byDomain)) {
    const slug = domainSlug[domain] || domain.replace(/-/g, "_");
    const filename = `${timestamp}_seed_rw_${slug}_from_sheets.sql`;
    const filepath = resolve(
      ROOT,
      "supabase",
      "migrations",
      "sat",
      filename
    );

    const lines = [];
    lines.push(
      `-- R&W practice questions from Google Sheets — domain: ${domain}`
    );
    lines.push(
      `-- Source: spreadsheet 1MPX_GCvWtecZ2saelOXNm0R4GfWhReR67vdqf_IN9tU`
    );
    lines.push(
      `-- ${qs.length} questions total, qc_done=false (needs review before going live)`
    );
    lines.push(
      `-- Generated by scripts/generate-rw-from-sheets.mjs on ${new Date().toISOString().split("T")[0]}`
    );
    lines.push("");
    lines.push("INSERT INTO public.sat_questions (");
    lines.push("  type, section, prompt, options, correct_answer, explanation,");
    lines.push(
      "  domain, difficulty_tier, module_number, set_number, subtopic, bank_item_id"
    );
    lines.push(")");
    lines.push("VALUES");
    lines.push("");

    for (let i = 0; i < qs.length; i++) {
      const q = qs[i];
      const isLast = i === qs.length - 1;

      const optionsJson = JSON.stringify(q.options);

      lines.push(`-- ${q.sheet} | ${q.questionId} | ${q.difficultyTier}`);
      lines.push("(");
      lines.push("  'mcq',");
      lines.push("  'rw',");
      lines.push(`  '${sqlEscape(q.prompt)}',`);
      lines.push(`  '${sqlEscape(optionsJson)}'::jsonb,`);
      lines.push(`  '${q.correctAnswer}',`);
      lines.push(`  '${sqlEscape(q.explanation)}',`);
      lines.push(`  '${domain}',`);
      lines.push(`  '${q.difficultyTier}',`);
      lines.push("  0,");
      lines.push("  0,");
      lines.push(`  '${sqlEscape(q.subtopic)}',`);
      lines.push(`  'rw_sheet_${sqlEscape(q.questionId)}'`);
      lines.push(`)${isLast ? ";" : ","}`);
      lines.push("");
    }

    writeFileSync(filepath, lines.join("\n"), "utf8");
    console.log(`\nWrote: ${filename} (${qs.length} questions)`);
  }

  // Write problems report
  if (problems.length > 0) {
    const reportPath = resolve(ROOT, "supabase", "migrations", "sat", "rw_sheet_import_problems.log");
    const reportLines = problems.map(
      (p) => `${p.sheet}\trow ${p.row}\t${p.questionId}\t${p.reason}`
    );
    writeFileSync(reportPath, reportLines.join("\n"), "utf8");
    console.log(`\nWrote problem report: rw_sheet_import_problems.log (${problems.length} issues)`);
  }
}

main().catch((err) => {
  console.error("Fatal:", err);
  process.exit(1);
});
