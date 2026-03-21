import { create } from 'zustand';
import type {
  CBSE10MathsQuestion,
  CBSE10MathsPracticeConfig,
  CBSE10PracticePhase,
} from '@/types/cbse10-maths';

interface CBSE10MathsState {
  phase: CBSE10PracticePhase;
  practiceConfig: CBSE10MathsPracticeConfig | null;
  practiceQuestions: CBSE10MathsQuestion[];
  practiceAnswers: Record<string, string>;
  practiceRevealed: Record<string, boolean>;
  practiceExplanations: Record<string, string>;
  practiceLoading: Record<string, boolean>;
  practiceTheory: Record<string, string>;
  practiceTheoryLoading: Record<string, boolean>;
  practiceIndex: number;
  practiceTimestamps: Record<string, number>;
  isCalculatorOpen: boolean;

  goToLanding: () => void;
  goToPracticeConfig: () => void;
  goToAnalytics: () => void;
  startPracticeMode: (config: CBSE10MathsPracticeConfig) => Promise<void>;
  setPracticeAnswer: (qId: string, value: string) => void;
  revealAnswer: (qId: string) => void;
  fetchTheory: (qId: string) => void;
  navigatePractice: (idx: number) => void;
  finishPractice: () => void;
  toggleCalculator: () => void;
}

export const useCBSE10MathsStore = create<CBSE10MathsState>((set, get) => ({
  phase: 'landing',
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

  goToLanding: () => set({ phase: 'landing' }),
  goToPracticeConfig: () => set({ phase: 'practice-config' }),
  goToAnalytics: () => set({ phase: 'analytics' }),
  toggleCalculator: () => set((s) => ({ isCalculatorOpen: !s.isCalculatorOpen })),

  startPracticeMode: async (config) => {
    const params = new URLSearchParams({
      count: String(config.questionCount),
    });
    if (config.domains.length > 0) params.set('domains', config.domains.join(','));
    if (config.chapters.length > 0) params.set('chapters', config.chapters.join(','));
    if (config.subtopics.length > 0) params.set('subtopics', config.subtopics.join(','));
    if (config.difficulty !== 'mixed') params.set('difficulty', config.difficulty);

    const res = await fetch(`/api/cbse10-maths/practice-questions?${params}`);
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

    fetch('/api/cbse10-maths/record-answer', {
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
        course: 'cbse10-maths',
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
        course: 'cbse10-maths',
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
    const now = Date.now();

    const updatedTimestamps = { ...practiceTimestamps };
    if (nextQ && !updatedTimestamps[nextQ.id]) {
      updatedTimestamps[nextQ.id] = now;
    }
    if (currentQ && updatedTimestamps[currentQ.id] && idx !== practiceIndex) {
      // Keep the enter time for the current question (time calculated on reveal)
    }

    set({ practiceIndex: idx, practiceTimestamps: updatedTimestamps });
  },

  finishPractice: () => set({ phase: 'practice-summary' }),
}));
