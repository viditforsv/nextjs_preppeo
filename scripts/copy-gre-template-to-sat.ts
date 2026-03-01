#!/usr/bin/env tsx
/**
 * Copy GRE course template_data to SAT Quant course
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

  console.log("📋 Fetching GRE course template_data...\n");

  // Get GRE course template_data
  const { data: greCourse, error: greError } = await supabase
    .from("courses")
    .select("template_data, template_id")
    .eq("slug", "gre-quant")
    .single();

  if (greError || !greCourse) {
    console.error(`❌ Error fetching GRE course: ${greError?.message || "Not found"}`);
    process.exit(1);
  }

  console.log("✅ Found GRE course template_data");
  console.log(`   Template ID: ${greCourse.template_id || "null"}`);
  console.log(`   Has template_data: ${!!greCourse.template_data}\n`);

  // Get SAT Quant course
  console.log("📋 Fetching SAT Quant course...\n");

  const { data: satCourse, error: satError } = await supabase
    .from("courses")
    .select("id, title, slug, template_data, template_id")
    .eq("slug", "sat-quant")
    .single();

  if (satError || !satCourse) {
    console.error(`❌ Error fetching SAT Quant course: ${satError?.message || "Not found"}`);
    process.exit(1);
  }

  console.log(`✅ Found SAT Quant course: ${satCourse.title}`);
  console.log(`   Current Template ID: ${satCourse.template_id || "null"}\n`);

  // Update SAT Quant course with GRE template_data and template_id
  console.log("🔄 Updating SAT Quant course with GRE template...\n");

  const { data: updatedCourse, error: updateError } = await supabase
    .from("courses")
    .update({
      template_id: greCourse.template_id,
      template_data: greCourse.template_data,
      updated_at: new Date().toISOString(),
    })
    .eq("id", satCourse.id)
    .select()
    .single();

  if (updateError) {
    console.error(`❌ Error updating course: ${updateError.message}`);
    process.exit(1);
  }

  console.log("✅ Successfully updated SAT Quant course!");
  console.log(`\n📋 Updated Course Details:`);
  console.log(`   ID: ${updatedCourse.id}`);
  console.log(`   Title: ${updatedCourse.title}`);
  console.log(`   Template ID: ${updatedCourse.template_id || "null"}`);
  console.log(`   Has template_data: ${!!updatedCourse.template_data}`);
  
  if (updatedCourse.template_data && typeof updatedCourse.template_data === 'object') {
    const templateData = updatedCourse.template_data as any;
    if (templateData.units && Array.isArray(templateData.units)) {
      console.log(`   Units: ${templateData.units.length}`);
    }
    if (templateData.tags && Array.isArray(templateData.tags)) {
      console.log(`   Tags: ${templateData.tags.length}`);
    }
  }
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
