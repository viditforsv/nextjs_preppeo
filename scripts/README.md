# CLI Scripts

This directory contains command-line tools for managing the Preppeo LMS.

## 📋 Available Scripts

### `create-course.ts`

Creates courses via Supabase API with full 5-tier hierarchy support.

**Usage:**
```bash
# Using npm script
npm run create-course <course-data.json>

# Direct execution
npx tsx scripts/create-course.ts <course-data.json>

# With instructor ID
npx tsx scripts/create-course.ts <course-data.json> <instructor-id>
```

**Example:**
```bash
npm run create-course scripts/example-course.json
```

**Prerequisites:**
- Environment variables set in `.env.local`:
  - `NEXT_PUBLIC_SUPABASE_URL_DEV` or `NEXT_PUBLIC_SUPABASE_URL_PROD`
  - `SUPABASE_SERVICE_ROLE_KEY_DEV` or `SUPABASE_SERVICE_ROLE_KEY_PROD`
  - `NEXT_PUBLIC_ENVIRONMENT=dev` or `prod`

**Course JSON Format:**
See `example-course.json` for a complete example.

**Features:**
- ✅ Creates course with all metadata
- ✅ Creates full 5-tier hierarchy (Units → Chapters → Topics → Lessons)
- ✅ Supports draft/published status
- ✅ Automatic slug generation
- ✅ Environment-aware (uses dev/prod based on config)

---

### `verify-env.ts`

Verifies environment configuration and shows which database will be used.

**Usage:**
```bash
npm run verify-env
# or
npx tsx scripts/verify-env.ts
```

**Output:**
- Current environment (dev/prod)
- Supabase URL being used
- Which environment variables are set
- Validation status

---

## 📝 Course JSON Structure

```json
{
  "title": "Course Title",
  "slug": "course-slug",
  "description": "Course description",
  "curriculum": "CBSE",
  "subject": "Mathematics",
  "grade": "9",
  "level": "intermediate",
  "price": 0,
  "validity_days": 365,
  "status": "draft",
  "template_data": {
    "units": [
      {
        "unit_name": "Unit Name",
        "unit_order": 1,
        "description": "Unit description",
        "chapters": [
          {
            "chapter_name": "Chapter Name",
            "chapter_order": 1,
            "description": "Chapter description",
            "topics": [
              {
                "topic_name": "Topic Name",
                "topic_order": 1,
                "lessons": [
                  {
                    "title": "Lesson Title",
                    "slug": "lesson-slug",
                    "lesson_order": 1,
                    "description": "Lesson description",
                    "type": "document"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "tags": ["tag1", "tag2"],
    "learningOutcomes": ["Outcome 1", "Outcome 2"],
    "prerequisites": ["Prerequisite 1"]
  }
}
```

---

## 🔧 Installation

If `tsx` is not installed globally, it will be used via `npx`:

```bash
# Install tsx globally (optional)
npm install -g tsx
```

---

## 📚 Related Documentation

- [Course Structure Setup Guide](../DOCS_FOR_AI_AGENT/COURSE_STRUCTURE_SETUP_GUIDE.md)
- [Environment Setup Guide](../DOCS_FOR_AI_AGENT/ENVIRONMENT_BASED_DATABASE_SETUP.md)

---

## 🐛 Troubleshooting

### "Missing Supabase credentials" error

**Solution:** Ensure `.env.local` has the correct environment variables:
- `NEXT_PUBLIC_ENVIRONMENT=dev` or `prod`
- `NEXT_PUBLIC_SUPABASE_URL_DEV` or `NEXT_PUBLIC_SUPABASE_URL_PROD`
- `SUPABASE_SERVICE_ROLE_KEY_DEV` or `SUPABASE_SERVICE_ROLE_KEY_PROD`

### "Failed to create course" error

**Solution:**
1. Check that the slug is unique
2. Verify all required fields are present
3. Check Supabase connection
4. Verify you have the correct permissions

### "tsx: command not found"

**Solution:**
- Use `npx tsx` instead of just `tsx`
- Or install tsx: `npm install -g tsx`

---

## ✅ Quick Start

1. **Create a course JSON file:**
   ```bash
   cp scripts/example-course.json scripts/my-course.json
   # Edit my-course.json with your course data
   ```

2. **Run the script:**
   ```bash
   npm run create-course scripts/my-course.json
   ```

3. **Verify the course:**
   - Check Supabase dashboard
   - Visit `/courses/<slug>` in your app
   - Or use the admin panel at `/admin/course-creator`

---

**Happy course creating!** 🚀

