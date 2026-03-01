#!/usr/bin/env tsx
/**
 * Verify SAT Quant course structure
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";

config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  process.env.NEXT_PUBLIC_ENVIRONMENT = "prod";
  const prodUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
  const prodServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;

  if (!prodUrl || !prodServiceKey) {
    console.error("❌ Missing credentials");
    process.exit(1);
  }

  const supabase = createClient(prodUrl, prodServiceKey);

  const { data: course } = await supabase
    .from("courses")
    .select("id, title")
    .eq("slug", "sat-quant")
    .single();

  const { count: unitsCount } = await supabase
    .from("courses_units")
    .select("*", { count: "exact", head: true })
    .eq("course_id", course.id);

  const { data: units } = await supabase
    .from("courses_units")
    .select("id")
    .eq("course_id", course.id);

  const { count: chaptersCount } = await supabase
    .from("courses_chapters")
    .select("*", { count: "exact", head: true })
    .in("unit_id", units.map((u) => u.id));

  const { count: lessonsCount } = await supabase
    .from("courses_lessons")
    .select("*", { count: "exact", head: true })
    .eq("course_id", course.id);

  const { data: unitsList } = await supabase
    .from("courses_units")
    .select("unit_name, unit_order")
    .eq("course_id", course.id)
    .order("unit_order");

  console.log("\n✅ SAT Quant Course Structure:");
  console.log(`   Course: ${course.title}`);
  console.log(`   Units: ${unitsCount}`);
  if (unitsList) {
    unitsList.forEach((u) => {
      console.log(`      ${u.unit_order}. ${u.unit_name}`);
    });
  }
  console.log(`   Chapters: ${chaptersCount}`);
  console.log(`   Lessons: ${lessonsCount}\n`);

  // Show sample lessons
  const { data: sampleLessons } = await supabase
    .from("courses_lessons")
    .select("slug, title, lesson_order")
    .eq("course_id", course.id)
    .order("lesson_order", { ascending: true })
    .limit(5);

  console.log("📝 Sample lessons:");
  sampleLessons.forEach((lesson) => {
    console.log(`   ${lesson.lesson_order}. ${lesson.title} (${lesson.slug})`);
  });
}

main().catch(console.error);
