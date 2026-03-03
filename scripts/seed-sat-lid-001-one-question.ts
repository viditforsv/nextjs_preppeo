#!/usr/bin/env tsx
/**
 * Seed one SAT lid_001 question into question_bank and link to lesson.
 * Run after: 20250303100000_add_sat_math_subject.sql
 *
 * Usage: npx tsx scripts/seed-sat-lid-001-one-question.ts
 *
 * Lesson ID: 347d1639-dab4-4e93-8430-fd749f9ee9b2
 * Course ID:  21f5d0c2-953c-4b49-b5d4-4e680b1bcf56
 */

import { config } from "dotenv";
import { resolve } from "path";
config({ path: resolve(process.cwd(), ".env.local") });

import { createClient } from "@supabase/supabase-js";
import {
  getSupabaseUrl,
  getSupabaseServiceRoleKey,
} from "../src/lib/supabase/env";

const LESSON_ID = "347d1639-dab4-4e93-8430-fd749f9ee9b2";

// Q1 from lid_001.md (parsed manually for flow setup)
const Q1 = {
  question_text: `A car rental agency charges a flat daily fee of 45 plus 0.25 per mile driven. If a customer was charged a total of 95 for a one-day rental, which equation represents the number of miles, $m$, the customer drove?`,
  options: [
    { value: "$45m + 0.25 = 95$" },
    { value: "$0.25m + 45 = 95$" },
    { value: "$45.25m = 95$" },
    { value: "$0.25m - 45 = 95$" },
  ],
  correct_answer: "$0.25m + 45 = 95$", // option B (index 1)
  explanation: `To model this real-world scenario, we must identify the constant and variable components of the total cost.

The flat daily fee of 45 is a fixed value that does not change regardless of the distance traveled. The cost per mile is 0.25, which must be multiplied by the total number of miles driven, $m$. This creates the variable term $0.25m$.

The total charge is the sum of these two distinct parts: the variable mileage cost and the fixed daily fee. Setting this sum equal to the final bill of 95 gives us the linear equation:

$0.25m + 45 = 95$`,
  difficulty: 5, // Medium
  question_type: "mcq" as const,
  topic: "Algebra",
  subtopic: "Linear equations in one variable",
  human_readable_id: "sat_lid_001_1",
};

async function main() {
  const url = getSupabaseUrl();
  const serviceKey = getSupabaseServiceRoleKey();
  if (!url || !serviceKey) {
    throw new Error("Missing Supabase URL or service role key in env");
  }
  const supabase = createClient(url, serviceKey);

  // 1) Upsert question_bank (avoid duplicate on re-run)
  const { data: existing } = await supabase
    .from("question_bank")
    .select("id")
    .eq("human_readable_id", Q1.human_readable_id)
    .maybeSingle();

  let questionId: string;
  if (existing?.id) {
    questionId = existing.id;
    console.log("Question already exists:", questionId);
  } else {
    const { data: inserted, error: insertErr } = await supabase
      .from("question_bank")
      .insert({
        question_text: Q1.question_text,
        options: Q1.options,
        correct_answer: Q1.correct_answer,
        explanation: Q1.explanation,
        difficulty: Q1.difficulty,
        question_type: Q1.question_type,
        subject: "SAT Math",
        source: "SAT",
        topic: Q1.topic,
        subtopic: Q1.subtopic,
        human_readable_id: Q1.human_readable_id,
        is_pyq: false,
        is_active: true,
      })
      .select("id")
      .single();
    if (insertErr) throw insertErr;
    questionId = inserted.id;
    console.log("Inserted question_bank id:", questionId);
  }

  // 2) Get or create quiz for this lesson
  const { data: lesson } = await supabase
    .from("courses_lessons")
    .select("id, quiz_id")
    .eq("id", LESSON_ID)
    .single();
  if (!lesson) throw new Error("Lesson not found: " + LESSON_ID);

  let quizId: string;
  if (lesson.quiz_id) {
    quizId = lesson.quiz_id;
    console.log("Using existing quiz:", quizId);
  } else {
    const { data: newQuiz, error: quizErr } = await supabase
      .from("quizzes")
      .insert({
        title: "lid_001 Practice",
        lesson_id: LESSON_ID,
      })
      .select("id")
      .single();
    if (quizErr) throw quizErr;
    quizId = newQuiz.id;
    await supabase
      .from("courses_lessons")
      .update({ quiz_id: quizId })
      .eq("id", LESSON_ID);
    console.log("Created quiz and linked to lesson:", quizId);
  }

  // 3) Link question to quiz (quiz_questions)
  const { data: existingLink } = await supabase
    .from("quiz_questions")
    .select("id")
    .eq("quiz_id", quizId)
    .eq("question_id", questionId)
    .maybeSingle();
  if (!existingLink) {
    const { error: qqErr } = await supabase.from("quiz_questions").insert({
      quiz_id: quizId,
      question_id: questionId,
      question_order: 1,
    });
    if (qqErr) throw qqErr;
    console.log("Inserted quiz_questions row");
  } else {
    console.log("quiz_questions link already exists");
  }

  // 4) Update lesson_interactive_content.quiz so learn page shows this question
  const quizItem = {
    id: questionId,
    question: Q1.question_text,
    options: Q1.options.map((o) => o.value),
    answer: 1, // 0-based index for correct option B
    explanation: Q1.explanation,
  };
  const { data: lic } = await supabase
    .from("lesson_interactive_content")
    .select("id, quiz")
    .eq("lesson_id", LESSON_ID)
    .maybeSingle();

  if (lic) {
    const existingQuiz = Array.isArray(lic.quiz) ? lic.quiz : [];
    const updatedQuiz = [quizItem];
    const { error: updateErr } = await supabase
      .from("lesson_interactive_content")
      .update({ quiz: updatedQuiz, updated_at: new Date().toISOString() })
      .eq("lesson_id", LESSON_ID);
    if (updateErr) throw updateErr;
    console.log("Updated lesson_interactive_content.quiz to 1 question");
  } else {
    const { error: insertLicErr } = await supabase
      .from("lesson_interactive_content")
      .insert({
        lesson_id: LESSON_ID,
        intro: "Practice for this lesson.",
        steps: [],
        quiz: [quizItem],
      });
    if (insertLicErr) throw insertLicErr;
    console.log("Inserted lesson_interactive_content with 1 question");
  }

  console.log("\nDone. One question (sat_lid_001_1) is in question_bank, linked via quiz_questions, and shown in lesson_interactive_content.quiz.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
