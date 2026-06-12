-- ════════════════════════════════════════════════════════════════════════
-- Seed placeholder items (video / pdf / flashcard / quiz) for every SAT Math
-- topic that lacks them, so the curriculum structure is complete. Each opens
-- to its built-in "coming soon" empty state until real content is added:
--   video    → no video_url
--   pdf      → no pdf_url
--   flashcard→ no sat_learn_flashcards rows
--   quiz     → no sat_learn_quiz_questions rows
--
-- Placeholders are GATED (is_free_preview=false). Notes remain the free tier.
-- Linear Equations already has all five item types and is skipped via
-- ON CONFLICT (topic_id, slug). Order: video 1 · notes 2 · pdf 3 · cards 4 · quiz 5.
-- Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════

-- Slot the existing topic notes at sort_order 2 (video takes slot 1).
UPDATE public.sat_learn_items i
SET sort_order = 2
FROM public.sat_learn_topics t
JOIN public.sat_learn_courses c ON c.id = t.course_id
WHERE i.topic_id = t.id AND c.slug = 'sat-math'
  AND i.slug = 'notes' AND i.sort_order <> 2;

-- One row of each placeholder type for every Math topic.
INSERT INTO public.sat_learn_items
  (topic_id, title, slug, type, sort_order, is_free_preview, is_published)
SELECT t.id, x.title, x.slug, x.type, x.sort_order, false, true
FROM public.sat_learn_topics t
JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
CROSS JOIN (VALUES
  ('Video Lesson',       'video',      'video',     1),
  ('Key Formulas (PDF)', 'pdf',        'pdf',       3),
  ('Flashcards',         'flashcards', 'flashcard', 4),
  ('Concept Quiz',       'quiz',       'quiz',      5)
) AS x(title, slug, type, sort_order)
ON CONFLICT (topic_id, slug) DO NOTHING;
