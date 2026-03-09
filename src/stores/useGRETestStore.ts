import { create } from 'zustand';
import {
  GREQuestion,
  GRESection,
  DifficultyTier,
  AppPhase,
  SectionResult,
  PracticeConfig,
} from '@/types/gre-test';
import {
  getQuestionsByDifficulty,
} from '@/lib/mock-gre-math-data';

const SECTION_1_DURATION = 1260; // 21 min
const SECTION_2_DURATION = 1560; // 26 min

function scoreToTier(correct: number): DifficultyTier {
  if (correct >= 8) return 'hard';
  if (correct <= 4) return 'easy';
  return 'medium';
}

function checkAnswer(
  question: GREQuestion,
  answer: string | string[] | null
): boolean {
  if (answer === null || answer === undefined) return false;
  const correct = question.correctAnswer;
  if (Array.isArray(correct)) {
    if (!Array.isArray(answer)) return false;
    if (answer.length !== correct.length) return false;
    const sorted = [...answer].sort();
    const sortedCorrect = [...correct].sort();
    return sorted.every((v, i) => v === sortedCorrect[i]);
  }
  return String(answer) === String(correct);
}

async function fetchQuestions(
  section: number,
  setNumber: number,
  difficulty?: DifficultyTier
): Promise<GREQuestion[]> {
  const params = new URLSearchParams({
    section: String(section),
    set: String(setNumber),
  });
  if (difficulty) params.set('difficulty', difficulty);

  const res = await fetch(`/api/gre/questions?${params}`);
  const data = await res.json();

  if (!res.ok || !data.questions) {
    throw new Error(data.error || 'Failed to fetch questions');
  }
  return data.questions;
}

// ── State Shape ─────────────────────────────────────────────────────────────

interface GRETestState {
  phase: AppPhase;
  mode: 'test' | 'practice' | null;

  // Test mode
  setNumber: number | null;
  section1: GRESection | null;
  section2: GRESection | null;
  currentSectionNumber: 1 | 2;
  currentQuestionIndex: number;
  answers: Record<string, string | string[] | null>;
  flags: Record<string, boolean>;
  timeLeft: number;
  section1Result: SectionResult | null;
  section2Result: SectionResult | null;
  section2Tier: DifficultyTier | null;

  // Practice mode
  practiceConfig: PracticeConfig | null;
  practiceQuestions: GREQuestion[];
  practiceAnswers: Record<string, string | string[] | null>;
  practiceRevealed: Record<string, boolean>;
  practiceIndex: number;

  // UI
  isCalculatorOpen: boolean;
  isReviewOpen: boolean;
  timerHidden: boolean;

  // Actions
  goToLanding: () => void;
  startTestMode: (setNumber: number) => Promise<void>;
  beginSection: () => void;
  setAnswer: (qId: string, value: string | string[] | null) => void;
  toggleFlag: (qId: string) => void;
  navigateQuestion: (idx: number) => void;
  tickTimer: () => void;
  submitSection: () => void;
  beginSection2: () => void;
  toggleCalculator: () => void;
  toggleReview: () => void;
  toggleTimerVisibility: () => void;

  // Practice actions
  startPracticeMode: (config: PracticeConfig) => void;
  setPracticeAnswer: (qId: string, value: string | string[] | null) => void;
  revealAnswer: (qId: string) => void;
  navigatePractice: (idx: number) => void;
  finishPractice: () => void;
}

export const useGRETestStore = create<GRETestState>()((set, get) => ({
  phase: 'landing',
  mode: null,
  setNumber: null,
  section1: null,
  section2: null,
  currentSectionNumber: 1,
  currentQuestionIndex: 0,
  answers: {},
  flags: {},
  timeLeft: 0,
  section1Result: null,
  section2Result: null,
  section2Tier: null,
  practiceConfig: null,
  practiceQuestions: [],
  practiceAnswers: {},
  practiceRevealed: {},
  practiceIndex: 0,
  isCalculatorOpen: false,
  isReviewOpen: false,
  timerHidden: false,

  goToLanding: () =>
    set({
      phase: 'landing',
      mode: null,
      setNumber: null,
      section1: null,
      section2: null,
      currentSectionNumber: 1,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: 0,
      section1Result: null,
      section2Result: null,
      section2Tier: null,
      practiceConfig: null,
      practiceQuestions: [],
      practiceAnswers: {},
      practiceRevealed: {},
      practiceIndex: 0,
      isCalculatorOpen: false,
      isReviewOpen: false,
      timerHidden: false,
    }),

  startTestMode: async (setNum: number) => {
    const questions = await fetchQuestions(1, setNum);
    const section1: GRESection = {
      sectionNumber: 1,
      difficultyTier: 'medium',
      durationSeconds: SECTION_1_DURATION,
      questions,
    };
    set({
      mode: 'test',
      phase: 'section-intro',
      setNumber: setNum,
      section1,
      section2: null,
      currentSectionNumber: 1,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: SECTION_1_DURATION,
      section1Result: null,
      section2Result: null,
      section2Tier: null,
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  beginSection: () => set({ phase: 'in-section' }),

  setAnswer: (qId, value) =>
    set((s) => ({ answers: { ...s.answers, [qId]: value } })),

  toggleFlag: (qId) =>
    set((s) => ({ flags: { ...s.flags, [qId]: !s.flags[qId] } })),

  navigateQuestion: (idx) => set({ currentQuestionIndex: idx, isReviewOpen: false }),

  tickTimer: () => {
    const { timeLeft } = get();
    if (timeLeft <= 1) {
      get().submitSection();
      return;
    }
    set({ timeLeft: timeLeft - 1 });
  },

  submitSection: () => {
    const { currentSectionNumber, section1, section2, answers, timeLeft, setNumber } = get();

    if (currentSectionNumber === 1 && section1) {
      let correct = 0;
      section1.questions.forEach((q) => {
        if (checkAnswer(q, answers[q.id] ?? null)) correct++;
      });
      const result: SectionResult = {
        sectionNumber: 1,
        difficultyTier: 'medium',
        correct,
        total: section1.questions.length,
        answers: { ...answers },
        timeUsed: SECTION_1_DURATION - timeLeft,
      };
      const tier = scoreToTier(correct);

      set({
        section1Result: result,
        section2Tier: tier,
        phase: 'between-sections',
        isReviewOpen: false,
        isCalculatorOpen: false,
      });

      if (setNumber) {
        fetchQuestions(2, setNumber, tier)
          .then((s2Questions) => {
            const s2: GRESection = {
              sectionNumber: 2,
              difficultyTier: tier,
              durationSeconds: SECTION_2_DURATION,
              questions: s2Questions,
            };
            set({ section2: s2 });
          })
          .catch((err) => {
            console.error('Failed to fetch Section 2 questions:', err);
          });
      }
    } else if (currentSectionNumber === 2 && section2) {
      let correct = 0;
      section2.questions.forEach((q) => {
        if (checkAnswer(q, answers[q.id] ?? null)) correct++;
      });
      const result: SectionResult = {
        sectionNumber: 2,
        difficultyTier: section2.difficultyTier,
        correct,
        total: section2.questions.length,
        answers: { ...answers },
        timeUsed: SECTION_2_DURATION - timeLeft,
      };
      set({
        section2Result: result,
        phase: 'results',
        isReviewOpen: false,
        isCalculatorOpen: false,
      });
    }
  },

  beginSection2: () => {
    const { section2 } = get();
    if (!section2) return;
    set({
      currentSectionNumber: 2,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: SECTION_2_DURATION,
      phase: 'section-intro',
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  toggleCalculator: () => set((s) => ({ isCalculatorOpen: !s.isCalculatorOpen })),
  toggleReview: () => set((s) => ({ isReviewOpen: !s.isReviewOpen })),
  toggleTimerVisibility: () => set((s) => ({ timerHidden: !s.timerHidden })),

  // Practice (still uses mock data)
  startPracticeMode: (config) => {
    const questions = getQuestionsByDifficulty(config.difficulty, config.questionCount);
    set({
      mode: 'practice',
      phase: 'in-practice',
      practiceConfig: config,
      practiceQuestions: questions,
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
