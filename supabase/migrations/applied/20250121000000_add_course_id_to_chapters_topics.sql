-- Add course_id column to courses_chapters
ALTER TABLE public.courses_chapters
ADD COLUMN IF NOT EXISTS course_id uuid;

-- Add course_id column to courses_topics
ALTER TABLE public.courses_topics
ADD COLUMN IF NOT EXISTS course_id uuid;

-- Populate course_id in courses_chapters from courses_units
UPDATE public.courses_chapters cc
SET course_id = cu.course_id
FROM public.courses_units cu
WHERE cc.unit_id = cu.id
  AND cc.course_id IS NULL;

-- Populate course_id in courses_topics from courses_chapters
UPDATE public.courses_topics ct
SET course_id = cc.course_id
FROM public.courses_chapters cc
WHERE ct.chapter_id = cc.id
  AND ct.course_id IS NULL;

-- Add foreign key constraints
ALTER TABLE public.courses_chapters
ADD CONSTRAINT courses_chapters_course_id_fkey 
FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;

ALTER TABLE public.courses_topics
ADD CONSTRAINT courses_topics_course_id_fkey 
FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;

-- Make course_id NOT NULL after populating (optional, but recommended)
-- Uncomment these if you want to enforce NOT NULL constraint:
-- ALTER TABLE public.courses_chapters
-- ALTER COLUMN course_id SET NOT NULL;

-- ALTER TABLE public.courses_topics
-- ALTER COLUMN course_id SET NOT NULL;

-- Add indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_courses_chapters_course_id 
ON public.courses_chapters(course_id);

CREATE INDEX IF NOT EXISTS idx_courses_topics_course_id 
ON public.courses_topics(course_id);

