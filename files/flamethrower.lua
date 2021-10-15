dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/AdventureMode/lib/coroutines.lua")

function get_direction(x1, y1, x2, y2)
  return math.atan2( ( y2 - y1 ), ( x2 - x1 ) )
end

function move_angle_towards(current_angle, target_angle, speed)
  -- Make angle go from 0 to 2pi
  if target_angle < 0 then
    target_angle = target_angle + math.pi * 2
  end
  if current_angle < 0 then
    current_angle = current_angle + math.pi * 2
  end

  local dist_up = math.abs(target_angle - current_angle)
  local dist_down = math.abs((current_angle + math.pi * 2) - target_angle)
  if current_angle > target_angle then
    dist_up = math.abs((target_angle + math.pi * 2) - current_angle)
    dist_down = math.abs(current_angle - target_angle)
  end
  
  local dir
  if math.abs(dist_up) < math.abs(dist_down) then
    dir = 1
  else
    dir = -1
  end
  local dist_smallest = math.min(dist_down, dist_up)


  local new_angle = current_angle + speed * dir
  if dir > 0 and current_angle <= target_angle and new_angle > target_angle then
    new_angle = target_angle
  elseif dir < 0 and current_angle >= target_angle and new_angle < target_angle  then
    new_angle = target_angle
  end
  -- new_angle = new_angle % (math.pi * 2)

  return new_angle
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local players = EntityGetWithTag("player_unit")
if #players > 0 then
  local player = players[1]
  local px, py = EntityGetFirstHitboxCenter(player) --EntityGetTransform(player)
  local did_hit ,hit_x ,hit_y = RaytraceSurfaces(x, y, px, py)
  if not did_hit then
    local dir = get_direction(x, y, px, py)
    local actual_dir = get_direction(x, y, px, py)
    local dir_old = GetValueNumber("dir", math.pi/2)
    dir = clamp(dir, 0.1, math.pi - 0.1)
    dir = move_angle_towards(dir_old, dir, 1 / 50)
    SetValueNumber("dir", dir)
    EntitySetTransform(entity_id, x, y, dir)

    if GameGetFrameNum() % 180 == 0 then --and math.abs(dir - actual_dir) < 0.5 then
      async(function()
        for i=1, 10 do          
          local px, py = EntityGetFirstHitboxCenter(player)
          local dir = get_direction(x, y, px, py)
          local dir_x = math.cos(dir)
          local dir_y = math.sin(dir)
          shoot_projectile(entity_id, "mods/AdventureMode/files/projectiles/flame_beam.xml", x + dir_x * 7, y + dir_y * 7, dir_x * 200, dir_y * 200, true)
          wait(1)
        end
      end)
    end
  end
end
