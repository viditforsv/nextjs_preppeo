import { create } from 'zustand';
import type {
  SATQuestion,
  SATModule,
  DifficultyTier,
  SATAppPhase,
  SATModuleResult,
  SATPracticeConfig,
} from '@/types/sat-test';

const MODULE_1_DURATION = 2100; // 35 min
const MODULE_2_DURATION = 2100; // 35 min

// >= 15/22 correct → hard module 2, else → easy
function routeToTier(correct: number): 'hard' | 'easy' {
  return correct >= 15 ? 'hard' : 'easy';
}

function checkAnswer(
  question: SATQuestion,
  answer: string | null
): boolean {
  if (answer === null || answer === undefined) return false;
  return String(answer).trim().toLowerCase() === String(question.correctAnswer).trim().toLowerCase();
}

async function fetchQuestions(
  moduleNum: number,
  setNumber: number,
  difficulty?: DifficultyTier
): Promise<SATQuestion[]> {
  const params = new URLSearchParams({
    module: String(moduleNum),
    set: String(setNumber),
  });
  if (difficulty) params.set('difficulty', difficulty);

  const res = await fetch(`/api/sat/questions?${params}`);
  const data = await res.json();

  if (!res.ok || !data.questions) {
    throw new Error(data.error || 'Failed to fetch questions');
  }
  return data.questions;
}

interface SATTestState {
  phase: SATAppPhase;
  mode: 'test' | 'practice' | null;

  // Test mode
  setNumber: number | null;
  module1: SATModule | null;
  module2: SATModule | null;
  currentModuleNumber: 1 | 2;
  currentQuestionIndex: number;
  answers: Record<string, string | null>;
  flags: Record<string, boolean>;
  timeLeft: number;
  module1Result: SATModuleResult | null;
  module2Result: SATModuleResult | null;
  module2Tier: 'hard' | 'easy' | null;

  // Practice mode
  practiceConfig: SATPracticeConfig | null;
  practiceQuestions: SATQuestion[];
  practiceAnswers: Record<string, string | null>;
  practiceRevealed: Record<string, boolean>;
  practiceIndex: number;

  // UI
  isCalculatorOpen: boolean;
  isReviewOpen: boolean;
  timerHidden: boolean;

  // Actions
  goToLanding: () => void;
  startTestMode: (setNumber: number) => Promise<void>;
  beginModule: () => void;
  setAnswer: (qId: string, value: string | null) => void;
  toggleFlag: (qId: string) => void;
  navigateQuestion: (idx: number) => void;
  tickTimer: () => void;
  submitModule: () => void;
  beginModule2: () => void;
  toggleCalculator: () => void;
  toggleReview: () => void;
  toggleTimerVisibility: () => void;

  // Practice actions
  startPracticeMode: (config: SATPracticeConfig) => void;
  setPracticeAnswer: (qId: string, value: string | null) => void;
  revealAnswer: (qId: string) => void;
  navigatePractice: (idx: number) => void;
  finishPractice: () => void;
}

const initialState = {
  phase: 'landing' as SATAppPhase,
  mode: null as 'test' | 'practice' | null,
  setNumber: null as number | null,
  module1: null as SATModule | null,
  module2: null as SATModule | null,
  currentModuleNumber: 1 as 1 | 2,
  currentQuestionIndex: 0,
  answers: {} as Record<string, string | null>,
  flags: {} as Record<string, boolean>,
  timeLeft: 0,
  module1Result: null as SATModuleResult | null,
  module2Result: null as SATModuleResult | null,
  module2Tier: null as 'hard' | 'easy' | null,
  practiceConfig: null as SATPracticeConfig | null,
  practiceQuestions: [] as SATQuestion[],
  practiceAnswers: {} as Record<string, string | null>,
  practiceRevealed: {} as Record<string, boolean>,
  practiceIndex: 0,
  isCalculatorOpen: false,
  isReviewOpen: false,
  timerHidden: false,
};

export const useSATTestStore = create<SATTestState>()((set, get) => ({
  ...initialState,

  goToLanding: () => set({ ...initialState }),

  startTestMode: async (setNum: number) => {
    const questions = await fetchQuestions(1, setNum);
    const mod1: SATModule = {
      moduleNumber: 1,
      difficultyTier: 'mixed',
      durationSeconds: MODULE_1_DURATION,
      questions,
    };
    set({
      mode: 'test',
      phase: 'module-intro',
      setNumber: setNum,
      module1: mod1,
      module2: null,
      currentModuleNumber: 1,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: MODULE_1_DURATION,
      module1Result: null,
      module2Result: null,
      module2Tier: null,
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  beginModule: () => set({ phase: 'in-module' }),

  setAnswer: (qId, value) =>
    set((s) => ({ answers: { ...s.answers, [qId]: value } })),

  toggleFlag: (qId) =>
    set((s) => ({ flags: { ...s.flags, [qId]: !s.flags[qId] } })),

  navigateQuestion: (idx) => set({ currentQuestionIndex: idx, isReviewOpen: false }),

  tickTimer: () => {
    const { timeLeft } = get();
    if (timeLeft <= 1) {
      get().submitModule();
      return;
    }
    set({ timeLeft: timeLeft - 1 });
  },

  submitModule: () => {
    const { currentModuleNumber, module1, module2, answers, timeLeft, setNumber } = get();

    if (currentModuleNumber === 1 && module1) {
      let correct = 0;
      module1.questions.forEach((q) => {
        if (checkAnswer(q, answers[q.id] ?? null)) correct++;
      });
      const result: SATModuleResult = {
        moduleNumber: 1,
        difficultyTier: 'mixed',
        correct,
        total: module1.questions.length,
        answers: { ...answers },
        timeUsed: MODULE_1_DURATION - timeLeft,
      };
      const tier = routeToTier(correct);

      set({
        module1Result: result,
        module2Tier: tier,
        phase: 'between-modules',
        isReviewOpen: false,
        isCalculatorOpen: false,
      });

      // Pre-fetch module 2 questions
      if (setNumber) {
        fetchQuestions(2, setNumber, tier)
          .then((m2Questions) => {
            const m2: SATModule = {
              moduleNumber: 2,
              difficultyTier: tier,
              durationSeconds: MODULE_2_DURATION,
              questions: m2Questions,
            };
            set({ module2: m2 });
          })
          .catch((err) => {
            console.error('Failed to fetch Module 2 questions:', err);
          });
      }
    } else if (currentModuleNumber === 2 && module2) {
      let correct = 0;
      module2.questions.forEach((q) => {
        if (checkAnswer(q, answers[q.id] ?? null)) correct++;
      });
      const result: SATModuleResult = {
        moduleNumber: 2,
        difficultyTier: module2.difficultyTier,
        correct,
        total: module2.questions.length,
        answers: { ...answers },
        timeUsed: MODULE_2_DURATION - timeLeft,
      };
      set({
        module2Result: result,
        phase: 'results',
        isReviewOpen: false,
        isCalculatorOpen: false,
      });
    }
  },

  beginModule2: () => {
    const { module2 } = get();
    if (!module2) return;
    set({
      currentModuleNumber: 2,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: MODULE_2_DURATION,
      phase: 'module-intro',
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  toggleCalculator: () => set((s) => ({ isCalculatorOpen: !s.isCalculatorOpen })),
  toggleReview: () => set((s) => ({ isReviewOpen: !s.isReviewOpen })),
  toggleTimerVisibility: () => set((s) => ({ timerHidden: !s.timerHidden })),

  // Practice (placeholder — will need sat_questions rows or mock data)
  startPracticeMode: (config) => {
    set({
      mode: 'practice',
      phase: 'in-practice',
      practiceConfig: config,
      practiceQuestions: [],
      practiceAnswers: {},
      practiceRevealed: {},
      practiceIndex: 0,
    });
  },

  setPracticeAnswer: (qId, value) =>
    set((s) => ({ practiceAnswers: { ...s.practiceAnswers, [qId]: value } })),

  revealAnswer: (qId) =>
    set((s) => ({ practiceRevealed: { ...s.practiceRevealed, [qId]: true } })),

  navigatePractice: (idx) => set({ practiceIndex: idx }),

  finishPractice: () => set({ phase: 'practice-summary' }),
}));
