-- =====================================================================
-- SIMAMA FC — Supabase schema
-- Paste this whole file into: Supabase Dashboard -> SQL Editor -> New query
-- -> Run.  It is safe to run more than once.
-- =====================================================================

-- ---------- TABLES ----------

create table if not exists public.players (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  number      int,
  position    text,
  photo_url   text,
  bio         text,
  sort_order  int  default 0,
  created_at  timestamptz default now()
);

create table if not exists public.articles (
  id            uuid primary key default gen_random_uuid(),
  title         text not null,
  slug          text,
  excerpt       text,
  body          text,            -- markdown
  cover_url     text,
  published_at  timestamptz default now(),
  created_at    timestamptz default now()
);

create table if not exists public.gallery (
  id          uuid primary key default gen_random_uuid(),
  image_url   text not null,
  caption     text,
  featured    boolean default false,  -- true = big tile
  sort_order  int default 0,
  created_at  timestamptz default now()
);

-- single editable row of site-wide numbers/text (id is always 1)
create table if not exists public.site_settings (
  id                int primary key default 1,
  season_label      text    default 'Season goal',
  fundraise_goal    numeric default 40000,
  fundraise_raised  numeric default 18600,
  stat_players      int     default 24,
  stat_seasons      int     default 3,
  stat_districts_now  int   default 1,
  stat_districts_goal int   default 30,
  updated_at        timestamptz default now(),
  constraint one_row check (id = 1)
);

insert into public.site_settings (id) values (1)
  on conflict (id) do nothing;

-- ---------- ROW LEVEL SECURITY ----------
-- Public can READ everything (so the site loads).
-- Only logged-in admins can INSERT / UPDATE / DELETE.

alter table public.players       enable row level security;
alter table public.articles      enable row level security;
alter table public.gallery       enable row level security;
alter table public.site_settings enable row level security;

-- players
drop policy if exists "players read"  on public.players;
drop policy if exists "players write" on public.players;
create policy "players read"  on public.players for select using (true);
create policy "players write" on public.players for all
  to authenticated using (true) with check (true);

-- articles
drop policy if exists "articles read"  on public.articles;
drop policy if exists "articles write" on public.articles;
create policy "articles read"  on public.articles for select using (true);
create policy "articles write" on public.articles for all
  to authenticated using (true) with check (true);

-- gallery
drop policy if exists "gallery read"  on public.gallery;
drop policy if exists "gallery write" on public.gallery;
create policy "gallery read"  on public.gallery for select using (true);
create policy "gallery write" on public.gallery for all
  to authenticated using (true) with check (true);

-- site_settings
drop policy if exists "settings read"  on public.site_settings;
drop policy if exists "settings write" on public.site_settings;
create policy "settings read"  on public.site_settings for select using (true);
create policy "settings write" on public.site_settings for all
  to authenticated using (true) with check (true);

-- ---------- STORAGE BUCKETS ----------

insert into storage.buckets (id, name, public) values
  ('player-photos',  'player-photos',  true),
  ('article-images', 'article-images', true),
  ('gallery',        'gallery',        true)
on conflict (id) do nothing;

-- Storage policies: public read, authenticated write on our three buckets.
drop policy if exists "media public read"   on storage.objects;
drop policy if exists "media auth insert"   on storage.objects;
drop policy if exists "media auth update"   on storage.objects;
drop policy if exists "media auth delete"   on storage.objects;

create policy "media public read" on storage.objects for select
  using ( bucket_id in ('player-photos','article-images','gallery') );

create policy "media auth insert" on storage.objects for insert to authenticated
  with check ( bucket_id in ('player-photos','article-images','gallery') );

create policy "media auth update" on storage.objects for update to authenticated
  using ( bucket_id in ('player-photos','article-images','gallery') );

create policy "media auth delete" on storage.objects for delete to authenticated
  using ( bucket_id in ('player-photos','article-images','gallery') );

-- ---------- OPTIONAL SEED DATA ----------
-- A few starter rows so the live site isn't empty on first load.
-- Delete/replace them from the admin panel any time.

insert into public.players (name, number, position, sort_order) values
  ('Eric',    9,  'Striker',    1),
  ('Aline',   7,  'Winger',     2),
  ('Kevin',   4,  'Defender',   3),
  ('Divine',  1,  'Goalkeeper', 4),
  ('Yves',    10, 'Playmaker',  5),
  ('Sandra',  8,  'Midfielder', 6),
  ('Patrick', 5,  'Defender',   7),
  ('Grace',   11, 'Forward',    8)
on conflict do nothing;

insert into public.articles (title, slug, excerpt, published_at) values
  ('Simama wins the Kigali youth cup', 'simama-wins-the-kigali-youth-cup',
   'A 2-1 comeback in the final capped the club''s best season yet — and the whole bench stormed the pitch at full time.',
   now() - interval '6 days'),
  ('New boots for the whole squad', 'new-boots-for-the-whole-squad',
   'Thanks to 32 donors, every player started pre-season in boots that actually fit. Small thing. Huge thing.',
   now() - interval '24 days'),
  ('Scouting our second district', 'scouting-our-second-district',
   'We''ve started conversations to launch a Simama team in a second district. One node closer to lighting the whole map.',
   now() - interval '42 days')
on conflict do nothing;

-- =====================================================================
-- DONE.  Next: create your admin login under
-- Authentication -> Users -> Add user  (tick "Auto Confirm User").
-- =====================================================================
