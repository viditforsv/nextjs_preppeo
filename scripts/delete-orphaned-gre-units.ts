#!/usr/bin/env tsx
/**
 * Delete orphaned GRE Quant units from production
 * 
 * Usage:
 *   NEXT_PUBLIC_ENVIRONMENT=prod npx tsx scripts/delete-orphaned-gre-units.ts
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";
import { getSupabaseUrl, getSupabaseServiceRoleKey } from "../src/lib/supabase/env";

config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  const useProd = process.env.NEXT_PUBLIC_ENVIRONMENT === "prod";
  
  if (!useProd) {
    console.error("❌ This script must be run with NEXT_PUBLIC_ENVIRONMENT=prod");
    process.exit(1);
  }

  console.log("🚀 PRODUCTION MODE - Deleting orphaned units\n");

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

  // Units to delete
  const orphanedUnitNames = [
    "Quantitative Reasoning Applications",
    "Data Analytics",
    "Arithmetic"
  ];

  // Get these units
  const { data: units } = await supabase
    .from("courses_units")
    .select("id, unit_name")
    .eq("course_id", course.id)
    .in("unit_name", orphanedUnitNames);

  if (!units || units.length === 0) {
    console.log("✅ No orphaned units found to delete");
    return;
  }

  console.log(`🗑️  Found ${units.length} orphaned unit(s) to delete:\n`);
  units.forEach((u) => console.log(`   - ${u.unit_name} (ID: ${u.id})`));
  console.log();

  // Get all chapters for these units
  const { data: chapters } = await supabase
    .from("courses_chapters")
    .select("id, chapter_name, unit_id")
    .in("unit_id", units.map((u) => u.id));

  // Get all topics for these chapters
  const { data: topics } = await supabase
    .from("courses_topics")
    .select("id, topic_name, chapter_id")
    .in("chapter_id", chapters?.map((c) => c.id) || []);

  // Get all lessons for these chapters
  const { data: lessons } = await supabase
    .from("courses_lessons")
    .select("id, title, chapter_id")
    .in("chapter_id", chapters?.map((c) => c.id) || []);

  console.log(`📊 Will delete:`);
  console.log(`   Units: ${units.length}`);
  console.log(`   Chapters: ${chapters?.length || 0}`);
  console.log(`   Topics: ${topics?.length || 0}`);
  console.log(`   Lessons: ${lessons?.length || 0}\n`);

  // Delete in order: lessons → topics → chapters → units
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

  if (chapters && chapters.length > 0) {
    console.log("🗑️  Deleting chapters...");
    const { error: chaptersError } = await supabase
      .from("courses_chapters")
      .delete()
      .in("id", chapters.map((c) => c.id));

    if (chaptersError) {
      throw new Error(`Failed to delete chapters: ${chaptersError.message}`);
    }
    console.log(`   ✅ Deleted ${chapters.length} chapters`);
  }

  console.log("🗑️  Deleting units...");
  const { error: unitsError } = await supabase
    .from("courses_units")
    .delete()
    .in("id", units.map((u) => u.id));

  if (unitsError) {
    throw new Error(`Failed to delete units: ${unitsError.message}`);
  }
  console.log(`   ✅ Deleted ${units.length} units\n`);

  console.log("=".repeat(60));
  console.log("✅ ORPHANED UNITS DELETED SUCCESSFULLY!");
  console.log("=".repeat(60));
}

main().catch((error) => {
  console.error("\n❌ Error:", error.message);
  if (error.stack) {
    console.error("\nStack trace:", error.stack);
  }
  process.exit(1);
});

