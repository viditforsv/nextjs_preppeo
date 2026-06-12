"use client";

/**
 * TEMPORARY local-only demo — visualizes the new per-part course format
 * (1 micro-video + quiz + flashcards per part) for the Linear Equations
 * chapter, with hardcoded data. No DB. Delete once the real seed lands.
 */

import { useState } from "react";
import { PlayCircle, HelpCircle, Lock } from "lucide-react";
import { SatLearnQuiz } from "../[courseSlug]/[topicSlug]/[itemSlug]/SatLearnQuiz";
import type { SatLearnQuizQuestion } from "@/types/sat-learn";

const NAVY = "#1a365d";
const AMBER = "#f4b400";
const RED = "#d6483b";
const CREAM = "#fbfaf6";

const VIDEO_URL =
  "https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/linear-equations/videos/part2-what-makes-a-line.mp4";

const PARTS = [
  "Why Lines Matter",
  "What Makes a Line",
  "Inclination & Slope Sign",
  "y = mx + b",
  "Slope = Rise / Run",
  "Intercepts",
  "Three Forms · Parallel & Perpendicular",
  "Worked Example",
];

const QUIZ: SatLearnQuizQuestion[] = [
  {
    id: "q1",
    question: "How many lines pass through a single point?",
    options: [
      { id: "A", text: "Exactly one" },
      { id: "B", text: "Two" },
      { id: "C", text: "Infinitely many" },
      { id: "D", text: "None" },
    ],
    correctAnswer: "C",
    explanation: "One point alone doesn't pin a line down — infinite lines fan through it.",
  },
  {
    id: "q2",
    question: "How many lines have a slope of exactly 2?",
    options: [
      { id: "A", text: "One" },
      { id: "B", text: "Infinitely many (all parallel)" },
      { id: "C", text: "Two" },
      { id: "D", text: "Depends on the y-intercept" },
    ],
    correctAnswer: "B",
    explanation: "A slope alone gives a whole family of parallel lines, all equally steep.",
  },
  {
    id: "q3",
    question: "What two pieces of information lock in exactly one line?",
    options: [
      { id: "A", text: "A point and a slope" },
      { id: "B", text: "Two slopes" },
      { id: "C", text: "A slope and an angle" },
      { id: "D", text: "A point and an intercept sign" },
    ],
    correctAnswer: "A",
    explanation: "Point + slope = one unique line. That's the core idea of this part.",
  },
  {
    id: "q4",
    question: "Two distinct points are given. How many lines pass through both?",
    options: [
      { id: "A", text: "Infinitely many" },
      { id: "B", text: "Exactly one" },
      { id: "C", text: "Two" },
      { id: "D", text: "None" },
    ],
    correctAnswer: "B",
    explanation: "Two points also fix the slope — so they determine exactly one line.",
  },
];

type Tab = "video" | "quiz";

export default function PartFormatDemo() {
  const [tab, setTab] = useState<Tab>("video");

  const tabs: { key: Tab; label: string; icon: typeof PlayCircle }[] = [
    { key: "video", label: "Video", icon: PlayCircle },
    { key: "quiz", label: "Quiz", icon: HelpCircle },
  ];

  return (
    <div className="min-h-screen" style={{ background: CREAM }}>
      <div className="mx-auto flex max-w-6xl gap-6 px-4 py-8">
        {/* ── Sidebar: chapter → parts ─────────────────────────── */}
        <aside className="hidden w-72 shrink-0 md:block">
          <div className="rounded-xl border border-gray-200 bg-white p-4">
            <p className="text-[10px] font-bold uppercase tracking-wider text-gray-400">
              Algebra · Chapter
            </p>
            <h2 className="mt-1 text-base font-extrabold" style={{ color: NAVY }}>
              Linear Equations
            </h2>
            <ol className="mt-4 space-y-1">
              {PARTS.map((title, i) => {
                const n = i + 1;
                const active = n === 2;
                return (
                  <li key={title}>
                    <div
                      className={`flex items-center gap-2.5 rounded-lg px-2.5 py-2 text-sm ${
                        active ? "font-bold text-white" : "text-gray-600"
                      }`}
                      style={active ? { background: NAVY } : undefined}
                    >
                      <span
                        className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full text-[10px] font-bold"
                        style={{
                          background: active ? AMBER : "#e5e7eb",
                          color: NAVY,
                        }}
                      >
                        {n}
                      </span>
                      <span className="truncate">{title}</span>
                      {!active && <Lock className="ml-auto h-3 w-3 shrink-0 text-gray-300" />}
                    </div>
                    {active && (
                      <div className="ml-10 mt-1 space-y-0.5 text-xs text-gray-500">
                        <p>▸ Video</p>
                        <p>▸ Quiz</p>
                      </div>
                    )}
                  </li>
                );
              })}
            </ol>
          </div>
        </aside>

        {/* ── Main: the part ───────────────────────────────────── */}
        <main className="min-w-0 flex-1">
          <p className="text-[10px] font-bold uppercase tracking-wider" style={{ color: RED }}>
            Part 2 of 8
          </p>
          <h1 className="mt-1 text-2xl font-extrabold" style={{ color: NAVY }}>
            What Makes a Line
          </h1>

          {/* tabs */}
          <div className="mt-4 flex gap-2">
            {tabs.map(({ key, label, icon: Icon }) => (
              <button
                key={key}
                onClick={() => setTab(key)}
                className={`flex items-center gap-1.5 rounded-lg px-4 py-2 text-sm font-bold transition ${
                  tab === key ? "text-white" : "bg-white text-gray-600 hover:bg-gray-50"
                }`}
                style={tab === key ? { background: NAVY } : { border: "1px solid #e5e7eb" }}
              >
                <Icon className="h-4 w-4" />
                {label}
              </button>
            ))}
          </div>

          <div className="mt-4 rounded-xl border border-gray-200 bg-white p-5">
            {tab === "video" && (
              <div
                className="relative w-full overflow-hidden rounded-xl bg-black"
                style={{ paddingTop: "56.25%" }}
              >
                {/* native <video> — direct CDN mp4 (referer-locked pull zone allows localhost) */}
                <video
                  src={VIDEO_URL}
                  controls
                  playsInline
                  className="absolute inset-0 h-full w-full"
                />
              </div>
            )}
            {tab === "quiz" && <SatLearnQuiz questions={QUIZ} />}
          </div>

          <p className="mt-3 text-xs text-gray-400">
            Local demo only — hardcoded data, no DB. Format: each part = 1 micro-video + quiz
            (+ flashcards where they earn their place).
          </p>
        </main>
      </div>
    </div>
  );
}
