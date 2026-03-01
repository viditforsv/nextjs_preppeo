#!/usr/bin/env tsx
/**
 * Verify SAT Quant chapters in Supabase
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

  const courseId = "a0129fd3-2487-47d9-94c7-1e07ddd514a9";

  console.log(`\n🔍 Checking chapters for course ID: ${courseId}\n`);

  // Get course info
  const { data: course, error: courseError } = await supabase
    .from("courses")
    .select("id, title, slug")
    .eq("id", courseId)
    .single();

  if (courseError || !course) {
    console.error(`❌ Course not found: ${courseError?.message}`);
    process.exit(1);
  }

  console.log(`✅ Course: ${course.title} (${course.slug})\n`);

  // Get all units
  const { data: units, error: unitsError } = await supabase
    .from("courses_units")
    .select("id, unit_name, unit_order")
    .eq("course_id", courseId)
    .order("unit_order");

  if (unitsError) {
    console.error(`❌ Error fetching units: ${unitsError.message}`);
    process.exit(1);
  }

  if (!units || units.length === 0) {
    console.log("⚠️  No units found!");
    return;
  }

  console.log(`📦 Found ${units.length} units:\n`);

  let totalChapters = 0;

  // Get chapters for each unit
  for (const unit of units) {
    const { data: chapters, error: chaptersError } = await supabase
      .from("courses_chapters")
      .select("id, chapter_name, chapter_order, unit_id")
      .eq("unit_id", unit.id)
      .order("chapter_order");

    if (chaptersError) {
      console.error(`   ❌ Error fetching chapters for unit ${unit.unit_name}: ${chaptersError.message}`);
      continue;
    }

    console.log(`   Unit ${unit.unit_order}: ${unit.unit_name} (ID: ${unit.id})`);
    console.log(`      Chapters: ${chapters?.length || 0}`);

    if (chapters && chapters.length > 0) {
      chapters.forEach((chapter) => {
        console.log(`         ${chapter.chapter_order}. ${chapter.chapter_name} (ID: ${chapter.id})`);
        totalChapters++;
      });
    } else {
      console.log(`         ⚠️  No chapters in this unit`);
    }
    console.log();
  }

  // Also check directly by course_id (if there's a direct relationship)
  console.log("=".repeat(80));
  console.log(`\n📊 Summary:`);
  console.log(`   Course ID: ${courseId}`);
  console.log(`   Units: ${units.length}`);
  console.log(`   Total Chapters: ${totalChapters}`);

  // Direct query for all chapters (in case there's a direct course_id relationship)
  const { data: allChapters, error: allChaptersError } = await supabase
    .from("courses_chapters")
    .select("id, chapter_name, chapter_order, unit_id")
    .in(
      "unit_id",
      units.map((u) => u.id)
    )
    .order("chapter_order");

  if (!allChaptersError && allChapters) {
    console.log(`   Direct query result: ${allChapters.length} chapters`);
  }
}

main().catch(console.error);
