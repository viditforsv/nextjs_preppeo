import { create } from 'zustand';
import { AshokaQuestion, AshokaPhase, AshokaTestResult } from '@/types/ashoka-test';

const MCQ_DURATION = 5400; // 90 min
const ESSAY_DURATION = 1800; // 30 min

const DEFAULT_ESSAY_PROMPTS = [
  'Should higher education prioritise job-readiness over intellectual exploration? Discuss with examples.',
  'In an age of artificial intelligence, what role should human creativity play in solving global challenges?',
];

function checkAnswer(question: AshokaQuestion, answer: string | null): boolean {
  if (!answer) return false;
  return answer === question.correctAnswer;
}

async function fetchQuestions(setNumber: number): Promise<AshokaQuestion[]> {
  const res = await fetch(`/api/ashoka/questions?set=${setNumber}`);
  const data = await res.json();
  if (!res.ok || !data.questions) {
    throw new Error(data.error || 'Failed to fetch questions');
  }
  return data.questions;
}

interface AshokaTestState {
  phase: AshokaPhase;
  setNumber: number | null;
  questions: AshokaQuestion[];
  currentQuestionIndex: number;
  answers: Record<string, string | null>;
  flags: Record<string, boolean>;
  timeLeft: number;
  timerHidden: boolean;
  isReviewOpen: boolean;

  essayPrompts: string[];
  selectedPromptIndex: number | null;
  essayText: string;
  essayTimeLeft: number;

  result: AshokaTestResult | null;

  goToLanding: () => void;
  startTest: (setNumber: number) => Promise<void>;
  beginTest: () => void;
  setAnswer: (qId: string, value: string | null) => void;
  toggleFlag: (qId: string) => void;
  navigateQuestion: (idx: number) => void;
  tickTimer: () => void;
  toggleTimerVisibility: () => void;
  toggleReview: () => void;
  submitMCQs: () => void;
  selectPrompt: (idx: number) => void;
  beginEssay: () => void;
  setEssayText: (text: string) => void;
  tickEssayTimer: () => void;
  submitEssay: () => void;
}

const initialState = {
  phase: 'landing' as AshokaPhase,
  setNumber: null as number | null,
  questions: [] as AshokaQuestion[],
  currentQuestionIndex: 0,
  answers: {} as Record<string, string | null>,
  flags: {} as Record<string, boolean>,
  timeLeft: 0,
  timerHidden: false,
  isReviewOpen: false,
  essayPrompts: DEFAULT_ESSAY_PROMPTS,
  selectedPromptIndex: null as number | null,
  essayText: '',
  essayTimeLeft: 0,
  result: null as AshokaTestResult | null,
};

export const useAshokaTestStore = create<AshokaTestState>()((set, get) => ({
  ...initialState,

  goToLanding: () => set({ ...initialState }),

  startTest: async (setNum: number) => {
    const questions = await fetchQuestions(setNum);
    // Shuffle questions so PS and CT are interleaved randomly
    const shuffled = [...questions].sort(() => Math.random() - 0.5);
    set({
      phase: 'section-intro',
      setNumber: setNum,
      questions: shuffled,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: MCQ_DURATION,
      timerHidden: false,
      isReviewOpen: false,
      essayPrompts: DEFAULT_ESSAY_PROMPTS,
      selectedPromptIndex: null,
      essayText: '',
      essayTimeLeft: ESSAY_DURATION,
      result: null,
    });
  },

  beginTest: () => set({ phase: 'in-test' }),

  setAnswer: (qId, value) =>
    set((s) => ({ answers: { ...s.answers, [qId]: value } })),

  toggleFlag: (qId) =>
    set((s) => ({ flags: { ...s.flags, [qId]: !s.flags[qId] } })),

  navigateQuestion: (idx) => set({ currentQuestionIndex: idx, isReviewOpen: false }),

  tickTimer: () => {
    const { timeLeft } = get();
    if (timeLeft <= 1) {
      get().submitMCQs();
      return;
    }
    set({ timeLeft: timeLeft - 1 });
  },

  toggleTimerVisibility: () => set((s) => ({ timerHidden: !s.timerHidden })),

  toggleReview: () => set((s) => ({ isReviewOpen: !s.isReviewOpen })),

  submitMCQs: () => {
    const { questions, answers, timeLeft } = get();

    let correct = 0;
    let psCorrect = 0;
    let psTotal = 0;
    let ctCorrect = 0;
    let ctTotal = 0;

    questions.forEach((q) => {
      const isRight = checkAnswer(q, answers[q.id] ?? null);
      if (isRight) correct++;
      if (q.sectionType === 'problem-solving') {
        psTotal++;
        if (isRight) psCorrect++;
      } else {
        ctTotal++;
        if (isRight) ctCorrect++;
      }
    });

    set({
      phase: 'essay-intro',
      isReviewOpen: false,
      result: {
        correct,
        total: questions.length,
        psSectionCorrect: psCorrect,
        psSectionTotal: psTotal,
        ctSectionCorrect: ctCorrect,
        ctSectionTotal: ctTotal,
        answers: { ...answers },
        timeUsed: MCQ_DURATION - timeLeft,
        essayPrompt: '',
        essayText: '',
        essayTimeUsed: 0,
      },
    });
  },

  selectPrompt: (idx) => set({ selectedPromptIndex: idx }),

  beginEssay: () => set({ phase: 'in-essay', essayTimeLeft: ESSAY_DURATION }),

  setEssayText: (text) => set({ essayText: text }),

  tickEssayTimer: () => {
    const { essayTimeLeft } = get();
    if (essayTimeLeft <= 1) {
      get().submitEssay();
      return;
    }
    set({ essayTimeLeft: essayTimeLeft - 1 });
  },

  submitEssay: () => {
    const { result, essayPrompts, selectedPromptIndex, essayText, essayTimeLeft } = get();
    if (!result) return;

    set({
      phase: 'results',
      result: {
        ...result,
        essayPrompt: selectedPromptIndex !== null ? essayPrompts[selectedPromptIndex] : '',
        essayText,
        essayTimeUsed: ESSAY_DURATION - essayTimeLeft,
      },
    });
  },
}));
