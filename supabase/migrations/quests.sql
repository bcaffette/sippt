create table public.quests (
  id uuid not null default gen_random_uuid (),
  partner_id bigint not null,
  value integer not null,
  expires_at timestamp with time zone not null,
  created_at timestamp with time zone not null default now(),
  constraint quests_pkey primary key (id),
  constraint quests_partner_id_fkey foreign KEY (partner_id) references partners (id)
) TABLESPACE pg_default;