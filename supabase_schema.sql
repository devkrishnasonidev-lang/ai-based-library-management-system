-- ============================================================
-- AI-Brary schema for Supabase
-- Run this once in your Supabase project's SQL editor:
-- Dashboard -> SQL Editor -> New query -> paste -> Run
-- ============================================================

-- 1. BOOKS (the catalog)
create table if not exists public.books (
  id text primary key,
  title text not null,
  author text,
  genre text,
  copies int not null default 0,
  available int not null default 0,
  why text
);

-- 2. SEATS (reading room seat map)
create table if not exists public.seats (
  seat_id text primary key,
  floor int not null,
  state text not null default 'free',   -- 'free' | 'occupied' | 'booked'
  booked_by_name text,
  booked_by_id text,
  slot text,
  ref text
);

-- 3. LOANS (issue / return history)
create table if not exists public.loans (
  ref text primary key,
  title text not null,
  borrower_name text not null,
  borrower_id text not null,
  issue_date date not null,
  due_date date not null,
  returned boolean not null default false,
  return_date date
);

-- ============================================================
-- Row Level Security
-- The app connects with the PUBLISHABLE (anon) key, so RLS must
-- explicitly allow it to read/write. These policies are wide open
-- (fine for a college project demo) — do NOT use this on a real
-- production app with sensitive data.
-- ============================================================

alter table public.books enable row level security;
alter table public.seats enable row level security;
alter table public.loans enable row level security;

create policy "public read books"  on public.books  for select using (true);
create policy "public write books" on public.books  for insert with check (true);
create policy "public update books" on public.books for update using (true);

create policy "public read seats"  on public.seats  for select using (true);
create policy "public write seats" on public.seats  for insert with check (true);
create policy "public update seats" on public.seats for update using (true);

create policy "public read loans"  on public.loans  for select using (true);
create policy "public write loans" on public.loans  for insert with check (true);
create policy "public update loans" on public.loans for update using (true);
