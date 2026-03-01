#!/usr/bin/env tsx
/**
 * Apply migration to add course_id to courses_chapters and courses_topics
 * 
 * Usage:
 *   NEXT_PUBLIC_ENVIRONMENT=prod npx tsx scripts/apply-migration-add-course-id.ts
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";
import { readFileSync } from "fs";
import { getSupabaseUrl, getSupabaseServiceRoleKey } from "../src/lib/supabase/env";

config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  const useProd = process.env.NEXT_PUBLIC_ENVIRONMENT === "prod";
  
  if (!useProd) {
    console.error("❌ This script must be run with NEXT_PUBLIC_ENVIRONMENT=prod");
    process.exit(1);
  }

  console.log("🚀 PRODUCTION MODE - Applying migration\n");

  const supabaseUrl = getSupabaseUrl();
  const serviceRoleKey = getSupabaseServiceRoleKey();

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error("Missing Supabase credentials");
  }

  const supabase = createClient(supabaseUrl, serviceRoleKey);

  // Read migration file
  const migrationPath = resolve(process.cwd(), "supabase/migrations/20250121000000_add_course_id_to_chapters_topics.sql");
  const migrationSQL = readFileSync(migrationPath, "utf-8");

  console.log("📄 Migration file loaded\n");

  // Split SQL into individual statements
  const statements = migrationSQL
    .split(";")
    .map((s) => s.trim())
    .filter((s) => s.length > 0 && !s.startsWith("--"));

  console.log(`   Found ${statements.length} SQL statements\n`);

  // Execute each statement
  for (let i = 0; i < statements.length; i++) {
    const statement = statements[i];
    console.log(`   Executing statement ${i + 1}/${statements.length}...`);

    try {
      // Use RPC or direct SQL execution
      // Note: Supabase JS client doesn't support raw SQL directly
      // We'll need to use the REST API or execute via psql
      // For now, let's use the REST API with rpc
      
      // Actually, we can't execute arbitrary SQL via the JS client
      // We need to break it down into individual operations
      
      if (statement.includes("ADD COLUMN IF NOT EXISTS course_id")) {
        const tableName = statement.includes("courses_chapters") ? "courses_chapters" : "courses_topics";
        console.log(`      Adding course_id column to ${tableName}...`);
        // This will be handled by the migration file when applied via Supabase CLI
        console.log(`      ⚠️  Column addition requires direct SQL execution`);
      } else if (statement.includes("UPDATE")) {
        console.log(`      ⚠️  UPDATE statement requires direct SQL execution`);
      } else if (statement.includes("ADD CONSTRAINT")) {
        console.log(`      ⚠️  Constraint addition requires direct SQL execution`);
      } else if (statement.includes("CREATE INDEX")) {
        console.log(`      ⚠️  Index creation requires direct SQL execution`);
      }
    } catch (error: any) {
      console.error(`      ❌ Error: ${error.message}`);
    }
  }

  console.log("\n⚠️  Note: This migration requires direct SQL execution.");
  console.log("   Please apply it using one of these methods:\n");
  console.log("   1. Supabase CLI:");
  console.log("      supabase db push\n");
  console.log("   2. Supabase Dashboard:");
  console.log("      Go to SQL Editor and run the migration file\n");
  console.log("   3. Direct psql connection:");
  console.log("      psql <connection_string> < migration_file.sql\n");
}

main().catch((error) => {
  console.error("\n❌ Error:", error.message);
  if (error.stack) {
    console.error("\nStack trace:", error.stack);
  }
  process.exit(1);
});

