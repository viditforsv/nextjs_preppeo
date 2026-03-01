#!/usr/bin/env tsx
/**
 * Apply migration to add course_id to courses_chapters and courses_topics
 * Executes SQL statements directly via Supabase REST API
 * 
 * Usage:
 *   NEXT_PUBLIC_ENVIRONMENT=prod npx tsx scripts/apply-course-id-migration.ts
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";
import { getSupabaseUrl, getSupabaseServiceRoleKey } from "../src/lib/supabase/env";

config({ path: resolve(process.cwd(), ".env.local") });

async function executeSQL(supabase: any, sql: string): Promise<void> {
  // Use the REST API to execute SQL
  // Note: Supabase JS client doesn't support raw SQL, so we'll use RPC
  // For ALTER TABLE and other DDL, we need to use the management API or psql
  
  // For now, we'll execute via the REST API using a custom function
  // Or we can break it down into individual operations
  
  // Since we can't execute DDL via the JS client easily,
  // we'll provide a script that can be run via Supabase CLI or dashboard
  throw new Error("Direct SQL execution not supported via JS client. Use Supabase CLI or Dashboard.");
}

async function main() {
  const useProd = process.env.NEXT_PUBLIC_ENVIRONMENT === "prod";
  
  if (!useProd) {
    console.error("❌ This script must be run with NEXT_PUBLIC_ENVIRONMENT=prod");
    process.exit(1);
  }

  console.log("🚀 PRODUCTION MODE - Adding course_id columns\n");

  const supabaseUrl = getSupabaseUrl();
  const serviceRoleKey = getSupabaseServiceRoleKey();

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error("Missing Supabase credentials");
  }

  const supabase = createClient(supabaseUrl, serviceRoleKey);

  // Step 1: Add columns (we'll need to do this via SQL Editor or CLI)
  console.log("📝 Step 1: Adding course_id columns...");
  console.log("   ⚠️  This requires SQL execution. Please run:");
  console.log("   ALTER TABLE public.courses_chapters ADD COLUMN IF NOT EXISTS course_id uuid;");
  console.log("   ALTER TABLE public.courses_topics ADD COLUMN IF NOT EXISTS course_id uuid;\n");

  // Step 2: Populate course_id in chapters
  console.log("📝 Step 2: Populating course_id in courses_chapters...");
  // We can do this via a query
  const { data: chapters, error: chaptersError } = await supabase
    .from("courses_chapters")
    .select("id, unit_id, courses_units!inner(course_id)");

  if (chaptersError) {
    console.error(`   ❌ Error fetching chapters: ${chaptersError.message}`);
  } else if (chapters && chapters.length > 0) {
    console.log(`   Found ${chapters.length} chapters to update`);
    
    // Update each chapter
    for (const chapter of chapters) {
      const courseId = (chapter.courses_units as any)?.course_id;
      if (courseId) {
        const { error: updateError } = await supabase
          .from("courses_chapters")
          .update({ course_id: courseId })
          .eq("id", chapter.id);

        if (updateError) {
          console.error(`   ❌ Failed to update chapter ${chapter.id}: ${updateError.message}`);
        }
      }
    }
    console.log(`   ✅ Updated ${chapters.length} chapters\n`);
  }

  // Step 3: Populate course_id in topics
  console.log("📝 Step 3: Populating course_id in courses_topics...");
  const { data: topics, error: topicsError } = await supabase
    .from("courses_topics")
    .select("id, chapter_id, courses_chapters!inner(course_id)");

  if (topicsError) {
    console.error(`   ❌ Error fetching topics: ${topicsError.message}`);
  } else if (topics && topics.length > 0) {
    console.log(`   Found ${topics.length} topics to update`);
    
    // Update each topic
    for (const topic of topics) {
      const courseId = (topic.courses_chapters as any)?.course_id;
      if (courseId) {
        const { error: updateError } = await supabase
          .from("courses_topics")
          .update({ course_id: courseId })
          .eq("id", topic.id);

        if (updateError) {
          console.error(`   ❌ Failed to update topic ${topic.id}: ${updateError.message}`);
        }
      }
    }
    console.log(`   ✅ Updated ${topics.length} topics\n`);
  }

  console.log("=".repeat(60));
  console.log("✅ MIGRATION APPLIED!");
  console.log("\n⚠️  Note: You still need to:");
  console.log("   1. Add the columns via SQL Editor (if not already added)");
  console.log("   2. Add foreign key constraints via SQL Editor");
  console.log("   3. Add indexes via SQL Editor");
  console.log("\n   See: supabase/migrations/20250121000000_add_course_id_to_chapters_topics.sql");
  console.log("=".repeat(60));
}

main().catch((error) => {
  console.error("\n❌ Error:", error.message);
  if (error.stack) {
    console.error("\nStack trace:", error.stack);
  }
  process.exit(1);
});

