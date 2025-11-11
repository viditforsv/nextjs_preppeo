# Course Structure Generator Scripts

This folder contains the automated SQL generation tool for creating course structures.

## 📁 Files

- **`generate-smart-sql.py`** - Main generator script (reusable for all courses)
- **`GRE-SETUP-README.md`** - GRE course specific documentation
- **`step1-insert-topics.sql`** - Generated: Topics INSERT (run first)
- **`step2-insert-lessons.sql`** - Generated: Lessons INSERT (run second)
- **`step3-insert-tags.sql`** - Generated: Tags INSERT (run third)

## 🚀 How to Use

### For New Course

1. **Complete manual setup** (Course, Units, Chapters in DB)
2. **Get Chapter IDs** from Supabase
3. **Prepare CSV** in `docs/` folder
4. **Update script configuration:**
   ```python
   COURSE_ID = 'your-course-uuid'
   CSV_FILE = '../docs/your-course-map.csv'
   CHAPTER_IDS = {
       "Chapter Name": "chapter-uuid",
       # ... all chapters
   }
   ```
5. **Run generator:**
   ```bash
   python3 generate-smart-sql.py
   ```
6. **Execute SQL files** in Supabase (step1 → step2 → step3)

### For GRE Course (Example)

The current configuration is set up for GRE course. Just run:
```bash
python3 generate-smart-sql.py
```

## 📋 Requirements

- Python 3.x
- CSV file with columns: `Sl. No., Unit, Chapter, Topics, Lesson ID, Lessons, Tags`
- Chapter IDs from database

## 📖 Documentation

- **Quick Start:** `docs/QUICK_REFERENCE.md`
- **Full Guide:** `docs/COURSE_STRUCTURE_SETUP_GUIDE.md`

## ✅ Output

Running the script generates 3 SQL files ready to execute:
1. Topics with auto-ordered numbering
2. Lessons with auto-matched topic IDs  
3. Tags with lesson code lookups

No manual editing required! 🎉






