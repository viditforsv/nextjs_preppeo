import { describe, it, expect } from 'vitest';
import {
  estimateMathScore,
  estimateRWScore,
  estimateTotalScore,
  routeToTierMath,
  routeToTierRW,
} from '@/lib/sat-scoring';

describe('routeToTierMath', () => {
  it('routes to hard when correct >= 15', () => {
    expect(routeToTierMath(15)).toBe('hard');
    expect(routeToTierMath(22)).toBe('hard');
  });

  it('routes to easy when correct < 15', () => {
    expect(routeToTierMath(14)).toBe('easy');
    expect(routeToTierMath(0)).toBe('easy');
  });
});

describe('routeToTierRW', () => {
  it('routes to hard when correct >= 14', () => {
    expect(routeToTierRW(14)).toBe('hard');
    expect(routeToTierRW(27)).toBe('hard');
  });

  it('routes to easy when correct < 14', () => {
    expect(routeToTierRW(13)).toBe('easy');
    expect(routeToTierRW(0)).toBe('easy');
  });
});

describe('estimateMathScore', () => {
  it('returns 200 for zero correct on easy tier', () => {
    const score = estimateMathScore({ module1Correct: 0, module1Total: 22, module2Correct: 0, module2Total: 22, module2Tier: 'easy' });
    expect(score).toBe(200);
  });

  it('returns 800 for perfect score on hard tier', () => {
    const score = estimateMathScore({ module1Correct: 22, module1Total: 22, module2Correct: 22, module2Total: 22, module2Tier: 'hard' });
    expect(score).toBe(800);
  });

  it('hard tier scores higher than easy tier for same raw correct', () => {
    const input = { module1Correct: 12, module1Total: 22, module2Correct: 10, module2Total: 22 };
    const hard = estimateMathScore({ ...input, module2Tier: 'hard' });
    const easy = estimateMathScore({ ...input, module2Tier: 'easy' });
    expect(hard).toBeGreaterThan(easy);
  });

  it('clamps total correct to 44', () => {
    // Overcounting should not throw or return undefined
    const score = estimateMathScore({ module1Correct: 30, module1Total: 22, module2Correct: 30, module2Total: 22, module2Tier: 'hard' });
    expect(score).toBe(800);
  });
});

describe('estimateRWScore', () => {
  it('returns 200 for zero correct', () => {
    const score = estimateRWScore({ module1Correct: 0, module1Total: 27, module2Correct: 0, module2Total: 27, module2Tier: 'easy' });
    expect(score).toBe(200);
  });

  it('returns 800 for perfect score on hard tier', () => {
    const score = estimateRWScore({ module1Correct: 27, module1Total: 27, module2Correct: 27, module2Total: 27, module2Tier: 'hard' });
    expect(score).toBe(800);
  });

  it('hard tier scores higher than easy tier for same raw correct', () => {
    const input = { module1Correct: 13, module1Total: 27, module2Correct: 12, module2Total: 27 };
    const hard = estimateRWScore({ ...input, module2Tier: 'hard' });
    const easy = estimateRWScore({ ...input, module2Tier: 'easy' });
    expect(hard).toBeGreaterThan(easy);
  });
});

describe('estimateTotalScore', () => {
  it('sums RW and math scores', () => {
    expect(estimateTotalScore(600, 550)).toBe(1150);
    expect(estimateTotalScore(800, 800)).toBe(1600);
    expect(estimateTotalScore(200, 200)).toBe(400);
  });
});
