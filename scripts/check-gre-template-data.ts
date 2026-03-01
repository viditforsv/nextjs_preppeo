#!/usr/bin/env tsx
/**
 * Check GRE course template_data and available templates
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

  // Get GRE course with template_data
  const { data: greCourse, error } = await supabase
    .from("courses")
    .select("id, title, slug, template_id, template_data")
    .eq("slug", "gre-quant")
    .single();

  if (error) {
    console.error(`❌ Error: ${error.message}`);
    process.exit(1);
  }

  if (!greCourse) {
    console.error("❌ GRE course not found");
    process.exit(1);
  }

  console.log("📋 GRE Course Template Info:\n");
  console.log(`Title: ${greCourse.title}`);
  console.log(`Template ID: ${greCourse.template_id || "null"}`);
  console.log(`Template Data:`, JSON.stringify(greCourse.template_data, null, 2));

  // Check available templates
  console.log("\n\n📄 Available Course Templates:\n");
  const { data: templates, error: templateError } = await supabase
    .from("courses_templates")
    .select("*")
    .order("created_at", { ascending: false });

  if (templateError) {
    console.error(`❌ Error fetching templates: ${templateError.message}`);
  } else if (templates && templates.length > 0) {
    templates.forEach((template) => {
      console.log(`Name: ${template.name}`);
      console.log(`Slug: ${template.slug}`);
      console.log(`ID: ${template.id}`);
      console.log(`Curriculum: ${template.curriculum}`);
      console.log(`Subject: ${template.subject}`);
      console.log("---\n");
    });
  } else {
    console.log("No templates found in database");
  }
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
