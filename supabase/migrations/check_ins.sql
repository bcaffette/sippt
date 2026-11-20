create table public.check_ins (
  id uuid not null default gen_random_uuid (),
  user_id uuid not null,
  shop_id bigint not null,
  pts_awarded bigint null,
  created_at timestamp with time zone not null default now(),
  quest_id uuid null,
  constraint check_ins_pkey primary key (id),
  constraint check_ins_quest_id_fkey foreign KEY (quest_id) references quests (id) on delete RESTRICT,
  constraint check_ins_shop_id_fkey foreign KEY (shop_id) references shops (id) on delete RESTRICT,
  constraint check_ins_user_id_fkey foreign KEY (user_id) references profiles (id) on update CASCADE on delete CASCADE
) TABLESPACE pg_default;