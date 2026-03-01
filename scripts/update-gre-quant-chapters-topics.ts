#!/usr/bin/env tsx
/**
 * Update GRE Quant Chapters and Topics from Google Sheets master_map
 * 
 * Updates chapter and topic structure based on master_map data
 * 
 * Usage:
 *   NEXT_PUBLIC_ENVIRONMENT=prod npx tsx scripts/update-gre-quant-chapters-topics.ts [--dry-run]
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

interface UnitData {
  id: string;
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

function buildStructureFromMasterMap(masterMapData: MasterMapRow[]): Map<string, UnitData> {
  const units = new Map<string, UnitData>();
  const unitOrderMap = new Map<string, number>();
  const chapterOrderMap = new Map<string, number>();
  const topicOrderMap = new Map<string, number>();

  // First pass: collect all units, chapters, topics and determine orders
  for (const row of masterMapData) {
    const unitName = row.Unit.trim();
    const chapterName = row.Chapters.trim();
    const topicName = row.Topics.trim();

    if (!unitOrderMap.has(unitName)) {
      unitOrderMap.set(unitName, unitOrderMap.size + 1);
    }

    const chapterKey = `${unitName}::${chapterName}`;
    if (!chapterOrderMap.has(chapterKey)) {
      chapterOrderMap.set(chapterKey, chapterOrderMap.size + 1);
    }

    const topicKey = `${chapterKey}::${topicName}`;
    if (!topicOrderMap.has(topicKey)) {
      topicOrderMap.set(topicKey, topicOrderMap.size + 1);
    }
  }

  // Second pass: build structure
  for (const row of masterMapData) {
    const unitName = row.Unit.trim();
    const chapterName = row.Chapters.trim();
    const topicName = row.Topics.trim();

    // Get or create unit
    if (!units.has(unitName)) {
      units.set(unitName, {
        id: "", // Will be filled from database
        name: unitName,
        order: unitOrderMap.get(unitName)!,
        chapters: new Map(),
      });
    }
    const unit = units.get(unitName)!;

    // Get or create chapter
    const chapterKey = `${unitName}::${chapterName}`;
    if (!unit.chapters.has(chapterKey)) {
      unit.chapters.set(chapterKey, {
        name: chapterName,
        order: chapterOrderMap.get(chapterKey)!,
        topics: new Map(),
      });
    }
    const chapter = unit.chapters.get(chapterKey)!;

    // Get or create topic
    const topicKey = `${chapterKey}::${topicName}`;
    if (!chapter.topics.has(topicKey)) {
      chapter.topics.set(topicKey, {
        name: topicName,
        order: topicOrderMap.get(topicKey)!,
      });
    }
  }

  return units;
}

async function updateChaptersAndTopics(
  supabase: any,
  courseId: string,
  units: Map<string, UnitData>,
  dryRun: boolean
) {
  console.log("\n📚 Updating chapters and topics...\n");

  // Get all units for this course
  const { data: dbUnits } = await supabase
    .from("courses_units")
    .select("id, unit_name, unit_order")
    .eq("course_id", courseId)
    .order("unit_order");

  if (!dbUnits) {
    throw new Error("Failed to fetch units");
  }

  // Map unit names to IDs
  const unitNameToId = new Map<string, string>();
  dbUnits.forEach((u) => {
    unitNameToId.set(u.unit_name, u.id);
    // Also update the unit data with ID
    const unitData = units.get(u.unit_name);
    if (unitData) {
      unitData.id = u.id;
    }
  });

  let chaptersCreated = 0;
  let chaptersUpdated = 0;
  let chaptersUnchanged = 0;
  let topicsCreated = 0;
  let topicsUpdated = 0;
  let topicsUnchanged = 0;

  for (const [unitName, unitData] of Array.from(units.entries()).sort(
    (a, b) => a[1].order - b[1].order
  )) {
    const unitId = unitNameToId.get(unitName);
    if (!unitId) {
      console.log(`   ⚠️  Unit "${unitName}" not found in database, skipping`);
      continue;
    }

    console.log(`   Unit: ${unitName}`);

    // Get existing chapters for this unit
    const { data: existingChapters } = await supabase
      .from("courses_chapters")
      .select("id, chapter_name, chapter_order")
      .eq("unit_id", unitId)
      .order("chapter_order");

    const existingChaptersMap = new Map<string, typeof existingChapters[0]>();
    existingChapters?.forEach((c) => {
      existingChaptersMap.set(c.chapter_name, c);
    });

    // Process chapters
    for (const [chapterKey, chapterData] of Array.from(unitData.chapters.entries()).sort(
      (a, b) => a[1].order - b[1].order
    )) {
      const existingChapter = existingChaptersMap.get(chapterData.name);

      if (existingChapter) {
        // Update if order changed
        if (existingChapter.chapter_order !== chapterData.order) {
          if (dryRun) {
            console.log(`      [DRY RUN] Would update chapter: ${chapterData.name} (order: ${existingChapter.chapter_order} → ${chapterData.order})`);
          } else {
            const { error } = await supabase
              .from("courses_chapters")
              .update({ chapter_order: chapterData.order })
              .eq("id", existingChapter.id);

            if (error) {
              console.error(`      ❌ Failed to update chapter "${chapterData.name}": ${error.message}`);
              continue;
            }
            console.log(`      ✅ Updated chapter: ${chapterData.name} (order: ${existingChapter.chapter_order} → ${chapterData.order})`);
          }
          chaptersUpdated++;
        } else {
          if (!dryRun) {
            console.log(`      ✓ Chapter already correct: ${chapterData.name} (order: ${chapterData.order})`);
          }
          chaptersUnchanged++;
        }

        // Process topics for this chapter
        const chapterId = existingChapter.id;

        // Get existing topics
        const { data: existingTopics } = await supabase
          .from("courses_topics")
          .select("id, topic_name, topic_order")
          .eq("chapter_id", chapterId)
          .order("topic_order");

        const existingTopicsMap = new Map<string, typeof existingTopics[0]>();
        existingTopics?.forEach((t) => {
          existingTopicsMap.set(t.topic_name, t);
        });

        for (const [topicKey, topicData] of Array.from(chapterData.topics.entries()).sort(
          (a, b) => a[1].order - b[1].order
        )) {
          const existingTopic = existingTopicsMap.get(topicData.name);

          if (existingTopic) {
            // Update if order changed
            if (existingTopic.topic_order !== topicData.order) {
              if (dryRun) {
                console.log(`         [DRY RUN] Would update topic: ${topicData.name} (order: ${existingTopic.topic_order} → ${topicData.order})`);
              } else {
                const { error } = await supabase
                  .from("courses_topics")
                  .update({
                    topic_order: topicData.order,
                    topic_number: String(topicData.order),
                  })
                  .eq("id", existingTopic.id);

                if (error) {
                  console.error(`         ❌ Failed to update topic "${topicData.name}": ${error.message}`);
                  continue;
                }
                console.log(`         ✅ Updated topic: ${topicData.name} (order: ${existingTopic.topic_order} → ${topicData.order})`);
              }
              topicsUpdated++;
            } else {
              topicsUnchanged++;
            }
          } else {
            // Create new topic
            if (dryRun) {
              console.log(`         [DRY RUN] Would create topic: ${topicData.name} (order: ${topicData.order})`);
            } else {
              const { error } = await supabase
                .from("courses_topics")
                .insert({
                  chapter_id: chapterId,
                  topic_name: topicData.name,
                  topic_order: topicData.order,
                  topic_number: String(topicData.order),
                });

              if (error) {
                console.error(`         ❌ Failed to create topic "${topicData.name}": ${error.message}`);
                continue;
              }
              console.log(`         ✅ Created topic: ${topicData.name} (order: ${topicData.order})`);
            }
            topicsCreated++;
          }
        }
      } else {
        // Create new chapter
        if (dryRun) {
          console.log(`      [DRY RUN] Would create chapter: ${chapterData.name} (order: ${chapterData.order})`);
          chaptersCreated++;
        } else {
          const { data: newChapter, error } = await supabase
            .from("courses_chapters")
            .insert({
              unit_id: unitId,
              chapter_name: chapterData.name,
              chapter_order: chapterData.order,
              description: null,
              is_locked: false,
            })
            .select()
            .single();

          if (error) {
            console.error(`      ❌ Failed to create chapter "${chapterData.name}": ${error.message}`);
            continue;
          }
          console.log(`      ✅ Created chapter: ${chapterData.name} (order: ${chapterData.order})`);
          chaptersCreated++;

          // Create all topics for this new chapter
          for (const [topicKey, topicData] of Array.from(chapterData.topics.entries()).sort(
            (a, b) => a[1].order - b[1].order
          )) {
            if (dryRun) {
              console.log(`         [DRY RUN] Would create topic: ${topicData.name} (order: ${topicData.order})`);
            } else {
              const { error: topicError } = await supabase
                .from("courses_topics")
                .insert({
                  chapter_id: newChapter.id,
                  topic_name: topicData.name,
                  topic_order: topicData.order,
                  topic_number: String(topicData.order),
                });

              if (topicError) {
                console.error(`         ❌ Failed to create topic "${topicData.name}": ${topicError.message}`);
                continue;
              }
              console.log(`         ✅ Created topic: ${topicData.name} (order: ${topicData.order})`);
            }
            topicsCreated++;
          }
        }
      }
    }
  }

  console.log("\n📊 Summary:");
  console.log(`   Chapters:`);
  console.log(`      Created: ${chaptersCreated}`);
  console.log(`      Updated: ${chaptersUpdated}`);
  console.log(`      Unchanged: ${chaptersUnchanged}`);
  console.log(`   Topics:`);
  console.log(`      Created: ${topicsCreated}`);
  console.log(`      Updated: ${topicsUpdated}`);
  console.log(`      Unchanged: ${topicsUnchanged}`);
  console.log();
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

  // Read master_map from Google Sheets
  console.log("📖 Reading master_map from Google Sheets...\n");
  const sheets = await authenticateGoogleSheets();
  const spreadsheetId = extractSpreadsheetId(
    "https://docs.google.com/spreadsheets/d/1Xezvw0_BXHTzZxw6lh4_4A1ybktAiZTwBFkgwx6bk8k/edit"
  );

  const masterMapResult = await readSheetData(sheets, spreadsheetId, "master_map");
  const masterMapData = masterMapResult.data as MasterMapRow[];
  console.log(`   ✅ Found ${masterMapData.length} rows in master_map\n`);

  // Build structure
  console.log("🔨 Building structure from master_map...\n");
  const units = buildStructureFromMasterMap(masterMapData);
  console.log(`   ✅ Built structure: ${units.size} units\n`);

  // Update chapters and topics
  await updateChaptersAndTopics(supabase, course.id, units, dryRun);

  console.log("=".repeat(60));
  if (dryRun) {
    console.log("✅ DRY RUN COMPLETE - No changes were made");
    console.log("   Run without --dry-run to apply changes");
  } else {
    console.log("✅ CHAPTERS AND TOPICS UPDATE COMPLETE!");
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

