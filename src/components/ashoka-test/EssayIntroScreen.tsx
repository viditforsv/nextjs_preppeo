'use client';

import { useAshokaTestStore } from '@/stores/useAshokaTestStore';
import { CheckCircle, PenTool, ArrowRight } from 'lucide-react';

export default function EssayIntroScreen() {
  const { essayPrompts, selectedPromptIndex, selectPrompt, beginEssay } =
    useAshokaTestStore();

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-2xl w-full p-8">
        <div className="text-center mb-6">
          <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <CheckCircle className="w-8 h-8 text-green-600" />
          </div>
          <h1 className="text-2xl font-bold text-gray-900 mb-2">
            MCQs Complete
          </h1>
          <p className="text-gray-600">
            Now choose an essay prompt and write your response in 30 minutes.
          </p>
        </div>

        <div className="space-y-4 mb-8">
          <div className="flex items-center gap-2 mb-2">
            <PenTool className="w-5 h-5 text-[#1a365d]" />
            <h2 className="text-lg font-semibold text-gray-900">Choose a Prompt</h2>
          </div>

          {essayPrompts.map((prompt, idx) => (
            <button
              key={idx}
              onClick={() => selectPrompt(idx)}
              className={`w-full text-left p-4 rounded-lg border-2 transition-all ${
                selectedPromptIndex === idx
                  ? 'border-[#1a365d] bg-blue-50'
                  : 'border-gray-200 hover:border-gray-300'
              }`}
            >
              <span className="text-sm font-semibold text-gray-500 block mb-1">
                Prompt {idx + 1}
              </span>
              <p className="text-gray-800">{prompt}</p>
            </button>
          ))}
        </div>

        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 mb-6 text-sm text-amber-800">
          <ul className="list-disc ml-4 space-y-1">
            <li>You will have 30 minutes to write your essay</li>
            <li>Focus on clarity of argument and structured reasoning</li>
            <li>The essay will be saved but is not auto-graded</li>
          </ul>
        </div>

        <button
          onClick={beginEssay}
          disabled={selectedPromptIndex === null}
          className="w-full py-3 bg-[#1a365d] text-white font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors text-lg inline-flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Begin Essay
          <ArrowRight className="w-5 h-5" />
        </button>
      </div>
    </div>
  );
}
