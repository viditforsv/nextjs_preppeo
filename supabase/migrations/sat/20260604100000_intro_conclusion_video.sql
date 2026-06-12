-- ════════════════════════════════════════════════════════════════════════
-- Add a free-preview video placeholder to the Introduction and Conclusion
-- topics (sort_order 0, so it shows above the reading). No video_url yet, so
-- it renders the "Video coming soon" empty state. Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO public.sat_learn_items
  (topic_id, title, slug, type, sort_order, is_free_preview, is_published)
SELECT t.id, v.title, 'video', 'video', 0, true, true
FROM (VALUES
  ('introduction', 'Welcome Video'),
  ('conclusion',   'Course Wrap-Up Video')
) AS v(topic_slug, title)
JOIN public.sat_learn_topics t ON t.slug = v.topic_slug
JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
ON CONFLICT (topic_id, slug) DO NOTHING;
