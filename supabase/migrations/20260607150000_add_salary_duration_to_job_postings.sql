-- Migration: add salary + minimum-duration fields to job_postings
-- Purpose: show compensation transparently on the careers page.
--          Empty string = hidden on the frontend (optional per role).
-- Prerequisites: 20260607120000_create_job_postings.sql
-- Apply to: dev branch (dxhxpfouzjlzpeazwrqo) first, promote to prod after QC.

alter table public.job_postings
  add column if not exists salary_range text not null default '',
  add column if not exists min_duration text not null default '';

update public.job_postings
set
  salary_range = '₹5,000 fixed + up to ₹5,000 incentives / month',
  min_duration = '3-month minimum',
  updated_at = now()
where slug = 'social-media-content-manager';
