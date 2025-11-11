# GRE Course Population - Step by Step Guide

## Overview
You have 133 lessons to add across 24 chapters. Here's the easiest approach:

---

## STEP 1: Get Chapter IDs

Run this in Supabase SQL Editor:

```sql
SELECT c.id, c.chapter_name, u.unit_name
FROM public.courses_chapters c
JOIN public.courses_units u ON c.unit_id = u.id
WHERE u.course_id = 'b60ede64-698c-450c-9395-008d568b7ab3'
ORDER BY u.unit_order, c.chapter_order;
```

**Copy the results** - you'll need them for the next steps.

---

## STEP 2: I'll generate the SQL for you

Once you share the chapter IDs, I'll generate **3 complete SQL files**:

1. **`01-insert-topics.sql`** - All 69 topics mapped to chapters
2. **`02-insert-lessons.sql`** - All 133 lessons mapped to topics  
3. **`03-insert-tags.sql`** - All lesson tags

You'll just run them sequentially in Supabase.

---

## Why this is easier:

✓ No manual ID replacement needed
✓ No Python scripting  
✓ Just copy-paste chapter IDs once
✓ Run 3 SQL files and you're done

---

## What I need from you:

Paste the output from STEP 1 (chapter IDs with their names)






