#!/usr/bin/env tsx
/**
 * Build SAT Quant course structure from GRE Quant structure
 * Creates units, chapters, and lessons in the database
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

  console.log("📋 Building SAT Quant course structure from GRE Quant...\n");

  // Get GRE Quant course
  const { data: greCourse, error: greError } = await supabase
    .from("courses")
    .select("id, title")
    .eq("slug", "gre-quant")
    .single();

  if (greError || !greCourse) {
    console.error(`❌ GRE Quant course not found: ${greError?.message}`);
    process.exit(1);
  }

  console.log(`✅ Found GRE Quant course: ${greCourse.title} (${greCourse.id})\n`);

  // Get SAT Quant course
  const { data: satCourse, error: satError } = await supabase
    .from("courses")
    .select("id, title")
    .eq("slug", "sat-quant")
    .single();

  if (satError || !satCourse) {
    console.error(`❌ SAT Quant course not found: ${satError?.message}`);
    process.exit(1);
  }

  console.log(`✅ Found SAT Quant course: ${satCourse.title} (${satCourse.id})\n`);

  // Check if SAT Quant already has units
  const { data: existingUnits } = await supabase
    .from("courses_units")
    .select("id")
    .eq("course_id", satCourse.id);

  if (existingUnits && existingUnits.length > 0) {
    console.log(`⚠️  SAT Quant already has ${existingUnits.length} units.`);
    console.log("   This script will create additional units/chapters/lessons if they don't exist.\n");
  }

  // Get GRE Quant units
  const { data: greUnits, error: unitsError } = await supabase
    .from("courses_units")
    .select("id, unit_name, unit_order, description")
    .eq("course_id", greCourse.id)
    .order("unit_order", { ascending: true });

  if (unitsError || !greUnits || greUnits.length === 0) {
    console.error(`❌ Error fetching GRE units: ${unitsError?.message}`);
    process.exit(1);
  }

  console.log(`📚 Found ${greUnits.length} units in GRE Quant\n`);
  console.log("=".repeat(80));

  let totalChaptersCreated = 0;
  let totalLessonsCreated = 0;

  // Process each unit
  for (const greUnit of greUnits) {
    console.log(`\n📦 Processing Unit ${greUnit.unit_order}: ${greUnit.unit_name}`);

    // Check if unit already exists in SAT Quant
    let satUnit;
    const { data: existingUnit } = await supabase
      .from("courses_units")
      .select("id")
      .eq("course_id", satCourse.id)
      .eq("unit_name", greUnit.unit_name)
      .eq("unit_order", greUnit.unit_order)
      .single();

    if (existingUnit) {
      console.log(`   ⚠️  Unit already exists, using: ${existingUnit.id}`);
      satUnit = existingUnit;
    } else {
      // Create unit in SAT Quant
      const { data: newUnit, error: unitError } = await supabase
        .from("courses_units")
        .insert({
          course_id: satCourse.id,
          unit_name: greUnit.unit_name,
          unit_order: greUnit.unit_order,
          description: greUnit.description || null,
          is_locked: false,
        })
        .select()
        .single();

      if (unitError) {
        console.error(`   ❌ Failed to create unit: ${unitError.message}`);
        continue;
      }

      satUnit = newUnit;
      console.log(`   ✅ Created unit: ${satUnit.id}`);
    }

    // Get chapters for this GRE unit
    const { data: greChapters, error: chaptersError } = await supabase
      .from("courses_chapters")
      .select("id, chapter_name, chapter_order, description")
      .eq("unit_id", greUnit.id)
      .order("chapter_order", { ascending: true });

    if (chaptersError || !greChapters || greChapters.length === 0) {
      console.log(`   ⚠️  No chapters found in GRE unit`);
      continue;
    }

    console.log(`   📖 Processing ${greChapters.length} chapters...`);

    // Process each chapter
    for (const greChapter of greChapters) {
      // Check if chapter already exists
      let satChapter;
      const { data: existingChapter } = await supabase
        .from("courses_chapters")
        .select("id")
        .eq("unit_id", satUnit.id)
        .eq("chapter_name", greChapter.chapter_name)
        .eq("chapter_order", greChapter.chapter_order)
        .single();

      if (existingChapter) {
        satChapter = existingChapter;
      } else {
        // Create chapter in SAT Quant
        const { data: newChapter, error: chapterError } = await supabase
          .from("courses_chapters")
          .insert({
            unit_id: satUnit.id,
            chapter_name: greChapter.chapter_name,
            chapter_order: greChapter.chapter_order,
            description: greChapter.description || null,
            is_locked: false,
          })
          .select()
          .single();

        if (chapterError) {
          console.error(`      ❌ Failed to create chapter: ${chapterError.message}`);
          continue;
        }

        satChapter = newChapter;
        totalChaptersCreated++;
      }

      // Get lessons for this GRE chapter
      const { data: greLessons, error: lessonsError } = await supabase
        .from("courses_lessons")
        .select("id, title, slug, lesson_order")
        .eq("chapter_id", greChapter.id)
        .order("lesson_order", { ascending: true });

      if (lessonsError || !greLessons || greLessons.length === 0) {
        continue;
      }

      // Process each lesson
      for (const greLesson of greLessons) {
        // Check if lesson already exists (by slug)
        const { data: existingLesson } = await supabase
          .from("courses_lessons")
          .select("id")
          .eq("course_id", satCourse.id)
          .eq("slug", greLesson.slug)
          .single();

        if (existingLesson) {
          continue; // Skip if already exists
        }

        // Convert GRE lesson slug to SAT lesson slug
        // gre-lid-001 -> sat-lid-001
        const satSlug = greLesson.slug.replace(/^gre-lid-/, "sat-lid-");
        const satTitle = greLesson.title.replace(/Gre Lid/i, "SAT Lid").replace(/GRE/i, "SAT");

        // Create lesson in SAT Quant
        const { data: newLesson, error: lessonError } = await supabase
          .from("courses_lessons")
          .insert({
            course_id: satCourse.id,
            chapter_id: satChapter.id,
            title: satTitle,
            slug: satSlug,
            lesson_order: greLesson.lesson_order,
            is_preview: false,
            content: null, // Will be updated with PDF URLs later
          })
          .select()
          .single();

        if (lessonError) {
          console.error(`         ❌ Failed to create lesson ${satSlug}: ${lessonError.message}`);
          continue;
        }

        totalLessonsCreated++;
      }

      if (greLessons.length > 0) {
        console.log(`      ✅ Chapter "${greChapter.chapter_name}": ${greLessons.length} lessons processed`);
      }
    }
  }

  console.log("\n" + "=".repeat(80));
  console.log("\n✅ Course structure creation completed!");
  console.log(`\n📊 Summary:`);
  console.log(`   Units: ${greUnits.length} (from GRE Quant)`);
  console.log(`   Chapters created: ${totalChaptersCreated}`);
  console.log(`   Lessons created: ${totalLessonsCreated}`);
  console.log(`\n💡 Next step: Update lesson content with PDF URLs`);
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
