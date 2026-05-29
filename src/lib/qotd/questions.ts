/**
 * Question of the Day — week 1 rotation.
 *
 * The array order IS the rotation index (0-6). The live page picks one per day
 * based on the UTC date, cycling through these every 7 days. Question CONTENT
 * (prompt, options, answer, explanation) lives in the `sat_questions` table —
 * this file only pins which question shows on which day.
 *
 * All 7 are hand-QC'd hard SAT Math questions from the practice pool
 * (set_number=0), chosen for clean, self-contained prompts and strong
 * step-by-step explanations across all four math domains.
 */
export interface QotdEntry {
  /** sat_questions.id */
  id: string;
  /** Human label for reference only — not shown to students. */
  topic: string;
}

export const QOTD_ROTATION: QotdEntry[] = [
  { id: 'ce32d28c-7985-48c1-9041-4b350a8e2b02', topic: 'Rational equation with extraneous solution' },
  { id: 'e782bfd5-c32e-4e1a-bb02-481f86b22c91', topic: 'Circle ∩ parabola system' },
  { id: '3b17d9fc-7545-4483-8cb8-745cad7ace54', topic: 'Perpendicular lines intersection' },
  { id: '73a2641f-03a7-4d85-bbf8-bd5558386b04', topic: 'Reflecting a line across the y-axis' },
  { id: '9f261cf6-d54e-4a9e-9a5d-1a3b9dada10b', topic: 'Water displacement (submerged cube)' },
  { id: '6a14cb3b-69f0-4549-a0cd-bfb5f599f361', topic: 'Square prism: surface area → volume' },
  { id: '8c7a5fee-f5b3-45ef-b05e-224bc3bdf6f3', topic: 'Standard deviation under shift & scale' },
];

/** Days since the Unix epoch in UTC — rolls over at 00:00 GMT, never local time. */
export function utcDayIndex(now: number = Date.now()): number {
  return Math.floor(now / 86_400_000);
}

/** The rotation index (0-6) for a given UTC day. */
export function rotationIndexForDay(dayIndex: number): number {
  const len = QOTD_ROTATION.length;
  return ((dayIndex % len) + len) % len;
}

/** Today's question entry, based on the current UTC date. */
export function getTodaysEntry(now: number = Date.now()): QotdEntry {
  return QOTD_ROTATION[rotationIndexForDay(utcDayIndex(now))];
}
