create table public.quests (
  id uuid not null default gen_random_uuid (),
  shop_id bigint not null,
  value integer not null,
  expires_at timestamp with time zone not null,
  created_at timestamp with time zone not null default now(),
  constraint quests_pkey primary key (id),
  constraint quests_shop_id_fkey foreign KEY (shop_id) references shops (id) on delete RESTRICT
) TABLESPACE pg_default;