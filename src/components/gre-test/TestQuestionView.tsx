'use client';

import { useEffect, useState } from 'react';
import { useGRETestStore } from '@/stores/useGRETestStore';
import QuestionRenderer from './question-types/QuestionRenderer';
import GRECalculator from './GRECalculator';
import ReviewScreen from './ReviewScreen';
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
    section1,
    section2,
    currentSectionNumber,
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
    submitSection,
    toggleCalculator,
    toggleReview,
    toggleTimerVisibility,
  } = useGRETestStore();

  const [showSubmitConfirm, setShowSubmitConfirm] = useState(false);

  const section = currentSectionNumber === 1 ? section1 : section2;

  // Timer tick
  useEffect(() => {
    const interval = setInterval(tickTimer, 1000);
    return () => clearInterval(interval);
  }, [tickTimer]);

  if (!section) return null;

  const questions = section.questions;
  const question = questions[currentQuestionIndex];
  const total = questions.length;
  const answered = questions.filter((q) => {
    const a = answers[q.id];
    return a !== null && a !== undefined && a !== '' && !(Array.isArray(a) && a.length === 0);
  }).length;

  const mins = Math.floor(timeLeft / 60);
  const secs = timeLeft % 60;
  const timeStr = `${mins}:${secs.toString().padStart(2, '0')}`;
  const isTimeLow = timeLeft < 300;
  const isTimeCritical = timeLeft < 60;

  const tierLabel =
    section.difficultyTier === 'easy'
      ? 'Easy'
      : section.difficultyTier === 'medium'
      ? 'Medium'
      : 'Hard';

  const handleSubmitClick = () => setShowSubmitConfirm(true);

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* ── Top Toolbar ── */}
      <header className="bg-[#1a365d] text-white px-4 py-2.5 flex items-center justify-between sticky top-0 z-30 shadow-md">
        <div className="flex items-center gap-4">
          <div className="text-sm font-medium">
            <span className="opacity-70">Section</span>{' '}
            <span className="font-bold">{currentSectionNumber}</span>{' '}
            <span className="opacity-70">of 2</span>
          </div>
          <div className="h-5 w-px bg-white/30" />
          <span className="text-xs px-2 py-0.5 rounded bg-white/15">{tierLabel}</span>
          <span className="text-xs opacity-70">
            Quantitative Reasoning
          </span>
        </div>

        <div className="flex items-center gap-3">
          {/* Timer */}
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

      {/* ── Question Area ── */}
      <main className="flex-1 p-6 max-w-4xl mx-auto w-full">
        {/* Question header */}
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-sm font-medium text-gray-500">
            Question {currentQuestionIndex + 1} of {total}
          </h2>
          <div className="flex items-center gap-2">
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

        {/* Question card */}
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-6">
          <div className="mb-5">
            <p className="text-base text-gray-800 leading-relaxed">{question.prompt}</p>
          </div>
          <QuestionRenderer
            question={question}
            answer={answers[question.id] ?? null}
            onAnswer={(val) => setAnswer(question.id, val)}
          />
        </div>
      </main>

      {/* ── Bottom Navigation Bar ── */}
      <footer className="sticky bottom-0 bg-white border-t border-gray-300 px-4 py-3 z-20">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          {/* Left: nav buttons */}
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

          {/* Center: question palette */}
          <div className="hidden sm:flex gap-1 flex-wrap max-w-md justify-center">
            {questions.map((q, idx) => {
              const a = answers[q.id];
              const isAns =
                a !== null && a !== undefined && a !== '' && !(Array.isArray(a) && a.length === 0);
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

          {/* Right: tools */}
          <div className="flex items-center gap-2">
            <button
              onClick={toggleCalculator}
              className={`inline-flex items-center gap-1.5 px-3 py-2 text-sm border rounded-lg transition-colors ${
                isCalculatorOpen
                  ? 'border-blue-400 bg-blue-50 text-blue-700'
                  : 'border-gray-300 text-gray-600 hover:bg-gray-50'
              }`}
            >
              <Calculator className="w-4 h-4" />
            </button>
            <button
              onClick={toggleReview}
              className="inline-flex items-center gap-1.5 px-3 py-2 text-sm border border-gray-300 rounded-lg text-gray-600 hover:bg-gray-50"
            >
              <Eye className="w-4 h-4" /> Review
            </button>
            <button
              onClick={handleSubmitClick}
              className="px-4 py-2 text-sm font-semibold text-white bg-[#1a365d] rounded-lg hover:bg-[#2a4a7f] transition-colors"
            >
              Submit
            </button>
          </div>
        </div>
      </footer>

      {/* Calculator overlay */}
      {isCalculatorOpen && <GRECalculator onClose={toggleCalculator} />}

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
              Submit Section {currentSectionNumber}?
            </h3>
            <p className="text-sm text-gray-600 mb-2">
              You have answered <strong>{answered}</strong> of <strong>{total}</strong> questions.
            </p>
            {answered < total && (
              <p className="text-sm text-amber-600 mb-4">
                {total - answered} question(s) remain unanswered. Unanswered questions will be
                marked incorrect.
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
                  submitSection();
                }}
                className="px-5 py-2 text-sm font-semibold text-white bg-[#1a365d] rounded-lg hover:bg-[#2a4a7f]"
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
