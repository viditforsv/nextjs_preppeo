'use client';

import { useGRETestStore } from '@/stores/useGRETestStore';
import QuestionRenderer from './question-types/QuestionRenderer';
import GRECalculator from './GRECalculator';
import { renderMixedContent } from '@/components/MathRenderer';
import {
  ChevronLeft,
  ChevronRight,
  Calculator,
  CheckCircle,
  Eye,
  ArrowLeft,
} from 'lucide-react';

function isAnswerCorrect(
  question: { correctAnswer: string | string[] },
  answer: string | string[] | null
): boolean {
  if (!answer) return false;
  const correct = question.correctAnswer;
  if (Array.isArray(correct)) {
    if (!Array.isArray(answer)) return false;
    const a = [...answer].sort();
    const c = [...correct].sort();
    return a.length === c.length && a.every((v, i) => v === c[i]);
  }
  return String(answer) === String(correct);
}

export default function PracticeView() {
  const {
    practiceQuestions,
    practiceAnswers,
    practiceRevealed,
    practiceIndex,
    isCalculatorOpen,
    setPracticeAnswer,
    revealAnswer,
    navigatePractice,
    finishPractice,
    goToLanding,
    toggleCalculator,
  } = useGRETestStore();

  const questions = practiceQuestions;
  const question = questions[practiceIndex];
  const total = questions.length;

  if (!question) return null;

  const answer = practiceAnswers[question.id] ?? null;
  const revealed = practiceRevealed[question.id] ?? false;
  const hasAnswer =
    answer !== null && answer !== '' && !(Array.isArray(answer) && answer.length === 0);
  const correct = revealed ? isAnswerCorrect(question, answer) : null;

  const answeredCount = questions.filter((q) => practiceRevealed[q.id]).length;

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Top bar */}
      <header className="bg-emerald-700 text-white px-4 py-2.5 flex items-center justify-between sticky top-0 z-30 shadow-md">
        <div className="flex items-center gap-3">
          <button
            onClick={goToLanding}
            className="flex items-center gap-1 text-sm opacity-80 hover:opacity-100"
          >
            <ArrowLeft className="w-4 h-4" /> Exit
          </button>
          <div className="h-5 w-px bg-white/30" />
          <span className="text-sm font-medium">Practice Mode</span>
        </div>
        <div className="text-sm opacity-80">
          {answeredCount}/{total} reviewed
        </div>
      </header>

      {/* Question */}
      <main className="flex-1 p-6 max-w-4xl mx-auto w-full">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-sm font-medium text-gray-500">
            Question {practiceIndex + 1} of {total}
          </h2>
          <span
            className={`text-xs px-2 py-0.5 rounded-full font-medium ${
              question.difficulty === 'easy'
                ? 'bg-green-100 text-green-700'
                : question.difficulty === 'medium'
                ? 'bg-yellow-100 text-yellow-700'
                : 'bg-red-100 text-red-700'
            }`}
          >
            {question.difficulty}
          </span>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-4">
          {question.type !== 'quantitative-comparison' && (
            <div className="text-base text-gray-800 leading-relaxed mb-5">{renderMixedContent(question.prompt)}</div>
          )}
          <QuestionRenderer
            question={question}
            answer={answer}
            onAnswer={(val) => setPracticeAnswer(question.id, val)}
            disabled={revealed}
            showCorrect={revealed}
          />
        </div>

        {/* Feedback area */}
        {!revealed && hasAnswer && (
          <button
            onClick={() => revealAnswer(question.id)}
            className="w-full py-2.5 bg-emerald-600 text-white font-semibold rounded-lg hover:bg-emerald-700 transition-colors inline-flex items-center justify-center gap-2"
          >
            <Eye className="w-4 h-4" /> Check Answer
          </button>
        )}

        {revealed && (
          <div
            className={`rounded-xl border-2 p-4 mb-4 ${
              correct ? 'border-green-300 bg-green-50' : 'border-red-300 bg-red-50'
            }`}
          >
            <div className="flex items-center gap-2 mb-2">
              {correct ? (
                <CheckCircle className="w-5 h-5 text-green-600" />
              ) : (
                <span className="w-5 h-5 rounded-full bg-red-500 text-white flex items-center justify-center text-xs font-bold">
                  ✕
                </span>
              )}
              <span className={`font-semibold ${correct ? 'text-green-700' : 'text-red-700'}`}>
                {correct ? 'Correct!' : 'Incorrect'}
              </span>
            </div>
            <div className="text-sm text-gray-700">{renderMixedContent(question.explanation)}</div>
          </div>
        )}
      </main>

      {/* Footer nav */}
      <footer className="sticky bottom-0 bg-white border-t border-gray-300 px-4 py-3 z-20">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <button
              onClick={() => navigatePractice(Math.max(0, practiceIndex - 1))}
              disabled={practiceIndex === 0}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <ChevronLeft className="w-4 h-4" /> Prev
            </button>
            <button
              onClick={() => navigatePractice(Math.min(total - 1, practiceIndex + 1))}
              disabled={practiceIndex === total - 1}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Next <ChevronRight className="w-4 h-4" />
            </button>
          </div>

          <div className="hidden sm:flex gap-1 flex-wrap max-w-md justify-center">
            {questions.map((q, idx) => {
              const rev = practiceRevealed[q.id];
              const isCurr = idx === practiceIndex;
              return (
                <button
                  key={q.id}
                  onClick={() => navigatePractice(idx)}
                  className={`w-8 h-8 rounded text-xs font-semibold border transition-all ${
                    isCurr
                      ? 'border-emerald-500 bg-emerald-600 text-white scale-110'
                      : rev
                      ? 'border-green-400 bg-green-100 text-green-700'
                      : 'border-gray-300 bg-white text-gray-600'
                  }`}
                >
                  {idx + 1}
                </button>
              );
            })}
          </div>

          <div className="flex items-center gap-2">
            <button
              onClick={toggleCalculator}
              className={`inline-flex items-center gap-1.5 px-3 py-2 text-sm border rounded-lg transition-colors ${
                isCalculatorOpen
                  ? 'border-emerald-400 bg-emerald-50 text-emerald-700'
                  : 'border-gray-300 text-gray-600 hover:bg-gray-50'
              }`}
            >
              <Calculator className="w-4 h-4" />
            </button>
            {answeredCount === total && (
              <button
                onClick={finishPractice}
                className="px-4 py-2 text-sm font-semibold text-white bg-emerald-600 rounded-lg hover:bg-emerald-700"
              >
                Finish
              </button>
            )}
          </div>
        </div>
      </footer>

      {isCalculatorOpen && <GRECalculator onClose={toggleCalculator} />}
    </div>
  );
}
