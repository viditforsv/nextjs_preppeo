#!/usr/bin/env tsx
/**
 * Get GRE Quant course structure from Supabase
 * Shows: Course -> Units -> Chapters -> Lessons
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";

// Load environment variables from .env.local
config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  // Force production environment
  process.env.NEXT_PUBLIC_ENVIRONMENT = "prod";

  // Get production credentials
  const prodUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
  const prodServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;

  if (!prodUrl || !prodServiceKey) {
    console.error("❌ Missing production Supabase credentials!");
    process.exit(1);
  }

  const supabase = createClient(prodUrl, prodServiceKey);

  console.log("📋 Fetching GRE Quant course structure...\n");

  // Get GRE Quant course
  const { data: course, error: courseError } = await supabase
    .from("courses")
    .select("id, title, slug, curriculum, subject")
    .eq("slug", "gre-quant")
    .single();

  if (courseError || !course) {
    console.error(`❌ Error: ${courseError?.message || "GRE Quant course not found"}`);
    process.exit(1);
  }

  console.log(`✅ Course: ${course.title}`);
  console.log(`   ID: ${course.id}`);
  console.log(`   Slug: ${course.slug}`);
  console.log(`   Curriculum: ${course.curriculum}`);
  console.log(`   Subject: ${course.subject}\n`);

  // Get Units
  const { data: units, error: unitsError } = await supabase
    .from("courses_units")
    .select("id, unit_name, unit_order, description")
    .eq("course_id", course.id)
    .order("unit_order", { ascending: true });

  if (unitsError) {
    console.error(`❌ Error fetching units: ${unitsError.message}`);
    process.exit(1);
  }

  if (!units || units.length === 0) {
    console.log("⚠️  No units found for this course");
    return;
  }

  console.log(`📚 Found ${units.length} units\n`);
  console.log("=".repeat(80));

  // For each unit, get chapters
  for (const unit of units) {
    console.log(`\n📦 Unit ${unit.unit_order}: ${unit.unit_name}`);
    if (unit.description) {
      console.log(`   Description: ${unit.description}`);
    }
    console.log(`   Unit ID: ${unit.id}`);

    // Get Chapters for this unit
    const { data: chapters, error: chaptersError } = await supabase
      .from("courses_chapters")
      .select("id, chapter_name, chapter_order, description")
      .eq("unit_id", unit.id)
      .order("chapter_order", { ascending: true });

    if (chaptersError) {
      console.error(`   ❌ Error fetching chapters: ${chaptersError.message}`);
      continue;
    }

    if (!chapters || chapters.length === 0) {
      console.log(`   ⚠️  No chapters in this unit`);
      continue;
    }

    console.log(`   📖 ${chapters.length} chapters:`);

    // For each chapter, get lessons
    for (const chapter of chapters) {
      console.log(`\n      📄 Chapter ${chapter.chapter_order}: ${chapter.chapter_name}`);
      if (chapter.description) {
        console.log(`         Description: ${chapter.description}`);
      }
      console.log(`         Chapter ID: ${chapter.id}`);

      // Get Lessons for this chapter
      const { data: lessons, error: lessonsError } = await supabase
        .from("courses_lessons")
        .select("id, title, slug, lesson_order")
        .eq("chapter_id", chapter.id)
        .order("lesson_order", { ascending: true });

      if (lessonsError) {
        console.error(`         ❌ Error fetching lessons: ${lessonsError.message}`);
        continue;
      }

      if (!lessons || lessons.length === 0) {
        console.log(`         ⚠️  No lessons in this chapter`);
        continue;
      }

      console.log(`         📝 ${lessons.length} lessons:`);
      lessons.forEach((lesson) => {
        console.log(`            ${lesson.lesson_order}. ${lesson.title} (${lesson.slug})`);
      });
    }
  }

  // Summary
  console.log("\n" + "=".repeat(80));
  console.log("\n📊 Summary:");
  console.log(`   Course: ${course.title}`);
  console.log(`   Units: ${units.length}`);
  
  let totalChapters = 0;
  let totalLessons = 0;
  
  for (const unit of units) {
    const { data: chapters } = await supabase
      .from("courses_chapters")
      .select("id")
      .eq("unit_id", unit.id);
    
    if (chapters) {
      totalChapters += chapters.length;
      
      for (const chapter of chapters) {
        const { data: lessons } = await supabase
          .from("courses_lessons")
          .select("id")
          .eq("chapter_id", chapter.id);
        
        if (lessons) {
          totalLessons += lessons.length;
        }
      }
    }
  }
  
  console.log(`   Chapters: ${totalChapters}`);
  console.log(`   Lessons: ${totalLessons}`);
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
