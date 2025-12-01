#!/usr/bin/env tsx
/**
 * Import CBSE Class 10 Maths Course Structure
 * 
 * Reads the master map CSV and creates/updates units, chapters, topics, and lessons
 * 
 * Usage:
 *   npx tsx scripts/import-cbse-maths-course.ts [course-slug]
 */

import { config } from "dotenv";
import { resolve } from "path";
import { readFileSync } from "fs";
import { parse } from "csv-parse/sync";
import { createClient } from "@supabase/supabase-js";
import {
  getSupabaseUrl,
  getSupabaseServiceRoleKey,
} from "../src/lib/supabase/env";

// Load environment variables
config({ path: resolve(process.cwd(), ".env.local") });

interface MasterMapRow {
  "Sl. No.": string;
  unit_name: string;
  chapter_name: string;
  topic_name: string;
  lesson_id: string;
  lesson_name: string;
  tags: string;
}

interface CourseStructure {
  unitName: string;
  unitOrder: number;
  chapters: Map<string, {
    chapterName: string;
    chapterOrder: number;
    topics: Map<string, {
      topicName: string;
      topicOrder: number;
      lessons: Array<{
        lessonId: string;
        lessonName: string;
        lessonOrder: number;
        tags: string;
      }>;
    }>;
  }>;
}

function parseMasterMap(csvPath: string): MasterMapRow[] {
  const csvContent = readFileSync(csvPath, "utf-8");
  const records = parse(csvContent, {
    columns: true,
    skip_empty_lines: true,
    trim: true,
  }) as MasterMapRow[];

  return records;
}

function buildCourseStructure(rows: MasterMapRow[]): CourseStructure[] {
  const unitsMap = new Map<string, CourseStructure>();
  let unitOrder = 1;
  let chapterOrderMap = new Map<string, number>();
  let topicOrderMap = new Map<string, number>();

  for (const row of rows) {
    const unitName = row.unit_name.trim();
    const chapterName = row.chapter_name.trim();
    const topicName = row.topic_name.trim();
    const lessonId = row.lesson_id.trim();
    const lessonName = row.lesson_name.trim();
    const tags = row.tags.trim();
    const lessonOrder = parseInt(row["Sl. No."]) || 0;

    // Get or create unit
    if (!unitsMap.has(unitName)) {
      unitsMap.set(unitName, {
        unitName,
        unitOrder: unitOrder++,
        chapters: new Map(),
      });
    }
    const unit = unitsMap.get(unitName)!;

    // Get or create chapter
    const chapterKey = `${unitName}::${chapterName}`;
    if (!unit.chapters.has(chapterKey)) {
      if (!chapterOrderMap.has(chapterKey)) {
        chapterOrderMap.set(chapterKey, chapterOrderMap.size + 1);
      }
      unit.chapters.set(chapterKey, {
        chapterName,
        chapterOrder: chapterOrderMap.get(chapterKey)!,
        topics: new Map(),
      });
    }
    const chapter = unit.chapters.get(chapterKey)!;

    // Get or create topic
    const topicKey = `${chapterKey}::${topicName}`;
    if (!chapter.topics.has(topicKey)) {
      if (!topicOrderMap.has(topicKey)) {
        topicOrderMap.set(topicKey, topicOrderMap.size + 1);
      }
      chapter.topics.set(topicKey, {
        topicName,
        topicOrder: topicOrderMap.get(topicKey)!,
        lessons: [],
      });
    }
    const topic = chapter.topics.get(topicKey)!;

    // Add lesson
    topic.lessons.push({
      lessonId,
      lessonName,
      lessonOrder,
      tags,
    });
  }

  return Array.from(unitsMap.values());
}

async function findOrCreateCourse(
  supabase: any,
  courseSlugOrId?: string
): Promise<string> {
  // If course ID provided, use it directly
  if (courseSlugOrId && courseSlugOrId.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i)) {
    const { data: course } = await supabase
      .from("courses")
      .select("id, title, slug")
      .eq("id", courseSlugOrId)
      .single();

    if (course) {
      console.log(`✅ Using course by ID: ${course.title} (${course.slug})`);
      return course.id;
    } else {
      throw new Error(`Course with ID ${courseSlugOrId} not found`);
    }
  }

  // Try to find existing course by slug
  if (courseSlugOrId) {
    const { data: existingCourse } = await supabase
      .from("courses")
      .select("id, title, slug")
      .eq("slug", courseSlugOrId)
      .single();

    if (existingCourse) {
      console.log(`✅ Found existing course: ${existingCourse.title} (${existingCourse.id})`);
      return existingCourse.id;
    }
  }

  // Try to find existing CBSE Class 10 Maths course
  const { data: existingCourses } = await supabase
    .from("courses")
    .select("id, title, slug, curriculum, subject, grade")
    .eq("curriculum", "CBSE")
    .eq("subject", "Mathematics")
    .eq("grade", "10")
    .order("created_at", { ascending: false })
    .limit(5);

  if (existingCourses && existingCourses.length > 0) {
    console.log(`\n⚠️  Found ${existingCourses.length} existing CBSE Class 10 Mathematics course(s):`);
    for (const course of existingCourses) {
      console.log(`   - ${course.title} (slug: ${course.slug}, id: ${course.id})`);
    }
    
    if (existingCourses.length === 1) {
      console.log(`\n✅ Using existing course: ${existingCourses[0].title}`);
      return existingCourses[0].id;
    } else {
      console.log(`\n⚠️  Multiple courses found. Using the most recent one: ${existingCourses[0].title}`);
      return existingCourses[0].id;
    }
  }

  // Create new course if none found
  const slug = courseSlugOrId || "cbse-class-10-mathematics";
  console.log(`📝 No existing course found. Creating new course with slug: ${slug}`);
  const { data: newCourse, error } = await supabase
    .from("courses")
    .insert({
      title: "CBSE Class 10 Mathematics",
      slug: slug,
      description: "Complete CBSE Class 10 Mathematics course covering all units, chapters, and topics",
      curriculum: "CBSE",
      subject: "Mathematics",
      grade: "10",
      level: "intermediate",
      price: 0,
      status: "draft",
    })
    .select()
    .single();

  if (error) {
    throw new Error(`Failed to create course: ${error.message}`);
  }

  console.log(`✅ Created course: ${newCourse.title} (${newCourse.id})`);
  return newCourse.id;
}

async function createOrUpdateUnit(
  supabase: any,
  courseId: string,
  unit: CourseStructure
): Promise<string> {
  // Check if unit exists
  const { data: existingUnit } = await supabase
    .from("courses_units")
    .select("id")
    .eq("course_id", courseId)
    .eq("unit_name", unit.unitName)
    .single();

  if (existingUnit) {
    console.log(`   ⚠️  Unit "${unit.unitName}" already exists, using existing`);
    return existingUnit.id;
  }

  // Create unit
  const { data: newUnit, error } = await supabase
    .from("courses_units")
    .insert({
      course_id: courseId,
      unit_name: unit.unitName,
      unit_order: unit.unitOrder,
      description: null,
      is_locked: false,
    })
    .select()
    .single();

  if (error) {
    throw new Error(`Failed to create unit "${unit.unitName}": ${error.message}`);
  }

  console.log(`   ✅ Created unit: ${unit.unitName} (order: ${unit.unitOrder})`);
  return newUnit.id;
}

async function createOrUpdateChapter(
  supabase: any,
  unitId: string,
  chapter: { chapterName: string; chapterOrder: number }
): Promise<string> {
  // Check if chapter exists
  const { data: existingChapter } = await supabase
    .from("courses_chapters")
    .select("id")
    .eq("unit_id", unitId)
    .eq("chapter_name", chapter.chapterName)
    .single();

  if (existingChapter) {
    console.log(`      ⚠️  Chapter "${chapter.chapterName}" already exists, using existing`);
    return existingChapter.id;
  }

  // Create chapter
  const { data: newChapter, error } = await supabase
    .from("courses_chapters")
    .insert({
      unit_id: unitId,
      chapter_name: chapter.chapterName,
      chapter_order: chapter.chapterOrder,
      description: null,
      is_locked: false,
    })
    .select()
    .single();

  if (error) {
    throw new Error(`Failed to create chapter "${chapter.chapterName}": ${error.message}`);
  }

  console.log(`      ✅ Created chapter: ${chapter.chapterName} (order: ${chapter.chapterOrder})`);
  return newChapter.id;
}

async function createOrUpdateTopic(
  supabase: any,
  chapterId: string,
  topic: { topicName: string; topicOrder: number }
): Promise<string> {
  // Check if topic exists
  const { data: existingTopic } = await supabase
    .from("courses_topics")
    .select("id")
    .eq("chapter_id", chapterId)
    .eq("topic_name", topic.topicName)
    .single();

  if (existingTopic) {
    console.log(`         ⚠️  Topic "${topic.topicName}" already exists, using existing`);
    return existingTopic.id;
  }

  // Create topic
  const { data: newTopic, error } = await supabase
    .from("courses_topics")
    .insert({
      chapter_id: chapterId,
      topic_name: topic.topicName,
      topic_number: String(topic.topicOrder),
      topic_order: topic.topicOrder,
      description: null,
    })
    .select()
    .single();

  if (error) {
    throw new Error(`Failed to create topic "${topic.topicName}": ${error.message}`);
  }

  console.log(`         ✅ Created topic: ${topic.topicName} (order: ${topic.topicOrder})`);
  return newTopic.id;
}

async function createOrUpdateLesson(
  supabase: any,
  courseId: string,
  chapterId: string,
  topicId: string,
  lesson: { lessonId: string; lessonName: string; lessonOrder: number; tags: string }
): Promise<void> {
  // Generate slug from lesson_id
  const slug = lesson.lessonId.toLowerCase().replace(/_/g, "-");

  // Check if lesson exists in this course
  const { data: existingLesson } = await supabase
    .from("courses_lessons")
    .select("id")
    .eq("course_id", courseId)
    .eq("slug", slug)
    .maybeSingle();

  if (existingLesson) {
    // Update existing lesson
    const { error: updateError } = await supabase
      .from("courses_lessons")
      .update({
        title: lesson.lessonName,
        lesson_order: lesson.lessonOrder,
        lesson_code: lesson.lessonId,
        chapter_id: chapterId,
        topic_id: topicId,
      })
      .eq("id", existingLesson.id);

    if (updateError) {
      console.error(`            ❌ Failed to update lesson "${lesson.lessonName}": ${updateError.message}`);
      return;
    }

    console.log(`            ⚠️  Updated lesson: ${lesson.lessonName}`);
  } else {
    // Check if lesson exists globally (might be in another course)
    const { data: globalLesson } = await supabase
      .from("courses_lessons")
      .select("id, course_id")
      .eq("slug", slug)
      .maybeSingle();

    if (globalLesson) {
      console.log(`            ⚠️  Lesson "${lesson.lessonName}" exists in another course (${globalLesson.course_id}), skipping`);
      return;
    }
    // Create new lesson
    const { data: newLesson, error: createError } = await supabase
      .from("courses_lessons")
      .insert({
        course_id: courseId,
        chapter_id: chapterId,
        topic_id: topicId,
        title: lesson.lessonName,
        slug: slug,
        lesson_order: lesson.lessonOrder,
        lesson_code: lesson.lessonId,
        is_preview: false,
      })
      .select()
      .single();

    if (createError) {
      console.error(`            ❌ Failed to create lesson "${lesson.lessonName}": ${createError.message}`);
      return;
    }

    console.log(`            ✅ Created lesson: ${lesson.lessonName} (${slug})`);

    // Create lesson tags if provided
    if (lesson.tags) {
      const tags = lesson.tags.split(",").map(t => t.trim()).filter(t => t.length > 0);
      for (const tag of tags) {
        const { error: tagError } = await supabase
          .from("lesson_tags")
          .upsert({
            lesson_id: newLesson.id,
            tag_name: tag,
          }, {
            onConflict: "lesson_id,tag_name",
          });

        if (tagError) {
          console.warn(`               ⚠️  Failed to add tag "${tag}": ${tagError.message}`);
        }
      }
    }
  }
}

async function main() {
  const courseSlugOrId = process.argv[2]; // Optional: course slug or ID
  const csvPath = resolve(process.cwd(), "Docs for me/master_map sheets/cbse_class_10_maths_master_map.csv");

  console.log("📖 Importing CBSE Class 10 Maths Course Structure\n");
  if (courseSlugOrId) {
    console.log(`   Course Slug/ID: ${courseSlugOrId}`);
  } else {
    console.log(`   Course: Will search for existing CBSE Class 10 Mathematics course`);
  }
  console.log(`   CSV Path: ${csvPath}\n`);

  // Initialize Supabase client
  const supabaseUrl = getSupabaseUrl();
  const serviceRoleKey = getSupabaseServiceRoleKey();

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error(
      "Missing Supabase credentials. Set NEXT_PUBLIC_SUPABASE_URL_DEV/PROD and SUPABASE_SERVICE_ROLE_KEY_DEV/PROD"
    );
  }

  const supabase = createClient(supabaseUrl, serviceRoleKey);

  try {
    // Parse CSV
    console.log("📄 Parsing CSV file...");
    const rows = parseMasterMap(csvPath);
    console.log(`   ✅ Parsed ${rows.length} rows\n`);

    // Build course structure
    console.log("🏗️  Building course structure...");
    const courseStructure = buildCourseStructure(rows);
    console.log(`   ✅ Found ${courseStructure.length} units\n`);

    // Find or create course
    const courseId = await findOrCreateCourse(supabase, courseSlugOrId);
    console.log("");

    // Create units, chapters, topics, and lessons
    let totalLessons = 0;
    for (const unit of courseStructure) {
      console.log(`📚 Processing Unit ${unit.unitOrder}: ${unit.unitName}`);
      const unitId = await createOrUpdateUnit(supabase, courseId, unit);

      for (const chapter of unit.chapters.values()) {
        console.log(`   📖 Processing Chapter ${chapter.chapterOrder}: ${chapter.chapterName}`);
        const chapterId = await createOrUpdateChapter(supabase, unitId, chapter);

        for (const topic of chapter.topics.values()) {
          console.log(`      📝 Processing Topic ${topic.topicOrder}: ${topic.topicName}`);
          const topicId = await createOrUpdateTopic(supabase, chapterId, topic);

          for (const lesson of topic.lessons) {
            await createOrUpdateLesson(supabase, courseId, chapterId, topicId, lesson);
            totalLessons++;
          }
        }
      }
      console.log("");
    }

    console.log("✅ Import completed successfully!");
    console.log(`\n📊 Summary:`);
    console.log(`   Units: ${courseStructure.length}`);
    console.log(`   Total Lessons: ${totalLessons}`);
    // Get course slug for the link
    const { data: course } = await supabase
      .from("courses")
      .select("slug")
      .eq("id", courseId)
      .single();
    
    const courseSlug = course?.slug || courseSlugOrId || "cbse-class-10-mathematics";
    console.log(`\n🔗 View course: ${process.env.NEXT_PUBLIC_APP_URL || "http://localhost:3000"}/courses/${courseSlug}`);

  } catch (error) {
    console.error("\n❌ Error:", error instanceof Error ? error.message : String(error));
    if (error instanceof Error && error.stack) {
      console.error("\nStack trace:", error.stack);
    }
    process.exit(1);
  }
}

// Run if executed directly
if (require.main === module) {
  main();
}

