/**
 * Digital SAT score estimation.
 *
 * The real SAT uses equating which varies per administration.
 * These lookup tables are approximations based on publicly
 * available College Board practice-test conversion data.
 *
 * Module-2 tier matters: getting the harder M2 gives access
 * to higher scaled scores for the same total raw correct.
 */

// ── Math (44 questions total: 22 M1 + 22 M2) ──────────────────────

const MATH_HARD_M2: number[] = [
  200, 210, 220, 230, 240, 250, 260, 270, 280, 290,
  310, 320, 330, 340, 360, 370, 390, 400, 420, 430,
  450, 460, 480, 490, 510, 520, 540, 560, 570, 590,
  600, 620, 640, 650, 670, 680, 700, 710, 720, 740,
  750, 770, 780, 790, 800,
];

const MATH_EASY_M2: number[] = [
  200, 200, 210, 220, 230, 240, 250, 260, 270, 280,
  290, 300, 310, 320, 330, 340, 350, 360, 370, 380,
  390, 400, 410, 420, 430, 440, 460, 470, 480, 490,
  510, 520, 530, 540, 550, 560, 570, 580, 590, 600,
  600, 610, 610, 620, 620,
];

// ── Reading & Writing (54 questions total: 27 M1 + 27 M2) ─────────

const RW_HARD_M2: number[] = [
  200, 200, 210, 210, 220, 220, 230, 240, 250, 260,
  270, 280, 290, 300, 310, 320, 330, 340, 350, 360,
  370, 380, 390, 400, 410, 420, 440, 450, 460, 470,
  490, 500, 510, 520, 540, 550, 560, 580, 590, 600,
  620, 630, 650, 660, 680, 690, 710, 720, 740, 750,
  770, 780, 790, 790, 800,
];

const RW_EASY_M2: number[] = [
  200, 200, 200, 200, 210, 210, 220, 230, 240, 250,
  260, 270, 280, 290, 300, 310, 320, 330, 340, 350,
  360, 370, 380, 390, 400, 410, 420, 430, 440, 450,
  460, 470, 480, 490, 500, 510, 520, 530, 540, 550,
  560, 570, 580, 580, 590, 590, 600, 600, 610, 610,
  610, 620, 620, 620, 620,
];

// ── Routing thresholds ─────────────────────────────────────────────

export function routeToTierMath(correct: number): 'hard' | 'easy' {
  return correct >= 15 ? 'hard' : 'easy';
}

export function routeToTierRW(correct: number): 'hard' | 'easy' {
  return correct >= 14 ? 'hard' : 'easy';
}

// ── Score estimation ───────────────────────────────────────────────

export interface SATScoreInput {
  module1Correct: number;
  module1Total: number;
  module2Correct: number;
  module2Total: number;
  module2Tier: 'hard' | 'easy';
}

export function estimateMathScore(input: SATScoreInput): number {
  const totalCorrect = input.module1Correct + input.module2Correct;
  const clamped = Math.max(0, Math.min(44, totalCorrect));
  const curve = input.module2Tier === 'hard' ? MATH_HARD_M2 : MATH_EASY_M2;
  return curve[clamped];
}

export function estimateRWScore(input: SATScoreInput): number {
  const totalCorrect = input.module1Correct + input.module2Correct;
  const clamped = Math.max(0, Math.min(54, totalCorrect));
  const curve = input.module2Tier === 'hard' ? RW_HARD_M2 : RW_EASY_M2;
  return curve[clamped];
}

/** Kept for backward compatibility — delegates to estimateMathScore */
export function estimateSATScore(input: SATScoreInput): number {
  return estimateMathScore(input);
}

export function estimateTotalScore(rwScore: number, mathScore: number): number {
  return rwScore + mathScore;
}
