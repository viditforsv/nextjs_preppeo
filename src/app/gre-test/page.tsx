"use client";

import { useEffect, useState } from 'react';
import { useTestStore } from '@/stores/useTestStore';
import { mockGRETest } from '@/lib/mock-gre-data';
import { Button } from '@/design-system/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/design-system/components/ui/card';
import { Clock, Calculator, Flag, Eye, ChevronLeft, ChevronRight, CheckCircle2 } from 'lucide-react';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/design-system/components/ui/dialog';

export default function GRETestPage() {
  const {
    test,
    currentSectionId,
    currentQuestionIndex,
    answers,
    flags,
    timeLeft,
    isCalculatorOpen,
    isReviewScreenOpen,
    initTest,
    setAnswer,
    toggleFlag,
    toggleCalculator,
    toggleReviewScreen,
    navigateQuestion,
    tickTimer,
    completeSection
  } = useTestStore();

  const [testStarted, setTestStarted] = useState(false);

  // Initialize test
  useEffect(() => {
    if (!test) {
      initTest(mockGRETest);
    }
  }, [test, initTest]);

  // Timer effect
  useEffect(() => {
    if (testStarted && timeLeft > 0) {
      const interval = setInterval(() => {
        tickTimer();
      }, 1000);
      return () => clearInterval(interval);
    }
  }, [testStarted, timeLeft, tickTimer]);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const handleStart = () => {
    setTestStarted(true);
    if (!test) {
      initTest(mockGRETest);
    }
  };

  const currentSection = test?.sections.find(s => s.id === currentSectionId);
  const currentQuestion = currentSection?.questions[currentQuestionIndex];
  const currentPassage = currentQuestion?.passageId 
    ? currentSection?.passages.find(p => p.id === currentQuestion.passageId)
    : null;

  if (!test || !currentSection || !currentQuestion) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <Card className="w-full max-w-md">
          <CardHeader>
            <CardTitle>GRE Test Simulator</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-gray-600 mb-4">Loading test...</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (!testStarted) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <Card className="w-full max-w-2xl">
          <CardHeader>
            <CardTitle className="text-2xl">{test.title}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <p className="text-gray-700"><strong>Instructions:</strong></p>
              <ul className="list-disc list-inside space-y-1 text-gray-600 ml-4">
                <li>This is a practice GRE Verbal Reasoning test</li>
                <li>You will start with a medium difficulty section</li>
                <li>Your performance will determine the next section (easy or hard)</li>
                <li>Answer all questions to the best of your ability</li>
                <li>You can flag questions for review</li>
              </ul>
            </div>
            <Button onClick={handleStart} className="w-full" size="lg">
              Start Test
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  const totalQuestions = currentSection.questions.length;
  const answeredCount = currentSection.questions.filter(q => answers[q.id] !== undefined).length;

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Toolbar */}
      <div className="bg-white border-b border-gray-300 px-4 py-3 flex items-center justify-between sticky top-0 z-10">
        <div className="flex items-center gap-4">
          <span className="font-semibold text-gray-800">{currentSection.title}</span>
          <div className="flex items-center gap-2 text-gray-700">
            <Clock className="w-4 h-4" />
            <span className="font-mono">{formatTime(timeLeft)}</span>
          </div>
          <span className="text-sm text-gray-600">
            Question {currentQuestionIndex + 1} of {totalQuestions}
          </span>
        </div>
        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            onClick={() => toggleFlag(currentQuestion.id)}
            className={flags[currentQuestion.id] ? 'bg-yellow-100' : ''}
          >
            <Flag className="w-4 h-4 mr-1" />
            {flags[currentQuestion.id] ? 'Unflag' : 'Flag'}
          </Button>
          <Button
            variant="outline"
            size="sm"
            onClick={toggleReviewScreen}
          >
            <Eye className="w-4 h-4 mr-1" />
            Review
          </Button>
          <Button
            variant="outline"
            size="sm"
            onClick={toggleCalculator}
          >
            <Calculator className="w-4 h-4 mr-1" />
            Calculator
          </Button>
          {answeredCount === totalQuestions && (
            <Button
              onClick={completeSection}
              size="sm"
              className="bg-green-600 hover:bg-green-700"
            >
              Complete Section
            </Button>
          )}
        </div>
      </div>

      {/* Main Content - Split View */}
      <div className="flex h-[calc(100vh-73px)]">
        {/* Left: Passage */}
        {currentPassage && (
          <div className="w-1/2 border-r border-gray-300 overflow-y-auto bg-white p-6">
            <div 
              className="prose max-w-none text-gray-800"
              dangerouslySetInnerHTML={{ __html: currentPassage.content }}
            />
          </div>
        )}

        {/* Right: Question */}
        <div className={`${currentPassage ? 'w-1/2' : 'w-full'} overflow-y-auto bg-gray-50 p-6`}>
          <Card className="mb-4">
            <CardHeader>
              <CardTitle className="text-lg">Question {currentQuestionIndex + 1}</CardTitle>
            </CardHeader>
            <CardContent>
              <div 
                className="mb-6 text-gray-800"
                dangerouslySetInnerHTML={{ __html: currentQuestion.prompt }}
              />

              {currentQuestion.type === 'single-choice' && currentQuestion.options && (
                <div className="space-y-3">
                  {currentQuestion.options.map((option) => (
                    <label
                      key={option.id}
                      className={`flex items-start p-4 border-2 rounded-lg cursor-pointer transition-colors ${
                        answers[currentQuestion.id] === option.id
                          ? 'border-blue-500 bg-blue-50'
                          : 'border-gray-300 hover:border-gray-400'
                      }`}
                    >
                      <input
                        type="radio"
                        name={`question-${currentQuestion.id}`}
                        value={option.id}
                        checked={answers[currentQuestion.id] === option.id}
                        onChange={() => setAnswer(currentQuestion.id, option.id)}
                        className="mt-1 mr-3"
                      />
                      <span className="flex-1 text-gray-800">{option.text}</span>
                    </label>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>

          {/* Navigation */}
          <div className="flex justify-between items-center mt-4">
            <Button
              variant="outline"
              onClick={() => navigateQuestion(Math.max(0, currentQuestionIndex - 1))}
              disabled={currentQuestionIndex === 0}
            >
              <ChevronLeft className="w-4 h-4 mr-1" />
              Previous
            </Button>
            <div className="flex gap-2">
              {currentSection.questions.map((q, idx) => (
                <button
                  key={q.id}
                  onClick={() => navigateQuestion(idx)}
                  className={`w-8 h-8 rounded border-2 flex items-center justify-center text-sm ${
                    idx === currentQuestionIndex
                      ? 'border-blue-500 bg-blue-100'
                      : answers[q.id] !== undefined
                      ? 'border-green-500 bg-green-100'
                      : flags[q.id]
                      ? 'border-yellow-500 bg-yellow-100'
                      : 'border-gray-300'
                  }`}
                >
                  {answers[q.id] !== undefined ? (
                    <CheckCircle2 className="w-4 h-4 text-green-600" />
                  ) : flags[q.id] ? (
                    <Flag className="w-3 h-3 text-yellow-600" />
                  ) : (
                    idx + 1
                  )}
                </button>
              ))}
            </div>
            <Button
              variant="outline"
              onClick={() => navigateQuestion(Math.min(totalQuestions - 1, currentQuestionIndex + 1))}
              disabled={currentQuestionIndex === totalQuestions - 1}
            >
              Next
              <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          </div>
        </div>
      </div>

      {/* Review Screen Modal */}
      <Dialog open={isReviewScreenOpen} onOpenChange={(open) => {
        if (!open) toggleReviewScreen();
      }}>
        <DialogContent className="max-w-4xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Review Questions - {currentSection.title}</DialogTitle>
          </DialogHeader>
          <div className="grid grid-cols-5 gap-3 mt-4">
            {currentSection.questions.map((q, idx) => (
              <button
                key={q.id}
                onClick={() => {
                  navigateQuestion(idx);
                  useTestStore.setState({ isReviewScreenOpen: false });
                }}
                className={`p-4 border-2 rounded-lg text-center ${
                  answers[q.id] !== undefined
                    ? 'border-green-500 bg-green-50'
                    : flags[q.id]
                    ? 'border-yellow-500 bg-yellow-50'
                    : 'border-gray-300 bg-gray-50'
                }`}
              >
                <div className="font-semibold">Q{idx + 1}</div>
                <div className="text-xs mt-1">
                  {answers[q.id] !== undefined ? 'Answered' : flags[q.id] ? 'Flagged' : 'Incomplete'}
                </div>
              </button>
            ))}
          </div>
        </DialogContent>
      </Dialog>

      {/* Calculator (Simple placeholder) */}
      {isCalculatorOpen && (
        <div className="fixed bottom-4 right-4 bg-white border-2 border-gray-300 rounded-lg shadow-lg p-4 w-64">
          <div className="flex justify-between items-center mb-2">
            <span className="font-semibold">Calculator</span>
            <Button variant="outline" size="sm" onClick={toggleCalculator}>×</Button>
          </div>
          <div className="bg-gray-100 p-2 rounded text-right font-mono mb-2">0</div>
          <div className="grid grid-cols-4 gap-2">
            {['7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '0', '.', '=', '+'].map((btn) => (
              <button
                key={btn}
                className="p-2 bg-gray-200 hover:bg-gray-300 rounded"
              >
                {btn}
              </button>
            ))}
          </div>
          <p className="text-xs text-gray-500 mt-2">Basic calculator (UI only)</p>
        </div>
      )}
    </div>
  );
}

