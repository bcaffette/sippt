create or replace function public.check_in(
  p_shop_id bigint,
  p_lat float8,
  p_long float8
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  c_earth_radius_ft constant float8 := 20902231;  -- 6,371 km mean radius
  c_check_in_radius_ft constant float8 := 55;      -- 50 ft + 5 ft forgiveness

  v_uid uuid;
  v_shop_lat float8;
  v_shop_long float8;
  v_quest_id uuid;
  v_quest_value int;
  v_already_claimed boolean := false;
  v_distance_ft float8;
  v_in_range boolean;
  v_pts_awarded int;
  v_check_in_id uuid;
begin
  -- step 1: who is checking in?
  v_uid := auth.uid();
  if v_uid is null then
    raise exception 'Not logged in';
  end if;

  -- step 2: where is the shop?
  select lat, long into v_shop_lat, v_shop_long
  from shops
  where id = p_shop_id;

  if not found then
    raise exception 'Shop % does not exist', p_shop_id;
  end if;

  -- step 3: is there an active quest at this shop? if not, keep quest info as null
  select id, value into v_quest_id, v_quest_value
  from quests
  where shop_id = p_shop_id
    and now() < expires_at
  limit 1;

  -- step 4: if a quest is found, has this user already claimed it? if so, they get no quest value
  if v_quest_id is not null then
    select exists (
      select 1 from check_ins
      where user_id = v_uid
        and quest_id = v_quest_id
        and pts_awarded is not null
    ) into v_already_claimed;

    if v_already_claimed then
      v_quest_id := null;
      v_quest_value := null;
    end if;
  end if;

  -- step 5: calculate distance to shop (haversine)
  v_distance_ft := 2 * c_earth_radius_ft * asin(sqrt(
    power(sin(radians(p_lat - v_shop_lat) / 2), 2)
    + cos(radians(v_shop_lat)) * cos(radians(p_lat))
    * power(sin(radians(p_long - v_shop_long) / 2), 2)
  ));

  v_in_range := v_distance_ft <= c_check_in_radius_ft;

  -- step 6: if in range, then get the points awarded. if already claimed, but not a failure, then 0 points.
  -- if not in range, no points awarded, and represent a failed check in
  if v_in_range then
    v_pts_awarded := coalesce(v_quest_value, 0);
  else
    v_pts_awarded := null;
  end if;

  -- step 7: record the attempt (always, for the audit trail)
  insert into check_ins (user_id, shop_id, pts_awarded, quest_id)
  values (v_uid, p_shop_id, v_pts_awarded, v_quest_id)
  returning id into v_check_in_id;

  return jsonb_build_object(
    'check_in_id', v_check_in_id,
    'success', v_pts_awarded is not null,
    'pts_awarded', v_pts_awarded,
    'quest_id', v_quest_id,
    'already_claimed', v_already_claimed,
    'distance_ft', v_distance_ft
  );
end;
$$;