#!/usr/bin/env tsx
/**
 * Check SAT Quant course details in production
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";

// Load environment variables from .env.local
config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  // Get production credentials
  const prodUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
  const prodServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;

  if (!prodUrl || !prodServiceKey) {
    console.error("❌ Missing production Supabase credentials!");
    process.exit(1);
  }

  const supabase = createClient(prodUrl, prodServiceKey);

  const { data: course, error } = await supabase
    .from("courses")
    .select("*")
    .eq("slug", "sat-quant")
    .single();

  if (error) {
    console.error(`❌ Error: ${error.message}`);
    process.exit(1);
  }

  if (!course) {
    console.error("❌ Course not found");
    process.exit(1);
  }

  console.log("📋 SAT Quant Course Details:\n");
  console.log(JSON.stringify(course, null, 2));
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
