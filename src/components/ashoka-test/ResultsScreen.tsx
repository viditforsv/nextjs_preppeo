'use client';

import { useAshokaTestStore } from '@/stores/useAshokaTestStore';
import { Trophy, Brain, Lightbulb, PenTool, RotateCcw } from 'lucide-react';

export default function ResultsScreen() {
  const { result, questions, goToLanding } = useAshokaTestStore();

  if (!result) return null;

  const mcqMins = Math.floor(result.timeUsed / 60);
  const mcqSecs = result.timeUsed % 60;
  const essayMins = Math.floor(result.essayTimeUsed / 60);
  const essaySecs = result.essayTimeUsed % 60;
  const pct = Math.round((result.correct / result.total) * 100);

  return (
    <div className="min-h-screen bg-[#f5f5f0] p-4">
      <div className="max-w-3xl mx-auto py-8">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="w-20 h-20 bg-[#1a365d]/10 rounded-full flex items-center justify-center mx-auto mb-4">
            <Trophy className="w-10 h-10 text-[#1a365d]" />
          </div>
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">
            Test Complete
          </h1>
          <p className="text-gray-600">
            Ashoka Aptitude Test Results
          </p>
        </div>

        {/* Overall Score */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
          <h2 className="text-lg font-bold text-gray-900 mb-4">MCQ Score</h2>
          <div className="flex items-center justify-center gap-8">
            <div className="text-center">
              <p className="text-5xl font-bold text-[#1a365d]">
                {result.correct}
                <span className="text-2xl text-gray-400">/{result.total}</span>
              </p>
              <p className="text-sm text-gray-500 mt-1">{pct}% correct</p>
            </div>
            <div className="h-16 w-px bg-gray-200" />
            <div className="text-sm text-gray-600">
              <p>Time used: {mcqMins}m {mcqSecs}s</p>
            </div>
          </div>
        </div>

        {/* Section Breakdown */}
        <div className="grid sm:grid-cols-2 gap-4 mb-6">
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-5">
            <div className="flex items-center gap-2 mb-3">
              <Brain className="w-5 h-5 text-[#1a365d]" />
              <h3 className="font-semibold text-gray-900">Problem Solving</h3>
            </div>
            <p className="text-3xl font-bold text-[#1a365d]">
              {result.psSectionCorrect}
              <span className="text-lg text-gray-400">/{result.psSectionTotal}</span>
            </p>
            <p className="text-sm text-gray-500 mt-1">
              {result.psSectionTotal > 0
                ? Math.round((result.psSectionCorrect / result.psSectionTotal) * 100)
                : 0}% correct
            </p>
          </div>
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-5">
            <div className="flex items-center gap-2 mb-3">
              <Lightbulb className="w-5 h-5 text-[#1a365d]" />
              <h3 className="font-semibold text-gray-900">Critical Thinking</h3>
            </div>
            <p className="text-3xl font-bold text-[#1a365d]">
              {result.ctSectionCorrect}
              <span className="text-lg text-gray-400">/{result.ctSectionTotal}</span>
            </p>
            <p className="text-sm text-gray-500 mt-1">
              {result.ctSectionTotal > 0
                ? Math.round((result.ctSectionCorrect / result.ctSectionTotal) * 100)
                : 0}% correct
            </p>
          </div>
        </div>

        {/* Question Review */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
          <h2 className="text-lg font-bold text-gray-900 mb-4">Question Review</h2>
          <div className="space-y-3 max-h-[400px] overflow-y-auto">
            {questions.map((q, idx) => {
              const userAns = result.answers[q.id];
              const isCorrect = userAns === q.correctAnswer;
              const userOpt = q.options.find((o) => o.id === userAns);
              const correctOpt = q.options.find((o) => o.id === q.correctAnswer);

              return (
                <div
                  key={q.id}
                  className={`p-3 rounded-lg border ${
                    isCorrect ? 'border-green-200 bg-green-50' : 'border-red-200 bg-red-50'
                  }`}
                >
                  <div className="flex items-start gap-2">
                    <span
                      className={`text-xs font-bold px-1.5 py-0.5 rounded ${
                        isCorrect ? 'bg-green-200 text-green-800' : 'bg-red-200 text-red-800'
                      }`}
                    >
                      Q{idx + 1}
                    </span>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm text-gray-800 line-clamp-2">{q.prompt}</p>
                      <div className="mt-1 text-xs text-gray-600">
                        {!isCorrect && (
                          <span>
                            Your answer: <strong>{userOpt?.text ?? 'Unanswered'}</strong> ·{' '}
                          </span>
                        )}
                        <span>
                          Correct: <strong>{correctOpt?.text}</strong>
                        </span>
                      </div>
                      {q.explanation && (
                        <p className="mt-1 text-xs text-gray-500 italic">{q.explanation}</p>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Essay */}
        {result.essayText && (
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
            <div className="flex items-center gap-2 mb-3">
              <PenTool className="w-5 h-5 text-[#1a365d]" />
              <h2 className="text-lg font-bold text-gray-900">Your Essay</h2>
            </div>
            <p className="text-sm text-gray-500 mb-2">
              Time used: {essayMins}m {essaySecs}s ·{' '}
              {result.essayText.trim().split(/\s+/).length} words
            </p>
            <div className="bg-gray-50 rounded-lg p-4 mb-3">
              <p className="text-sm font-medium text-gray-600 mb-1">Prompt:</p>
              <p className="text-sm text-gray-800">{result.essayPrompt}</p>
            </div>
            <div className="bg-gray-50 rounded-lg p-4 text-sm text-gray-800 whitespace-pre-wrap leading-relaxed max-h-[300px] overflow-y-auto">
              {result.essayText}
            </div>
          </div>
        )}

        {/* Actions */}
        <div className="text-center">
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-2 px-6 py-3 bg-[#1a365d] text-white font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors"
          >
            <RotateCcw className="w-4 h-4" />
            Back to Home
          </button>
        </div>
      </div>
    </div>
  );
}
