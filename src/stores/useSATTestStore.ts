import { create } from 'zustand';
import type {
  SATQuestion,
  SATModule,
  SATSection,
  DifficultyTier,
  SATAppPhase,
  SATModuleResult,
  SATPracticeConfig,
  SATQuestionResponse,
} from '@/types/sat-test';
import {
  estimateMathScore,
  estimateRWScore,
  estimateTotalScore,
  routeToTierMath,
  routeToTierRW,
} from '@/lib/sat-scoring';

const RW_MODULE_DURATION = 1920; // 32 min
const MATH_MODULE_DURATION = 2100; // 35 min

function durationForSection(section: SATSection): number {
  return section === 'rw' ? RW_MODULE_DURATION : MATH_MODULE_DURATION;
}

function checkAnswer(
  question: SATQuestion,
  answer: string | null
): boolean {
  if (answer === null || answer === undefined) return false;
  return String(answer).trim().toLowerCase() === String(question.correctAnswer).trim().toLowerCase();
}

async function fetchQuestions(
  section: SATSection,
  moduleNum: number,
  setNumber: number,
  difficulty?: DifficultyTier
): Promise<SATQuestion[]> {
  const params = new URLSearchParams({
    section,
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

interface QuestionTiming {
  enterTime: number;
  totalMs: number;
}

function finalizeCurrentQuestionTime(
  questions: SATQuestion[],
  currentIndex: number,
  timestamps: Record<string, QuestionTiming>,
): Record<string, QuestionTiming> {
  const q = questions[currentIndex];
  if (!q) return timestamps;
  const ts = timestamps[q.id];
  if (!ts || ts.enterTime === 0) return timestamps;
  const elapsed = Date.now() - ts.enterTime;
  return {
    ...timestamps,
    [q.id]: { enterTime: 0, totalMs: ts.totalMs + elapsed },
  };
}

function buildResponses(
  section: SATSection,
  questions: SATQuestion[],
  answers: Record<string, string | null>,
  flags: Record<string, boolean>,
  timestamps: Record<string, QuestionTiming>,
  visitCounts: Record<string, number>,
): SATQuestionResponse[] {
  return questions.map((q) => {
    const answer = answers[q.id] ?? null;
    const isOmitted = answer === null || answer === undefined || answer === '';
    return {
      questionId: q.id,
      section,
      answer,
      isCorrect: checkAnswer(q, answer),
      isOmitted,
      isFlagged: !!flags[q.id],
      timeSpentMs: timestamps[q.id]?.totalMs ?? 0,
      visitCount: visitCounts[q.id] ?? 0,
      domain: q.domain ?? null,
      difficulty: q.difficulty,
      questionType: q.type,
      prompt: q.prompt,
      passage: q.passage,
      options: q.options,
      correctAnswer: q.correctAnswer,
      explanation: q.explanation,
      imageUrl: q.imageUrl,
    };
  });
}

interface SATTestState {
  phase: SATAppPhase;
  mode: 'test' | 'practice' | null;

  // Section tracking
  currentSection: SATSection;

  // Test mode — current module (reused for both sections)
  tokenCode: string | null;
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

  // Per-question tracking (current module)
  questionTimestamps: Record<string, QuestionTiming>;
  visitCounts: Record<string, number>;
  module1QuestionResponses: SATQuestionResponse[];

  // R&W section results (persisted across section break)
  rwModule1Result: SATModuleResult | null;
  rwModule2Result: SATModuleResult | null;
  rwModule2Tier: 'hard' | 'easy' | null;
  rwQuestionResponses: SATQuestionResponse[];
  rwEstimatedScore: number | null;

  // Combined results (set after Math M2 submission)
  allQuestionResponses: SATQuestionResponse[];
  mathEstimatedScore: number | null;
  totalEstimatedScore: number | null;

  // Practice mode
  practiceConfig: SATPracticeConfig | null;
  practiceQuestions: SATQuestion[];
  practiceAnswers: Record<string, string | null>;
  practiceRevealed: Record<string, boolean>;
  practiceExplanations: Record<string, string>;
  practiceLoading: Record<string, boolean>;
  practiceTheory: Record<string, string>;
  practiceTheoryLoading: Record<string, boolean>;
  practiceIndex: number;

  // UI
  isCalculatorOpen: boolean;
  isReviewOpen: boolean;
  timerHidden: boolean;

  // Actions
  goToLanding: () => void;
  startTestMode: (setNumber: number, tokenCode?: string) => Promise<void>;
  beginModule: () => void;
  setAnswer: (qId: string, value: string | null) => void;
  toggleFlag: (qId: string) => void;
  navigateQuestion: (idx: number) => void;
  tickTimer: () => void;
  submitModule: () => void;
  beginModule2: () => void;
  beginMathSection: () => Promise<void>;
  toggleCalculator: () => void;
  toggleReview: () => void;
  toggleTimerVisibility: () => void;

  // Practice actions
  startPracticeMode: (config: SATPracticeConfig) => Promise<void>;
  setPracticeAnswer: (qId: string, value: string | null) => void;
  revealAnswer: (qId: string) => void;
  fetchTheory: (qId: string) => void;
  navigatePractice: (idx: number) => void;
  finishPractice: () => void;
}

const initialState = {
  phase: 'landing' as SATAppPhase,
  mode: null as 'test' | 'practice' | null,
  currentSection: 'rw' as SATSection,
  tokenCode: null as string | null,
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
  questionTimestamps: {} as Record<string, QuestionTiming>,
  visitCounts: {} as Record<string, number>,
  module1QuestionResponses: [] as SATQuestionResponse[],
  rwModule1Result: null as SATModuleResult | null,
  rwModule2Result: null as SATModuleResult | null,
  rwModule2Tier: null as 'hard' | 'easy' | null,
  rwQuestionResponses: [] as SATQuestionResponse[],
  rwEstimatedScore: null as number | null,
  allQuestionResponses: [] as SATQuestionResponse[],
  mathEstimatedScore: null as number | null,
  totalEstimatedScore: null as number | null,
  practiceConfig: null as SATPracticeConfig | null,
  practiceQuestions: [] as SATQuestion[],
  practiceAnswers: {} as Record<string, string | null>,
  practiceRevealed: {} as Record<string, boolean>,
  practiceExplanations: {} as Record<string, string>,
  practiceLoading: {} as Record<string, boolean>,
  practiceTheory: {} as Record<string, string>,
  practiceTheoryLoading: {} as Record<string, boolean>,
  practiceIndex: 0,
  isCalculatorOpen: false,
  isReviewOpen: false,
  timerHidden: false,
};

export const useSATTestStore = create<SATTestState>()((set, get) => ({
  ...initialState,

  goToLanding: () => set({ ...initialState }),

  // Full test: try RW first; if no RW questions exist, fall back to Math-only
  startTestMode: async (setNum: number, tokenCode?: string) => {
    let section: SATSection = 'rw';
    let questions: SATQuestion[];

    try {
      questions = await fetchQuestions('rw', 1, setNum);
    } catch {
      // No R&W questions available — start with Math directly
      section = 'math';
      questions = await fetchQuestions('math', 1, setNum);
    }

    const duration = durationForSection(section);
    const mod1: SATModule = {
      moduleNumber: 1,
      section,
      difficultyTier: 'mixed',
      durationSeconds: duration,
      questions,
    };
    set({
      mode: 'test',
      phase: 'module-intro',
      currentSection: section,
      tokenCode: tokenCode ?? null,
      setNumber: setNum,
      module1: mod1,
      module2: null,
      currentModuleNumber: 1,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: duration,
      module1Result: null,
      module2Result: null,
      module2Tier: null,
      rwModule1Result: null,
      rwModule2Result: null,
      rwModule2Tier: null,
      rwQuestionResponses: [],
      rwEstimatedScore: null,
      mathEstimatedScore: null,
      totalEstimatedScore: null,
      allQuestionResponses: [],
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  beginModule: () => {
    const { currentModuleNumber, module1, module2 } = get();
    const mod = currentModuleNumber === 1 ? module1 : module2;
    const firstQ = mod?.questions[0];
    set({
      phase: 'in-module',
      questionTimestamps: firstQ
        ? { [firstQ.id]: { enterTime: Date.now(), totalMs: 0 } }
        : {},
      visitCounts: firstQ ? { [firstQ.id]: 1 } : {},
    });
  },

  setAnswer: (qId, value) =>
    set((s) => ({ answers: { ...s.answers, [qId]: value } })),

  toggleFlag: (qId) =>
    set((s) => ({ flags: { ...s.flags, [qId]: !s.flags[qId] } })),

  navigateQuestion: (idx) => {
    const { currentQuestionIndex, currentModuleNumber, module1, module2, questionTimestamps, visitCounts } = get();
    if (idx === currentQuestionIndex) {
      set({ isReviewOpen: false });
      return;
    }
    const mod = currentModuleNumber === 1 ? module1 : module2;
    if (!mod) {
      set({ currentQuestionIndex: idx, isReviewOpen: false });
      return;
    }
    const now = Date.now();
    const prevQ = mod.questions[currentQuestionIndex];
    const nextQ = mod.questions[idx];
    const updatedTs = { ...questionTimestamps };

    if (prevQ) {
      const prev = updatedTs[prevQ.id] || { enterTime: now, totalMs: 0 };
      const elapsed = prev.enterTime > 0 ? now - prev.enterTime : 0;
      updatedTs[prevQ.id] = { enterTime: 0, totalMs: prev.totalMs + elapsed };
    }
    if (nextQ) {
      const existing = updatedTs[nextQ.id] || { enterTime: 0, totalMs: 0 };
      updatedTs[nextQ.id] = { enterTime: now, totalMs: existing.totalMs };
    }

    set({
      currentQuestionIndex: idx,
      isReviewOpen: false,
      questionTimestamps: updatedTs,
      visitCounts: {
        ...visitCounts,
        [nextQ?.id ?? '']: (visitCounts[nextQ?.id ?? ''] || 0) + 1,
      },
    });
  },

  tickTimer: () => {
    const { timeLeft } = get();
    if (timeLeft <= 1) {
      get().submitModule();
      return;
    }
    set({ timeLeft: timeLeft - 1 });
  },

  submitModule: () => {
    const {
      currentSection, currentModuleNumber, module1, module2, answers, flags,
      timeLeft, setNumber, currentQuestionIndex,
      questionTimestamps, visitCounts,
    } = get();

    const duration = durationForSection(currentSection);

    if (currentModuleNumber === 1 && module1) {
      const finalTs = finalizeCurrentQuestionTime(module1.questions, currentQuestionIndex, questionTimestamps);
      let correct = 0;
      module1.questions.forEach((q) => {
        if (checkAnswer(q, answers[q.id] ?? null)) correct++;
      });
      const result: SATModuleResult = {
        moduleNumber: 1,
        section: currentSection,
        difficultyTier: 'mixed',
        correct,
        total: module1.questions.length,
        answers: { ...answers },
        timeUsed: duration - timeLeft,
      };
      const tier = currentSection === 'rw'
        ? routeToTierRW(correct)
        : routeToTierMath(correct);

      const m1Responses = buildResponses(currentSection, module1.questions, answers, flags, finalTs, visitCounts);

      set({
        module1Result: result,
        module2Tier: tier,
        module1QuestionResponses: m1Responses,
        phase: 'between-modules',
        isReviewOpen: false,
        isCalculatorOpen: false,
      });

      if (setNumber) {
        fetchQuestions(currentSection, 2, setNumber, tier)
          .then((m2Questions) => {
            const m2: SATModule = {
              moduleNumber: 2,
              section: currentSection,
              difficultyTier: tier,
              durationSeconds: duration,
              questions: m2Questions,
            };
            set({ module2: m2 });
          })
          .catch((err) => {
            console.error('Failed to fetch Module 2 questions:', err);
          });
      }
    } else if (currentModuleNumber === 2 && module2) {
      const finalTs = finalizeCurrentQuestionTime(module2.questions, currentQuestionIndex, questionTimestamps);
      let correct = 0;
      module2.questions.forEach((q) => {
        if (checkAnswer(q, answers[q.id] ?? null)) correct++;
      });
      const result: SATModuleResult = {
        moduleNumber: 2,
        section: currentSection,
        difficultyTier: module2.difficultyTier,
        correct,
        total: module2.questions.length,
        answers: { ...answers },
        timeUsed: duration - timeLeft,
      };

      const { module1Result, module1QuestionResponses } = get();

      if (currentSection === 'rw') {
        // R&W M2 done → save R&W results and go to section break
        const m2Responses = buildResponses('rw', module2.questions, answers, flags, finalTs, visitCounts);
        const allRWResponses = [...module1QuestionResponses, ...m2Responses];
        const m2Tier = (result.difficultyTier === 'hard' || result.difficultyTier === 'easy')
          ? result.difficultyTier
          : 'easy';
        const rwScore = estimateRWScore({
          module1Correct: module1Result!.correct,
          module1Total: module1Result!.total,
          module2Correct: result.correct,
          module2Total: result.total,
          module2Tier: m2Tier,
        });

        set({
          module2Result: result,
          rwModule1Result: module1Result,
          rwModule2Result: result,
          rwModule2Tier: m2Tier,
          rwQuestionResponses: allRWResponses,
          rwEstimatedScore: rwScore,
          phase: 'section-break',
          isReviewOpen: false,
          isCalculatorOpen: false,
        });
      } else {
        // Math M2 done → compute combined scores, persist, go to results
        const m2Responses = buildResponses('math', module2.questions, answers, flags, finalTs, visitCounts);
        const mathResponses = [...module1QuestionResponses, ...m2Responses];
        const allAnswers = { ...module1Result!.answers, ...result.answers };
        const m2Tier = (result.difficultyTier === 'hard' || result.difficultyTier === 'easy')
          ? result.difficultyTier
          : 'easy';
        const mathScore = estimateMathScore({
          module1Correct: module1Result!.correct,
          module1Total: module1Result!.total,
          module2Correct: result.correct,
          module2Total: result.total,
          module2Tier: m2Tier,
        });

        const { rwQuestionResponses, rwEstimatedScore, tokenCode, setNumber: sn,
                rwModule1Result, rwModule2Result, rwModule2Tier } = get();

        const hasRW = rwEstimatedScore !== null;
        const allResponses = [...rwQuestionResponses, ...mathResponses];
        const totalScore = hasRW ? estimateTotalScore(rwEstimatedScore, mathScore) : null;

        set({
          module2Result: result,
          allQuestionResponses: allResponses,
          mathEstimatedScore: mathScore,
          totalEstimatedScore: totalScore,
          phase: 'results',
          isReviewOpen: false,
          isCalculatorOpen: false,
        });

        fetch('/api/sat/attempts', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            tokenCode,
            setNumber: sn,
            sectionType: hasRW ? 'full' : 'math',
            // Math
            module1Correct: module1Result!.correct,
            module1Total: module1Result!.total,
            module1TimeUsed: module1Result!.timeUsed,
            module2Tier: m2Tier,
            module2Correct: result.correct,
            module2Total: result.total,
            module2TimeUsed: result.timeUsed,
            answersJson: allAnswers,
            estimatedScore: mathScore,
            questionResponses: mathResponses,
            // R&W (null when math-only)
            rwModule1Correct: rwModule1Result?.correct ?? null,
            rwModule1Total: rwModule1Result?.total ?? null,
            rwModule1TimeUsed: rwModule1Result?.timeUsed ?? null,
            rwModule2Tier: rwModule2Tier ?? null,
            rwModule2Correct: rwModule2Result?.correct ?? null,
            rwModule2Total: rwModule2Result?.total ?? null,
            rwModule2TimeUsed: rwModule2Result?.timeUsed ?? null,
            rwEstimatedScore: rwEstimatedScore ?? null,
            rwQuestionResponses: hasRW ? rwQuestionResponses : [],
            // Combined
            totalEstimatedScore: totalScore,
          }),
        }).catch((err) => console.error('Failed to persist SAT attempt:', err));
      }
    }
  },

  beginModule2: () => {
    const { module2, currentSection } = get();
    if (!module2) return;
    const duration = durationForSection(currentSection);
    set({
      currentModuleNumber: 2,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: duration,
      phase: 'module-intro',
      isCalculatorOpen: false,
      isReviewOpen: false,
      questionTimestamps: {},
      visitCounts: {},
    });
  },

  // Called from SectionBreakScreen after the 10-min break
  beginMathSection: async () => {
    const { setNumber } = get();
    if (!setNumber) return;

    const section: SATSection = 'math';
    const duration = durationForSection(section);
    const questions = await fetchQuestions(section, 1, setNumber);
    const mod1: SATModule = {
      moduleNumber: 1,
      section,
      difficultyTier: 'mixed',
      durationSeconds: duration,
      questions,
    };

    set({
      currentSection: section,
      module1: mod1,
      module2: null,
      currentModuleNumber: 1,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: duration,
      module1Result: null,
      module2Result: null,
      module2Tier: null,
      module1QuestionResponses: [],
      questionTimestamps: {},
      visitCounts: {},
      phase: 'module-intro',
      isCalculatorOpen: false,
      isReviewOpen: false,
    });
  },

  toggleCalculator: () => set((s) => ({ isCalculatorOpen: !s.isCalculatorOpen })),
  toggleReview: () => set((s) => ({ isReviewOpen: !s.isReviewOpen })),
  toggleTimerVisibility: () => set((s) => ({ timerHidden: !s.timerHidden })),

  startPracticeMode: async (config) => {
    const params = new URLSearchParams({
      section: config.section,
      count: String(config.questionCount),
    });
    if (config.domains.length > 0) {
      params.set('domains', config.domains.join(','));
    }
    if (config.chapters?.length > 0) {
      params.set('chapters', config.chapters.join(','));
    }
    if (config.subtopics?.length > 0) {
      params.set('subtopics', config.subtopics.join(','));
    }
    if (config.difficulty !== 'mixed') {
      params.set('difficulty', config.difficulty);
    }

    const res = await fetch(`/api/sat/practice-questions?${params}`);
    if (!res.ok) throw new Error('Failed to fetch practice questions');
    const data = await res.json();

    set({
      mode: 'practice',
      phase: 'in-practice',
      currentSection: config.section,
      practiceConfig: config,
      practiceQuestions: data.questions,
      practiceAnswers: {},
      practiceRevealed: {},
      practiceExplanations: {},
      practiceLoading: {},
      practiceTheory: {},
      practiceTheoryLoading: {},
      practiceIndex: 0,
      isCalculatorOpen: false,
    });
  },

  setPracticeAnswer: (qId, value) =>
    set((s) => ({ practiceAnswers: { ...s.practiceAnswers, [qId]: value } })),

  revealAnswer: (qId) => {
    const { practiceQuestions, practiceAnswers, practiceRevealed } = get();
    if (practiceRevealed[qId]) return;

    set((s) => ({
      practiceRevealed: { ...s.practiceRevealed, [qId]: true },
      practiceLoading: { ...s.practiceLoading, [qId]: true },
    }));

    const question = practiceQuestions.find((q) => q.id === qId);
    if (!question) return;

    const userAnswer = practiceAnswers[qId] ?? '';
    const isCorrect = userAnswer.trim().toLowerCase() === question.correctAnswer.trim().toLowerCase();

    fetch('/api/sat/record-answer', {
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
      }),
    }).catch(() => {});

    fetch('/api/sat/explain', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        questionId: question.id,
        prompt: question.prompt,
        passage: question.passage,
        options: question.options,
        userAnswer: practiceAnswers[qId] ?? '',
        correctAnswer: question.correctAnswer,
        section: question.section ?? 'math',
        domain: question.domain,
        difficulty: question.difficulty,
        explanation: question.explanation,
      }),
    })
      .then((r) => r.json())
      .then((data) => {
        set((s) => ({
          practiceExplanations: {
            ...s.practiceExplanations,
            [qId]: data.explanation ?? question.explanation,
          },
          practiceLoading: { ...s.practiceLoading, [qId]: false },
        }));
      })
      .catch(() => {
        set((s) => ({
          practiceExplanations: {
            ...s.practiceExplanations,
            [qId]: question.explanation,
          },
          practiceLoading: { ...s.practiceLoading, [qId]: false },
        }));
      });
  },

  fetchTheory: (qId) => {
    const { practiceQuestions, practiceTheory, practiceTheoryLoading, practiceAnswers } = get();
    if (practiceTheory[qId] || practiceTheoryLoading[qId]) return;

    set((s) => ({
      practiceTheoryLoading: { ...s.practiceTheoryLoading, [qId]: true },
    }));

    const question = practiceQuestions.find((q) => q.id === qId);
    if (!question) return;

    fetch('/api/sat/explain', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        questionId: question.id,
        prompt: question.prompt,
        passage: question.passage,
        options: question.options,
        userAnswer: practiceAnswers[qId] ?? '',
        correctAnswer: question.correctAnswer,
        section: question.section ?? 'math',
        domain: question.domain,
        difficulty: question.difficulty,
        mode: 'theory',
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

  navigatePractice: (idx) => set({ practiceIndex: idx }),

  finishPractice: () => set({ phase: 'practice-summary' }),
}));
