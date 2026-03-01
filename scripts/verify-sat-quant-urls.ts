#!/usr/bin/env tsx
/**
 * Verify SAT Quant lesson URLs
 */

import { config } from "dotenv";
import { resolve } from "path";
import { createClient } from "@supabase/supabase-js";

config({ path: resolve(process.cwd(), ".env.local") });

async function main() {
  process.env.NEXT_PUBLIC_ENVIRONMENT = "prod";
  const prodUrl = process.env.NEXT_PUBLIC_SUPABASE_URL_PROD;
  const prodServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY_PROD;

  if (!prodUrl || !prodServiceKey) {
    console.error("❌ Missing credentials");
    process.exit(1);
  }

  const supabase = createClient(prodUrl, prodServiceKey);

  const { data: course } = await supabase
    .from("courses")
    .select("id")
    .eq("slug", "sat-quant")
    .single();

  const { data: lessons } = await supabase
    .from("courses_lessons")
    .select("slug, title, pdf_url, solution_url")
    .eq("course_id", course.id)
    .in("slug", ["sat-lid-001", "sat-lid-025", "sat-lid-052"])
    .order("slug");

  console.log("\n✅ Sample Lesson URLs:\n");
  lessons.forEach((l) => {
    console.log(`${l.slug} - ${l.title}`);
    console.log(`  PDF: ${l.pdf_url}`);
    console.log(`  Solution: ${l.solution_url}\n`);
  });

  // Count lessons with URLs
  const { count: withUrls } = await supabase
    .from("courses_lessons")
    .select("*", { count: "exact", head: true })
    .eq("course_id", course.id)
    .not("pdf_url", "is", null);

  console.log(`📊 Lessons with PDF URLs: ${withUrls} / 192`);
}

main().catch(console.error);
