-- Run this in the Supabase SQL editor before launching the app.
-- The Flutter app only uses the publishable/anon key; never put service_role
-- credentials in .env or the mobile app.

create table if not exists public.scheduled_events (
  id uuid primary key default gen_random_uuid(),
  day_index integer not null check (day_index > 0),
  title text not null,
  starts_at timestamptz not null,
  ends_at timestamptz not null check (ends_at > starts_at),
  location text not null,
  description text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.announcements (
  id uuid primary key default gen_random_uuid(),
  message text not null,
  tags text[] not null default '{}',
  published_at timestamptz not null default now()
);

create table if not exists public.announcement_reads (
  announcement_id uuid not null references public.announcements(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  read_at timestamptz not null default now(),
  primary key (announcement_id, user_id)
);

create table if not exists public.tickets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  first_name text not null,
  middle_name text,
  last_name text not null,
  barcode text not null unique,
  tier text not null,
  venue text not null,
  venue_instructions text,
  created_at timestamptz not null default now()
);

alter table public.scheduled_events enable row level security;
alter table public.announcements enable row level security;
alter table public.announcement_reads enable row level security;
alter table public.tickets enable row level security;

create policy "Anyone can read scheduled events"
  on public.scheduled_events for select using (true);
create policy "Anyone can read announcements"
  on public.announcements for select using (true);
create policy "Users manage their announcement reads"
  on public.announcement_reads for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can read their own tickets"
  on public.tickets for select using (auth.uid() = user_id);

-- The app consumes this view for the announcements list. security_invoker
-- ensures the caller's RLS policies still apply to announcement_reads.
create or replace view public.announcement_feed
with (security_invoker = true) as
select
  a.id,
  a.message,
  a.tags,
  a.published_at,
  exists (
    select 1 from public.announcement_reads ar
    where ar.announcement_id = a.id and ar.user_id = auth.uid()
  ) as is_read
from public.announcements a;

grant select on public.scheduled_events, public.announcements,
  public.announcement_feed to anon, authenticated;
grant select, insert, update, delete on public.announcement_reads to authenticated;
grant select on public.tickets to authenticated;

-- Enable Realtime for the schedule stream:
alter publication supabase_realtime add table public.scheduled_events;
