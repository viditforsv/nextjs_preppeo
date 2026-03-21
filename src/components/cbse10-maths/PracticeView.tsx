'use client';

import type { CSSProperties } from 'react';
import { useCBSE10MathsStore } from '@/stores/useCBSE10MathsStore';
import { renderMixedContent } from '@/components/MathRenderer';
import DesmosCalculator from '@/components/sat-test/DesmosCalculator';
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
  Lightbulb,
} from 'lucide-react';

const DOMAIN_LABELS: Record<string, string> = {
  'real-numbers': 'Real Numbers',
  'polynomials': 'Polynomials',
  'linear-equations': 'Linear Equations',
  'quadratic-equations': 'Quadratic Equations',
  'arithmetic-progressions': 'Arithmetic Progressions',
  'triangles': 'Triangles',
  'coordinate-geometry': 'Coordinate Geometry',
  'trigonometry': 'Trigonometry',
  'applications-of-trig': 'Applications of Trig',
  'circles': 'Circles',
  'areas-related-to-circles': 'Areas Related to Circles',
  'surface-areas-volumes': 'Surface Areas & Volumes',
  'statistics': 'Statistics',
  'probability': 'Probability',
};

export default function PracticeView() {
  const {
    practiceQuestions,
    practiceAnswers,
    practiceRevealed,
    practiceExplanations,
    practiceLoading,
    practiceTheory,
    practiceTheoryLoading,
    practiceIndex,
    isCalculatorOpen,
    setPracticeAnswer,
    revealAnswer,
    fetchTheory,
    navigatePractice,
    finishPractice,
    goToLanding,
    toggleCalculator,
  } = useCBSE10MathsStore();

  const total = practiceQuestions.length;
  if (total === 0) return null;

  const question = practiceQuestions[practiceIndex];
  const answer = practiceAnswers[question.id] ?? null;
  const isRevealed = !!practiceRevealed[question.id];
  const isLoading = !!practiceLoading[question.id];
  const aiExplanation = practiceExplanations[question.id];
  const isCorrect = answer !== null && answer.trim().toLowerCase() === question.correctAnswer.trim().toLowerCase();
  const theory = practiceTheory[question.id];
  const isTheoryLoading = !!practiceTheoryLoading[question.id];
  const reviewed = Object.keys(practiceRevealed).length;

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      <header className="text-white px-4 py-2.5 flex items-center justify-between sticky top-0 z-30 shadow-md" style={{ backgroundColor: '#8a8c00' }}>
        <div className="flex items-center gap-3">
          <BookOpen className="w-4 h-4" />
          <span className="text-sm font-semibold">CBSE 10 Maths</span>
          <span className="text-xs opacity-70">{reviewed}/{total} reviewed</span>
        </div>
        <button onClick={goToLanding} className="inline-flex items-center gap-1.5 text-sm opacity-80 hover:opacity-100 transition-opacity">
          <LogOut className="w-4 h-4" /> Exit
        </button>
      </header>

      <main className="flex-1 p-6 max-w-4xl mx-auto w-full">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-sm font-medium text-gray-500">Question {practiceIndex + 1} of {total}</h2>
          <div className="flex items-center gap-1.5 flex-wrap">
            {question.domain && (
              <span className="text-xs px-2 py-1 rounded bg-gray-100 text-gray-500 font-medium">
                {DOMAIN_LABELS[question.domain] ?? question.domain}
              </span>
            )}
            {question.subtopic && (
              <span className="text-xs px-2 py-1 rounded bg-violet-50 text-violet-600 font-medium">
                {question.subtopic}
              </span>
            )}
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-4">
          <div className="mb-5">
            <div className="text-base text-gray-800 leading-relaxed">{renderMixedContent(question.prompt)}</div>
          </div>

          {question.imageUrl && (
            <div className="mb-5">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={question.imageUrl} alt="Question figure" className="max-w-full rounded-lg border border-gray-200" />
            </div>
          )}

          {question.options && (
            <div className="space-y-2">
              {question.options.map((opt) => {
                const isSelected = answer === opt.id;
                const isCorrectOpt = opt.id === question.correctAnswer;

                let borderClass = 'border-gray-200 hover:border-gray-300';
                let bgClass = '';
                let optionStyle: CSSProperties | undefined;

                if (isRevealed) {
                  if (isCorrectOpt) { borderClass = 'border-green-400'; bgClass = 'bg-green-50'; }
                  else if (isSelected && !isCorrectOpt) { borderClass = 'border-red-400'; bgClass = 'bg-red-50'; }
                  else { borderClass = 'border-gray-200 opacity-60'; }
                } else if (isSelected) {
                  borderClass = 'border-gray-200';
                  optionStyle = { borderColor: '#d4d700', backgroundColor: '#f5f7c4' };
                }

                return (
                  <button key={opt.id} onClick={() => !isRevealed && setPracticeAnswer(question.id, opt.id)} disabled={isRevealed}
                    className={`w-full text-left flex items-start gap-3 p-3 rounded-lg border-2 transition-all ${borderClass} ${bgClass}`}
                    style={optionStyle}
                  >
                    <span className={`w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs font-bold shrink-0 mt-0.5 ${
                      isRevealed && isCorrectOpt ? 'border-green-500 bg-green-500 text-white'
                        : isRevealed && isSelected && !isCorrectOpt ? 'border-red-500 bg-red-500 text-white'
                        : isSelected ? 'text-gray-900'
                        : 'border-gray-300 text-gray-500'
                    }`}
                      style={isSelected && !isRevealed ? { borderColor: '#d4d700', backgroundColor: '#d4d700' } : undefined}
                    >
                      {isRevealed && isCorrectOpt ? <CheckCircle className="w-4 h-4" />
                        : isRevealed && isSelected && !isCorrectOpt ? <XCircle className="w-4 h-4" />
                        : opt.id}
                    </span>
                    <span className="text-sm text-gray-800 leading-relaxed pt-0.5">{renderMixedContent(opt.text)}</span>
                  </button>
                );
              })}
            </div>
          )}

          {question.type === 'spr' && (
            <div className="mt-4">
              <input type="text" value={answer ?? ''} onChange={(e) => !isRevealed && setPracticeAnswer(question.id, e.target.value)} disabled={isRevealed}
                placeholder="Type your answer..."
                className={`w-full px-4 py-3 border-2 rounded-lg text-base ${
                  isRevealed ? (isCorrect ? 'border-green-400 bg-green-50' : 'border-red-400 bg-red-50')
                    : 'border-gray-300 focus:border-[#d4d700] focus:ring-1 focus:ring-[#d4d700]'
                } outline-none transition-colors`}
              />
              {isRevealed && !isCorrect && (
                <p className="text-sm text-green-700 mt-2">Correct answer: <strong>{question.correctAnswer}</strong></p>
              )}
            </div>
          )}

          {!isRevealed && (
            <button onClick={() => revealAnswer(question.id)} disabled={answer === null || answer === ''}
              className="mt-5 w-full py-2.5 text-gray-900 font-semibold rounded-lg hover:brightness-95 disabled:opacity-40 disabled:cursor-not-allowed transition-all inline-flex items-center justify-center gap-2"
              style={{ backgroundColor: '#d4d700' }}
            >
              <CheckCircle className="w-4 h-4" /> Check Answer
            </button>
          )}

          {isRevealed && (
            <div className={`mt-4 flex items-center gap-2 px-4 py-2 rounded-lg ${isCorrect ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'}`}>
              {isCorrect ? <CheckCircle className="w-5 h-5" /> : <XCircle className="w-5 h-5" />}
              <span className="font-semibold text-sm">{isCorrect ? 'Correct!' : 'Incorrect'}</span>
            </div>
          )}
        </div>

        {isRevealed && (
          <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 mb-4">
            <div className="flex items-center gap-2 mb-3">
              <Sparkles className="w-4 h-4 text-amber-500" />
              <h3 className="text-sm font-semibold text-gray-700">AI Explanation</h3>
            </div>
            {isLoading ? (
              <div className="flex items-center gap-2 text-sm text-gray-500 py-4">
                <Loader2 className="w-4 h-4 animate-spin" /> Generating explanation...
              </div>
            ) : (
              <div className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
                {renderMixedContent(aiExplanation ?? question.explanation ?? '')}
              </div>
            )}
          </div>
        )}

        {isRevealed && !theory && !isTheoryLoading && (
          <button onClick={() => fetchTheory(question.id)}
            className="w-full mb-4 py-2.5 border-2 font-semibold rounded-xl hover:brightness-[0.98] transition-all inline-flex items-center justify-center gap-2 text-sm"
            style={{ borderColor: '#d4d700', backgroundColor: '#f5f7c4', color: '#8a8c00' }}
          >
            <Lightbulb className="w-4 h-4" /> Deep Dive: Theory
          </button>
        )}

        {isRevealed && isTheoryLoading && (
          <div className="rounded-xl border p-6 mb-4" style={{ backgroundColor: '#f5f7c4', borderColor: '#d4d700' }}>
            <div className="flex items-center gap-2 text-sm py-2" style={{ color: '#8a8c00' }}>
              <Loader2 className="w-4 h-4 animate-spin" /> Loading theory...
            </div>
          </div>
        )}

        {isRevealed && theory && (
          <div className="rounded-xl border shadow-sm p-6 mb-4" style={{ backgroundColor: '#f5f7c4', borderColor: '#d4d700' }}>
            <div className="flex items-center gap-2 mb-3">
              <Lightbulb className="w-4 h-4" style={{ color: '#8a8c00' }} />
              <h3 className="text-sm font-semibold" style={{ color: '#8a8c00' }}>Deep Dive: Theory</h3>
            </div>
            <div className="text-sm leading-relaxed whitespace-pre-line" style={{ color: '#8a8c00' }}>{theory}</div>
          </div>
        )}
      </main>

      <footer className="sticky bottom-0 bg-white border-t border-gray-300 px-4 py-3 z-20">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <button onClick={() => navigatePractice(Math.max(0, practiceIndex - 1))} disabled={practiceIndex === 0}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <ChevronLeft className="w-4 h-4" /> Back
            </button>
            <button onClick={() => navigatePractice(Math.min(total - 1, practiceIndex + 1))} disabled={practiceIndex === total - 1}
              className="inline-flex items-center gap-1 px-3 py-2 text-sm font-medium border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Next <ChevronRight className="w-4 h-4" />
            </button>
          </div>

          <div className="hidden sm:flex gap-1 flex-wrap max-w-md justify-center">
            {practiceQuestions.map((q, idx) => {
              const revealed = !!practiceRevealed[q.id];
              const ans = practiceAnswers[q.id];
              const correct = revealed && ans !== null && ans !== undefined && ans.trim().toLowerCase() === q.correctAnswer.trim().toLowerCase();
              const isCurr = idx === practiceIndex;
              return (
                <button key={q.id} onClick={() => navigatePractice(idx)}
                  className={`w-8 h-8 rounded text-xs font-semibold border transition-all ${
                    isCurr ? 'text-gray-900 scale-110'
                      : revealed ? (correct ? 'border-green-400 bg-green-100 text-green-700' : 'border-red-400 bg-red-100 text-red-700')
                      : ans ? 'border-gray-400 bg-gray-100 text-gray-600'
                      : 'border-gray-300 bg-white text-gray-500 hover:border-gray-400'
                  }`}
                  style={isCurr ? { borderColor: '#d4d700', backgroundColor: '#d4d700' } : undefined}
                >
                  {idx + 1}
                </button>
              );
            })}
          </div>

          <div className="flex items-center gap-2">
            <button onClick={toggleCalculator}
              className={`inline-flex items-center gap-1.5 px-3 py-2 text-sm border rounded-lg transition-colors ${
                isCalculatorOpen ? 'text-gray-900' : 'border-gray-300 text-gray-600 hover:bg-gray-50'
              }`}
              style={isCalculatorOpen ? { borderColor: '#d4d700', backgroundColor: '#f5f7c4' } : undefined}
              title="Desmos Calculator"
            >
              <Calculator className="w-4 h-4" />
            </button>
            <button onClick={finishPractice}
              className="px-4 py-2 text-sm font-semibold text-gray-900 rounded-lg hover:brightness-95 transition-all"
              style={{ backgroundColor: '#d4d700' }}
            >
              Finish
            </button>
          </div>
        </div>
      </footer>

      {isCalculatorOpen && <DesmosCalculator onClose={toggleCalculator} />}
    </div>
  );
}
