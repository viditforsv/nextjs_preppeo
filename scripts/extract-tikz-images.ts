/**
 * Extract tikzpicture blocks from .tex files and render them to PNG.
 *
 * Usage: npx tsx scripts/extract-tikz-images.ts [--dry-run]
 *
 * Requires: pdflatex (TeX Live), ImageMagick (convert)
 */

import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import os from 'os';

const DRY_RUN = process.argv.includes('--dry-run');

const TEX_DIR = path.resolve(
  __dirname,
  '../Docs for me/sat-ecosystem/sat_question_bank_maths_mocks'
);
const IMG_DIR = path.join(TEX_DIR, 'images');

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

interface TikzDiagram {
  sourceFile: string;
  questionIndex: number;
  tikzContent: string;
  outputName: string;
}

function extractTikzFromFile(filePath: string): TikzDiagram[] {
  const content = fs.readFileSync(filePath, 'utf-8');
  const fileName = path.basename(filePath, '.tex');

  const questionsMatch = content.match(
    /\\begin\{questions\}([\s\S]*?)\\end\{questions\}/
  );
  if (!questionsMatch) {
    console.warn(`  No questions block in ${fileName}`);
    return [];
  }

  const questionsBlock = questionsMatch[1];
  const questionChunks = questionsBlock.split(/\\question\s*\n/).slice(1);

  const diagrams: TikzDiagram[] = [];

  for (let i = 0; i < questionChunks.length; i++) {
    const chunk = questionChunks[i];
    const qNum = i + 1;

    // Find all tikzpicture blocks in this question chunk
    const tikzRegex = /\\begin\{tikzpicture\}([\s\S]*?)\\end\{tikzpicture\}/g;
    let match: RegExpExecArray | null;
    let diagramInQ = 0;

    while ((match = tikzRegex.exec(chunk)) !== null) {
      diagramInQ++;
      const tikzBody = match[0]; // full \begin{tikzpicture}...\end{tikzpicture}
      const suffix = diagramInQ > 1 ? `_${diagramInQ}` : '';
      const outputName = `${fileName}_q${qNum}${suffix}`;

      diagrams.push({
        sourceFile: fileName,
        questionIndex: qNum,
        tikzContent: tikzBody,
        outputName,
      });
    }
  }

  return diagrams;
}

function renderTikzToPng(diagram: TikzDiagram, tmpDir: string): boolean {
  const texContent = `${STANDALONE_PREAMBLE}
\\begin{document}
${diagram.tikzContent}
\\end{document}
`;

  const texPath = path.join(tmpDir, `${diagram.outputName}.tex`);
  const pdfPath = path.join(tmpDir, `${diagram.outputName}.pdf`);
  const pngPath = path.join(IMG_DIR, `${diagram.outputName}.png`);

  fs.writeFileSync(texPath, texContent, 'utf-8');

  try {
    execSync(
      `pdflatex -interaction=nonstopmode -output-directory="${tmpDir}" "${texPath}"`,
      { stdio: 'pipe', timeout: 30000 }
    );
  } catch {
    const logPath = path.join(tmpDir, `${diagram.outputName}.log`);
    if (fs.existsSync(logPath)) {
      const log = fs.readFileSync(logPath, 'utf-8');
      const errorLines = log
        .split('\n')
        .filter((l) => l.startsWith('!'))
        .slice(0, 3);
      console.error(
        `    pdflatex FAILED for ${diagram.outputName}: ${errorLines.join(' | ') || 'see log'}`
      );
    } else {
      console.error(`    pdflatex FAILED for ${diagram.outputName}`);
    }
    return false;
  }

  if (!fs.existsSync(pdfPath)) {
    console.error(`    No PDF produced for ${diagram.outputName}`);
    return false;
  }

  try {
    execSync(
      `convert -density 300 "${pdfPath}" -quality 100 -background white -flatten "${pngPath}"`,
      { stdio: 'pipe', timeout: 30000 }
    );
  } catch (err) {
    console.error(`    convert FAILED for ${diagram.outputName}: ${err}`);
    return false;
  }

  return fs.existsSync(pngPath);
}

async function main() {
  console.log(`Mode: ${DRY_RUN ? 'DRY RUN' : 'LIVE'}`);
  console.log(`Source: ${TEX_DIR}\n`);

  const texFiles = fs.readdirSync(TEX_DIR).filter((f) => f.endsWith('.tex'));
  console.log(`Found ${texFiles.length} .tex files\n`);

  let allDiagrams: TikzDiagram[] = [];

  for (const file of texFiles) {
    const diagrams = extractTikzFromFile(path.join(TEX_DIR, file));
    if (diagrams.length > 0) {
      console.log(`  ${file}: ${diagrams.length} diagram(s)`);
      for (const d of diagrams) console.log(`    -> ${d.outputName}.png (Q${d.questionIndex})`);
    } else {
      console.log(`  ${file}: no diagrams`);
    }
    allDiagrams = allDiagrams.concat(diagrams);
  }

  console.log(`\nTotal diagrams to render: ${allDiagrams.length}`);

  if (DRY_RUN) {
    console.log('\nDRY RUN — skipping rendering.');
    return;
  }

  // Create temp directory for compilation
  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), 'tikz-extract-'));
  console.log(`Temp directory: ${tmpDir}`);

  // Ensure images directory exists
  if (!fs.existsSync(IMG_DIR)) fs.mkdirSync(IMG_DIR, { recursive: true });

  let success = 0;
  let failed = 0;

  for (const diagram of allDiagrams) {
    process.stdout.write(`  Rendering ${diagram.outputName}...`);
    if (renderTikzToPng(diagram, tmpDir)) {
      console.log(' OK');
      success++;
    } else {
      console.log(' FAILED');
      failed++;
    }
  }

  console.log(`\n══════════════════ RESULTS ══════════════════`);
  console.log(`  Success: ${success}`);
  console.log(`  Failed:  ${failed}`);
  console.log(`  Output:  ${IMG_DIR}`);
  console.log(`═════════════════════════════════════════════`);

  // Cleanup tmp
  try {
    fs.rmSync(tmpDir, { recursive: true });
  } catch {
    console.log(`Note: temp dir not cleaned up: ${tmpDir}`);
  }
}

main().catch(console.error);
