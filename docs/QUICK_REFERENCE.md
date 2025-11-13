# Course Structure Quick Reference

## 🎯 5-Tier System at a Glance

```
Course → Units → Chapters → Topics → Lessons → Tags
```

## ⚡ Quick Setup (3 Steps)

### 1️⃣ Manual Setup
```sql
-- Create Course
INSERT INTO courses (...) VALUES (...) RETURNING id;

-- Create Units
INSERT INTO courses_units (...) VALUES (...);

-- Create Chapters  
INSERT INTO courses_chapters (...) VALUES (...);
```

### 2️⃣ Prepare CSV
Format: `Sl. No., Unit, Chapter, Topics, Lesson ID, Lessons, Tags`

### 3️⃣ Run Python Script
```bash
cd scripts
# Update: COURSE_ID, CHAPTER_IDS, CSV_FILE
python3 generate-smart-sql.py
# Then run step1, step2, step3 SQL files in Supabase
```

## 📝 CSV Template

```csv
Sl. No.,Unit,Chapter,Topics,Lesson ID,Lessons,Tags
1,Unit Name,Chapter Name,Topic Name,course_lid_001,Lesson Title,"tag1, tag2"
```

## 🔍 Essential Queries

**Get Chapter IDs:**
```sql
SELECT c.id, c.chapter_name, u.unit_name
FROM courses_chapters c
JOIN courses_units u ON c.unit_id = u.id
WHERE u.course_id = 'YOUR_ID'
ORDER BY u.unit_order, c.chapter_order;
```

**Verify Structure:**
```sql
SELECT u.unit_name, c.chapter_name, t.topic_name, l.title
FROM courses_lessons l
JOIN courses_topics t ON l.topic_id = t.id
JOIN courses_chapters c ON t.chapter_id = c.id
JOIN courses_units u ON c.unit_id = u.id
WHERE u.course_id = 'YOUR_ID'
ORDER BY u.unit_order, c.chapter_order, t.topic_order, l.lesson_order;
```

**Publish Course:**
```sql
UPDATE courses SET status = 'published' WHERE id = 'YOUR_ID';
```

## ⏱️ Time Estimates

- Manual setup (Units + Chapters): 10-15 min
- CSV preparation: 20-40 min
- Script execution: < 1 min
- Database insertion: 2-5 min
- **Total: ~40 minutes for 100+ lessons**

## 🚨 Common Pitfalls

❌ Chapter names in CSV don't match DB  
❌ Missing VALUES keyword in INSERT  
❌ Duplicate lesson codes  
❌ Missing type casts (::uuid, ::boolean)  

## 📚 Full Documentation

See `docs/COURSE_STRUCTURE_SETUP_GUIDE.md` for complete details.













