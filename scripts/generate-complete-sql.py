#!/usr/bin/env python3
"""
Generate complete SQL files from master_map.csv with actual chapter IDs
"""
import csv

# Course ID
COURSE_ID = 'b60ede64-698c-450c-9395-008d568b7ab3'

# Chapter IDs from Supabase
CHAPTER_IDS = {
    "Number Properties": "5bb04889-3346-4dc1-ae12-550132629536",
    "Ratios & Proportions": "63853251-8e64-492c-80de-300c3f1fb17c",
    "Percentages & Fractions": "1708fbd8-e5c0-4cbe-87a1-301d19694d3d",
    "Averages & Mixtures": "09d237d0-4b37-439d-b5bd-80741572560f",
    "Time, Work & Distance": "bc3d99c7-8156-44ab-a503-99dce3595e19",
    "Linear Equations": "2da6588e-a254-42ad-9182-134e27e5a881",
    "Quadratic Equations & Expressions": "f500c856-df1c-4ded-a509-e436b9bfd23e",
    "Inequalities": "27e0bffa-6551-4df3-9a6d-b4bcba4a86b6",
    "Functions & Graphs": "7851eda5-1ebf-465c-8205-58b0c2bba85b",
    "Sequences & Series": "2e3f3e33-c540-4255-85e0-28428e390579",
    "Lines & Angles": "53c2ddeb-1b37-4d9c-840d-6bd7a0048e7e",
    "Triangles": "9f845450-6ee0-4766-b6f0-0250ee5825d6",
    "Quadrilaterals & Polygons": "dc373b15-b222-4cd4-9961-c7b0a1541aca",
    "Circles": "164c5454-0f9d-448c-a3dc-78f0a1d40e60",
    "3D Geometry": "e4ba47b9-0f93-4ec9-8aca-58ba71a7bf1e",
    "Coordinate Geometry": "16616c0b-2229-47e1-ab72-b3eca685ab5a",
    "Descriptive Statistics": "9a99cd02-586d-44f2-a1d9-546d3eda66ce",
    "Data Interpretation": "455ee023-7218-478c-bf24-2beb1bf8e3cf",
    "Probability": "96dc9d78-15ff-4a66-b6f6-6b869e481274",
    "Counting Methods": "efbae176-069e-4c49-bcd2-290d983de367",
    "Quantitative Comparisons": "2dc034b4-d95c-46aa-b5ea-d4d96959feea",
    "Word Problems": "19060fbf-66eb-47e6-a428-64689402833d",
    "Data Sufficiency": "ea3f09ff-cb88-4b40-88e5-b752f968a2e4",
    "GRE Strategy": "06120067-a981-4dc9-9242-f426ae130953",
}

# Read CSV
with open('../docs/master_map.csv', 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    rows = list(reader)

# Process data
topics_map = {}  # (chapter, topic) -> {data}
topic_order_tracker = {}
lessons_data = []

for row in rows:
    chapter = row['Chapter']
    topic = row['Topics']
    lesson_id = row['Lesson ID']
    lesson_name = row['Lessons']
    tags = row['Tags']
    
    # Track topics
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
    
    # Store lesson data
    lessons_data.append({
        'chapter': chapter,
        'topic': topic,
        'lesson_id': lesson_id,
        'lesson_name': lesson_name,
        'tags': tags
    })

# ============================================
# FILE 1: Insert Topics
# ============================================
print("Generating 01-insert-topics.sql...")
with open('01-insert-topics.sql', 'w', encoding='utf-8') as f:
    f.write("-- GRE Course: Insert Topics\n")
    f.write("-- Generated from master_map.csv\n")
    f.write(f"-- Total topics: {len(topics_map)}\n\n")
    
    f.write("INSERT INTO public.courses_topics (chapter_id, topic_name, topic_number, topic_order) VALUES\n")
    
    topic_inserts = []
    for (chapter, topic), data in sorted(topics_map.items(), key=lambda x: (x[1]['chapter'], x[1]['order'])):
        chapter_id = CHAPTER_IDS[chapter]
        order = data['order']
        # Escape single quotes
        topic_escaped = topic.replace("'", "''")
        topic_inserts.append(f"  ('{chapter_id}', '{topic_escaped}', '{order}', {order})")
    
    f.write(",\n".join(topic_inserts) + ";\n")

print(f"✓ Created 01-insert-topics.sql ({len(topics_map)} topics)")

# ============================================
# FILE 2: Query to get topic IDs
# ============================================
print("\nGenerating 02-get-topic-ids.sql...")
with open('02-get-topic-ids.sql', 'w', encoding='utf-8') as f:
    f.write("-- GRE Course: Get Topic IDs after inserting topics\n")
    f.write("-- Run this query and use the results for the next step\n\n")
    f.write(f"""SELECT t.id, t.topic_name, c.chapter_name, t.topic_order
FROM public.courses_topics t
JOIN public.courses_chapters c ON t.chapter_id = c.id
JOIN public.courses_units u ON c.unit_id = u.id
WHERE u.course_id = '{COURSE_ID}'
ORDER BY c.chapter_order, t.topic_order;
""")

print("✓ Created 02-get-topic-ids.sql (query to run after topics)")

# ============================================
# FILE 3: Template for Lessons (needs topic IDs)
# ============================================
print("\nGenerating 03-insert-lessons-template.sql...")
with open('03-insert-lessons-template.sql', 'w', encoding='utf-8') as f:
    f.write("-- GRE Course: Insert Lessons\n")
    f.write("-- IMPORTANT: Fill in topic IDs from 02-get-topic-ids.sql results\n")
    f.write(f"-- Total lessons: {len(lessons_data)}\n\n")
    
    f.write("-- Step 1: Create a mapping of topics to their IDs\n")
    f.write("-- Replace UUIDs below with actual topic IDs from previous query\n\n")
    f.write("-- Topic ID Mapping (FILL THIS IN):\n")
    
    # Generate template for topic IDs
    unique_topics = sorted(set((lesson['chapter'], lesson['topic']) for lesson in lessons_data))
    f.write("/*\n")
    for chapter, topic in unique_topics:
        topic_key = f"{chapter}::{topic}".replace("'", "''")
        f.write(f"  '{topic_key}' -> 'PASTE_TOPIC_ID_HERE'\n")
    f.write("*/\n\n")
    
    f.write("-- Step 2: After filling topic IDs, uncomment and update the INSERT below\n\n")
    f.write("INSERT INTO public.courses_lessons (\n")
    f.write("  course_id, title, lesson_code, slug, chapter_id, topic_id, is_preview, lesson_order\n")
    f.write(") VALUES\n")
    
    # Generate lesson inserts with placeholders
    lesson_order_tracker = {}
    lesson_inserts = []
    
    for lesson in lessons_data:
        chapter = lesson['chapter']
        topic = lesson['topic']
        lesson_id = lesson['lesson_id']
        lesson_name = lesson['lesson_name'].replace("'", "''")
        
        # Track lesson order per topic
        topic_key = (chapter, topic)
        if topic_key not in lesson_order_tracker:
            lesson_order_tracker[topic_key] = 1
        else:
            lesson_order_tracker[topic_key] += 1
        
        lesson_order = lesson_order_tracker[topic_key]
        slug = lesson_id.replace('_', '-')
        chapter_id = CHAPTER_IDS[chapter]
        
        lesson_inserts.append(
            f"  -- {chapter} > {topic}\n"
            f"  ('{COURSE_ID}', '{lesson_name}', '{lesson_id}', '{slug}', '{chapter_id}', 'TOPIC_ID_FOR_{topic.replace(' ', '_').replace('&', 'AND').upper()}', false, {lesson_order})"
        )
    
    f.write(",\n".join(lesson_inserts) + ";\n")

print(f"✓ Created 03-insert-lessons-template.sql ({len(lessons_data)} lessons - needs topic IDs)")

# ============================================
# FILE 4: Insert Tags (can run after lessons)
# ============================================
print("\nGenerating 04-insert-tags.sql...")
with open('04-insert-tags.sql', 'w', encoding='utf-8') as f:
    f.write("-- GRE Course: Insert Lesson Tags\n")
    f.write("-- Run this AFTER lessons are created\n\n")
    
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
print(f"✓ Created 04-insert-tags.sql ({tag_count} tag entries)")

print("\n" + "="*60)
print("SUMMARY")
print("="*60)
print(f"✓ Topics: {len(topics_map)}")
print(f"✓ Lessons: {len(lessons_data)}")
print(f"✓ Tags: {tag_count}")
print("\nFiles created:")
print("  1. 01-insert-topics.sql - Ready to run!")
print("  2. 02-get-topic-ids.sql - Run after step 1")
print("  3. 03-insert-lessons-template.sql - Needs topic IDs")
print("  4. 04-insert-tags.sql - Run after lessons")













