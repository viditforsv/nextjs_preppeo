-- Migration: tracked short links for community marketing (Reddit/Discord)
-- Purpose: the VA mints short links (/l/<slug>) that redirect to a fixed set of
--          pages with UTM tags, count clicks, and attribute signups.
--          All reads/writes go through service-role API routes, so RLS denies
--          anon/authenticated access (no policies = deny by default).
-- Apply to: dev branch (dxhxpfouzjlzpeazwrqo) first, promote to prod after QC.

create table if not exists public.tracked_links (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  destination_key text not null,   -- 'home' | 'qotd' | 'free-mock' | 'pricing'
  destination_path text not null,  -- '/', '/question-of-the-day', ...
  source text not null,            -- 'reddit' | 'discord' | 'other'  (-> utm_source)
  label text not null default '',  -- human note, e.g. "r/SAT weekly thread"
  campaign text not null default '',
  click_count integer not null default 0,
  last_clicked_at timestamptz,
  created_by text not null default 'va',  -- 'admin' | 'va'
  created_at timestamptz not null default now()
);

-- One attribution row per signed-up user (last link clicked before signup).
create table if not exists public.link_signups (
  id uuid primary key default gen_random_uuid(),
  link_slug text not null,
  user_id uuid not null unique,
  created_at timestamptz not null default now()
);

create index if not exists idx_link_signups_slug on public.link_signups (link_slug);

alter table public.tracked_links enable row level security;
alter table public.link_signups enable row level security;
-- No policies: only the service role (API routes) can touch these tables.

-- Atomic click increment used by the /l/<slug> redirect.
create or replace function public.increment_link_click(p_slug text)
returns void
language sql
security definer
set search_path to 'public', 'pg_temp'
as $$
  update public.tracked_links
  set click_count = click_count + 1,
      last_clicked_at = now()
  where slug = p_slug;
$$;
