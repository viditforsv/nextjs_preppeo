#!/usr/bin/env tsx
/**
 * Update GRE Quant Units from Google Sheets master_map
 * 
 * Updates unit names, order, and descriptions based on master_map data
 * 
 * Usage:
 *   npx tsx scripts/update-gre-quant-units.ts [--dry-run]
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

function extractUnitsFromMasterMap(masterMapData: MasterMapRow[]) {
  const unitMap = new Map<string, number>();
  let order = 1;

  for (const row of masterMapData) {
    const unitName = row.Unit.trim();
    if (unitName && !unitMap.has(unitName)) {
      unitMap.set(unitName, order++);
    }
  }

  return Array.from(unitMap.entries()).map(([name, order]) => ({
    name,
    order,
  }));
}

async function updateUnits(
  supabase: any,
  courseId: string,
  units: Array<{ name: string; order: number }>,
  dryRun: boolean
) {
  console.log("\n📚 Updating units...\n");

  // Get existing units
  const { data: existingUnits } = await supabase
    .from("courses_units")
    .select("id, unit_name, unit_order")
    .eq("course_id", courseId)
    .order("unit_order");

  if (!existingUnits) {
    throw new Error("Failed to fetch existing units");
  }

  console.log(`   Found ${existingUnits.length} existing units in database`);
  console.log(`   Found ${units.length} units in master_map\n`);

  // Create a map of existing units by name
  const existingUnitsMap = new Map<string, typeof existingUnits[0]>();
  existingUnits.forEach((u) => {
    existingUnitsMap.set(u.unit_name, u);
  });

  let updated = 0;
  let created = 0;
  let unchanged = 0;

  for (const unit of units) {
    const existing = existingUnitsMap.get(unit.name);

    if (existing) {
      // Check if order needs updating
      if (existing.unit_order !== unit.order) {
        if (dryRun) {
          console.log(`   [DRY RUN] Would update unit: ${unit.name}`);
          console.log(`      Order: ${existing.unit_order} → ${unit.order}`);
        } else {
          const { error } = await supabase
            .from("courses_units")
            .update({ unit_order: unit.order })
            .eq("id", existing.id);

          if (error) {
            console.error(`   ❌ Failed to update unit "${unit.name}": ${error.message}`);
            continue;
          }
          console.log(`   ✅ Updated unit: ${unit.name} (order: ${existing.unit_order} → ${unit.order})`);
        }
        updated++;
      } else {
        if (!dryRun) {
          console.log(`   ✓ Unit already correct: ${unit.name} (order: ${unit.order})`);
        }
        unchanged++;
      }
    } else {
      // Unit doesn't exist, create it
      if (dryRun) {
        console.log(`   [DRY RUN] Would create unit: ${unit.name} (order: ${unit.order})`);
      } else {
        const { data: newUnit, error } = await supabase
          .from("courses_units")
          .insert({
            course_id: courseId,
            unit_name: unit.name,
            unit_order: unit.order,
            description: null,
            is_locked: false,
          })
          .select()
          .single();

        if (error) {
          console.error(`   ❌ Failed to create unit "${unit.name}": ${error.message}`);
          continue;
        }
        console.log(`   ✅ Created unit: ${unit.name} (order: ${unit.order})`);
      }
      created++;
    }
  }

  // Check for units that exist in DB but not in master_map
  const masterMapUnitNames = new Set(units.map((u) => u.name));
  const orphanedUnits = existingUnits.filter((u) => !masterMapUnitNames.has(u.unit_name));

  if (orphanedUnits.length > 0) {
    console.log(`\n   ⚠️  Found ${orphanedUnits.length} unit(s) in database not in master_map:`);
    orphanedUnits.forEach((u) => {
      console.log(`      - ${u.unit_name} (order: ${u.unit_order})`);
    });
    console.log(`   (These will not be deleted - manual cleanup may be needed)\n`);
  }

  console.log("\n📊 Summary:");
  console.log(`   Updated: ${updated}`);
  console.log(`   Created: ${created}`);
  console.log(`   Unchanged: ${unchanged}`);
  if (orphanedUnits.length > 0) {
    console.log(`   Orphaned (not in master_map): ${orphanedUnits.length}`);
  }
  console.log();
}

async function main() {
  const dryRun = process.argv.includes("--dry-run");
  const useProd = process.argv.includes("--prod") || process.env.NEXT_PUBLIC_ENVIRONMENT === "prod";

  if (dryRun) {
    console.log("🔍 DRY RUN MODE - No changes will be made\n");
  }

  if (useProd) {
    console.log("🚀 PRODUCTION MODE - Targeting production database\n");
    // Override environment to use prod credentials
    process.env.NEXT_PUBLIC_ENVIRONMENT = "prod";
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

  // Extract units
  const units = extractUnitsFromMasterMap(masterMapData);
  console.log("📋 Units from master_map:");
  units.forEach((u) => console.log(`   ${u.order}. ${u.name}`));
  console.log();

  // Update units
  await updateUnits(supabase, course.id, units, dryRun);

  console.log("=".repeat(60));
  if (dryRun) {
    console.log("✅ DRY RUN COMPLETE - No changes were made");
    console.log("   Run without --dry-run to apply changes");
  } else {
    console.log("✅ UNITS UPDATE COMPLETE!");
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

