'use client';

import { useState, useEffect } from 'react';
import { Heart, Zap, Trophy, Lock, Check, X, Lightbulb, Sparkles, Target, Flame, Crown, RotateCcw } from 'lucide-react';

const QUESTIONS = {
  algebra: {
    name: "Algebra Arena",
    emoji: "🧮",
    vibe: "Where x's and y's live rent-free",
    color: "from-blue-500 to-cyan-500",
    questions: [
      {
        q: "If 3x + 7 = 22, what is the value of x?",
        options: ["3", "5", "7", "15"],
        correct: 1,
        explain: "Subtract 7: 3x = 15. Divide by 3: x = 5. Ez 🎯"
      },
      {
        q: "Solve: 2(x - 3) = 4x + 6",
        options: ["x = -6", "x = 6", "x = -3", "x = 3"],
        correct: 0,
        explain: "Expand: 2x - 6 = 4x + 6. Move terms: -12 = 2x, so x = -6. Negatives matter bestie 💅"
      },
      {
        q: "What is the solution to x² - 5x + 6 = 0?",
        options: ["x = 1, 6", "x = 2, 3", "x = -2, -3", "x = 5, 6"],
        correct: 1,
        explain: "Factor: (x-2)(x-3) = 0. Roots: 2 and 3. Quadratics got humbled 📉"
      },
      {
        q: "If 2x + 3y = 12 and x = 3, find y.",
        options: ["y = 1", "y = 2", "y = 3", "y = 6"],
        correct: 1,
        explain: "Substitute x=3: 6 + 3y = 12, so 3y = 6, y = 2. System solved 🔓"
      },
      {
        q: "The line y = mx + 4 passes through (2, 10). What is m?",
        options: ["2", "3", "4", "5"],
        correct: 1,
        explain: "Plug in: 10 = 2m + 4, so 2m = 6, m = 3. Slope unlocked 📐"
      }
    ]
  },
  advanced: {
    name: "Advanced Math Dungeon",
    emoji: "🔮",
    vibe: "Functions that bite back",
    color: "from-purple-500 to-pink-500",
    questions: [
      {
        q: "If f(x) = x² + 2x, what is f(3)?",
        options: ["9", "11", "15", "21"],
        correct: 2,
        explain: "f(3) = 9 + 6 = 15. Functions are just picky calculators 🤖"
      },
      {
        q: "Simplify: (x³)(x⁴)",
        options: ["x⁷", "x¹²", "x¹", "2x⁷"],
        correct: 0,
        explain: "Same base, add exponents: x^(3+4) = x⁷. Exponent rules on god 📏"
      },
      {
        q: "If 2^x = 32, what is x?",
        options: ["4", "5", "6", "16"],
        correct: 1,
        explain: "2⁵ = 32, so x = 5. Powers of 2 should be memorized fr 🧠"
      },
      {
        q: "What are the roots of x² - 4 = 0?",
        options: ["x = 2 only", "x = -2 only", "x = ±2", "No real roots"],
        correct: 2,
        explain: "Difference of squares: (x-2)(x+2) = 0. Both ±2 work 🪞"
      },
      {
        q: "If g(x) = √(x+5), what is g(11)?",
        options: ["4", "5", "6", "16"],
        correct: 0,
        explain: "g(11) = √16 = 4. Radicals stay humble 🌱"
      }
    ]
  },
  data: {
    name: "Data Dojo",
    emoji: "📊",
    vibe: "Stats that actually stat",
    color: "from-green-500 to-emerald-500",
    questions: [
      {
        q: "The mean of 4, 8, 12, and x is 10. What is x?",
        options: ["10", "12", "14", "16"],
        correct: 3,
        explain: "Sum must be 40. 4+8+12 = 24, so x = 16. Mean the math, not the vibe 🧮"
      },
      {
        q: "A shirt costs $40 after a 20% discount. What was the original price?",
        options: ["$48", "$50", "$60", "$80"],
        correct: 1,
        explain: "$40 = 0.8 × original. Original = $50. Discount math is life 🛍️"
      },
      {
        q: "If the ratio of cats to dogs is 3:5 and there are 15 cats, how many dogs?",
        options: ["9", "20", "25", "45"],
        correct: 2,
        explain: "3:5 = 15:x. Cross multiply: x = 25. Ratios > vibes 🐕"
      },
      {
        q: "What is 15% of 80?",
        options: ["8", "12", "15", "20"],
        correct: 1,
        explain: "0.15 × 80 = 12. Percentages are just fractions in disguise 🎭"
      },
      {
        q: "Data set: 2, 5, 5, 7, 11. What is the median?",
        options: ["5", "6", "7", "11"],
        correct: 0,
        explain: "Middle value when ordered = 5. Median said I'm the moment 👑"
      }
    ]
  },
  geometry: {
    name: "Geometry Gauntlet",
    emoji: "📐",
    vibe: "Shapes with attitude",
    color: "from-orange-500 to-red-500",
    questions: [
      {
        q: "A rectangle has length 8 and width 5. What is its area?",
        options: ["13", "26", "40", "80"],
        correct: 2,
        explain: "Area = L × W = 8 × 5 = 40. Rectangles stay winning 🟩"
      },
      {
        q: "A circle has radius 6. What is its circumference? (Use π ≈ 3.14)",
        options: ["18.84", "37.68", "56.52", "113.04"],
        correct: 1,
        explain: "C = 2πr = 2(3.14)(6) = 37.68. Circles come full circle 🔵"
      },
      {
        q: "A right triangle has legs 6 and 8. What is the hypotenuse?",
        options: ["10", "12", "14", "48"],
        correct: 0,
        explain: "6-8-10 triangle! (3-4-5 × 2). Pythagoras ate 🔺"
      },
      {
        q: "What is the sum of interior angles of a triangle?",
        options: ["90°", "180°", "270°", "360°"],
        correct: 1,
        explain: "Always 180°. Triangles are consistent kings 👑"
      },
      {
        q: "A cube has side length 4. What is its volume?",
        options: ["12", "16", "48", "64"],
        correct: 3,
        explain: "V = s³ = 4³ = 64. Cubes cubed, literally 🧊"
      }
    ]
  },
  trig: {
    name: "Trig Temple",
    emoji: "🗿",
    vibe: "SOH CAH TOA propaganda",
    color: "from-yellow-500 to-orange-500",
    questions: [
      {
        q: "In a right triangle, sin(θ) = 3/5. What is cos(θ)?",
        options: ["3/5", "4/5", "5/3", "5/4"],
        correct: 1,
        explain: "3-4-5 triangle. cos = adj/hyp = 4/5. Pythagorean pair 💕"
      },
      {
        q: "What is tan(45°)?",
        options: ["0", "1/2", "1", "√2"],
        correct: 2,
        explain: "sin(45) = cos(45), so tan = 1. Memorize the unit circle bestie 📝"
      },
      {
        q: "If sin(θ) = 1/2 in a right triangle, what is θ?",
        options: ["30°", "45°", "60°", "90°"],
        correct: 0,
        explain: "sin(30°) = 1/2. Special angles unlock real XP 🔓"
      },
      {
        q: "In triangle ABC, angle C = 90°, AB = 10, BC = 6. What is sin(A)?",
        options: ["3/5", "4/5", "3/4", "6/10"],
        correct: 0,
        explain: "sin(A) = opposite/hyp = BC/AB = 6/10 = 3/5. SOH activated 🎯"
      },
      {
        q: "What is cos(60°)?",
        options: ["1/2", "√3/2", "1", "√2/2"],
        correct: 0,
        explain: "cos(60°) = 1/2. The unit circle never lies 🌀"
      }
    ]
  },
  boss: {
    name: "Final Boss: SAT Itself",
    emoji: "👹",
    vibe: "The final form. No mercy.",
    color: "from-red-600 to-purple-700",
    questions: [
      {
        q: "If 2x + 3y = 18 and x - y = 1, what is x?",
        options: ["3", "4", "4.2", "5"],
        correct: 2,
        explain: "From x = y+1, sub in: 2(y+1) + 3y = 18 → 5y = 16, y = 3.2, x = 4.2. Systems slapped 🔥"
      },
      {
        q: "A function f(x) = 2x² - 8. What is f(x) = 0's solution?",
        options: ["x = ±2", "x = ±4", "x = 2 only", "x = 4 only"],
        correct: 0,
        explain: "2x² = 8, x² = 4, x = ±2. Don't forget the negative root 🚨"
      },
      {
        q: "A store marks up a $60 item by 25%, then discounts 20%. Final price?",
        options: ["$57", "$60", "$63", "$75"],
        correct: 1,
        explain: "$60 × 1.25 = $75. Then $75 × 0.8 = $60. Math is chaotic 🌪️"
      },
      {
        q: "Circle with equation (x-2)² + (y+3)² = 25. What is the radius?",
        options: ["3", "5", "10", "25"],
        correct: 1,
        explain: "Standard form: r² = 25, so r = 5. Centers don't matter here 📍"
      },
      {
        q: "If log₂(x) = 3, what is x?",
        options: ["6", "8", "9", "16"],
        correct: 1,
        explain: "2³ = 8, so x = 8. Logs are exponents in a trench coat 🕵️"
      }
    ]
  }
};

const FLOORS = ['algebra', 'advanced', 'data', 'geometry', 'trig', 'boss'];

const REACTIONS = {
  correct: ["Let him cook 🔥", "She's cooking 👩‍🍳", "Sigma move 🗿", "W rizz 💯", "No thoughts, only math ✨", "GOATED 🐐", "Math wizard energy 🧙"],
  wrong: ["Bruh 💀", "Skill issue 😬", "Tragic 🥲", "NPC behavior 🤖", "Not the vibe 📉", "L + ratio 👎", "Math said no 🚫"],
  levelUp: ["FLOOR CLEARED! 🎉", "You're him fr 👑", "Main character energy ⭐", "Certified math head 🎓"],
  gameOver: ["The SAT ate you 💀", "Skill issue detected 📉", "Try again warrior ⚔️", "Math won this round 🥀"]
};

export default function SATMathQuest() {
  const [screen, setScreen] = useState('menu');
  const [currentFloor, setCurrentFloor] = useState(0);
  const [questionIndex, setQuestionIndex] = useState(0);
  const [hearts, setHearts] = useState(3);
  const [xp, setXp] = useState(0);
  const [combo, setCombo] = useState(0);
  const [maxCombo, setMaxCombo] = useState(0);
  const [unlockedFloors, setUnlockedFloors] = useState([0]);
  const [selectedAnswer, setSelectedAnswer] = useState(null);
  const [showResult, setShowResult] = useState(false);
  const [reaction, setReaction] = useState('');
  const [showExplain, setShowExplain] = useState(false);
  const [completed, setCompleted] = useState([]);
  const [hintsLeft, setHintsLeft] = useState(3);
  const [hintUsed, setHintUsed] = useState(false);

  const floorKey = FLOORS[currentFloor];
  const floor = QUESTIONS[floorKey];
  const currentQ = floor?.questions[questionIndex];

  const getRandom = (arr) => arr[Math.floor(Math.random() * arr.length)];

  const handleAnswer = (idx) => {
    if (showResult) return;
    setSelectedAnswer(idx);
    setShowResult(true);

    if (idx === currentQ.correct) {
      const bonus = combo >= 2 ? 15 : 10;
      const hintPenalty = hintUsed ? 5 : 0;
      setXp(xp + bonus - hintPenalty);
      setCombo(combo + 1);
      setMaxCombo(Math.max(maxCombo, combo + 1));
      setReaction(getRandom(REACTIONS.correct));
    } else {
      setHearts(hearts - 1);
      setCombo(0);
      setReaction(getRandom(REACTIONS.wrong));
      if (hearts - 1 <= 0) {
        setTimeout(() => setScreen('gameover'), 1500);
        return;
      }
    }

    setTimeout(() => setShowExplain(true), 600);
  };

  const nextQuestion = () => {
    setSelectedAnswer(null);
    setShowResult(false);
    setShowExplain(false);
    setHintUsed(false);

    if (questionIndex < floor.questions.length - 1) {
      setQuestionIndex(questionIndex + 1);
    } else {
      const newCompleted = [...completed, currentFloor];
      setCompleted(newCompleted);
      
      if (currentFloor < FLOORS.length - 1) {
        const newUnlocked = [...unlockedFloors, currentFloor + 1];
        setUnlockedFloors(newUnlocked);
        setScreen('floorComplete');
      } else {
        setScreen('victory');
      }
    }
  };

  const startFloor = (floorIdx) => {
    setCurrentFloor(floorIdx);
    setQuestionIndex(0);
    setSelectedAnswer(null);
    setShowResult(false);
    setShowExplain(false);
    setCombo(0);
    setHintUsed(false);
    setScreen('playing');
  };

  const continueAdventure = () => {
    setScreen('menu');
  };

  const useHint = () => {
    if (hintsLeft > 0 && !showResult) {
      setHintsLeft(hintsLeft - 1);
      setHintUsed(true);
    }
  };

  const resetGame = () => {
    setScreen('menu');
    setCurrentFloor(0);
    setQuestionIndex(0);
    setHearts(3);
    setXp(0);
    setCombo(0);
    setMaxCombo(0);
    setUnlockedFloors([0]);
    setCompleted([]);
    setHintsLeft(3);
    setSelectedAnswer(null);
    setShowResult(false);
    setShowExplain(false);
    setHintUsed(false);
  };

  // MENU SCREEN
  if (screen === 'menu') {
    return (
      <div className="min-h-screen bg-slate-950 text-white p-6 font-sans">
        <div className="max-w-3xl mx-auto">
          <div className="text-center mb-8 pt-4">
            <div className="inline-block mb-3">
              <Sparkles className="w-10 h-10 text-yellow-400 mx-auto animate-pulse" />
            </div>
            <h1 className="text-5xl font-black mb-2 bg-gradient-to-r from-cyan-400 via-purple-500 to-pink-500 bg-clip-text text-transparent">
              SAT MATH QUEST
            </h1>
            <p className="text-slate-400 text-sm">Climb the Digital SAT Tower. Defeat each floor. Become the math GOAT. 🐐</p>
          </div>

          <div className="grid grid-cols-3 gap-3 mb-6">
            <div className="bg-slate-900 border border-slate-800 rounded-xl p-3 text-center">
              <div className="flex items-center justify-center gap-1 mb-1">
                {[...Array(3)].map((_, i) => (
                  <Heart key={i} className={`w-4 h-4 ${i < hearts ? 'fill-red-500 text-red-500' : 'text-slate-700'}`} />
                ))}
              </div>
              <div className="text-xs text-slate-500">Lives</div>
            </div>
            <div className="bg-slate-900 border border-slate-800 rounded-xl p-3 text-center">
              <div className="flex items-center justify-center gap-1 mb-1">
                <Zap className="w-4 h-4 text-yellow-400" />
                <span className="font-bold text-yellow-400">{xp}</span>
              </div>
              <div className="text-xs text-slate-500">XP</div>
            </div>
            <div className="bg-slate-900 border border-slate-800 rounded-xl p-3 text-center">
              <div className="flex items-center justify-center gap-1 mb-1">
                <Lightbulb className="w-4 h-4 text-blue-400" />
                <span className="font-bold text-blue-400">{hintsLeft}</span>
              </div>
              <div className="text-xs text-slate-500">Hints</div>
            </div>
          </div>

          <div className="space-y-3">
            {FLOORS.map((key, idx) => {
              const f = QUESTIONS[key];
              const isLocked = !unlockedFloors.includes(idx);
              const isComplete = completed.includes(idx);
              const isBoss = idx === FLOORS.length - 1;

              return (
                <button
                  key={key}
                  onClick={() => !isLocked && startFloor(idx)}
                  disabled={isLocked}
                  className={`w-full text-left bg-gradient-to-r ${isLocked ? 'from-slate-900 to-slate-900' : f.color} rounded-2xl p-5 transition-all ${
                    isLocked ? 'opacity-40 cursor-not-allowed' : 'hover:scale-[1.02] active:scale-[0.98] cursor-pointer'
                  } ${isBoss && !isLocked ? 'ring-2 ring-red-500 ring-offset-2 ring-offset-slate-950' : ''}`}
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-4">
                      <div className="text-4xl">{isLocked ? '🔒' : f.emoji}</div>
                      <div>
                        <div className="flex items-center gap-2">
                          <h3 className="font-bold text-lg">
                            Floor {idx + 1}: {f.name}
                          </h3>
                          {isBoss && !isLocked && <Crown className="w-5 h-5 text-yellow-300" />}
                        </div>
                        <p className="text-sm opacity-90">{f.vibe}</p>
                      </div>
                    </div>
                    {isComplete && (
                      <div className="bg-white/20 rounded-full p-2">
                        <Check className="w-5 h-5" />
                      </div>
                    )}
                    {isLocked && <Lock className="w-5 h-5 text-slate-600" />}
                  </div>
                </button>
              );
            })}
          </div>

          {completed.length > 0 && (
            <button
              onClick={resetGame}
              className="mt-6 w-full bg-slate-900 border border-slate-800 hover:border-slate-700 rounded-xl py-3 text-sm text-slate-400 flex items-center justify-center gap-2"
            >
              <RotateCcw className="w-4 h-4" /> Reset Progress
            </button>
          )}
        </div>
      </div>
    );
  }

  // PLAYING SCREEN
  if (screen === 'playing') {
    return (
      <div className="min-h-screen bg-slate-950 text-white p-4 font-sans">
        <div className="max-w-2xl mx-auto">
          {/* HUD */}
          <div className="flex items-center justify-between mb-4 bg-slate-900 border border-slate-800 rounded-xl p-3">
            <div className="flex gap-1">
              {[...Array(3)].map((_, i) => (
                <Heart key={i} className={`w-5 h-5 transition-all ${i < hearts ? 'fill-red-500 text-red-500' : 'text-slate-700'}`} />
              ))}
            </div>
            <div className="flex items-center gap-4">
              {combo >= 2 && (
                <div className="flex items-center gap-1 bg-orange-500/20 px-2 py-1 rounded-lg">
                  <Flame className="w-4 h-4 text-orange-400" />
                  <span className="text-xs font-bold text-orange-400">{combo}x COMBO</span>
                </div>
              )}
              <div className="flex items-center gap-1">
                <Zap className="w-4 h-4 text-yellow-400" />
                <span className="font-bold text-yellow-400">{xp}</span>
              </div>
            </div>
          </div>

          {/* Floor header */}
          <div className={`bg-gradient-to-r ${floor.color} rounded-2xl p-4 mb-4`}>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <span className="text-3xl">{floor.emoji}</span>
                <div>
                  <h2 className="font-bold text-lg">{floor.name}</h2>
                  <p className="text-sm opacity-90">Question {questionIndex + 1} of {floor.questions.length}</p>
                </div>
              </div>
            </div>
            <div className="mt-3 bg-white/20 rounded-full h-2 overflow-hidden">
              <div
                className="bg-white h-full transition-all duration-500"
                style={{ width: `${((questionIndex) / floor.questions.length) * 100}%` }}
              />
            </div>
          </div>

          {/* Question */}
          <div className="bg-slate-900 border border-slate-800 rounded-2xl p-6 mb-4">
            <p className="text-xl font-medium leading-relaxed mb-6">{currentQ.q}</p>

            <div className="space-y-3">
              {currentQ.options.map((opt, idx) => {
                let buttonClass = "bg-slate-800 border-slate-700 hover:border-slate-500 hover:bg-slate-750";
                
                if (showResult) {
                  if (idx === currentQ.correct) {
                    buttonClass = "bg-green-500/20 border-green-500 text-green-300";
                  } else if (idx === selectedAnswer) {
                    buttonClass = "bg-red-500/20 border-red-500 text-red-300";
                  } else {
                    buttonClass = "bg-slate-800 border-slate-700 opacity-50";
                  }
                } else if (hintUsed && idx !== currentQ.correct && [...Array(currentQ.options.length).keys()].filter(i => i !== currentQ.correct).slice(0, 1).includes(idx)) {
                  buttonClass = "bg-slate-800 border-slate-700 opacity-30 line-through";
                }

                return (
                  <button
                    key={idx}
                    onClick={() => handleAnswer(idx)}
                    disabled={showResult || (hintUsed && idx !== currentQ.correct && [...Array(currentQ.options.length).keys()].filter(i => i !== currentQ.correct).slice(0, 1).includes(idx))}
                    className={`w-full text-left border-2 rounded-xl px-4 py-3 transition-all ${buttonClass} ${!showResult ? 'active:scale-[0.98]' : ''}`}
                  >
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 rounded-lg bg-slate-900 flex items-center justify-center font-bold text-sm">
                        {['A', 'B', 'C', 'D'][idx]}
                      </div>
                      <span className="font-medium">{opt}</span>
                      {showResult && idx === currentQ.correct && <Check className="w-5 h-5 ml-auto text-green-400" />}
                      {showResult && idx === selectedAnswer && idx !== currentQ.correct && <X className="w-5 h-5 ml-auto text-red-400" />}
                    </div>
                  </button>
                );
              })}
            </div>

            {!showResult && hintsLeft > 0 && (
              <button
                onClick={useHint}
                disabled={hintUsed}
                className="mt-4 w-full bg-blue-500/10 border border-blue-500/30 hover:bg-blue-500/20 disabled:opacity-30 rounded-xl py-2 text-sm text-blue-400 flex items-center justify-center gap-2"
              >
                <Lightbulb className="w-4 h-4" />
                {hintUsed ? 'Hint used (-5 XP)' : `Use hint (${hintsLeft} left) — eliminates one wrong answer`}
              </button>
            )}
          </div>

          {/* Result panel */}
          {showResult && (
            <div className={`rounded-2xl p-5 border-2 ${selectedAnswer === currentQ.correct ? 'bg-green-500/10 border-green-500/50' : 'bg-red-500/10 border-red-500/50'}`}>
              <div className="text-2xl font-bold mb-2">{reaction}</div>
              {showExplain && (
                <div className="animate-fade-in">
                  <p className="text-sm text-slate-300 mb-4">{currentQ.explain}</p>
                  <button
                    onClick={nextQuestion}
                    className="w-full bg-white text-slate-900 font-bold py-3 rounded-xl hover:bg-slate-200 active:scale-[0.98] transition"
                  >
                    {questionIndex === floor.questions.length - 1 ? 'Finish Floor →' : 'Next Question →'}
                  </button>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    );
  }

  // FLOOR COMPLETE
  if (screen === 'floorComplete') {
    return (
      <div className="min-h-screen bg-slate-950 text-white p-6 font-sans flex items-center justify-center">
        <div className="max-w-lg w-full text-center">
          <div className="animate-bounce mb-4">
            <Trophy className="w-20 h-20 text-yellow-400 mx-auto" />
          </div>
          <h1 className="text-4xl font-black mb-2 bg-gradient-to-r from-yellow-400 to-orange-500 bg-clip-text text-transparent">
            {getRandom(REACTIONS.levelUp)}
          </h1>
          <p className="text-slate-400 mb-6">Next floor unlocked 🔓</p>

          <div className="bg-slate-900 border border-slate-800 rounded-2xl p-6 mb-6">
            <div className="grid grid-cols-3 gap-4">
              <div>
                <div className="text-2xl font-bold text-yellow-400">{xp}</div>
                <div className="text-xs text-slate-500">Total XP</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-orange-400">{maxCombo}x</div>
                <div className="text-xs text-slate-500">Max Combo</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-red-400">{hearts}</div>
                <div className="text-xs text-slate-500">Lives Left</div>
              </div>
            </div>
          </div>

          <button
            onClick={continueAdventure}
            className="w-full bg-gradient-to-r from-cyan-500 to-purple-500 hover:opacity-90 font-bold py-4 rounded-xl transition"
          >
            Continue Adventure →
          </button>
        </div>
      </div>
    );
  }

  // VICTORY
  if (screen === 'victory') {
    return (
      <div className="min-h-screen bg-slate-950 text-white p-6 font-sans flex items-center justify-center">
        <div className="max-w-lg w-full text-center">
          <div className="mb-4 animate-pulse">
            <Crown className="w-24 h-24 text-yellow-400 mx-auto" />
          </div>
          <h1 className="text-5xl font-black mb-2 bg-gradient-to-r from-yellow-400 via-pink-500 to-purple-500 bg-clip-text text-transparent">
            YOU'RE THE GOAT 🐐
          </h1>
          <p className="text-slate-300 mb-2 text-lg">SAT tower conquered.</p>
          <p className="text-slate-500 mb-6 text-sm">The College Board is literally shaking rn 😭</p>

          <div className="bg-gradient-to-br from-yellow-500/20 to-purple-500/20 border border-yellow-500/30 rounded-2xl p-6 mb-6">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <div className="text-3xl font-bold text-yellow-400">{xp}</div>
                <div className="text-xs text-slate-400">Final XP</div>
              </div>
              <div>
                <div className="text-3xl font-bold text-orange-400">{maxCombo}x</div>
                <div className="text-xs text-slate-400">Best Combo</div>
              </div>
              <div>
                <div className="text-3xl font-bold text-red-400">{hearts}/3</div>
                <div className="text-xs text-slate-400">Lives Saved</div>
              </div>
              <div>
                <div className="text-3xl font-bold text-green-400">6/6</div>
                <div className="text-xs text-slate-400">Floors Cleared</div>
              </div>
            </div>
          </div>

          <button
            onClick={resetGame}
            className="w-full bg-gradient-to-r from-yellow-500 to-purple-500 hover:opacity-90 font-bold py-4 rounded-xl transition flex items-center justify-center gap-2"
          >
            <RotateCcw className="w-5 h-5" /> Play Again
          </button>
        </div>
      </div>
    );
  }

  // GAME OVER
  if (screen === 'gameover') {
    return (
      <div className="min-h-screen bg-slate-950 text-white p-6 font-sans flex items-center justify-center">
        <div className="max-w-lg w-full text-center">
          <div className="text-7xl mb-4">💀</div>
          <h1 className="text-4xl font-black mb-2 text-red-400">
            {getRandom(REACTIONS.gameOver)}
          </h1>
          <p className="text-slate-400 mb-6">Ran out of lives. The math won this round.</p>

          <div className="bg-slate-900 border border-slate-800 rounded-2xl p-6 mb-6">
            <div className="grid grid-cols-3 gap-4">
              <div>
                <div className="text-2xl font-bold text-yellow-400">{xp}</div>
                <div className="text-xs text-slate-500">XP Earned</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-orange-400">{maxCombo}x</div>
                <div className="text-xs text-slate-500">Max Combo</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-green-400">{completed.length}</div>
                <div className="text-xs text-slate-500">Floors Cleared</div>
              </div>
            </div>
          </div>

          <button
            onClick={resetGame}
            className="w-full bg-gradient-to-r from-red-500 to-purple-500 hover:opacity-90 font-bold py-4 rounded-xl transition flex items-center justify-center gap-2"
          >
            <RotateCcw className="w-5 h-5" /> Try Again Warrior
          </button>
        </div>
      </div>
    );
  }

  return null;
}