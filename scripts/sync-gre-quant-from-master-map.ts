#!/usr/bin/env tsx
/**
 * Sync GRE Quant Course from Google Sheets master_map
 * 
 * This script:
 * 1. Reads master_map and gre_quant_URLs from Google Sheets
 * 2. Deletes existing GRE quant course structure (units, chapters, topics, lessons)
 * 3. Recreates structure from master_map
 * 4. Updates lessons with PDF and solution URLs
 * 
 * Usage:
 *   npx tsx scripts/sync-gre-quant-from-master-map.ts [--dry-run]
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";
import { readFileSync, writeFileSync } from "fs";
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

interface UnitData {
  name: string;
  order: number;
  chapters: Map<string, ChapterData>;
}

interface ChapterData {
  name: string;
  order: number;
  topics: Map<string, TopicData>;
}

interface TopicData {
  name: string;
  order: number;
  lessons: LessonData[];
}

interface LessonData {
  lessonId: string;
  slug: string;
  order: number;
  pdf_url?: string;
  solution_url?: string;
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

async function deleteExistingStructure(supabase: any, courseId: string, dryRun: boolean) {
  console.log("\n🗑️  Deleting existing GRE quant structure...\n");

  // Get all units for this course
  const { data: units } = await supabase
    .from("courses_units")
    .select("id")
    .eq("course_id", courseId);

  // Count existing data
  const { count: lessonsCount } = await supabase
    .from("courses_lessons")
    .select("*", { count: "exact", head: true })
    .eq("course_id", courseId);

  const { count: chaptersCount } = await supabase
    .from("courses_chapters")
    .select("*", { count: "exact", head: true })
    .in("unit_id", units?.map((u) => u.id) || []);

  const { count: topicsCount } = await supabase
    .from("courses_topics")
    .select("*", { count: "exact", head: true })
    .in("chapter_id", []); // Will update after getting chapters

  console.log(`   Found: ${units?.length || 0} units, ${chaptersCount || 0} chapters, ${topicsCount || 0} topics, ${lessonsCount || 0} lessons`);

  if (dryRun) {
    console.log("   [DRY RUN] Would delete all lessons, topics, chapters, and units\n");
    return;
  }

  // Delete lessons first (they reference topics and chapters)
  const { error: lessonsError } = await supabase
    .from("courses_lessons")
    .delete()
    .eq("course_id", courseId);

  if (lessonsError) {
    throw new Error(`Failed to delete lessons: ${lessonsError.message}`);
  }
  console.log(`   ✅ Deleted ${lessonsCount || 0} lessons`);

  // Get all chapters for topics deletion
  const { data: chapters } = await supabase
    .from("courses_chapters")
    .select("id")
    .in("unit_id", units?.map((u) => u.id) || []);

  // Delete topics (they reference chapters)
  if (chapters && chapters.length > 0) {
    const { error: topicsError } = await supabase
      .from("courses_topics")
      .delete()
      .in("chapter_id", chapters.map((c) => c.id));

    if (topicsError) {
      throw new Error(`Failed to delete topics: ${topicsError.message}`);
    }
    console.log(`   ✅ Deleted topics`);
  }

  // Delete chapters (they reference units)
  if (chapters && chapters.length > 0) {
    const { error: chaptersError } = await supabase
      .from("courses_chapters")
      .delete()
      .in("id", chapters.map((c) => c.id));

    if (chaptersError) {
      throw new Error(`Failed to delete chapters: ${chaptersError.message}`);
    }
    console.log(`   ✅ Deleted ${chapters.length} chapters`);
  }

  // Finally delete units
  if (units && units.length > 0) {
    const { error: unitsError } = await supabase
      .from("courses_units")
      .delete()
      .in("id", units.map((u) => u.id));

    if (unitsError) {
      throw new Error(`Failed to delete units: ${unitsError.message}`);
    }
    console.log(`   ✅ Deleted ${units.length} units\n`);
  }
}

function buildStructureFromMasterMap(masterMapData: MasterMapRow[], urlMap: Map<string, URLRow>) {
  const units = new Map<string, UnitData>();
  let unitOrder = 1;
  let chapterOrder = 1;
  let topicOrder = 1;

  for (const row of masterMapData) {
    const unitName = row.Unit.trim();
    const chapterName = row.Chapters.trim();
    const topicName = row.Topics.trim();
    const lessonId = row["Lesson ID"].trim();
    const lessonSlug = lessonId.replace(/_/g, "-");
    const lessonOrder = parseInt(row["Sl. No."]) || 0;

    // Get URLs if available
    const urlData = urlMap.get(lessonId) || urlMap.get(lessonSlug);

    // Get or create unit
    if (!units.has(unitName)) {
      units.set(unitName, {
        name: unitName,
        order: unitOrder++,
        chapters: new Map(),
      });
    }
    const unit = units.get(unitName)!;

    // Get or create chapter
    const chapterKey = `${unitName}::${chapterName}`;
    if (!unit.chapters.has(chapterKey)) {
      unit.chapters.set(chapterKey, {
        name: chapterName,
        order: chapterOrder++,
        topics: new Map(),
      });
    }
    const chapter = unit.chapters.get(chapterKey)!;

    // Get or create topic
    const topicKey = `${chapterKey}::${topicName}`;
    if (!chapter.topics.has(topicKey)) {
      chapter.topics.set(topicKey, {
        name: topicName,
        order: topicOrder++,
        lessons: [],
      });
    }
    const topic = chapter.topics.get(topicKey)!;

    // Add lesson
    topic.lessons.push({
      lessonId,
      slug: lessonSlug,
      order: lessonOrder,
      pdf_url: urlData?.pdf_url,
      solution_url: urlData?.solution_url,
    });
  }

  return units;
}

async function createStructure(
  supabase: any,
  courseId: string,
  units: Map<string, UnitData>,
  dryRun: boolean
) {
  console.log("📚 Creating course structure...\n");

  let createdUnits = 0;
  let createdChapters = 0;
  let createdTopics = 0;
  let createdLessons = 0;

  for (const [unitName, unitData] of Array.from(units.entries()).sort(
    (a, b) => a[1].order - b[1].order
  )) {
    console.log(`   Unit ${unitData.order}: ${unitName}`);

    if (dryRun) {
      console.log(`      [DRY RUN] Would create unit`);
      createdUnits++;
    } else {
      const { data: unit, error: unitError } = await supabase
        .from("courses_units")
        .insert({
          course_id: courseId,
          unit_name: unitName,
          unit_order: unitData.order,
          description: null,
          is_locked: false,
        })
        .select()
        .single();

      if (unitError) {
        console.error(`      ❌ Failed to create unit: ${unitError.message}`);
        continue;
      }
      createdUnits++;
      console.log(`      ✅ Created unit: ${unit.id}`);

      // Create chapters
      for (const [chapterKey, chapterData] of Array.from(unitData.chapters.entries()).sort(
        (a, b) => a[1].order - b[1].order
      )) {
        console.log(`         Chapter ${chapterData.order}: ${chapterData.name}`);

        if (dryRun) {
          console.log(`            [DRY RUN] Would create chapter`);
          createdChapters++;
        } else {
          const { data: chapter, error: chapterError } = await supabase
            .from("courses_chapters")
            .insert({
              unit_id: unit.id,
              chapter_name: chapterData.name,
              chapter_order: chapterData.order,
              description: null,
              is_locked: false,
            })
            .select()
            .single();

          if (chapterError) {
            console.error(`            ❌ Failed to create chapter: ${chapterError.message}`);
            continue;
          }
          createdChapters++;
          console.log(`            ✅ Created chapter: ${chapter.id}`);

          // Create topics
          for (const [topicKey, topicData] of Array.from(chapterData.topics.entries()).sort(
            (a, b) => a[1].order - b[1].order
          )) {
            console.log(`               Topic ${topicData.order}: ${topicData.name}`);

            if (dryRun) {
              console.log(`                  [DRY RUN] Would create topic with ${topicData.lessons.length} lessons`);
              createdTopics++;
              createdLessons += topicData.lessons.length;
            } else {
              const { data: topic, error: topicError } = await supabase
                .from("courses_topics")
                .insert({
                  chapter_id: chapter.id,
                  topic_name: topicData.name,
                  topic_order: topicData.order,
                  topic_number: String(topicData.order),
                })
                .select()
                .single();

              if (topicError) {
                console.error(`                  ❌ Failed to create topic: ${topicError.message}`);
                continue;
              }
              createdTopics++;
              console.log(`                  ✅ Created topic: ${topic.id}`);

              // Create lessons
              for (const lesson of topicData.lessons.sort((a, b) => a.order - b.order)) {
                if (dryRun) {
                  createdLessons++;
                } else {
                  const { error: lessonError } = await supabase
                    .from("courses_lessons")
                    .insert({
                      course_id: courseId,
                      chapter_id: chapter.id,
                      topic_id: topic.id,
                      title: lesson.lessonId.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase()),
                      slug: lesson.slug,
                      lesson_order: lesson.order,
                      pdf_url: lesson.pdf_url || null,
                      solution_url: lesson.solution_url || null,
                      is_preview: lesson.order === 1,
                    });

                  if (lessonError) {
                    console.error(`                     ❌ Failed to create lesson ${lesson.slug}: ${lessonError.message}`);
                    continue;
                  }
                  createdLessons++;
                }
              }
            }
          }
        }
      }
    }
  }

  console.log("\n📊 Summary:");
  console.log(`   Units: ${createdUnits}`);
  console.log(`   Chapters: ${createdChapters}`);
  console.log(`   Topics: ${createdTopics}`);
  console.log(`   Lessons: ${createdLessons}\n`);
}

async function main() {
  const dryRun = process.argv.includes("--dry-run");

  if (dryRun) {
    console.log("🔍 DRY RUN MODE - No changes will be made\n");
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
  }
  console.log(`   ✅ Found ${urlsData.length} URL mappings\n`);

  // Delete existing structure
  await deleteExistingStructure(supabase, course.id, dryRun);

  // Build structure from master_map
  console.log("🔨 Building structure from master_map...\n");
  const units = buildStructureFromMasterMap(masterMapData, urlMap);
  console.log(`   ✅ Built structure: ${units.size} units\n`);

  // Create structure
  await createStructure(supabase, course.id, units, dryRun);

  console.log("=".repeat(60));
  if (dryRun) {
    console.log("✅ DRY RUN COMPLETE - No changes were made");
    console.log("   Run without --dry-run to apply changes");
  } else {
    console.log("✅ SYNC COMPLETE!");
  }
  console.log("=".repeat(60));
}

main().catch((error) => {
  console.error("\n❌ Error:", error.message);
  if (error.stack) {
    console.error("\nStack trace:", error.stack);
  }
  process.exit(1);
});

