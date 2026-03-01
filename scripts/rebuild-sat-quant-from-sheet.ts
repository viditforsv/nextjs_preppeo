#!/usr/bin/env tsx
/**
 * Rebuild SAT Quant course structure from Google Sheet master_map_quant
 * Replaces the current structure with the one from the sheet
 */

import { config } from "dotenv";
import { resolve } from "path";
import { readFileSync } from "fs";
import { createClient } from "@supabase/supabase-js";

// Load environment variables from .env.local
config({ path: resolve(process.cwd(), ".env.local") });

interface GoogleSheetsData {
  headers: string[];
  data: Array<{
    "Sl. No.": string;
    "Lesson ID": string;
    "Unit": string;
    "Chapters": string;
    "Topics": string;
    "lesson_name": string;
  }>;
}

async function main() {
  const dryRun = process.argv.includes("--dry-run");

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

  console.log("🔄 Rebuilding SAT Quant course structure from Google Sheet...\n");
  if (dryRun) {
    console.log("🔍 DRY RUN MODE - No changes will be made\n");
  }

  // Read Google Sheets data
  const jsonPath = resolve(process.cwd(), "scripts/google-sheets-output.json");
  let sheetsData: GoogleSheetsData;

  try {
    const jsonContent = readFileSync(jsonPath, "utf-8");
    sheetsData = JSON.parse(jsonContent);
  } catch (error) {
    console.error(`❌ Error reading Google Sheets data: ${error instanceof Error ? error.message : error}`);
    process.exit(1);
  }

  console.log(`✅ Loaded ${sheetsData.data.length} lessons from Google Sheet\n`);

  // Get SAT Quant course
  const { data: course, error: courseError } = await supabase
    .from("courses")
    .select("id, title")
    .eq("slug", "sat-quant")
    .single();

  if (courseError || !course) {
    console.error(`❌ SAT Quant course not found: ${courseError?.message}`);
    process.exit(1);
  }

  console.log(`✅ Found course: ${course.title}\n`);

  // Organize data by Unit -> Chapter -> Lessons
  interface UnitData {
    unitName: string;
    unitOrder: number;
    chapters: Map<string, ChapterData>;
  }

  interface ChapterData {
    chapterName: string;
    chapterOrder: number;
    lessons: Array<{
      lessonId: string;
      lessonName: string;
      lessonOrder: number;
    }>;
  }

  const unitsMap = new Map<string, UnitData>();
  let unitOrder = 1;

  for (const row of sheetsData.data) {
    const unitName = row["Unit"].trim();
    const chapterName = row["Chapters"].trim();
    const lessonId = row["Lesson ID"].trim();
    const lessonName = row["lesson_name"].trim();
    const lessonOrder = parseInt(row["Sl. No."], 10);

    if (!unitsMap.has(unitName)) {
      unitsMap.set(unitName, {
        unitName,
        unitOrder: unitOrder++,
        chapters: new Map(),
      });
    }

    const unit = unitsMap.get(unitName)!;

    if (!unit.chapters.has(chapterName)) {
      unit.chapters.set(chapterName, {
        chapterName,
        chapterOrder: unit.chapters.size + 1,
        lessons: [],
      });
    }

    const chapter = unit.chapters.get(chapterName)!;
    chapter.lessons.push({
      lessonId,
      lessonName,
      lessonOrder,
    });
  }

  console.log(`📚 Structure from Google Sheet:`);
  console.log(`   Units: ${unitsMap.size}`);
  let totalChapters = 0;
  unitsMap.forEach((unit) => {
    totalChapters += unit.chapters.size;
    console.log(`   ${unit.unitOrder}. ${unit.unitName} (${unit.chapters.size} chapters)`);
  });
  console.log(`   Total Chapters: ${totalChapters}\n`);

  if (dryRun) {
    console.log("[DRY RUN] Would rebuild the course structure");
    console.log("💡 Run without --dry-run to apply changes");
    return;
  }

  // Delete all existing units, chapters, and lessons
  console.log("🗑️  Deleting existing structure...");

  // Get all existing lessons
  const { data: existingLessons } = await supabase
    .from("courses_lessons")
    .select("id")
    .eq("course_id", course.id);

  if (existingLessons && existingLessons.length > 0) {
    for (const lesson of existingLessons) {
      await supabase.from("courses_lessons").delete().eq("id", lesson.id);
    }
    console.log(`   ✅ Deleted ${existingLessons.length} lessons`);
  }

  // Get all existing chapters
  const { data: existingChapters } = await supabase
    .from("courses_chapters")
    .select("id")
    .in(
      "unit_id",
      (
        await supabase
          .from("courses_units")
          .select("id")
          .eq("course_id", course.id)
      ).data?.map((u) => u.id) || []
    );

  if (existingChapters && existingChapters.length > 0) {
    for (const chapter of existingChapters) {
      await supabase.from("courses_chapters").delete().eq("id", chapter.id);
    }
    console.log(`   ✅ Deleted ${existingChapters.length} chapters`);
  }

  // Delete all existing units
  const { data: existingUnits } = await supabase
    .from("courses_units")
    .select("id")
    .eq("course_id", course.id);

  if (existingUnits && existingUnits.length > 0) {
    for (const unit of existingUnits) {
      await supabase.from("courses_units").delete().eq("id", unit.id);
    }
    console.log(`   ✅ Deleted ${existingUnits.length} units\n`);
  }

  // Create new structure
  console.log("🔨 Creating new structure from Google Sheet...\n");

  const unitsArray = Array.from(unitsMap.values()).sort(
    (a, b) => a.unitOrder - b.unitOrder
  );

  for (const unitData of unitsArray) {
    console.log(`📦 Creating Unit ${unitData.unitOrder}: ${unitData.unitName}`);

    // Create unit
    const { data: newUnit, error: unitError } = await supabase
      .from("courses_units")
      .insert({
        course_id: course.id,
        unit_name: unitData.unitName,
        unit_order: unitData.unitOrder,
        description: null,
        is_locked: false,
      })
      .select()
      .single();

    if (unitError) {
      console.error(`   ❌ Failed to create unit: ${unitError.message}`);
      continue;
    }

    console.log(`   ✅ Created unit: ${newUnit.id}`);

    // Create chapters
    const chaptersArray = Array.from(unitData.chapters.values()).sort(
      (a, b) => a.chapterOrder - b.chapterOrder
    );

    for (const chapterData of chaptersArray) {
      console.log(
        `      📄 Creating Chapter ${chapterData.chapterOrder}: ${chapterData.chapterName}`
      );

      // Create chapter
      const { data: newChapter, error: chapterError } = await supabase
        .from("courses_chapters")
        .insert({
          unit_id: newUnit.id,
          chapter_name: chapterData.chapterName,
          chapter_order: chapterData.chapterOrder,
          description: null,
          is_locked: false,
        })
        .select()
        .single();

      if (chapterError) {
        console.error(`         ❌ Failed to create chapter: ${chapterError.message}`);
        continue;
      }

      // Create lessons
      const sortedLessons = chapterData.lessons.sort(
        (a, b) => a.lessonOrder - b.lessonOrder
      );

      for (const lessonData of sortedLessons) {
        const slug = lessonData.lessonId.replace(/_/g, "-");
        const baseUrl = "https://shrividhyaclasses.b-cdn.net/sat_quant/html_for_pdfs";
        const pdfUrl = `${baseUrl}/${lessonData.lessonId}.html`;
        const solutionUrl = `${baseUrl}/${lessonData.lessonId}_sol.html`;

        // Get existing lesson by slug to preserve PDF URLs
        const { data: existingLesson } = await supabase
          .from("courses_lessons")
          .select("pdf_url, solution_url")
          .eq("course_id", course.id)
          .eq("slug", slug)
          .single();

        const { error: lessonError } = await supabase
          .from("courses_lessons")
          .insert({
            course_id: course.id,
            chapter_id: newChapter.id,
            title: lessonData.lessonName,
            slug: slug,
            lesson_order: lessonData.lessonOrder,
            is_preview: lessonData.lessonOrder === 1,
            pdf_url: existingLesson?.pdf_url || pdfUrl,
            solution_url: existingLesson?.solution_url || solutionUrl,
          });

        if (lessonError) {
          console.error(
            `            ❌ Failed to create lesson ${slug}: ${lessonError.message}`
          );
        }
      }

      console.log(
        `         ✅ Created chapter with ${sortedLessons.length} lessons`
      );
    }
  }

  console.log("\n✅ Course structure rebuilt successfully!");
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
