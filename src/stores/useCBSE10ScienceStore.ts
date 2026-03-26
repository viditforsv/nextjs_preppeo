import { create } from 'zustand';
import type {
  CBSE10ScienceQuestion,
  CBSE10SciencePracticeConfig,
  CBSE10SciencePracticePhase,
  CBSE10ScienceTestConfig,
  CBSE10ScienceFlashcardConfig,
} from '@/types/cbse10-science';

interface CBSE10ScienceState {
  phase: CBSE10SciencePracticePhase;

  // Practice mode
  practiceConfig: CBSE10SciencePracticeConfig | null;
  practiceQuestions: CBSE10ScienceQuestion[];
  practiceAnswers: Record<string, string>;
  practiceRevealed: Record<string, boolean>;
  practiceExplanations: Record<string, string>;
  practiceLoading: Record<string, boolean>;
  practiceTheory: Record<string, string>;
  practiceTheoryLoading: Record<string, boolean>;
  practiceIndex: number;
  practiceTimestamps: Record<string, number>;
  isCalculatorOpen: boolean;

  // Test mode
  testConfig: CBSE10ScienceTestConfig | null;
  testQuestions: CBSE10ScienceQuestion[];
  testAnswers: Record<string, string>;
  testFlags: Record<string, boolean>;
  testIndex: number;
  testStartTime: number | null;
  testTimeLimitMs: number;

  // Flashcards
  flashcardConfig: CBSE10ScienceFlashcardConfig | null;
  flashcardCards: CBSE10ScienceQuestion[];
  flashcardIndex: number;
  flashcardKnown: string[];
  flashcardReview: string[];

  // Navigation
  goToLanding: () => void;
  goToStudyModeSelect: () => void;
  goToPracticeConfig: () => void;
  goToAnalytics: () => void;
  goToTestConfig: () => void;
  goToFlashcardConfig: () => void;

  // Practice actions
  startPracticeMode: (config: CBSE10SciencePracticeConfig) => Promise<void>;
  setPracticeAnswer: (qId: string, value: string) => void;
  revealAnswer: (qId: string) => void;
  fetchTheory: (qId: string) => void;
  navigatePractice: (idx: number) => void;
  finishPractice: () => void;
  toggleCalculator: () => void;

  // Test actions
  startTestMode: (config: CBSE10ScienceTestConfig) => Promise<void>;
  setTestAnswer: (qId: string, value: string) => void;
  toggleTestFlag: (qId: string) => void;
  navigateTest: (idx: number) => void;
  finishTest: () => void;

  // Flashcard actions
  startFlashcards: (config: CBSE10ScienceFlashcardConfig) => Promise<void>;
  navigateFlashcard: (idx: number) => void;
  markFlashcardKnown: (qId: string) => void;
  markFlashcardReview: (qId: string) => void;
}

export const useCBSE10ScienceStore = create<CBSE10ScienceState>((set, get) => ({
  phase: 'landing',

  // Practice mode initial state
  practiceConfig: null,
  practiceQuestions: [],
  practiceAnswers: {},
  practiceRevealed: {},
  practiceExplanations: {},
  practiceLoading: {},
  practiceTheory: {},
  practiceTheoryLoading: {},
  practiceIndex: 0,
  practiceTimestamps: {},
  isCalculatorOpen: false,

  // Test mode initial state
  testConfig: null,
  testQuestions: [],
  testAnswers: {},
  testFlags: {},
  testIndex: 0,
  testStartTime: null,
  testTimeLimitMs: 0,

  // Flashcard initial state
  flashcardConfig: null,
  flashcardCards: [],
  flashcardIndex: 0,
  flashcardKnown: [],
  flashcardReview: [],

  // Navigation
  goToLanding: () => set({ phase: 'landing' }),
  goToStudyModeSelect: () => set({ phase: 'study-mode-select' }),
  goToPracticeConfig: () => set({ phase: 'practice-config' }),
  goToAnalytics: () => set({ phase: 'analytics' }),
  goToTestConfig: () => set({ phase: 'test-config' }),
  goToFlashcardConfig: () => set({ phase: 'flashcard-config' }),
  toggleCalculator: () => set((s) => ({ isCalculatorOpen: !s.isCalculatorOpen })),

  // Practice mode
  startPracticeMode: async (config) => {
    const params = new URLSearchParams({
      count: String(config.questionCount),
    });
    if (config.domains.length > 0) params.set('domains', config.domains.join(','));
    if (config.chapters.length > 0) params.set('chapters', config.chapters.join(','));
    if (config.subtopics.length > 0) params.set('subtopics', config.subtopics.join(','));
    if (config.difficulty !== 'mixed') params.set('difficulty', config.difficulty);

    const res = await fetch(`/api/cbse10-science/practice-questions?${params}`);
    if (!res.ok) throw new Error('Failed to fetch practice questions');
    const data = await res.json();

    set({
      phase: 'in-practice',
      practiceConfig: config,
      practiceQuestions: data.questions,
      practiceAnswers: {},
      practiceRevealed: {},
      practiceExplanations: {},
      practiceLoading: {},
      practiceTheory: {},
      practiceTheoryLoading: {},
      practiceIndex: 0,
      practiceTimestamps: {},
      isCalculatorOpen: false,
    });
  },

  setPracticeAnswer: (qId, value) =>
    set((s) => ({ practiceAnswers: { ...s.practiceAnswers, [qId]: value } })),

  revealAnswer: (qId) => {
    const { practiceQuestions, practiceAnswers, practiceRevealed, practiceTimestamps } = get();
    if (practiceRevealed[qId]) return;

    const question = practiceQuestions.find((q) => q.id === qId);
    if (!question) return;

    const userAnswer = practiceAnswers[qId] ?? '';
    const isCorrect = userAnswer.trim().toLowerCase() === question.correctAnswer.trim().toLowerCase();
    const enterTime = practiceTimestamps[qId];
    const timeSpentMs = enterTime ? Date.now() - enterTime : undefined;

    set((s) => ({
      practiceRevealed: { ...s.practiceRevealed, [qId]: true },
      practiceLoading: { ...s.practiceLoading, [qId]: true },
    }));

    fetch('/api/cbse10-science/record-answer', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        questionId: question.id,
        answerGiven: userAnswer,
        isCorrect,
        domain: question.domain,
        chapter: question.chapter,
        subtopic: question.subtopic,
        difficultyTier: question.difficulty,
        timeSpentMs,
      }),
    }).catch(() => {});

    fetch('/api/sat/explain', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        questionId: question.id,
        prompt: question.prompt,
        options: question.options,
        userAnswer,
        correctAnswer: question.correctAnswer,
        section: 'math',
        domain: question.domain,
        difficulty: question.difficulty,
        explanation: question.explanation,
        course: 'cbse10-science',
      }),
    })
      .then((r) => r.json())
      .then((data) => {
        set((s) => ({
          practiceExplanations: { ...s.practiceExplanations, [qId]: data.explanation ?? question.explanation },
          practiceLoading: { ...s.practiceLoading, [qId]: false },
        }));
      })
      .catch(() => {
        set((s) => ({
          practiceExplanations: { ...s.practiceExplanations, [qId]: question.explanation },
          practiceLoading: { ...s.practiceLoading, [qId]: false },
        }));
      });
  },

  fetchTheory: (qId) => {
    const { practiceQuestions, practiceTheory, practiceTheoryLoading, practiceAnswers } = get();
    if (practiceTheory[qId] || practiceTheoryLoading[qId]) return;

    set((s) => ({ practiceTheoryLoading: { ...s.practiceTheoryLoading, [qId]: true } }));

    const question = practiceQuestions.find((q) => q.id === qId);
    if (!question) return;

    fetch('/api/sat/explain', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        questionId: question.id,
        prompt: question.prompt,
        options: question.options,
        userAnswer: practiceAnswers[qId] ?? '',
        correctAnswer: question.correctAnswer,
        section: 'math',
        domain: question.domain,
        difficulty: question.difficulty,
        mode: 'theory',
        course: 'cbse10-science',
      }),
    })
      .then((r) => r.json())
      .then((data) => {
        set((s) => ({
          practiceTheory: { ...s.practiceTheory, [qId]: data.explanation ?? 'Unable to load theory.' },
          practiceTheoryLoading: { ...s.practiceTheoryLoading, [qId]: false },
        }));
      })
      .catch(() => {
        set((s) => ({
          practiceTheory: { ...s.practiceTheory, [qId]: 'Unable to load theory at this time.' },
          practiceTheoryLoading: { ...s.practiceTheoryLoading, [qId]: false },
        }));
      });
  },

  navigatePractice: (idx) => {
    const { practiceQuestions, practiceIndex, practiceTimestamps } = get();
    const currentQ = practiceQuestions[practiceIndex];
    const nextQ = practiceQuestions[idx];

    const updatedTimestamps = { ...practiceTimestamps };
    if (nextQ && !updatedTimestamps[nextQ.id]) {
      updatedTimestamps[nextQ.id] = Date.now();
    }
    if (currentQ && updatedTimestamps[currentQ.id] && idx !== practiceIndex) {
      // Keep the enter time for the current question (time calculated on reveal)
    }

    set({ practiceIndex: idx, practiceTimestamps: updatedTimestamps });
  },

  finishPractice: () => set({ phase: 'practice-summary' }),

  // Test mode
  startTestMode: async (config) => {
    const params = new URLSearchParams({
      count: String(config.questionCount),
    });
    if (config.domains.length > 0) params.set('domains', config.domains.join(','));
    if (config.chapters.length > 0) params.set('chapters', config.chapters.join(','));
    if (config.subtopics.length > 0) params.set('subtopics', config.subtopics.join(','));
    if (config.difficulty !== 'mixed') params.set('difficulty', config.difficulty);

    const res = await fetch(`/api/cbse10-science/practice-questions?${params}`);
    if (!res.ok) throw new Error('Failed to fetch test questions');
    const data = await res.json();

    set({
      phase: 'in-test',
      testConfig: config,
      testQuestions: data.questions,
      testAnswers: {},
      testFlags: {},
      testIndex: 0,
      testStartTime: Date.now(),
      testTimeLimitMs: config.timeLimitMinutes * 60 * 1000,
    });
  },

  setTestAnswer: (qId, value) =>
    set((s) => ({ testAnswers: { ...s.testAnswers, [qId]: value } })),

  toggleTestFlag: (qId) =>
    set((s) => ({ testFlags: { ...s.testFlags, [qId]: !s.testFlags[qId] } })),

  navigateTest: (idx) => set({ testIndex: idx }),

  finishTest: () => {
    const { testQuestions, testAnswers, testStartTime, testTimeLimitMs } = get();
    const totalTimeMs = testStartTime ? Date.now() - testStartTime : testTimeLimitMs;

    // Record all answers to analytics
    testQuestions.forEach((question) => {
      const userAnswer = testAnswers[question.id] ?? '';
      const isCorrect = userAnswer.trim().toLowerCase() === question.correctAnswer.trim().toLowerCase();
      const isAttempted = userAnswer.trim() !== '';

      if (isAttempted) {
        fetch('/api/cbse10-science/record-answer', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            questionId: question.id,
            answerGiven: userAnswer,
            isCorrect,
            domain: question.domain,
            chapter: question.chapter,
            subtopic: question.subtopic,
            difficultyTier: question.difficulty,
            timeSpentMs: Math.round(totalTimeMs / testQuestions.length),
          }),
        }).catch(() => {});
      }
    });

    set({ phase: 'test-results' });
  },

  // Flashcards
  startFlashcards: async (config) => {
    const params = new URLSearchParams({
      count: String(config.cardCount),
    });
    if (config.domains.length > 0) params.set('domains', config.domains.join(','));
    if (config.chapters.length > 0) params.set('chapters', config.chapters.join(','));

    const res = await fetch(`/api/cbse10-science/flashcards?${params}`);
    if (!res.ok) throw new Error('Failed to fetch flashcard questions');
    const data = await res.json();

    set({
      phase: 'in-flashcards',
      flashcardConfig: config,
      flashcardCards: data.cards,
      flashcardIndex: 0,
      flashcardKnown: [],
      flashcardReview: [],
    });
  },

  navigateFlashcard: (idx) => set({ flashcardIndex: idx }),

  markFlashcardKnown: (qId) =>
    set((s) => ({
      flashcardKnown: s.flashcardKnown.includes(qId) ? s.flashcardKnown : [...s.flashcardKnown, qId],
      flashcardReview: s.flashcardReview.filter((id) => id !== qId),
    })),

  markFlashcardReview: (qId) =>
    set((s) => ({
      flashcardReview: s.flashcardReview.includes(qId) ? s.flashcardReview : [...s.flashcardReview, qId],
      flashcardKnown: s.flashcardKnown.filter((id) => id !== qId),
    })),
}));
