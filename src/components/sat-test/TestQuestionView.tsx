'use client';

import { useEffect, useState } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import QuestionRenderer from './question-types/QuestionRenderer';
import DesmosCalculator from './DesmosCalculator';
import ReviewScreen from './ReviewScreen';
import { renderMixedContent } from '@/components/MathRenderer';
import { satPromptImageUrls } from '@/lib/sat-prompt-images';
import {
  Clock,
  Flag,
  Eye,
  Calculator,
  ChevronLeft,
  ChevronRight,
  AlertCircle,
  EyeOff,
} from 'lucide-react';

export default function TestQuestionView() {
  const {
    module1,
    module2,
    currentModuleNumber,
    currentSection,
    currentQuestionIndex,
    answers,
    flags,
    timeLeft,
    isCalculatorOpen,
    isReviewOpen,
    timerHidden,
    setAnswer,
    toggleFlag,
    navigateQuestion,
    tickTimer,
    submitModule,
    toggleCalculator,
    toggleReview,
    toggleTimerVisibility,
  } = useSATTestStore();

  const [showSubmitConfirm, setShowSubmitConfirm] = useState(false);

  const mod = currentModuleNumber === 1 ? module1 : module2;
  const isMathSection = currentSection === 'math';
  const sectionLabel = isMathSection ? 'Math' : 'R&W';

  useEffect(() => {
    const interval = setInterval(tickTimer, 1000);
    return () => clearInterval(interval);
  }, [tickTimer]);

  if (!mod) return null;

  const questions = mod.questions;
  const question = questions[currentQuestionIndex];
  const total = questions.length;
  const answered = questions.filter((q) => {
    const a = answers[q.id];
    return a !== null && a !== undefined && a !== '';
  }).length;

  const mins = Math.floor(timeLeft / 60);
  const secs = timeLeft % 60;
  const timeStr = `${mins}:${secs.toString().padStart(2, '0')}`;
  const isTimeLow = timeLeft < 300;
  const isTimeCritical = timeLeft < 60;

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Top Toolbar */}
      <header className="bg-[#0d47a1] text-white px-4 py-2.5 flex items-center justify-between sticky top-0 z-30 shadow-md">
        <div className="flex items-center gap-4">
          <div className="text-sm font-medium">
            <span className="font-semibold">{sectionLabel}</span>{' '}
            <span className="opacity-70">Module</span>{' '}
            <span className="font-bold">{currentModuleNumber}</span>{' '}
            <span className="opacity-70">of 2</span>
          </div>
        </div>

        <div className="flex items-center gap-3">
          <button
            onClick={toggleTimerVisibility}
            className="flex items-center gap-1.5 text-sm"
          >
            {timerHidden ? (
              <>
                <EyeOff className="w-4 h-4 opacity-60" />
                <span className="opacity-60">Show Time</span>
              </>
            ) : (
              <span
                className={`font-mono font-bold ${
                  isTimeCritical
                    ? 'text-red-300 animate-pulse'
                    : isTimeLow
                    ? 'text-yellow-300'
                    : ''
                }`}
              >
                <Clock className="w-4 h-4 inline mr-1" />
                {timeStr}
              </span>
            )}
            {isTimeLow && !timerHidden && (
              <AlertCircle className="w-4 h-4 text-yellow-300" />
            )}
          </button>
        </div>
      </header>

      {/* Question Area */}
      <main className="flex-1 p-6 max-w-4xl mx-auto w-full">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-sm font-medium text-gray-500">
            Question {currentQuestionIndex + 1} of {total}
          </h2>
          <div className="flex items-center gap-2">
            {question.type === 'spr' && (
              <span className="text-xs px-2 py-1 rounded bg-purple-100 text-purple-700 font-medium">
                Grid-In
              </span>
            )}
            <button
              onClick={() => toggleFlag(question.id)}
              className={`inline-flex items-center gap-1.5 px-3 py-1.5 text-sm border rounded-lg transition-colors ${
                flags[question.id]
                  ? 'border-yellow-400 bg-yellow-50 text-yellow-700'
                  : 'border-gray-300 text-gray-600 hover:bg-gray-50'
              }`}
            >
              <Flag
                className={`w-4 h-4 ${flags[question.id] ? 'fill-yellow-500 text-yellow-500' : ''}`}
              />
              {flags[question.id] ? 'Flagged' : 'Mark'}
            </button>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-6">
          {/* Passage for R&W questions */}
          {question.passage && (
            <div className="mb-5 pb-5 border-b border-gray-200">
              <p className="text-xs font-semibold uppercase text-gray-400 mb-2 tracking-wider">Passage</p>
              <div className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
                {renderMixedContent(question.passage)}
              </div>
            </div>
          )}
          <div className="mb-5">
            <div className="text-base text-gray-800 leading-relaxed">
              {renderMixedContent(question.prompt)}
            </div>
          </div>
          {satPromptImageUrls(question).map((url, i) => (
            <div key={`${url}-${i}`} className="mb-5">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={url}
                alt={`Question figure ${i + 1}`}
                className="max-w-full rounded-lg border border-gray-200"
              />
            </div>
          ))}
          <QuestionRenderer
            question={question}
            answer={answers[question.id] ?? null}
            onAnswer={(val) => setAnswer(question.id, val)}
          />
        </div>
      </main>

      {/* Bottom Navigation */}
      <footer className="sticky bottom-0 bg-white border-t border-gray-300 px-4 py-3 z-20">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <button
              onClick={() => navigateQuestion(Math.max(0, currentQuestionIndex - 1))}
              disabled={currentQuestionIndex === 0}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <ChevronLeft className="w-4 h-4" /> Back
            </button>
            <button
              onClick={() => navigateQuestion(Math.min(total - 1, currentQuestionIndex + 1))}
              disabled={currentQuestionIndex === total - 1}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Next <ChevronRight className="w-4 h-4" />
            </button>
          </div>

          {/* Question palette */}
          <div className="hidden sm:flex gap-1 flex-wrap max-w-md justify-center">
            {questions.map((q, idx) => {
              const a = answers[q.id];
              const isAns = a !== null && a !== undefined && a !== '';
              const isCurr = idx === currentQuestionIndex;
              const isFlagged = flags[q.id];

              return (
                <button
                  key={q.id}
                  onClick={() => navigateQuestion(idx)}
                  title={`Q${idx + 1}`}
                  className={`w-8 h-8 rounded text-xs font-semibold border transition-all ${
                    isCurr
                      ? 'border-blue-500 bg-blue-600 text-white scale-110'
                      : isAns
                      ? 'border-green-400 bg-green-100 text-green-700'
                      : isFlagged
                      ? 'border-yellow-400 bg-yellow-50 text-yellow-700'
                      : 'border-gray-300 bg-white text-gray-600 hover:border-gray-400'
                  }`}
                >
                  {idx + 1}
                </button>
              );
            })}
          </div>

          <div className="flex items-center gap-2">
            {isMathSection && (
              <button
                onClick={toggleCalculator}
                className={`inline-flex items-center gap-1.5 px-3 py-2 text-sm border rounded-lg transition-colors ${
                  isCalculatorOpen
                    ? 'border-blue-400 bg-blue-50 text-blue-700'
                    : 'border-gray-300 text-gray-600 hover:bg-gray-50'
                }`}
                title="Desmos Calculator"
              >
                <Calculator className="w-4 h-4" />
              </button>
            )}
            <button
              onClick={toggleReview}
              className="inline-flex items-center gap-1.5 px-3 py-2 text-sm border border-gray-300 rounded-lg text-gray-600 hover:bg-gray-50"
            >
              <Eye className="w-4 h-4" /> Review
            </button>
            <button
              onClick={() => setShowSubmitConfirm(true)}
              className="px-4 py-2 text-sm font-semibold text-white bg-[#0d47a1] rounded-lg hover:bg-[#1565c0] transition-colors"
            >
              Submit
            </button>
          </div>
        </div>
      </footer>

      {/* Desmos Calculator overlay — Math only */}
      {isMathSection && isCalculatorOpen && <DesmosCalculator onClose={toggleCalculator} />}

      {/* Review overlay */}
      {isReviewOpen && (
        <ReviewScreen
          questions={questions}
          answers={answers}
          flags={flags}
          currentIndex={currentQuestionIndex}
          onNavigate={navigateQuestion}
          onClose={toggleReview}
          onSubmit={() => {
            toggleReview();
            setShowSubmitConfirm(true);
          }}
        />
      )}

      {/* Submit confirmation */}
      {showSubmitConfirm && (
        <div className="fixed inset-0 z-50 bg-black/50 flex items-center justify-center p-4">
          <div className="bg-white rounded-xl shadow-2xl max-w-sm w-full p-6">
            <h3 className="text-lg font-bold text-gray-900 mb-2">
              Submit {sectionLabel} Module {currentModuleNumber}?
            </h3>
            <p className="text-sm text-gray-600 mb-2">
              You have answered <strong>{answered}</strong> of <strong>{total}</strong> questions.
            </p>
            {answered < total && (
              <p className="text-sm text-amber-600 mb-4">
                {total - answered} question(s) remain unanswered. There is no penalty for guessing — try to answer every question.
              </p>
            )}
            <div className="flex gap-3 justify-end mt-4">
              <button
                onClick={() => setShowSubmitConfirm(false)}
                className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
              >
                Go Back
              </button>
              <button
                onClick={() => {
                  setShowSubmitConfirm(false);
                  submitModule();
                }}
                className="px-5 py-2 text-sm font-semibold text-white bg-[#0d47a1] rounded-lg hover:bg-[#1565c0]"
              >
                Confirm Submit
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
