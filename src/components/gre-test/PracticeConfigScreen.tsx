'use client';

import { useState } from 'react';
import { useGRETestStore } from '@/stores/useGRETestStore';
import { DifficultyTier } from '@/types/gre-test';
import { ArrowLeft, Sliders } from 'lucide-react';

const DIFFICULTY_OPTIONS: { value: DifficultyTier | 'mixed'; label: string; desc: string }[] = [
  { value: 'easy', label: 'Easy', desc: 'Basic arithmetic, simple algebra' },
  { value: 'medium', label: 'Medium', desc: 'Multi-step problems, moderate algebra' },
  { value: 'hard', label: 'Hard', desc: 'Advanced topics, complex reasoning' },
  { value: 'mixed', label: 'Mixed', desc: 'All difficulty levels shuffled' },
];

const COUNT_OPTIONS = [5, 10, 15, 20];

export default function PracticeConfigScreen() {
  const { goToLanding, startPracticeMode } = useGRETestStore();
  const [difficulty, setDifficulty] = useState<DifficultyTier | 'mixed'>('medium');
  const [count, setCount] = useState(10);

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-md w-full p-8">
        {/* Back */}
        <button
          onClick={goToLanding}
          className="inline-flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-6"
        >
          <ArrowLeft className="w-4 h-4" /> Back
        </button>

        <div className="flex items-center gap-2 mb-6">
          <Sliders className="w-5 h-5 text-emerald-600" />
          <h1 className="text-xl font-bold text-gray-900">Practice Settings</h1>
        </div>

        {/* Difficulty */}
        <div className="mb-6">
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Difficulty Level
          </label>
          <div className="grid grid-cols-2 gap-2">
            {DIFFICULTY_OPTIONS.map((opt) => (
              <button
                key={opt.value}
                onClick={() => setDifficulty(opt.value)}
                className={`p-3 rounded-lg border-2 text-left transition-all ${
                  difficulty === opt.value
                    ? 'border-emerald-500 bg-emerald-50'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <p
                  className={`text-sm font-semibold ${
                    difficulty === opt.value ? 'text-emerald-700' : 'text-gray-800'
                  }`}
                >
                  {opt.label}
                </p>
                <p className="text-xs text-gray-500 mt-0.5">{opt.desc}</p>
              </button>
            ))}
          </div>
        </div>

        {/* Count */}
        <div className="mb-8">
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Number of Questions
          </label>
          <div className="flex gap-2">
            {COUNT_OPTIONS.map((n) => (
              <button
                key={n}
                onClick={() => setCount(n)}
                className={`flex-1 py-2.5 rounded-lg border-2 text-sm font-semibold transition-all ${
                  count === n
                    ? 'border-emerald-500 bg-emerald-50 text-emerald-700'
                    : 'border-gray-200 text-gray-600 hover:border-gray-300'
                }`}
              >
                {n}
              </button>
            ))}
          </div>
        </div>

        <button
          onClick={() => startPracticeMode({ difficulty, questionCount: count })}
          className="w-full py-3 bg-emerald-600 text-white font-semibold rounded-lg hover:bg-emerald-700 transition-colors text-lg"
        >
          Start Practice
        </button>
      </div>
    </div>
  );
}
