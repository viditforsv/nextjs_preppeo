# GRE Course Setup - Complete Guide

## 📊 What's Been Generated

From your `master_map.csv`, I've created 3 ready-to-run SQL files:

- **127 Topics** across 24 chapters
- **133 Lessons** across all topics
- **621 Tag entries** for all lessons

---

## 🚀 How to Use

### Step 1: Insert Topics
Open Supabase SQL Editor and run:
```
scripts/step1-insert-topics.sql
```
This creates all 127 topics and links them to your chapters.

### Step 2: Insert Lessons
Run:
```
scripts/step2-insert-lessons.sql
```
This creates all 133 lessons and automatically matches them to the correct topics using their names (no manual ID filling needed!).

### Step 3: Insert Tags
Run:
```
scripts/step3-insert-tags.sql
```
This creates all 621 tag entries for your lessons.

---

## ✅ That's It!

**Total time:** ~5 minutes to run all 3 files

Your complete GRE course structure will be populated:
- Units ✓ (already created)
- Chapters ✓ (already created)
- Topics ✓ (step 1)
- Lessons ✓ (step 2)
- Tags ✓ (step 3)

---

## 🔍 Verify After Running

Check your course structure:
```sql
-- View complete hierarchy
SELECT 
  u.unit_name,
  c.chapter_name,
  t.topic_name,
  l.title as lesson_name,
  l.lesson_code
FROM courses_lessons l
JOIN courses_topics t ON l.topic_id = t.id
JOIN courses_chapters c ON t.chapter_id = c.id
JOIN courses_units u ON c.unit_id = u.id
WHERE u.course_id = 'b60ede64-698c-450c-9395-008d568b7ab3'
ORDER BY u.unit_order, c.chapter_order, t.topic_order, l.lesson_order
LIMIT 50;
```

---

## 📝 Source Files

- `master_map.csv` - Your original data
- `generate-smart-sql.py` - Generator script (kept for reference)
- `gre-step-by-step.md` - Process documentation

---

**Questions?** The SQL uses CTEs (Common Table Expressions) to auto-match topics by name, so no manual editing needed!



