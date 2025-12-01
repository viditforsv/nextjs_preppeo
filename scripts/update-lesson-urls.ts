#!/usr/bin/env tsx
/**
 * Update lesson PDF and solution URLs from CSV file
 * 
 * Reads a CSV file with slug, pdf_url, and solution_url columns
 * and updates the corresponding lessons in the database.
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";
import { readFileSync } from "fs";
import { parse } from "csv-parse/sync";
import { getSupabaseUrl, getSupabaseServiceRoleKey } from "../src/lib/supabase/env";

config({ path: resolve(process.cwd(), ".env.local") });

interface CSVRow {
  slug: string;
  pdf_url: string;
  solution_url: string;
}

async function updateLessonUrls(csvFilePath: string, dryRun: boolean = false) {
  const supabaseUrl = getSupabaseUrl();
  const serviceRoleKey = getSupabaseServiceRoleKey();

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error(
      "Missing Supabase credentials. Set NEXT_PUBLIC_SUPABASE_URL_DEV/PROD and SUPABASE_SERVICE_ROLE_KEY_DEV/PROD"
    );
  }

  const supabase = createClient(supabaseUrl, serviceRoleKey);

  // Read and parse CSV file
  console.log(`\n📖 Reading CSV file: ${csvFilePath}\n`);
  const csvContent = readFileSync(csvFilePath, "utf-8");
  
  const records: CSVRow[] = parse(csvContent, {
    columns: true,
    skip_empty_lines: true,
    trim: true,
  });

  if (records.length === 0) {
    throw new Error("No records found in CSV file");
  }

  console.log(`📊 Found ${records.length} lesson(s) in CSV\n`);

  if (dryRun) {
    console.log("🔍 DRY RUN MODE - No changes will be made\n");
  }

  let successCount = 0;
  let notFoundCount = 0;
  let errorCount = 0;
  const notFoundSlugs: string[] = [];
  const errors: Array<{ slug: string; error: string }> = [];

  // Process each row
  for (const row of records) {
    const { slug, pdf_url, solution_url } = row;

    if (!slug) {
      console.warn(`⚠️  Skipping row with missing slug`);
      errorCount++;
      continue;
    }

    // Find lesson by slug
    const { data: lesson, error: fetchError } = await supabase
      .from("courses_lessons")
      .select("id, slug, title, pdf_url, solution_url")
      .eq("slug", slug)
      .single();

    if (fetchError || !lesson) {
      console.log(`❌ Lesson not found: ${slug}`);
      notFoundCount++;
      notFoundSlugs.push(slug);
      continue;
    }

    // Check if update is needed
    const needsUpdate = 
      lesson.pdf_url !== pdf_url || 
      lesson.solution_url !== solution_url;

    if (!needsUpdate && !dryRun) {
      console.log(`✓ ${slug} - Already up to date`);
      successCount++;
      continue;
    }

    if (dryRun) {
      console.log(`[DRY RUN] Would update: ${slug}`);
      console.log(`  Current pdf_url: ${lesson.pdf_url || "(empty)"}`);
      console.log(`  New pdf_url: ${pdf_url}`);
      console.log(`  Current solution_url: ${lesson.solution_url || "(empty)"}`);
      console.log(`  New solution_url: ${solution_url}\n`);
      successCount++;
      continue;
    }

    // Update lesson
    const { error: updateError } = await supabase
      .from("courses_lessons")
      .update({
        pdf_url: pdf_url || null,
        solution_url: solution_url || null,
      })
      .eq("id", lesson.id);

    if (updateError) {
      console.error(`❌ Failed to update ${slug}: ${updateError.message}`);
      errorCount++;
      errors.push({ slug, error: updateError.message });
    } else {
      console.log(`✅ Updated: ${slug} - ${lesson.title}`);
      successCount++;
    }
  }

  // Summary
  console.log("\n" + "=".repeat(60));
  console.log("📊 SUMMARY");
  console.log("=".repeat(60));
  console.log(`✅ Successfully ${dryRun ? "verified" : "updated"}: ${successCount}`);
  console.log(`❌ Not found: ${notFoundCount}`);
  console.log(`⚠️  Errors: ${errorCount}`);

  if (notFoundSlugs.length > 0) {
    console.log(`\n⚠️  Lessons not found in database:`);
    notFoundSlugs.forEach((slug) => console.log(`   - ${slug}`));
  }

  if (errors.length > 0) {
    console.log(`\n❌ Errors encountered:`);
    errors.forEach(({ slug, error }) => {
      console.log(`   - ${slug}: ${error}`);
    });
  }

  if (dryRun) {
    console.log(`\n💡 Run without --dry-run to apply changes`);
  }

  console.log();
}

// Main execution
async function main() {
  const args = process.argv.slice(2);

  if (args.length === 0 || args[0] === "--help" || args[0] === "-h") {
    console.log(`
Update Lesson URLs Script

Usage:
  npx tsx scripts/update-lesson-urls.ts <csv-file-path> [--dry-run]

Arguments:
  <csv-file-path>    Path to CSV file with columns: slug, pdf_url, solution_url
  --dry-run          Preview changes without applying them

Example:
  npx tsx scripts/update-lesson-urls.ts "Docs for me/master_map sheets/gre_quant.csv"
  npx tsx scripts/update-lesson-urls.ts "Docs for me/master_map sheets/gre_quant.csv" --dry-run
`);
    process.exit(0);
  }

  const csvFilePath = args[0];
  const dryRun = args.includes("--dry-run") || args.includes("-d");

  try {
    await updateLessonUrls(csvFilePath, dryRun);
  } catch (error) {
    console.error("\n❌ Error:", error instanceof Error ? error.message : error);
    process.exit(1);
  }
}

main();

