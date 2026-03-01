#!/usr/bin/env tsx
/**
 * Update GRE Quant Lessons from Google Sheets master_map
 * 
 * Creates/updates lessons based on master_map and syncs PDF/solution URLs
 * 
 * Usage:
 *   NEXT_PUBLIC_ENVIRONMENT=prod npx tsx scripts/update-gre-quant-lessons.ts [--dry-run]
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";
import { readFileSync } from "fs";
import { getSupabaseUrl, getSupabaseServiceRoleKey } from "../src/lib/supabase/env";
import { google } from "googleapis";

config({ path: resolve(process.cwd(), ".env.local") });

interface MasterMapRow {
  "Sl. No.": string;
  "Lesson ID": string;
  "Unit": string;
  "Chapters": string;
  "Topics": string;
  "Status": string;
}

interface URLRow {
  slug: string;
  pdf_url: string;
  solution_url: string;
}

// Extract spreadsheet ID from URL
function extractSpreadsheetId(url: string): string {
  const match = url.match(/\/spreadsheets\/d\/([a-zA-Z0-9-_]+)/);
  if (!match) {
    throw new Error("Invalid Google Sheets URL");
  }
  return match[1];
}

async function authenticateGoogleSheets() {
  let credentials: any;

  if (process.env.GOOGLE_SERVICE_ACCOUNT_JSON) {
    credentials = JSON.parse(process.env.GOOGLE_SERVICE_ACCOUNT_JSON);
  } else if (process.env.GOOGLE_APPLICATION_CREDENTIALS) {
    credentials = JSON.parse(readFileSync(process.env.GOOGLE_APPLICATION_CREDENTIALS, "utf-8"));
  } else if (process.env.GOOGLE_SERVICE_ACCOUNT_KEY) {
    credentials = JSON.parse(readFileSync(process.env.GOOGLE_SERVICE_ACCOUNT_KEY, "utf-8"));
  } else {
    const defaultPath = resolve(process.cwd(), "google-service-account-key.json");
    credentials = JSON.parse(readFileSync(defaultPath, "utf-8"));
  }

  const auth = new google.auth.GoogleAuth({
    credentials,
    scopes: ["https://www.googleapis.com/auth/spreadsheets.readonly"],
  });

  return google.sheets({ version: "v4", auth });
}

async function readSheetData(sheets: any, spreadsheetId: string, sheetName: string) {
  const response = await sheets.spreadsheets.values.get({
    spreadsheetId,
    range: `'${sheetName}'!A:Z`,
  });

  const values = response.data.values || [];
  if (values.length === 0) return { headers: [], data: [] };

  const headers = values[0];
  const rows = values.slice(1).map((row: any[]) => {
    const obj: any = {};
    headers.forEach((header: string, index: number) => {
      obj[header] = row[index] || "";
    });
    return obj;
  });

  return { headers, data: rows };
}

async function main() {
  const dryRun = process.argv.includes("--dry-run");
  const useProd = process.env.NEXT_PUBLIC_ENVIRONMENT === "prod";

  if (dryRun) {
    console.log("🔍 DRY RUN MODE - No changes will be made\n");
  }

  if (useProd) {
    console.log("🚀 PRODUCTION MODE - Targeting production database\n");
  } else {
    console.log("🔧 DEV MODE - Targeting development database\n");
  }

  const supabaseUrl = getSupabaseUrl();
  const serviceRoleKey = getSupabaseServiceRoleKey();

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error("Missing Supabase credentials");
  }

  const supabase = createClient(supabaseUrl, serviceRoleKey);

  // Get GRE quant course
  const { data: course, error: courseError } = await supabase
    .from("courses")
    .select("id, title, slug")
    .eq("slug", "gre-quant")
    .single();

  if (courseError || !course) {
    throw new Error("GRE quant course not found. Please create it first.");
  }

  console.log(`📚 Course: ${course.title}`);
  console.log(`   ID: ${course.id}`);
  console.log(`   Slug: ${course.slug}\n`);

  // Read data from Google Sheets
  console.log("📖 Reading data from Google Sheets...\n");
  const sheets = await authenticateGoogleSheets();
  const spreadsheetId = extractSpreadsheetId(
    "https://docs.google.com/spreadsheets/d/1Xezvw0_BXHTzZxw6lh4_4A1ybktAiZTwBFkgwx6bk8k/edit"
  );

  // Read master_map
  console.log("   Reading master_map sheet...");
  const masterMapResult = await readSheetData(sheets, spreadsheetId, "master_map");
  const masterMapData = masterMapResult.data as MasterMapRow[];
  console.log(`   ✅ Found ${masterMapData.length} rows in master_map`);

  // Read gre_quant_URLs
  console.log("   Reading gre_quant_URLs sheet...");
  const urlsResult = await readSheetData(sheets, spreadsheetId, "gre_quant_URLs");
  const urlsData = urlsResult.data as URLRow[];

  // Create URL map (key by both slug formats)
  const urlMap = new Map<string, URLRow>();
  for (const row of urlsData) {
    urlMap.set(row.slug, row);
    urlMap.set(row.slug.replace(/-/g, "_"), row); // Also key by underscore format
    urlMap.set(row.slug.replace(/_/g, "-"), row); // Also key by hyphen format
  }
  console.log(`   ✅ Found ${urlsData.length} URL mappings\n`);

  // Get all units, chapters, and topics for mapping
  console.log("📋 Loading course structure...\n");
  const { data: units } = await supabase
    .from("courses_units")
    .select("id, unit_name")
    .eq("course_id", course.id);

  const { data: chapters } = await supabase
    .from("courses_chapters")
    .select("id, chapter_name, unit_id, courses_units!inner(unit_name)")
    .eq("course_id", course.id);

  const { data: topics } = await supabase
    .from("courses_topics")
    .select("id, topic_name, chapter_id, courses_chapters!inner(chapter_name, courses_units!inner(unit_name))")
    .eq("course_id", course.id);

  // Create lookup maps
  const unitMap = new Map<string, string>();
  units?.forEach((u) => unitMap.set(u.unit_name, u.id));

  const chapterMap = new Map<string, string>();
  chapters?.forEach((c) => {
    const unitName = (c.courses_units as any)?.unit_name;
    const key = `${unitName}::${c.chapter_name}`;
    chapterMap.set(key, c.id);
  });

  const topicMap = new Map<string, string>();
  topics?.forEach((t) => {
    const chapterData = (t.courses_chapters as any);
    const unitName = chapterData?.courses_units?.unit_name;
    const chapterName = chapterData?.chapter_name;
    const key = `${unitName}::${chapterName}::${t.topic_name}`;
    topicMap.set(key, t.id);
  });

  console.log(`   Units: ${units?.length || 0}`);
  console.log(`   Chapters: ${chapters?.length || 0}`);
  console.log(`   Topics: ${topics?.length || 0}\n`);

  // Process lessons
  console.log("📝 Processing lessons...\n");

  let created = 0;
  let updated = 0;
  let skipped = 0;
  const errors: Array<{ lessonId: string; error: string }> = [];

  for (const row of masterMapData) {
    const lessonId = row["Lesson ID"].trim();
    const unitName = row.Unit.trim();
    const chapterName = row.Chapters.trim();
    const topicName = row.Topics.trim();
    const lessonOrder = parseInt(row["Sl. No."]) || 0;
    const slug = lessonId.replace(/_/g, "-");

    // Get URLs
    const urlData = urlMap.get(lessonId) || urlMap.get(slug);

    // Find chapter and topic IDs
    const chapterKey = `${unitName}::${chapterName}`;
    const topicKey = `${chapterKey}::${topicName}`;

    const chapterId = chapterMap.get(chapterKey);
    const topicId = topicMap.get(topicKey);

    if (!chapterId) {
      console.log(`   ⚠️  Chapter not found: ${chapterKey} (Lesson: ${lessonId})`);
      skipped++;
      continue;
    }

    if (!topicId) {
      console.log(`   ⚠️  Topic not found: ${topicKey} (Lesson: ${lessonId})`);
      skipped++;
      continue;
    }

    // Check if lesson exists
    const { data: existingLesson } = await supabase
      .from("courses_lessons")
      .select("id, slug, title, pdf_url, solution_url")
      .eq("slug", slug)
      .single();

    // Generate title from lesson ID
    const title = lessonId
      .replace(/_/g, " ")
      .replace(/\b\w/g, (l) => l.toUpperCase());

    const lessonData = {
      course_id: course.id,
      chapter_id: chapterId,
      topic_id: topicId,
      title,
      slug,
      lesson_order: lessonOrder,
      pdf_url: urlData?.pdf_url || null,
      solution_url: urlData?.solution_url || null,
      is_preview: lessonOrder === 1,
    };

    if (existingLesson) {
      // Update existing lesson
      const needsUpdate =
        existingLesson.title !== title ||
        existingLesson.pdf_url !== lessonData.pdf_url ||
        existingLesson.solution_url !== lessonData.solution_url ||
        existingLesson.lesson_order !== lessonOrder;

      if (!needsUpdate) {
        if (!dryRun) {
          // Check if chapter_id or topic_id needs updating
          const { data: currentLesson } = await supabase
            .from("courses_lessons")
            .select("chapter_id, topic_id")
            .eq("id", existingLesson.id)
            .single();

          if (currentLesson?.chapter_id !== chapterId || currentLesson?.topic_id !== topicId) {
            if (dryRun) {
              console.log(`   [DRY RUN] Would update lesson: ${slug} (chapter/topic mapping)`);
            } else {
              const { error: updateError } = await supabase
                .from("courses_lessons")
                .update({
                  chapter_id: chapterId,
                  topic_id: topicId,
                })
                .eq("id", existingLesson.id);

              if (updateError) {
                console.error(`   ❌ Failed to update lesson ${slug}: ${updateError.message}`);
                errors.push({ lessonId, error: updateError.message });
                skipped++;
                continue;
              }
              updated++;
            }
          }
        }
        continue;
      }

      if (dryRun) {
        console.log(`   [DRY RUN] Would update lesson: ${slug}`);
      } else {
        const { error: updateError } = await supabase
          .from("courses_lessons")
          .update(lessonData)
          .eq("id", existingLesson.id);

        if (updateError) {
          console.error(`   ❌ Failed to update lesson ${slug}: ${updateError.message}`);
          errors.push({ lessonId, error: updateError.message });
          skipped++;
          continue;
        }
        updated++;
        if (updated % 10 === 0) {
          process.stdout.write(`   Updated ${updated}/${masterMapData.length}...\r`);
        }
      }
    } else {
      // Create new lesson
      if (dryRun) {
        console.log(`   [DRY RUN] Would create lesson: ${slug} - ${title}`);
      } else {
        const { error: createError } = await supabase
          .from("courses_lessons")
          .insert(lessonData);

        if (createError) {
          console.error(`   ❌ Failed to create lesson ${slug}: ${createError.message}`);
          errors.push({ lessonId, error: createError.message });
          skipped++;
          continue;
        }
        created++;
        if (created % 10 === 0) {
          process.stdout.write(`   Created ${created}/${masterMapData.length}...\r`);
        }
      }
    }
  }

  console.log("\n\n📊 Summary:");
  console.log(`   Created: ${created}`);
  console.log(`   Updated: ${updated}`);
  console.log(`   Skipped: ${skipped}`);

  if (errors.length > 0) {
    console.log(`   Errors: ${errors.length}`);
    console.log("\n❌ Errors encountered:");
    errors.slice(0, 10).forEach(({ lessonId, error }) => {
      console.log(`   - ${lessonId}: ${error}`);
    });
    if (errors.length > 10) {
      console.log(`   ... and ${errors.length - 10} more errors`);
    }
  }

  console.log("\n" + "=".repeat(60));
  if (dryRun) {
    console.log("✅ DRY RUN COMPLETE - No changes were made");
    console.log("   Run without --dry-run to apply changes");
  } else {
    console.log("✅ LESSONS UPDATE COMPLETE!");
  }
  console.log(`   Environment: ${useProd ? "PRODUCTION" : "DEVELOPMENT"}`);
  console.log("=".repeat(60));
}

main().catch((error) => {
  console.error("\n❌ Error:", error.message);
  if (error.stack) {
    console.error("\nStack trace:", error.stack);
  }
  process.exit(1);
});

