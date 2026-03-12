'use client';

import { useSATTestStore } from '@/stores/useSATTestStore';
import { renderMixedContent } from '@/components/MathRenderer';
import DesmosCalculator from './DesmosCalculator';
import {
  BookOpen,
  ChevronLeft,
  ChevronRight,
  Calculator,
  CheckCircle,
  XCircle,
  Loader2,
  LogOut,
  Sparkles,
} from 'lucide-react';

const DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Advanced Math',
  'problem-solving': 'Problem Solving',
  'geometry-trig': 'Geometry & Trig',
  'craft-structure': 'Craft & Structure',
  'information-ideas': 'Information & Ideas',
  'standard-english': 'Standard English',
  'expression-of-ideas': 'Expression of Ideas',
};

export default function PracticeView() {
  const {
    practiceQuestions,
    practiceAnswers,
    practiceRevealed,
    practiceExplanations,
    practiceLoading,
    practiceIndex,
    currentSection,
    isCalculatorOpen,
    setPracticeAnswer,
    revealAnswer,
    navigatePractice,
    finishPractice,
    goToLanding,
    toggleCalculator,
  } = useSATTestStore();

  const total = practiceQuestions.length;
  if (total === 0) return null;

  const question = practiceQuestions[practiceIndex];
  const answer = practiceAnswers[question.id] ?? null;
  const isRevealed = !!practiceRevealed[question.id];
  const isLoading = !!practiceLoading[question.id];
  const aiExplanation = practiceExplanations[question.id];
  const isCorrect = answer !== null && answer.trim().toLowerCase() === question.correctAnswer.trim().toLowerCase();
  const isMath = currentSection === 'math';

  const reviewed = Object.keys(practiceRevealed).length;

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Header */}
      <header className="bg-emerald-700 text-white px-4 py-2.5 flex items-center justify-between sticky top-0 z-30 shadow-md">
        <div className="flex items-center gap-3">
          <BookOpen className="w-4 h-4" />
          <span className="text-sm font-semibold">Practice</span>
          <span className="text-xs opacity-70">
            {isMath ? 'Math' : 'R&W'} · {reviewed}/{total} reviewed
          </span>
        </div>
        <button
          onClick={goToLanding}
          className="inline-flex items-center gap-1.5 text-sm opacity-80 hover:opacity-100 transition-opacity"
        >
          <LogOut className="w-4 h-4" />
          Exit
        </button>
      </header>

      {/* Question Area */}
      <main className="flex-1 p-6 max-w-4xl mx-auto w-full">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-sm font-medium text-gray-500">
            Question {practiceIndex + 1} of {total}
          </h2>
          {question.domain && (
            <span className="text-xs px-2 py-1 rounded bg-gray-100 text-gray-500 font-medium">
              {DOMAIN_LABELS[question.domain] ?? question.domain}
            </span>
          )}
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-4">
          {/* Passage */}
          {question.passage && (
            <div className="mb-5 pb-5 border-b border-gray-200">
              <p className="text-xs font-semibold uppercase text-gray-400 mb-2 tracking-wider">Passage</p>
              <div className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
                {renderMixedContent(question.passage)}
              </div>
            </div>
          )}

          {/* Prompt */}
          <div className="mb-5">
            <div className="text-base text-gray-800 leading-relaxed">
              {renderMixedContent(question.prompt)}
            </div>
          </div>

          {/* Image */}
          {question.imageUrl && (
            <div className="mb-5">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={question.imageUrl} alt="Question figure" className="max-w-full rounded-lg border border-gray-200" />
            </div>
          )}

          {/* Options */}
          {question.options && (
            <div className="space-y-2">
              {question.options.map((opt) => {
                const isSelected = answer === opt.id;
                const isCorrectOpt = opt.id === question.correctAnswer;

                let borderClass = 'border-gray-200 hover:border-gray-300';
                let bgClass = '';

                if (isRevealed) {
                  if (isCorrectOpt) {
                    borderClass = 'border-green-400';
                    bgClass = 'bg-green-50';
                  } else if (isSelected && !isCorrectOpt) {
                    borderClass = 'border-red-400';
                    bgClass = 'bg-red-50';
                  } else {
                    borderClass = 'border-gray-200 opacity-60';
                  }
                } else if (isSelected) {
                  borderClass = 'border-emerald-400 bg-emerald-50';
                }

                return (
                  <button
                    key={opt.id}
                    onClick={() => !isRevealed && setPracticeAnswer(question.id, opt.id)}
                    disabled={isRevealed}
                    className={`w-full text-left flex items-start gap-3 p-3 rounded-lg border-2 transition-all ${borderClass} ${bgClass}`}
                  >
                    <span className={`w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs font-bold shrink-0 mt-0.5 ${
                      isRevealed && isCorrectOpt
                        ? 'border-green-500 bg-green-500 text-white'
                        : isRevealed && isSelected && !isCorrectOpt
                        ? 'border-red-500 bg-red-500 text-white'
                        : isSelected
                        ? 'border-emerald-500 bg-emerald-500 text-white'
                        : 'border-gray-300 text-gray-500'
                    }`}>
                      {isRevealed && isCorrectOpt ? (
                        <CheckCircle className="w-4 h-4" />
                      ) : isRevealed && isSelected && !isCorrectOpt ? (
                        <XCircle className="w-4 h-4" />
                      ) : (
                        opt.id
                      )}
                    </span>
                    <span className="text-sm text-gray-800 leading-relaxed pt-0.5">
                      {renderMixedContent(opt.text)}
                    </span>
                  </button>
                );
              })}
            </div>
          )}

          {/* SPR input */}
          {question.type === 'spr' && (
            <div className="mt-4">
              <input
                type="text"
                value={answer ?? ''}
                onChange={(e) => !isRevealed && setPracticeAnswer(question.id, e.target.value)}
                disabled={isRevealed}
                placeholder="Type your answer..."
                className={`w-full px-4 py-3 border-2 rounded-lg text-base ${
                  isRevealed
                    ? isCorrect
                      ? 'border-green-400 bg-green-50'
                      : 'border-red-400 bg-red-50'
                    : 'border-gray-300 focus:border-emerald-400 focus:ring-1 focus:ring-emerald-400'
                } outline-none transition-colors`}
              />
              {isRevealed && !isCorrect && (
                <p className="text-sm text-green-700 mt-2">
                  Correct answer: <strong>{question.correctAnswer}</strong>
                </p>
              )}
            </div>
          )}

          {/* Check Answer button */}
          {!isRevealed && (
            <button
              onClick={() => revealAnswer(question.id)}
              disabled={answer === null || answer === ''}
              className="mt-5 w-full py-2.5 bg-emerald-600 text-white font-semibold rounded-lg hover:bg-emerald-700 disabled:opacity-40 disabled:cursor-not-allowed transition-colors inline-flex items-center justify-center gap-2"
            >
              <CheckCircle className="w-4 h-4" />
              Check Answer
            </button>
          )}

          {/* Result badge */}
          {isRevealed && (
            <div className={`mt-4 flex items-center gap-2 px-4 py-2 rounded-lg ${
              isCorrect ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'
            }`}>
              {isCorrect ? (
                <CheckCircle className="w-5 h-5" />
              ) : (
                <XCircle className="w-5 h-5" />
              )}
              <span className="font-semibold text-sm">
                {isCorrect ? 'Correct!' : 'Incorrect'}
              </span>
            </div>
          )}
        </div>

        {/* AI Explanation */}
        {isRevealed && (
          <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-4">
            <div className="flex items-center gap-2 mb-3">
              <Sparkles className="w-4 h-4 text-amber-500" />
              <h3 className="text-sm font-semibold text-gray-700">AI Explanation</h3>
            </div>
            {isLoading ? (
              <div className="flex items-center gap-2 text-sm text-gray-500 py-4">
                <Loader2 className="w-4 h-4 animate-spin" />
                Generating explanation...
              </div>
            ) : (
              <div className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
                {aiExplanation ?? question.explanation}
              </div>
            )}
          </div>
        )}
      </main>

      {/* Footer */}
      <footer className="sticky bottom-0 bg-white border-t border-gray-300 px-4 py-3 z-20">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <button
              onClick={() => navigatePractice(Math.max(0, practiceIndex - 1))}
              disabled={practiceIndex === 0}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <ChevronLeft className="w-4 h-4" /> Back
            </button>
            <button
              onClick={() => navigatePractice(Math.min(total - 1, practiceIndex + 1))}
              disabled={practiceIndex === total - 1}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Next <ChevronRight className="w-4 h-4" />
            </button>
          </div>

          {/* Question palette */}
          <div className="hidden sm:flex gap-1 flex-wrap max-w-md justify-center">
            {practiceQuestions.map((q, idx) => {
              const revealed = !!practiceRevealed[q.id];
              const ans = practiceAnswers[q.id];
              const correct = revealed && ans !== null && ans.trim().toLowerCase() === q.correctAnswer.trim().toLowerCase();
              const isCurr = idx === practiceIndex;

              return (
                <button
                  key={q.id}
                  onClick={() => navigatePractice(idx)}
                  className={`w-8 h-8 rounded text-xs font-semibold border transition-all ${
                    isCurr
                      ? 'border-emerald-500 bg-emerald-600 text-white scale-110'
                      : revealed
                      ? correct
                        ? 'border-green-400 bg-green-100 text-green-700'
                        : 'border-red-400 bg-red-100 text-red-700'
                      : ans
                      ? 'border-gray-400 bg-gray-100 text-gray-600'
                      : 'border-gray-300 bg-white text-gray-500 hover:border-gray-400'
                  }`}
                >
                  {idx + 1}
                </button>
              );
            })}
          </div>

          <div className="flex items-center gap-2">
            {isMath && (
              <button
                onClick={toggleCalculator}
                className={`inline-flex items-center gap-1.5 px-3 py-2 text-sm border rounded-lg transition-colors ${
                  isCalculatorOpen
                    ? 'border-emerald-400 bg-emerald-50 text-emerald-700'
                    : 'border-gray-300 text-gray-600 hover:bg-gray-50'
                }`}
                title="Desmos Calculator"
              >
                <Calculator className="w-4 h-4" />
              </button>
            )}
            <button
              onClick={finishPractice}
              className="px-4 py-2 text-sm font-semibold text-white bg-emerald-600 rounded-lg hover:bg-emerald-700 transition-colors"
            >
              Finish
            </button>
          </div>
        </div>
      </footer>

      {isMath && isCalculatorOpen && <DesmosCalculator onClose={toggleCalculator} />}
    </div>
  );
}
