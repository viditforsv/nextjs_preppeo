-- Migration: refocus the Social Media Content Manager JD
-- Purpose: role pivots from broad social (Instagram/YouTube) to community-first:
--          Reddit + Discord as primary channels, LinkedIn maintenance only,
--          helping students with Preppeo resources (QOTD, free mocks, analytics).
-- Prerequisites: 20260607120000_create_job_postings.sql
-- Apply to: dev branch (dxhxpfouzjlzpeazwrqo) first, promote to prod after QC.

update public.job_postings
set
  blurb = 'Run Preppeo''s student community on Reddit and Discord — help students prep smarter with QOTD, free mocks, and score analytics.',
  about_role = 'Preppeo helps students master the Digital SAT with adaptive practice, full-length mocks, and human coaching. SAT students don''t hang out on polished brand feeds — they hang out on Reddit and Discord. Your job is to be Preppeo''s genuinely helpful presence there: answer questions, share the right resource at the right moment (Question of the Day, free mock tests, practice analytics), and build a community students actually want to be part of. You''ll also keep our LinkedIn page alive with regular updates.',
  responsibilities = '["Be active daily in SAT communities on Reddit — answer student questions helpfully and honestly, never spammy", "Build, grow, and moderate Preppeo''s Discord server — channels, study groups, events, AMAs with our teachers", "Point students to the right Preppeo resource when it genuinely helps: Question of the Day, free mocks, practice analytics", "Explain how Preppeo''s score analytics work — turn features into simple posts and guides students understand", "Maintain Preppeo''s LinkedIn page — consistent posts on student results, product updates, and company news", "Bring student feedback and recurring questions from the community back to the product and teaching teams", "Track what works — community growth, engagement, and signups coming from Reddit/Discord"]'::jsonb,
  requirements = '["You live on Reddit and Discord — you understand community norms and what reads as helpful vs. what gets flagged as spam", "1–3 years in community management or social media — or proof you''ve grown/moderated a community yourself", "Excellent written English with a helpful, honest, no-hype tone", "Willing to learn the product deeply (mocks, QOTD, analytics) so your answers are always accurate", "Self-directed — you show up daily and ship without being chased"]'::jsonb,
  nice_to_have = '["You''ve taken the SAT (or know the Digital SAT format well)", "You''ve moderated a subreddit or run a Discord server and can show it", "Basic design skills (Canva or similar) for LinkedIn posts"]'::jsonb,
  updated_at = now()
where slug = 'social-media-content-manager';
