import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { GRETest } from '../types/gre-test';

interface TestState {
  // Data
  test: GRETest | null;
  currentSectionId: string | null;
  currentQuestionIndex: number;
  
  // User Inputs
  answers: Record<string, string | number | string[] | null>; // questionId -> value
  flags: Record<string, boolean>; // questionId -> isFlagged
  
  // UI State
  timeLeft: number;
  isCalculatorOpen: boolean;
  isReviewScreenOpen: boolean;
  
  // Actions
  initTest: (test: GRETest, sectionType?: 'verbal' | 'quantitative') => void;
  setAnswer: (questionId: string, answer: string | number | string[] | null) => void;
  toggleFlag: (questionId: string) => void;
  toggleCalculator: () => void;
  toggleReviewScreen: () => void;
  navigateQuestion: (index: number) => void;
  tickTimer: () => void;
  completeSection: () => void;
}

export const useTestStore = create<TestState>()(
  persist(
    (set, get) => ({
      test: null,
      currentSectionId: null,
      currentQuestionIndex: 0,
      answers: {},
      flags: {},
      timeLeft: 0,
      isCalculatorOpen: false,
      isReviewScreenOpen: false,

      initTest: (test, sectionType) => {
        let startingSectionId = test.startingSectionId;
        
        // If sectionType is provided, find the appropriate starting section
        if (sectionType) {
          const section = test.sections.find(
            s => s.sectionType === sectionType && s.id.includes('medium')
          );
          if (section) {
            startingSectionId = section.id;
          }
        }
        
        const startingSection = test.sections.find(s => s.id === startingSectionId);
        set({
          test,
          currentSectionId: startingSectionId,
          currentQuestionIndex: 0,
          timeLeft: startingSection?.durationSeconds || 0,
          answers: {},
          flags: {}
        });
      },

      setAnswer: (qId, val) => set((state) => ({
        answers: { ...state.answers, [qId]: val }
      })),

      toggleFlag: (qId) => set((state) => ({
        flags: { ...state.flags, [qId]: !state.flags[qId] }
      })),

      toggleCalculator: () => set((state) => ({ isCalculatorOpen: !state.isCalculatorOpen })),

      toggleReviewScreen: () => set((state) => ({ isReviewScreenOpen: !state.isReviewScreenOpen })),

      navigateQuestion: (idx) => set({ currentQuestionIndex: idx, isReviewScreenOpen: false }),

      tickTimer: () => set((state) => ({ timeLeft: state.timeLeft > 0 ? state.timeLeft - 1 : 0 })),

      completeSection: () => {
        const { test, currentSectionId, answers } = get();
        if (!test || !currentSectionId) return;

        const currentSection = test.sections.find(s => s.id === currentSectionId);
        if (!currentSection) return;

        // --- ADAPTIVE LOGIC CORE ---
        // 1. Calculate Score for current section
        let score = 0;
        currentSection.questions.forEach(q => {
             // Basic equality check - expand for multi-select logic later
            if (answers[q.id] === q.correctAnswer) score++;
        });

        // 2. Find next section based on routingRules
        const rule = currentSection.routingRules.find(r => 
            (r.condition.minScore === undefined || score >= r.condition.minScore) &&
            (r.condition.maxScore === undefined || score <= r.condition.maxScore)
        );

        if (rule) {
            const nextSection = test.sections.find(s => s.id === rule.nextSectionId);
            set({
                currentSectionId: nextSection?.id,
                currentQuestionIndex: 0,
                timeLeft: nextSection?.durationSeconds || 0,
                // Reset flags? Usually yes for new section. Keep answers? No.
                // Note: Real GRE doesn't let you return to previous sections.
            });
        } else {
            // Test Over or Error
            console.log("Test Complete");
        }
      }
    }),
    { name: 'gre-test-storage' }
  )
);

