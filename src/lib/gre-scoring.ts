/**
 * GRE Quantitative score estimation.
 *
 * The real GRE uses equating which varies per administration.
 * These lookup tables are approximations based on publicly
 * available ETS practice-test conversion data.
 *
 * Section-2 tier matters: getting the harder S2 gives access
 * to higher scaled scores for the same total raw correct.
 *
 * GRE Quant range: 130–170 (1-point increments).
 * Total questions: 27 (12 S1 + 15 S2).
 */

import type { DifficultyTier } from '@/types/gre-test';

// Index = total correct (0–27)

const HARD_S2: number[] = [
  130, 130, 131, 132, 133, 134, 135, 137, 139, 141,
  143, 145, 147, 149, 151, 153, 155, 157, 158, 160,
  162, 163, 165, 166, 167, 168, 169, 170,
];

const MEDIUM_S2: number[] = [
  130, 130, 130, 131, 132, 133, 134, 136, 137, 139,
  141, 143, 145, 147, 149, 150, 152, 153, 155, 156,
  157, 158, 159, 160, 161, 161, 162, 162,
];

const EASY_S2: number[] = [
  130, 130, 130, 130, 131, 132, 133, 134, 135, 136,
  138, 139, 141, 142, 144, 145, 147, 148, 149, 150,
  151, 152, 153, 153, 154, 154, 155, 155,
];

export interface GREScoreInput {
  section1Correct: number;
  section2Correct: number;
  section2Tier: DifficultyTier;
}

export function estimateGREScore(input: GREScoreInput): number {
  const totalCorrect = input.section1Correct + input.section2Correct;
  const clamped = Math.max(0, Math.min(27, totalCorrect));
  const curve =
    input.section2Tier === 'hard'
      ? HARD_S2
      : input.section2Tier === 'easy'
      ? EASY_S2
      : MEDIUM_S2;
  return curve[clamped];
}
