import { create } from 'zustand';
import {
  GREQuestion,
  GRESection,
  DifficultyTier,
  AppPhase,
  SectionResult,
  PracticeConfig,
  GREQuestionResponse,
} from '@/types/gre-test';
import {
  getQuestionsByDifficulty,
} from '@/lib/mock-gre-math-data';
import { estimateGREScore } from '@/lib/gre-scoring';

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

function buildResponses(
  sectionNumber: 1 | 2,
  questions: GREQuestion[],
  answers: Record<string, string | string[] | null>,
  flags: Record<string, boolean>,
  timeAccum: Record<string, number>,
  visits: Record<string, number>,
): GREQuestionResponse[] {
  return questions.map((q) => {
    const answer = answers[q.id] ?? null;
    const isOmitted = answer === null || (Array.isArray(answer) && answer.length === 0);
    return {
      questionId: q.id,
      answer,
      isCorrect: checkAnswer(q, answer),
      isOmitted,
      isFlagged: !!flags[q.id],
      timeSpentMs: timeAccum[q.id] ?? 0,
      visitCount: visits[q.id] ?? 0,
      topics: q.topics ?? [],
      difficulty: q.difficulty,
      questionType: q.type,
      sectionNumber,
    };
  });
}

function flushCurrentQuestion(state: GRETestState): {
  questionTimeAccum: Record<string, number>;
  lastNavigatedAt: number;
} {
  const section = state.currentSectionNumber === 1 ? state.section1 : state.section2;
  if (!section) return { questionTimeAccum: state.questionTimeAccum, lastNavigatedAt: state.lastNavigatedAt };
  const q = section.questions[state.currentQuestionIndex];
  if (!q) return { questionTimeAccum: state.questionTimeAccum, lastNavigatedAt: state.lastNavigatedAt };

  const now = Date.now();
  const elapsed = now - state.lastNavigatedAt;
  return {
    questionTimeAccum: {
      ...state.questionTimeAccum,
      [q.id]: (state.questionTimeAccum[q.id] ?? 0) + elapsed,
    },
    lastNavigatedAt: now,
  };
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

  // Per-question analytics tracking
  lastNavigatedAt: number;
  questionTimeAccum: Record<string, number>;
  visitCounts: Record<string, number>;
  section1Responses: GREQuestionResponse[];
  allQuestionResponses: GREQuestionResponse[];
  estimatedScore: number | null;

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

const INITIAL_ANALYTICS = {
  lastNavigatedAt: 0,
  questionTimeAccum: {} as Record<string, number>,
  visitCounts: {} as Record<string, number>,
  section1Responses: [] as GREQuestionResponse[],
  allQuestionResponses: [] as GREQuestionResponse[],
  estimatedScore: null as number | null,
};

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
  ...INITIAL_ANALYTICS,
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
      ...INITIAL_ANALYTICS,
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
      ...INITIAL_ANALYTICS,
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  beginSection: () => {
    const state = get();
    const section = state.currentSectionNumber === 1 ? state.section1 : state.section2;
    const firstQ = section?.questions[0];
    set({
      phase: 'in-section',
      lastNavigatedAt: Date.now(),
      visitCounts: firstQ ? { [firstQ.id]: 1 } : {},
    });
  },

  setAnswer: (qId, value) =>
    set((s) => ({ answers: { ...s.answers, [qId]: value } })),

  toggleFlag: (qId) =>
    set((s) => ({ flags: { ...s.flags, [qId]: !s.flags[qId] } })),

  navigateQuestion: (idx) => {
    const state = get();
    const { questionTimeAccum, lastNavigatedAt } = flushCurrentQuestion(state);

    const section = state.currentSectionNumber === 1 ? state.section1 : state.section2;
    const targetQ = section?.questions[idx];
    const newVisits = { ...state.visitCounts };
    if (targetQ) {
      newVisits[targetQ.id] = (newVisits[targetQ.id] ?? 0) + 1;
    }

    set({
      currentQuestionIndex: idx,
      isReviewOpen: false,
      questionTimeAccum,
      lastNavigatedAt,
      visitCounts: newVisits,
    });
  },

  tickTimer: () => {
    const { timeLeft } = get();
    if (timeLeft <= 1) {
      get().submitSection();
      return;
    }
    set({ timeLeft: timeLeft - 1 });
  },

  submitSection: () => {
    const state = get();
    const { currentSectionNumber, section1, section2, answers, flags, timeLeft, setNumber, visitCounts } = state;

    const { questionTimeAccum } = flushCurrentQuestion(state);

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
      const s1Responses = buildResponses(1, section1.questions, answers, flags, questionTimeAccum, visitCounts);

      set({
        section1Result: result,
        section2Tier: tier,
        section1Responses: s1Responses,
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

      const s2Responses = buildResponses(2, section2.questions, answers, flags, questionTimeAccum, visitCounts);
      const s1Responses = state.section1Responses;
      const all = [...s1Responses, ...s2Responses];

      const s1Correct = state.section1Result?.correct ?? 0;
      const score = estimateGREScore({
        section1Correct: s1Correct,
        section2Correct: correct,
        section2Tier: section2.difficultyTier,
      });

      set({
        section2Result: result,
        allQuestionResponses: all,
        estimatedScore: score,
        phase: 'results',
        isReviewOpen: false,
        isCalculatorOpen: false,
      });

      // Persist attempt to DB
      const s1Result = state.section1Result;
      const totalCorrect = s1Correct + correct;
      const totalQuestions = (s1Result?.total ?? 0) + section2.questions.length;
      const scorePct = totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 10000) / 100 : 0;

      fetch('/api/gre/attempts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          setNumber: state.setNumber,
          section1Correct: s1Correct,
          section1Total: s1Result?.total ?? 0,
          section1TimeUsed: s1Result?.timeUsed ?? 0,
          section2Tier: section2.difficultyTier,
          section2Correct: correct,
          section2Total: section2.questions.length,
          section2TimeUsed: SECTION_2_DURATION - timeLeft,
          totalCorrect,
          totalQuestions,
          scorePct,
          estimatedScore: score,
          questionResponses: all,
        }),
      }).catch((err) => console.error('Failed to persist GRE attempt:', err));
    }
  },

  beginSection2: () => {
    const { section2 } = get();
    if (!section2) return;
    const firstQ = section2.questions[0];
    set({
      currentSectionNumber: 2,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: SECTION_2_DURATION,
      phase: 'section-intro',
      isCalculatorOpen: false,
      isReviewOpen: false,
      lastNavigatedAt: 0,
      questionTimeAccum: {},
      visitCounts: firstQ ? { [firstQ.id]: 0 } : {},
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
