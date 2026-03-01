#!/usr/bin/env tsx
/**
 * Check GRE course template details in production
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

  // Find GRE course - could be "GRE", "GRE Mathematics", "GRE Quant", etc.
  const { data: greCourses, error } = await supabase
    .from("courses")
    .select("id, title, slug, template_id, curriculum, subject")
    .or("title.ilike.%GRE%,slug.ilike.%gre%")
    .order("created_at", { ascending: false });

  if (error) {
    console.error(`❌ Error: ${error.message}`);
    process.exit(1);
  }

  if (!greCourses || greCourses.length === 0) {
    console.error("❌ No GRE courses found");
    process.exit(1);
  }

  console.log("📋 GRE Courses Found:\n");
  greCourses.forEach((course) => {
    console.log(`Title: ${course.title}`);
    console.log(`Slug: ${course.slug}`);
    console.log(`Template ID: ${course.template_id || "null"}`);
    console.log(`Curriculum: ${course.curriculum}`);
    console.log(`Subject: ${course.subject}`);
    console.log("---\n");
  });

  // If we found a GRE course with a template, show template details
  const greWithTemplate = greCourses.find((c) => c.template_id);
  if (greWithTemplate) {
    const { data: template, error: templateError } = await supabase
      .from("courses_templates")
      .select("*")
      .eq("id", greWithTemplate.template_id)
      .single();

    if (!templateError && template) {
      console.log("📄 Template Details:\n");
      console.log(JSON.stringify(template, null, 2));
    }
  }
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
