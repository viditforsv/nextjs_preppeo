#!/usr/bin/env tsx
/**
 * Create SAT Quant course in production database
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";

// Load environment variables from .env.local
config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  // Force production environment
  process.env.NEXT_PUBLIC_ENVIRONMENT = "prod";

  // Get production credentials
  const prodUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
  const prodServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;

  if (!prodUrl || !prodServiceKey) {
    console.error("❌ Missing production Supabase credentials!");
    console.error("   Required: NEXT_PUBLIC_SUPABASE_URL_PROD and SUPABASE_SERVICE_ROLE_KEY_PROD");
    process.exit(1);
  }

  console.log("🔧 Connecting to PRODUCTION database...");
  console.log(`   URL: ${prodUrl.substring(0, 30)}...\n`);

  const supabase = createClient(prodUrl, prodServiceKey);

  // Check if course already exists
  const { data: existingCourse } = await supabase
    .from("courses")
    .select("id, title, slug")
    .eq("slug", "sat-quant")
    .single();

  if (existingCourse) {
    console.log(`⚠️  Course "SAT Quant" already exists!`);
    console.log(`   ID: ${existingCourse.id}`);
    console.log(`   Title: ${existingCourse.title}`);
    console.log(`   Slug: ${existingCourse.slug}`);
    process.exit(0);
  }

  // Course data
  const courseData = {
    title: "SAT Quant",
    slug: "sat-quant",
    description: "Complete SAT Quantitative Reasoning preparation course",
    curriculum: "SAT",
    subject: "Mathematics",
    grade: null,
    level: "advanced",
    price: 0,
    validity_days: 365,
    status: "draft" as const,
    template_data: {},
  };

  console.log("📝 Creating course...");
  console.log(`   Title: ${courseData.title}`);
  console.log(`   Slug: ${courseData.slug}`);
  console.log(`   Status: ${courseData.status}\n`);

  const { data: course, error } = await supabase
    .from("courses")
    .insert(courseData)
    .select()
    .single();

  if (error) {
    console.error(`❌ Failed to create course: ${error.message}`);
    process.exit(1);
  }

  console.log("✅ Course created successfully!");
  console.log(`\n📋 Course Details:`);
  console.log(`   ID: ${course.id}`);
  console.log(`   Title: ${course.title}`);
  console.log(`   Slug: ${course.slug}`);
  console.log(`   Status: ${course.status}`);
  console.log(`   Curriculum: ${course.curriculum}`);
  console.log(`   Subject: ${course.subject}`);
}

main().catch((error) => {
  console.error("\n❌ Fatal error:", error instanceof Error ? error.message : error);
  process.exit(1);
});
