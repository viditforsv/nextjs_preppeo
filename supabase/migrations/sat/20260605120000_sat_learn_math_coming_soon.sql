-- 20260605120000_sat_learn_math_coming_soon.sql
--
-- Mark the SAT Self-Learn MATH course as "Coming soon" on the frontend while
-- video lessons are still being produced.
--
-- Mechanism: the frontend treats a published course with ZERO published topics
-- as "Coming soon" (same as the English course). The course row stays published
-- so its card still renders; we just unpublish its topics. All content rows
-- (notes, PDFs, flashcards, quizzes) are preserved — nothing is deleted.
--
-- TO RE-LAUNCH (once videos are wired): re-run the same UPDATE with
-- is_published = true for the sat-math course topics.
--
-- Prerequisite: sat_learn_courses / sat_learn_topics exist (20260604020000).
-- Target: dev branch first (per CLAUDE.md dev→prod flow).

update sat_learn_topics t
set is_published = false
from sat_learn_courses c
where t.course_id = c.id
  and c.slug = 'sat-math';
