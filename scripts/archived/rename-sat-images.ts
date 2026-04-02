import * as fs from 'fs';
import * as path from 'path';

const SRC_DIR = path.join(
  __dirname,
  '..',
  'Docs for me',
  'sat-ecosystem',
  'sat_question_bank_verbal',
  'question_bank_sat_verbal_images'
);

const DEST_DIR = path.join(
  __dirname,
  '..',
  'Docs for me',
  'sat-ecosystem',
  'sat_question_bank_verbal',
  'sat-rw-quant-images'
);

if (!fs.existsSync(DEST_DIR)) {
  fs.mkdirSync(DEST_DIR, { recursive: true });
}

for (let i = 1; i <= 50; i++) {
  const nn = String(i).padStart(2, '0');
  const newName = `sat-rw-quant-${nn}`;

  // Try .png first, then .jpg
  let srcFile = path.join(SRC_DIR, `${i}.png`);
  let ext = '.png';
  if (!fs.existsSync(srcFile)) {
    srcFile = path.join(SRC_DIR, `${i}.jpg`);
    ext = '.jpg';
  }

  if (!fs.existsSync(srcFile)) {
    console.warn(`Missing: ${i}.png / ${i}.jpg — skipped`);
    continue;
  }

  const destFile = path.join(DEST_DIR, `${newName}${ext}`);
  fs.copyFileSync(srcFile, destFile);
  console.log(`${path.basename(srcFile)} → ${newName}${ext}`);
}

console.log(`\nDone. Renamed images in: ${DEST_DIR}`);
