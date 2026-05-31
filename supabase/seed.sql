insert into public.users (name, email)
values
  ('Ada Lovelace', 'ada@example.com'),
  ('Grace Hopper', 'grace@example.com')
on conflict (email) do nothing;
