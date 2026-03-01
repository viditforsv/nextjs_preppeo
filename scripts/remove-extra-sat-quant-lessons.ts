#!/usr/bin/env tsx
/**
 * Remove extra SAT Quant lessons beyond sat_lid_052
 * Only keeps lessons sat_lid_001 to sat_lid_052
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";

// Load environment variables from .env.local
config({ path: resolve(process.cwd(), ".env.local") });

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

  console.log("🗑️  Removing extra SAT Quant lessons...\n");
  if (dryRun) {
    console.log("🔍 DRY RUN MODE - No changes will be made\n");
  }

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

  // Get all lessons for SAT Quant
  const { data: allLessons, error: lessonsError } = await supabase
    .from("courses_lessons")
    .select("id, slug, title, lesson_order")
    .eq("course_id", course.id)
    .order("lesson_order", { ascending: true });

  if (lessonsError || !allLessons) {
    console.error(`❌ Error fetching lessons: ${lessonsError?.message}`);
    process.exit(1);
  }

  console.log(`📋 Found ${allLessons.length} total lessons\n`);

  // Filter lessons to keep (sat_lid_001 to sat_lid_052)
  const lessonsToKeep = allLessons.filter((lesson) => {
    const match = lesson.slug.match(/sat-lid-(\d+)/);
    if (!match) return false;
    const lessonNum = parseInt(match[1], 10);
    return lessonNum >= 1 && lessonNum <= 52;
  });

  // Find lessons to delete
  const lessonsToDelete = allLessons.filter((lesson) => {
    const match = lesson.slug.match(/sat-lid-(\d+)/);
    if (!match) return true; // Delete lessons that don't match the pattern
    const lessonNum = parseInt(match[1], 10);
    return lessonNum > 52;
  });

  console.log(`✅ Lessons to keep: ${lessonsToKeep.length} (sat_lid_001 to sat_lid_052)`);
  console.log(`🗑️  Lessons to delete: ${lessonsToDelete.length}\n`);

  if (lessonsToDelete.length === 0) {
    console.log("✨ No extra lessons to remove!");
    return;
  }

  // Show sample of lessons to be deleted
  console.log("📝 Sample lessons to be deleted:");
  lessonsToDelete.slice(0, 10).forEach((lesson) => {
    console.log(`   - ${lesson.slug} (${lesson.title})`);
  });
  if (lessonsToDelete.length > 10) {
    console.log(`   ... and ${lessonsToDelete.length - 10} more`);
  }
  console.log();

  if (dryRun) {
    console.log(`[DRY RUN] Would delete ${lessonsToDelete.length} lessons`);
    console.log("💡 Run without --dry-run to apply changes");
    return;
  }

  // Confirm deletion
  console.log("⚠️  WARNING: This will permanently delete lessons from the database!");
  console.log("   Press Ctrl+C to cancel, or wait 3 seconds to continue...\n");
  await new Promise((resolve) => setTimeout(resolve, 3000));

  // Delete lessons
  let deletedCount = 0;
  let errorCount = 0;
  const errors: Array<{ slug: string; error: string }> = [];

  for (const lesson of lessonsToDelete) {
    const { error: deleteError } = await supabase
      .from("courses_lessons")
      .delete()
      .eq("id", lesson.id);

    if (deleteError) {
      console.error(`❌ Failed to delete ${lesson.slug}: ${deleteError.message}`);
      errorCount++;
      errors.push({ slug: lesson.slug, error: deleteError.message });
    } else {
      deletedCount++;
      if (deletedCount % 10 === 0) {
        console.log(`   ✅ Deleted ${deletedCount}/${lessonsToDelete.length} lessons...`);
      }
    }
  }

  // Summary
  console.log("\n" + "=".repeat(80));
  console.log("📊 SUMMARY");
  console.log("=".repeat(80));
  console.log(`✅ Successfully deleted: ${deletedCount}`);
  console.log(`❌ Errors: ${errorCount}`);
  console.log(`📋 Remaining lessons: ${lessonsToKeep.length}`);

  if (errors.length > 0) {
    console.log(`\n❌ Errors encountered:`);
    errors.slice(0, 10).forEach(({ slug, error }) => {
      console.log(`   - ${slug}: ${error}`);
    });
    if (errors.length > 10) {
      console.log(`   ... and ${errors.length - 10} more errors`);
    }
  }

  console.log();
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
