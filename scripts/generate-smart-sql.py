#!/usr/bin/env python3
"""
Generate SMART SQL files that auto-match topic IDs using CTEs
No manual ID filling needed!

REUSABLE TEMPLATE FOR ALL COURSES
See: docs/COURSE_STRUCTURE_SETUP_GUIDE.md for full documentation
"""
import csv

# ============================================
# CONFIGURATION - UPDATE FOR EACH COURSE
# ============================================

# Course ID (get from Step 1 in setup guide)
COURSE_ID = 'b60ede64-698c-450c-9395-008d568b7ab3'

# CSV file containing course structure
CSV_FILE = '../docs/master_map.csv'

# Chapter IDs from Supabase (get from Step 3 query)
# Format: "Chapter Name": "uuid"
CHAPTER_IDS = {
    # GRE Course - Arithmetic
    "Number Properties": "5bb04889-3346-4dc1-ae12-550132629536",
    "Ratios & Proportions": "63853251-8e64-492c-80de-300c3f1fb17c",
    "Percentages & Fractions": "1708fbd8-e5c0-4cbe-87a1-301d19694d3d",
    "Averages & Mixtures": "09d237d0-4b37-439d-b5bd-80741572560f",
    "Time, Work & Distance": "bc3d99c7-8156-44ab-a503-99dce3595e19",
    # GRE Course - Algebra
    "Linear Equations": "2da6588e-a254-42ad-9182-134e27e5a881",
    "Quadratic Equations & Expressions": "f500c856-df1c-4ded-a509-e436b9bfd23e",
    "Inequalities": "27e0bffa-6551-4df3-9a6d-b4bcba4a86b6",
    "Functions & Graphs": "7851eda5-1ebf-465c-8205-58b0c2bba85b",
    "Sequences & Series": "2e3f3e33-c540-4255-85e0-28428e390579",
    # GRE Course - Geometry
    "Lines & Angles": "53c2ddeb-1b37-4d9c-840d-6bd7a0048e7e",
    "Triangles": "9f845450-6ee0-4766-b6f0-0250ee5825d6",
    "Quadrilaterals & Polygons": "dc373b15-b222-4cd4-9961-c7b0a1541aca",
    "Circles": "164c5454-0f9d-448c-a3dc-78f0a1d40e60",
    "3D Geometry": "e4ba47b9-0f93-4ec9-8aca-58ba71a7bf1e",
    "Coordinate Geometry": "16616c0b-2229-47e1-ab72-b3eca685ab5a",
    # GRE Course - Data Analytics
    "Descriptive Statistics": "9a99cd02-586d-44f2-a1d9-546d3eda66ce",
    "Data Interpretation": "455ee023-7218-478c-bf24-2beb1bf8e3cf",
    "Probability": "96dc9d78-15ff-4a66-b6f6-6b869e481274",
    "Counting Methods": "efbae176-069e-4c49-bcd2-290d983de367",
    # GRE Course - Quantitative Reasoning Applications
    "Quantitative Comparisons": "2dc034b4-d95c-46aa-b5ea-d4d96959feea",
    "Word Problems": "19060fbf-66eb-47e6-a428-64689402833d",
    "Data Sufficiency": "ea3f09ff-cb88-4b40-88e5-b752f968a2e4",
    "GRE Strategy": "06120067-a981-4dc9-9242-f426ae130953",
}

# ============================================
# SCRIPT - No changes needed below this line
# ============================================

# Read CSV
with open(CSV_FILE, 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    rows = list(reader)

# Process data
topics_map = {}
topic_order_tracker = {}
lessons_data = []

for row in rows:
    chapter = row['Chapter']
    topic = row['Topics']
    lesson_id = row['Lesson ID']
    lesson_name = row['Lessons']
    tags = row['Tags']
    
    key = (chapter, topic)
    if key not in topics_map:
        if chapter not in topic_order_tracker:
            topic_order_tracker[chapter] = 1
        else:
            topic_order_tracker[chapter] += 1
        
        topics_map[key] = {
            'chapter': chapter,
            'topic': topic,
            'order': topic_order_tracker[chapter]
        }
    
    lessons_data.append({
        'chapter': chapter,
        'topic': topic,
        'lesson_id': lesson_id,
        'lesson_name': lesson_name,
        'tags': tags
    })

print("Generating SMART SQL files (no manual editing needed)...\n")

# ============================================
# FILE 1: Insert Topics (READY TO RUN)
# ============================================
with open('step1-insert-topics.sql', 'w', encoding='utf-8') as f:
    f.write("-- STEP 1: Insert Topics\n")
    f.write("-- This file is READY TO RUN in Supabase SQL Editor\n")
    f.write(f"-- Total topics: {len(topics_map)}\n\n")
    
    f.write("INSERT INTO public.courses_topics (chapter_id, topic_name, topic_number, topic_order) VALUES\n")
    
    topic_inserts = []
    for (chapter, topic), data in sorted(topics_map.items(), key=lambda x: (x[1]['chapter'], x[1]['order'])):
        chapter_id = CHAPTER_IDS[chapter]
        order = data['order']
        topic_escaped = topic.replace("'", "''")
        topic_inserts.append(f"  ('{chapter_id}', '{topic_escaped}', '{order}', {order})")
    
    f.write(",\n".join(topic_inserts) + ";\n")

print(f"✓ step1-insert-topics.sql ({len(topics_map)} topics) - READY TO RUN")

# ============================================
# FILE 2: Insert Lessons with CTE (SMART!)
# ============================================
with open('step2-insert-lessons.sql', 'w', encoding='utf-8') as f:
    f.write("-- STEP 2: Insert Lessons (SMART VERSION - Auto-matches topic IDs)\n")
    f.write("-- Run this AFTER step 1 (topics are inserted)\n")
    f.write(f"-- Total lessons: {len(lessons_data)}\n\n")
    
    f.write("-- Using CTE to auto-match topics by name and chapter\n")
    f.write("WITH topic_lookup AS (\n")
    f.write("  SELECT t.id as topic_id, t.topic_name, c.id as chapter_id, c.chapter_name\n")
    f.write("  FROM public.courses_topics t\n")
    f.write("  JOIN public.courses_chapters c ON t.chapter_id = c.id\n")
    f.write("  JOIN public.courses_units u ON c.unit_id = u.id\n")
    f.write(f"  WHERE u.course_id = '{COURSE_ID}'\n")
    f.write(")\n")
    f.write("INSERT INTO public.courses_lessons (\n")
    f.write("  course_id, title, lesson_code, slug, chapter_id, topic_id, is_preview, lesson_order\n")
    f.write(")\n")
    f.write("SELECT * FROM (\n")
    f.write("  VALUES\n")
    
    lesson_order_tracker = {}
    lesson_values = []
    
    for lesson in lessons_data:
        chapter = lesson['chapter']
        topic = lesson['topic']
        lesson_id = lesson['lesson_id']
        lesson_name = lesson['lesson_name'].replace("'", "''")
        
        topic_key = (chapter, topic)
        if topic_key not in lesson_order_tracker:
            lesson_order_tracker[topic_key] = 1
        else:
            lesson_order_tracker[topic_key] += 1
        
        lesson_order = lesson_order_tracker[topic_key]
        slug = lesson_id.replace('_', '-')
        chapter_id = CHAPTER_IDS[chapter]
        topic_escaped = topic.replace("'", "''")
        chapter_escaped = chapter.replace("'", "''")
        
        lesson_values.append(
            f"    ('{COURSE_ID}', '{lesson_name}', '{lesson_id}', '{slug}', '{chapter_escaped}', '{topic_escaped}', false, {lesson_order})"
        )
    
    f.write(",\n".join(lesson_values) + "\n")
    f.write(") AS lesson_data(course_id, title, lesson_code, slug, chapter_name, topic_name, is_preview, lesson_order)\n")
    f.write("JOIN topic_lookup tl ON tl.chapter_name = lesson_data.chapter_name AND tl.topic_name = lesson_data.topic_name\n")
    f.write("SELECT \n")
    f.write("  lesson_data.course_id,\n")
    f.write("  lesson_data.title,\n")
    f.write("  lesson_data.lesson_code,\n")
    f.write("  lesson_data.slug,\n")
    f.write("  tl.chapter_id,\n")
    f.write("  tl.topic_id,\n")
    f.write("  lesson_data.is_preview,\n")
    f.write("  lesson_data.lesson_order;\n")

print(f"✓ step2-insert-lessons.sql ({len(lessons_data)} lessons) - READY TO RUN")

# ============================================
# FILE 3: Insert Tags (SMART!)
# ============================================
with open('step3-insert-tags.sql', 'w', encoding='utf-8') as f:
    f.write("-- STEP 3: Insert Lesson Tags\n")
    f.write("-- Run this AFTER step 2 (lessons are created)\n\n")
    
    f.write("INSERT INTO public.lesson_tags (lesson_id, tag_name)\n")
    
    tag_inserts = []
    for lesson in lessons_data:
        lesson_code = lesson['lesson_id']
        tags = lesson['tags'].split(',')
        
        for tag in tags:
            tag = tag.strip()
            if tag:
                tag_escaped = tag.replace("'", "''")
                tag_inserts.append(
                    f"  ((SELECT id FROM public.courses_lessons WHERE lesson_code = '{lesson_code}'), '{tag_escaped}')"
                )
    
    f.write(",\n".join(tag_inserts) + ";\n")

tag_count = sum(len(lesson['tags'].split(',')) for lesson in lessons_data)
print(f"✓ step3-insert-tags.sql ({tag_count} tag entries) - READY TO RUN")

print("\n" + "="*60)
print("✅ ALL FILES READY!")
print("="*60)
print(f"\nTopics: {len(topics_map)} | Lessons: {len(lessons_data)} | Tags: {tag_count}")
print("\nJust run these 3 files in order:")
print("  1. step1-insert-topics.sql")
print("  2. step2-insert-lessons.sql  (auto-matches topic IDs!)")
print("  3. step3-insert-tags.sql")
print("\nNo manual editing needed! 🎉\n")

