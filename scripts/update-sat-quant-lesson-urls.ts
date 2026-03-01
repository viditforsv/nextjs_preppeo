#!/usr/bin/env tsx
/**
 * Update SAT Quant lesson URLs from Google Sheet mapping
 * 
 * Pattern:
 * - PDF URL: https://shrividhyaclasses.b-cdn.net/sat_quant/html_for_pdfs/sat_lid_XXX.html
 * - Solution URL: https://shrividhyaclasses.b-cdn.net/sat_quant/html_for_pdfs/sat_lid_XXX_sol.html
 * 
 * Lessons: sat_lid_001 to sat_lid_052 (from master_map_quant sheet)
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

  console.log("📋 Updating SAT Quant lesson URLs...\n");
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
    console.error(`   Expected file: ${jsonPath}`);
    console.error(`   Run: npx tsx scripts/read-google-sheets.ts <SHEETS_URL>`);
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

  let successCount = 0;
  let errorCount = 0;
  let notFoundCount = 0;
  let alreadyUpToDateCount = 0;
  const errors: Array<{ lessonId: string; error: string }> = [];
  const notFoundSlugs: string[] = [];

  // Process each lesson from the sheet
  for (const row of sheetsData.data) {
    const lessonId = row["Lesson ID"].trim(); // e.g., "sat_lid_001"
    const lessonName = row["lesson_name"];

    if (!lessonId) {
      console.warn(`⚠️  Skipping row with missing Lesson ID`);
      continue;
    }

    // Generate URLs based on pattern
    const baseUrl = "https://shrividhyaclasses.b-cdn.net/sat_quant/html_for_pdfs";
    const pdfUrl = `${baseUrl}/${lessonId}.html`;
    const solutionUrl = `${baseUrl}/${lessonId}_sol.html`;

    // Convert lesson ID to slug format (sat_lid_001 -> sat-lid-001)
    const slug = lessonId.replace(/_/g, "-");

    // Find lesson by slug
    const { data: lesson, error: fetchError } = await supabase
      .from("courses_lessons")
      .select("id, slug, title, pdf_url, solution_url")
      .eq("course_id", course.id)
      .eq("slug", slug)
      .single();

    if (fetchError || !lesson) {
      console.log(`❌ Lesson not found: ${slug} (${lessonId})`);
      notFoundCount++;
      notFoundSlugs.push(slug);
      continue;
    }

    // Check if update is needed
    const needsUpdate =
      lesson.pdf_url !== pdfUrl || lesson.solution_url !== solutionUrl;

    if (!needsUpdate) {
      if (!dryRun) {
        console.log(`✓ ${slug} - Already up to date`);
        alreadyUpToDateCount++;
      } else {
        console.log(`[DRY RUN] ${slug} - Already up to date`);
      }
      successCount++;
      continue;
    }

    if (dryRun) {
      console.log(`[DRY RUN] Would update: ${slug} - ${lessonName}`);
      console.log(`  Current pdf_url: ${lesson.pdf_url || "(empty)"}`);
      console.log(`  New pdf_url: ${pdfUrl}`);
      console.log(`  Current solution_url: ${lesson.solution_url || "(empty)"}`);
      console.log(`  New solution_url: ${solutionUrl}\n`);
      successCount++;
      continue;
    }

    // Update lesson
    const { error: updateError } = await supabase
      .from("courses_lessons")
      .update({
        pdf_url: pdfUrl,
        solution_url: solutionUrl,
      })
      .eq("id", lesson.id);

    if (updateError) {
      console.error(`❌ Failed to update ${slug}: ${updateError.message}`);
      errorCount++;
      errors.push({ lessonId: slug, error: updateError.message });
    } else {
      console.log(`✅ Updated: ${slug} - ${lessonName || lesson.title}`);
      successCount++;
    }
  }

  // Summary
  console.log("\n" + "=".repeat(80));
  console.log("📊 SUMMARY");
  console.log("=".repeat(80));
  console.log(`✅ Successfully ${dryRun ? "verified" : "updated"}: ${successCount}`);
  if (!dryRun && alreadyUpToDateCount > 0) {
    console.log(`✓ Already up to date: ${alreadyUpToDateCount}`);
  }
  console.log(`❌ Not found: ${notFoundCount}`);
  console.log(`⚠️  Errors: ${errorCount}`);

  if (notFoundSlugs.length > 0) {
    console.log(`\n⚠️  Lessons not found in database:`);
    notFoundSlugs.slice(0, 10).forEach((slug) => console.log(`   - ${slug}`));
    if (notFoundSlugs.length > 10) {
      console.log(`   ... and ${notFoundSlugs.length - 10} more`);
    }
  }

  if (errors.length > 0) {
    console.log(`\n❌ Errors encountered:`);
    errors.slice(0, 10).forEach(({ lessonId, error }) => {
      console.log(`   - ${lessonId}: ${error}`);
    });
    if (errors.length > 10) {
      console.log(`   ... and ${errors.length - 10} more errors`);
    }
  }

  if (dryRun) {
    console.log(`\n💡 Run without --dry-run to apply changes`);
  }

  console.log();
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
