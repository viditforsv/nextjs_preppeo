#!/usr/bin/env tsx
/**
 * Parse GRE Quant Master Map CSV and generate course structure JSON
 */

import { readFileSync, writeFileSync } from "fs";
import { resolve } from "path";
import { parse } from "csv-parse/sync";

interface CSVRow {
  "Sl. No.": string;
  Unit: string;
  Chapter: string;
  Topics: string;
  "Lesson ID": string;
  Lessons: string;
  Tags: string;
}

interface Lesson {
  title: string;
  slug: string;
  lesson_order: number;
  lesson_id: string;
  tags: string[];
  description?: string;
}

interface Topic {
  topic_name: string;
  topic_order: number;
  lessons: Lesson[];
}

interface Chapter {
  chapter_name: string;
  chapter_order: number;
  topics: Topic[];
}

interface Unit {
  unit_name: string;
  unit_order: number;
  chapters: Chapter[];
}

function slugify(text: string): string {
  return text
    .toLowerCase()
    .trim()
    .replace(/[^\w\s-]/g, "")
    .replace(/[\s_-]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function parseCSV(csvPath: string): Unit[] {
  const fileContent = readFileSync(csvPath, "utf-8");
  const records = parse(fileContent, {
    columns: true,
    skip_empty_lines: true,
    trim: true,
  }) as CSVRow[];

  // Organize data into hierarchy
  const unitsMap = new Map<string, Unit>();
  const chaptersMap = new Map<string, Chapter>();
  const topicsMap = new Map<string, Topic>();

  records.forEach((row, index) => {
    const unitName = row.Unit.trim();
    const chapterName = row.Chapter.trim();
    const topicName = row.Topics.trim();
    const lessonTitle = row.Lessons.trim();
    const lessonId = row["Lesson ID"].trim();
    const tags = row.Tags.split(",").map((t) => t.trim()).filter(Boolean);

    // Get or create unit
    if (!unitsMap.has(unitName)) {
      unitsMap.set(unitName, {
        unit_name: unitName,
        unit_order: unitsMap.size + 1,
        chapters: [],
      });
    }
    const unit = unitsMap.get(unitName)!;

    // Get or create chapter
    const chapterKey = `${unitName}::${chapterName}`;
    if (!chaptersMap.has(chapterKey)) {
      chaptersMap.set(chapterKey, {
        chapter_name: chapterName,
        chapter_order: Array.from(chaptersMap.values()).filter(
          (c) => c.chapter_name === chapterName
        ).length + 1,
        topics: [],
      });
      unit.chapters.push(chaptersMap.get(chapterKey)!);
    }
    const chapter = chaptersMap.get(chapterKey)!;

    // Get or create topic
    // Use chapterKey::topicName to ensure same topic name in same chapter is merged
    const topicKey = `${chapterKey}::${topicName}`;
    if (!topicsMap.has(topicKey)) {
      // Count existing topics in this chapter to set order
      const existingTopicCount = chapter.topics.length;
      topicsMap.set(topicKey, {
        topic_name: topicName,
        topic_order: existingTopicCount + 1,
        lessons: [],
      });
      chapter.topics.push(topicsMap.get(topicKey)!);
    }
    const topic = topicsMap.get(topicKey)!;

    // Add lesson
    const lesson: Lesson = {
      title: lessonTitle,
      slug: slugify(lessonId || lessonTitle),
      lesson_order: topic.lessons.length + 1,
      lesson_id: lessonId,
      tags: tags,
      description: `Lesson ${topic.lessons.length + 1}: ${lessonTitle}`,
    };
    topic.lessons.push(lesson);
  });

  // Fix chapter orders within each unit
  unitsMap.forEach((unit) => {
    const chapterNames = new Set<string>();
    unit.chapters.forEach((chapter, index) => {
      if (!chapterNames.has(chapter.chapter_name)) {
        chapter.chapter_order = chapterNames.size + 1;
        chapterNames.add(chapter.chapter_name);
      } else {
        // Find the first occurrence's order
        const firstIndex = unit.chapters.findIndex(
          (c) => c.chapter_name === chapter.chapter_name
        );
        chapter.chapter_order = unit.chapters[firstIndex].chapter_order;
      }
    });
  });

  return Array.from(unitsMap.values());
}

function main() {
  const csvPath = resolve(
    process.cwd(),
    "Docs for me/master_map sheets/gre_quant_master_map.csv"
  );
  const outputPath = resolve(process.cwd(), "scripts/gre-quant-full-course.json");

  console.log("📖 Parsing GRE Quant Master Map CSV...");
  console.log(`   Input: ${csvPath}`);

  const units = parseCSV(csvPath);

  console.log(`\n✅ Parsed ${units.length} units:`);
  units.forEach((unit) => {
    const totalChapters = unit.chapters.length;
    const totalTopics = unit.chapters.reduce(
      (sum, ch) => sum + ch.topics.length,
      0
    );
    const totalLessons = unit.chapters.reduce(
      (sum, ch) => sum + ch.topics.reduce((s, t) => s + t.lessons.length, 0),
      0
    );
    console.log(
      `   - ${unit.unit_name}: ${totalChapters} chapters, ${totalTopics} topics, ${totalLessons} lessons`
    );
  });

  // Create full course JSON
  const courseData = {
    title: "GRE Quant",
    slug: "gre-quant",
    description:
      "Complete GRE Quant preparation with topic-wise question banks, varied practice sets, and mock tests covering Algebra, Arithmetic, Geometry, and Data Analysis.",
    curriculum: "GRE",
    subject: "Quantitative Reasoning",
    grade: "12+",
    level: null,
    price: 4000,
    validity_days: 365,
    status: "draft",
    thumbnail_url:
      "https://shrividhyaclasses.b-cdn.net/lms_qb_images/GRE%20Quant.png",
    template_data: {
      duration: "3 Months",
      units: units.map((unit) => ({
        unit_name: unit.unit_name,
        unit_order: unit.unit_order,
        description: `${unit.unit_name} - Complete coverage of all topics`,
        chapters: unit.chapters.map((chapter) => ({
          chapter_name: chapter.chapter_name,
          chapter_order: chapter.chapter_order,
          description: `${chapter.chapter_name} - Detailed lessons and practice`,
          topics: chapter.topics.map((topic) => ({
            topic_name: topic.topic_name,
            topic_order: topic.topic_order,
            lessons: topic.lessons.map((lesson) => ({
              title: lesson.title,
              slug: lesson.slug,
              lesson_order: lesson.lesson_order,
              description: lesson.description,
              type: "document" as const,
            })),
          })),
        })),
      })),
      tags: [
        "GRE",
        "test-prep",
        "quantitative-reasoning",
        "mathematics",
        "algebra",
        "geometry",
        "arithmetic",
        "data-analytics",
      ],
    },
  };

  writeFileSync(outputPath, JSON.stringify(courseData, null, 2));
  console.log(`\n✅ Generated course JSON: ${outputPath}`);
  console.log(`\n📊 Total Structure:`);
  console.log(
    `   Units: ${units.length}`,
    `\n   Chapters: ${units.reduce((sum, u) => sum + u.chapters.length, 0)}`,
    `\n   Topics: ${units.reduce(
      (sum, u) =>
        sum + u.chapters.reduce((s, c) => s + c.topics.length, 0),
      0
    )}`,
    `\n   Lessons: ${units.reduce(
      (sum, u) =>
        sum +
        u.chapters.reduce(
          (s, c) => s + c.topics.reduce((t, top) => t + top.lessons.length, 0),
          0
        ),
      0
    )}`
  );
  console.log(
    `\n🚀 To create/update the course, run:`,
    `\n   npm run create-course scripts/gre-quant-full-course.json --update`
  );
}

main();

