create table public.profiles (
  id uuid not null,
  username text not null,
  pfp_url text null,
  created_at timestamp with time zone not null default now(),
  constraint profile_pkey primary key (id),
  constraint profile_username_key unique (username),
  constraint profile_id_fkey foreign KEY (id) references auth.users (id) on update CASCADE on delete CASCADE
) TABLESPACE pg_default;