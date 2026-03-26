import { describe, it, expect, beforeEach, vi } from 'vitest';
import { useSATTestStore } from '@/stores/useSATTestStore';
import type { SATQuestion } from '@/types/sat-test';

// Mock fetch so startTestMode doesn't hit the network
const mockFetch = vi.fn();
vi.stubGlobal('fetch', mockFetch);

function makeQuestion(id: string, correctAnswer = 'A'): SATQuestion {
  return {
    id,
    type: 'mcq',
    prompt: 'Test question',
    options: [{ id: 'A', text: 'Option A' }, { id: 'B', text: 'Option B' }],
    correctAnswer,
    difficulty: 'easy',
    domain: 'algebra',
    explanation: 'Because A.',
  };
}

function mockModule1(questions: SATQuestion[]) {
  return {
    moduleNumber: 1 as const,
    section: 'rw' as const,
    difficultyTier: 'mixed' as const,
    durationSeconds: 1920,
    questions,
  };
}

beforeEach(() => {
  useSATTestStore.getState().goToLanding();
  vi.clearAllMocks();
});

describe('useSATTestStore — initial state', () => {
  it('starts on landing phase with no answers', () => {
    const state = useSATTestStore.getState();
    expect(state.phase).toBe('landing');
    expect(state.answers).toEqual({});
    expect(state.flags).toEqual({});
    expect(state.mode).toBeNull();
  });
});

describe('useSATTestStore — goToLanding', () => {
  it('resets all state back to initial', () => {
    useSATTestStore.setState({ answers: { 'q1': 'A' }, flags: { 'q1': true }, currentQuestionIndex: 5 });
    useSATTestStore.getState().goToLanding();
    const state = useSATTestStore.getState();
    expect(state.answers).toEqual({});
    expect(state.flags).toEqual({});
    expect(state.currentQuestionIndex).toBe(0);
    expect(state.phase).toBe('landing');
  });
});

describe('useSATTestStore — setAnswer', () => {
  it('records an answer for a question', () => {
    useSATTestStore.getState().setAnswer('q1', 'B');
    expect(useSATTestStore.getState().answers['q1']).toBe('B');
  });

  it('allows overwriting an existing answer', () => {
    useSATTestStore.getState().setAnswer('q1', 'A');
    useSATTestStore.getState().setAnswer('q1', 'C');
    expect(useSATTestStore.getState().answers['q1']).toBe('C');
  });

  it('allows setting answer to null (clearing)', () => {
    useSATTestStore.getState().setAnswer('q1', 'A');
    useSATTestStore.getState().setAnswer('q1', null);
    expect(useSATTestStore.getState().answers['q1']).toBeNull();
  });

  it('records answers for multiple questions independently', () => {
    useSATTestStore.getState().setAnswer('q1', 'A');
    useSATTestStore.getState().setAnswer('q2', 'D');
    const { answers } = useSATTestStore.getState();
    expect(answers['q1']).toBe('A');
    expect(answers['q2']).toBe('D');
  });
});

describe('useSATTestStore — toggleFlag', () => {
  it('flags an unflagged question', () => {
    useSATTestStore.getState().toggleFlag('q1');
    expect(useSATTestStore.getState().flags['q1']).toBe(true);
  });

  it('unflags a flagged question', () => {
    useSATTestStore.getState().toggleFlag('q1');
    useSATTestStore.getState().toggleFlag('q1');
    expect(useSATTestStore.getState().flags['q1']).toBe(false);
  });
});

describe('useSATTestStore — navigateQuestion', () => {
  it('updates currentQuestionIndex', () => {
    useSATTestStore.getState().navigateQuestion(4);
    expect(useSATTestStore.getState().currentQuestionIndex).toBe(4);
  });
});

describe('useSATTestStore — submitModule', () => {
  it('submits module 1 and transitions to module1_complete phase', () => {
    const q1 = makeQuestion('q1', 'A');
    const q2 = makeQuestion('q2', 'B');
    useSATTestStore.setState({
      phase: 'in-module',
      currentModuleNumber: 1,
      module1: mockModule1([q1, q2]),
      answers: { q1: 'A', q2: 'C' }, // q1 correct, q2 wrong
      flags: {},
      questionTimestamps: {},
      visitCounts: {},
      currentSection: 'rw',
      timeLeft: 1920,
    });

    useSATTestStore.getState().submitModule();
    const state = useSATTestStore.getState();
    expect(state.phase).toBe('between-modules');
    expect(state.module1Result).not.toBeNull();
    expect(state.module1Result?.correct).toBe(1);
    expect(state.module1Result?.total).toBe(2);
  });

  it('routes to hard M2 when module 1 correct count meets threshold', () => {
    const questions = Array.from({ length: 22 }, (_, i) => makeQuestion(`q${i}`, 'A'));
    const answers = Object.fromEntries(questions.map((q) => [q.id, 'A'])); // all correct
    useSATTestStore.setState({
      phase: 'in-module',
      currentModuleNumber: 1,
      module1: mockModule1(questions),
      answers,
      flags: {},
      questionTimestamps: {},
      visitCounts: {},
      currentSection: 'rw',
      timeLeft: 1920,
    });

    useSATTestStore.getState().submitModule();
    // 22/22 correct on RW M1 → hard tier (threshold is 14)
    expect(useSATTestStore.getState().module2Tier).toBe('hard');
  });
});

describe('useSATTestStore — startTestMode', () => {
  it('fetches questions and transitions to pre_module phase', async () => {
    const questions = Array.from({ length: 27 }, (_, i) => makeQuestion(`rw-q${i}`));
    mockFetch.mockResolvedValue({
      ok: true,
      json: async () => ({ questions }),
    });

    await useSATTestStore.getState().startTestMode(1);

    const state = useSATTestStore.getState();
    expect(state.phase).toBe('module-intro');
    expect(state.module1?.questions).toHaveLength(27);
    expect(state.currentSection).toBe('rw');
  });

  it('falls back to math section when RW fetch fails', async () => {
    const mathQuestions = Array.from({ length: 22 }, (_, i) => makeQuestion(`m-q${i}`));
    mockFetch
      .mockRejectedValueOnce(new Error('No RW questions'))
      .mockResolvedValue({
        ok: true,
        json: async () => ({ questions: mathQuestions }),
      });

    await useSATTestStore.getState().startTestMode(1);

    expect(useSATTestStore.getState().currentSection).toBe('math');
  });
});
