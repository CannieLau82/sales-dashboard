-- Outlet performance dashboard: table, read access and seed data.
-- Paste into Supabase > SQL Editor > New query, then Run. Safe to run more than once.

create table if not exists public.outlet_weekly (
  id       bigint generated always as identity primary key,
  outlet   text          not null,
  week     date          not null,
  sales    numeric(12,2) not null,
  target   numeric(12,2) not null,
  orders   integer       not null,
  returns  integer       not null,
  unique (outlet, week)
);

-- Row level security: the browser (anon / publishable key) may read, not write.
alter table public.outlet_weekly enable row level security;
grant select on public.outlet_weekly to anon, authenticated;
drop policy if exists "Dashboard can read outlet_weekly" on public.outlet_weekly;
create policy "Dashboard can read outlet_weekly"
  on public.outlet_weekly for select
  to anon, authenticated
  using (true);

-- Seed data (from the original CSV). Re-running updates existing rows instead of duplicating.
insert into public.outlet_weekly (outlet, week, sales, target, orders, returns) values
  ('Tampines', '2026-09-07', 18400, 18000, 612,  9),
  ('Tampines', '2026-09-14', 16100, 18000, 540, 14),
  ('Tampines', '2026-09-21', 19200, 18000, 640,  8),
  ('Jurong',   '2026-09-07', 14200, 15000, 488, 11),
  ('Jurong',   '2026-09-14', 12600, 15000, 430, 19),
  ('Jurong',   '2026-09-21', 15300, 15000, 512, 10),
  ('Orchard',  '2026-09-07', 22500, 24000, 690, 12),
  ('Orchard',  '2026-09-14', 20100, 24000, 612, 21),
  ('Orchard',  '2026-09-21', 24800, 24000, 742,  9)
on conflict (outlet, week) do update set
  sales = excluded.sales, target = excluded.target,
  orders = excluded.orders, returns = excluded.returns;

-- Check: should return 9 rows.
select outlet, week, sales, target, orders, returns from public.outlet_weekly order by outlet, week;
