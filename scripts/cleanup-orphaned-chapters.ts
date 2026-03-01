#!/usr/bin/env tsx
/**
 * Delete orphaned chapters that are not in master_map
 * 
 * Usage:
 *   NEXT_PUBLIC_ENVIRONMENT=prod npx tsx scripts/cleanup-orphaned-chapters.ts [--dry-run]
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
  const { data: course } = await supabase
    .from("courses")
    .select("id, title")
    .eq("slug", "gre-quant")
    .single();

  if (!course) {
    throw new Error("GRE quant course not found");
  }

  console.log(`📚 Course: ${course.title}`);
  console.log(`   ID: ${course.id}\n`);

  // Read master_map from Google Sheets
  console.log("📖 Reading master_map from Google Sheets...\n");
  const sheets = await authenticateGoogleSheets();
  const spreadsheetId = extractSpreadsheetId(
    "https://docs.google.com/spreadsheets/d/1Xezvw0_BXHTzZxw6lh4_4A1ybktAiZTwBFkgwx6bk8k/edit"
  );

  const masterMapResult = await readSheetData(sheets, spreadsheetId, "master_map");
  const masterMapData = masterMapResult.data as MasterMapRow[];

  // Get unique chapters from master_map
  const validChapters = new Set<string>();
  masterMapData.forEach((row) => {
    const chapter = row.Chapters.trim();
    if (chapter) {
      validChapters.add(chapter);
    }
  });

  console.log(`   ✅ Found ${validChapters.size} unique chapters in master_map\n`);

  // Get all chapters for this course
  const { data: allChapters } = await supabase
    .from("courses_chapters")
    .select("id, chapter_name, chapter_order, unit_id, courses_units!inner(unit_name)")
    .eq("course_id", course.id)
    .order("chapter_order");

  if (!allChapters) {
    throw new Error("Failed to fetch chapters");
  }

  console.log(`📋 Found ${allChapters.length} chapters in database\n`);

  // Find orphaned chapters
  const orphanedChapters = allChapters.filter(
    (ch) => !validChapters.has(ch.chapter_name)
  );

  if (orphanedChapters.length === 0) {
    console.log("✅ No orphaned chapters found. All chapters match master_map.\n");
    return;
  }

  console.log(`🗑️  Found ${orphanedChapters.length} orphaned chapter(s) to delete:\n`);
  orphanedChapters.forEach((ch) => {
    console.log(`   - ${ch.chapter_name} (Unit: ${(ch.courses_units as any)?.unit_name})`);
  });
  console.log();

  // Get topics and lessons for these chapters
  const { data: topics } = await supabase
    .from("courses_topics")
    .select("id, topic_name, chapter_id")
    .in("chapter_id", orphanedChapters.map((c) => c.id));

  const { data: lessons } = await supabase
    .from("courses_lessons")
    .select("id, title, chapter_id")
    .in("chapter_id", orphanedChapters.map((c) => c.id));

  console.log(`📊 Will delete:`);
  console.log(`   Chapters: ${orphanedChapters.length}`);
  console.log(`   Topics: ${topics?.length || 0}`);
  console.log(`   Lessons: ${lessons?.length || 0}\n`);

  if (dryRun) {
    console.log("   [DRY RUN] Would delete the above items\n");
    return;
  }

  // Delete in order: lessons → topics → chapters
  if (lessons && lessons.length > 0) {
    console.log("🗑️  Deleting lessons...");
    const { error: lessonsError } = await supabase
      .from("courses_lessons")
      .delete()
      .in("id", lessons.map((l) => l.id));

    if (lessonsError) {
      throw new Error(`Failed to delete lessons: ${lessonsError.message}`);
    }
    console.log(`   ✅ Deleted ${lessons.length} lessons`);
  }

  if (topics && topics.length > 0) {
    console.log("🗑️  Deleting topics...");
    const { error: topicsError } = await supabase
      .from("courses_topics")
      .delete()
      .in("id", topics.map((t) => t.id));

    if (topicsError) {
      throw new Error(`Failed to delete topics: ${topicsError.message}`);
    }
    console.log(`   ✅ Deleted ${topics.length} topics`);
  }

  console.log("🗑️  Deleting chapters...");
  const { error: chaptersError } = await supabase
    .from("courses_chapters")
    .delete()
    .in("id", orphanedChapters.map((c) => c.id));

  if (chaptersError) {
    throw new Error(`Failed to delete chapters: ${chaptersError.message}`);
  }
  console.log(`   ✅ Deleted ${orphanedChapters.length} chapters\n`);

  console.log("=".repeat(60));
  console.log("✅ ORPHANED CHAPTERS DELETED SUCCESSFULLY!");
  console.log("=".repeat(60));
}

main().catch((error) => {
  console.error("\n❌ Error:", error.message);
  if (error.stack) {
    console.error("\nStack trace:", error.stack);
  }
  process.exit(1);
});

