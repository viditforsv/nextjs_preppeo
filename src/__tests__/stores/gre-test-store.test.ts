import { describe, it, expect, beforeEach, vi } from 'vitest';
import { useGRETestStore } from '@/stores/useGRETestStore';
import type { GREQuestion, GRESection } from '@/types/gre-test';

const mockFetch = vi.fn();
vi.stubGlobal('fetch', mockFetch);

function makeGREQuestion(id: string, correctAnswer: string | string[] = 'A'): GREQuestion {
  return {
    id,
    type: 'single-choice',
    prompt: 'GRE question',
    options: [{ id: 'A', text: 'Option A' }, { id: 'B', text: 'Option B' }],
    correctAnswer,
    difficulty: 'medium',
    topics: ['arithmetic'],
    explanation: 'Because A.',
  };
}

function mockSection1(questions: GREQuestion[]): GRESection {
  return {
    sectionNumber: 1,
    difficultyTier: 'medium',
    durationSeconds: 1260,
    questions,
  };
}

beforeEach(() => {
  useGRETestStore.getState().goToLanding();
  vi.clearAllMocks();
});

describe('useGRETestStore — initial state', () => {
  it('starts on landing phase', () => {
    const state = useGRETestStore.getState();
    expect(state.phase).toBe('landing');
    expect(state.answers).toEqual({});
    expect(state.mode).toBeNull();
  });
});

describe('useGRETestStore — goToLanding', () => {
  it('resets all state', () => {
    useGRETestStore.setState({ answers: { 'q1': 'B' }, currentQuestionIndex: 3 });
    useGRETestStore.getState().goToLanding();
    const state = useGRETestStore.getState();
    expect(state.answers).toEqual({});
    expect(state.currentQuestionIndex).toBe(0);
    expect(state.phase).toBe('landing');
  });
});

describe('useGRETestStore — setAnswer', () => {
  it('records a single-value answer', () => {
    useGRETestStore.getState().setAnswer('q1', 'B');
    expect(useGRETestStore.getState().answers['q1']).toBe('B');
  });

  it('records a multi-select answer (array)', () => {
    useGRETestStore.getState().setAnswer('q1', ['A', 'C']);
    expect(useGRETestStore.getState().answers['q1']).toEqual(['A', 'C']);
  });

  it('allows clearing with null', () => {
    useGRETestStore.getState().setAnswer('q1', 'A');
    useGRETestStore.getState().setAnswer('q1', null);
    expect(useGRETestStore.getState().answers['q1']).toBeNull();
  });
});

describe('useGRETestStore — toggleFlag', () => {
  it('flags a question', () => {
    useGRETestStore.getState().toggleFlag('q1');
    expect(useGRETestStore.getState().flags['q1']).toBe(true);
  });

  it('unflags a flagged question', () => {
    useGRETestStore.getState().toggleFlag('q1');
    useGRETestStore.getState().toggleFlag('q1');
    expect(useGRETestStore.getState().flags['q1']).toBe(false);
  });
});

describe('useGRETestStore — navigateQuestion', () => {
  it('updates currentQuestionIndex', () => {
    useGRETestStore.getState().navigateQuestion(6);
    expect(useGRETestStore.getState().currentQuestionIndex).toBe(6);
  });
});

describe('useGRETestStore — submitSection', () => {
  it('submits section 1 and transitions to section1_complete', () => {
    const q1 = makeGREQuestion('q1', 'A');
    const q2 = makeGREQuestion('q2', 'B');
    useGRETestStore.setState({
      phase: 'in-section',
      currentSectionNumber: 1,
      section1: mockSection1([q1, q2]),
      answers: { q1: 'A', q2: 'A' }, // q1 correct, q2 wrong
      flags: {},
      questionTimeAccum: {},
      visitCounts: {},
      lastNavigatedAt: Date.now(),
      timeLeft: 1260,
    });

    useGRETestStore.getState().submitSection();
    const state = useGRETestStore.getState();
    expect(state.phase).toBe('between-sections');
    expect(state.section1Result).not.toBeNull();
    expect(state.section1Result?.correct).toBe(1);
    expect(state.section1Result?.total).toBe(2);
  });
});

describe('useGRETestStore — startTestMode', () => {
  it('fetches section 1 questions and goes to pre_section phase', async () => {
    const questions = Array.from({ length: 12 }, (_, i) => makeGREQuestion(`q${i}`));
    mockFetch.mockResolvedValue({
      ok: true,
      json: async () => ({ questions }),
    });

    await useGRETestStore.getState().startTestMode(1);

    const state = useGRETestStore.getState();
    expect(state.phase).toBe('section-intro');
    expect(state.section1?.questions).toHaveLength(12);
  });
});
