# Course Import from Master Map

Quick guide for importing course structures from Google Sheets master map CSV files.

## Prerequisites

- Google Sheets API credentials configured (service account)
- Master map CSV file with structure: `Sl. No.`, `unit_name`, `chapter_name`, `topic_name`, `lesson_id`, `lesson_name`, `tags`
- Supabase credentials configured in `.env.local`

## Quick Start

### 1. Download Master Map from Google Sheets

```bash
npx tsx scripts/read-google-sheets.ts <GOOGLE_SHEETS_URL> <OUTPUT_FILENAME>
```

**Example:**
```bash
npx tsx scripts/read-google-sheets.ts \
  "https://docs.google.com/spreadsheets/d/SPREADSHEET_ID/edit?gid=0" \
  "cbse_class_10_maths_master_map"
```

Saves CSV to: `Docs for me/master_map sheets/<OUTPUT_FILENAME>.csv`

### 2. Import Course Structure

```bash
npx tsx scripts/import-cbse-maths-course.ts [course-slug-or-id]
```

**Options:**
- No argument: Auto-detects existing CBSE course
- Course slug: `cbse-mathematics-class-10`
- Course ID: UUID

**Example:**
```bash
npx tsx scripts/import-cbse-maths-course.ts "cbse-mathematics-class-10"
```

### 3. Verify Import

Check course at: `/courses/<course-slug>`

## CSV Format Requirements

Required columns:
- `Sl. No.` - Sequential number
- `unit_name` - Unit name (e.g., "Algebra")
- `chapter_name` - Chapter name (e.g., "Polynomials")
- `topic_name` - Topic name (e.g., "Basics of Polynomials")
- `lesson_id` - Unique lesson identifier (e.g., `cbse_maths_10_001`)
- `lesson_name` - Lesson title
- `tags` - Comma-separated tags

## Database Structure Created

```
Course
  └── Units (courses_units)
      └── Chapters (courses_chapters)
          └── Topics (courses_topics)
              └── Lessons (courses_lessons)
                  └── Tags (lesson_tags)
```

## Troubleshooting

### Duplicate Course Created

If script creates duplicate course:
1. Find existing course: `npx tsx scripts/find-cbse-courses.ts`
2. Delete duplicate: `npx tsx scripts/delete-course.ts <duplicate-slug> --force`
3. Re-run import with correct slug

### Lessons Already Exist

Script handles existing lessons by:
- Updating if exists in same course
- Skipping if exists in different course
- Creating if doesn't exist

### Course Not Found

Script auto-detects CBSE courses by:
- Curriculum = "CBSE"
- Subject = "Mathematics"  
- Grade = "10"

If multiple found, uses most recent.

## Related Scripts

- `scripts/read-google-sheets.ts` - Download from Google Sheets
- `scripts/import-cbse-maths-course.ts` - Import course structure
- `scripts/find-cbse-courses.ts` - List CBSE courses
- `scripts/delete-course.ts` - Delete course and all related data

## Notes

- Lesson slugs are globally unique (derived from `lesson_id`)
- Units, chapters, and topics are created per course
- Script is idempotent - safe to run multiple times
- Existing records are updated, not duplicated

