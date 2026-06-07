-- Migration: create job_postings table for the Careers page
-- Purpose: DB-backed job listings so admin can open/close roles without a deploy.
--          Public (anon) can only read postings where is_open = true (RLS).
--          Admin writes go through /api/admin/careers using the service role
--          (bypasses RLS), so no insert/update policies are needed.
-- Prerequisites: none.
-- Apply to: dev branch (dxhxpfouzjlzpeazwrqo) first, promote to prod after QC.

create table if not exists public.job_postings (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  team text not null,
  location text not null default 'Remote',
  employment_type text not null default 'Full-time',
  blurb text not null default '',
  about_role text not null default '',
  responsibilities jsonb not null default '[]'::jsonb,
  requirements jsonb not null default '[]'::jsonb,
  nice_to_have jsonb not null default '[]'::jsonb,
  is_open boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.job_postings enable row level security;

-- Anyone (anon or signed-in) can read open postings only.
drop policy if exists "Public can read open postings" on public.job_postings;
create policy "Public can read open postings"
  on public.job_postings
  for select
  using (is_open = true);

-- Seed: first listing
insert into public.job_postings
  (slug, title, team, location, employment_type, blurb, about_role, responsibilities, requirements, nice_to_have, is_open)
values
  (
    'social-media-content-manager',
    'Social Media Content Manager',
    'Marketing',
    'Remote',
    'Full-time',
    'Own Preppeo''s social presence end to end — plan, create, and publish content that helps students prep smarter.',
    'Preppeo helps students master the Digital SAT with adaptive practice, full-length mocks, and human coaching. As our Social Media Content Manager, you''ll own our voice across Instagram, YouTube, and LinkedIn — turning what we know about test prep into content students actually want to watch, save, and share.',
    '["Plan and run the monthly content calendar across Instagram, YouTube Shorts, and LinkedIn", "Create and edit short-form video, carousels, and posts (scripting, design, captions)", "Turn SAT tips, score data, and student wins into engaging, accurate content", "Track what works — grow reach, saves, and follows; double down on winning formats", "Engage with comments and DMs; route student questions to the right team", "Coordinate with teachers and founders for expert-led content"]'::jsonb,
    '["1–3 years running social media for a brand or creator (education a plus)", "Strong short-form video instincts — you can script, shoot, and edit independently", "Excellent written English; you can make a dry topic genuinely fun", "Comfortable with design/editing tools (Canva, CapCut, Premiere, or similar)", "Self-directed — you ship on a schedule without being chased"]'::jsonb,
    '["You''ve grown an account (personal or brand) and can show the numbers", "Familiarity with the SAT or test-prep/ed-tech audiences", "Basic analytics chops — you read retention graphs, not just like counts"]'::jsonb,
    true
  )
on conflict (slug) do nothing;
