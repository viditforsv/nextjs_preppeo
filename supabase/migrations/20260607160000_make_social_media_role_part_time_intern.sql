-- Migration: reposition Social Media Content Manager as a part-time internship
-- Purpose: comp is ₹5k fixed + ₹5k incentives/month — entry-level. Change
--          employment type to part-time internship and swap the "1–3 years"
--          requirement for student/fresher-friendly wording.
-- Prerequisites: 20260607150000_add_salary_duration_to_job_postings.sql
-- Apply to: dev branch (dxhxpfouzjlzpeazwrqo) first, promote to prod after QC.

update public.job_postings
set
  employment_type = 'Part-time · Internship',
  requirements = '["You live on Reddit and Discord — you understand community norms and what reads as helpful vs. what gets flagged as spam", "You''ve run social or community before — work, a college club, or your own accounts all count", "Excellent written English with a helpful, honest, no-hype tone", "Willing to learn the product deeply (mocks, QOTD, analytics) so your answers are always accurate", "Self-directed — you show up daily and ship without being chased"]'::jsonb,
  updated_at = now()
where slug = 'social-media-content-manager';
